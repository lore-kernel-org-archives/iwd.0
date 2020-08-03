Content-Type: multipart/mixed; boundary="===============4958437968228030471=="
MIME-Version: 1.0
From: Daniel DE ALMEIDA BRAGA <daniel.de-almeida-braga@irisa.fr>
Subject: [PATCHv2] Fix a side channel leak on the password in SAE
Date: Mon, 03 Aug 2020 11:08:37 +0200
Message-ID: <20200803090836.62977-1-daniel.de-almeida-braga@irisa.fr>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4958437968228030471==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use a constant control flow in the derivation loop, avoiding leakage
in the iteration succesfuly converting the password.
Increase number of iterations (20 to 30) to avoid issues with
passwords needing more iterations.
Updated to take account of ELL's patch modifications.
---
 src/sae.c  | 135 +++++++++++++++++++++++++++++++++++++----------------
 src/util.h |  31 ++++++++++++
 2 files changed, 125 insertions(+), 41 deletions(-)

diff --git a/src/sae.c b/src/sae.c
index 97e3348e..c3bb6515 100644
--- a/src/sae.c
+++ b/src/sae.c
@@ -97,23 +97,47 @@ static bool sae_pwd_seed(const uint8_t *addr1, const ui=
nt8_t *addr2,
 					&counter, (size_t) 1);
 }
 =

+/*
+ * Computes KDF-256(pwd_seed, "SAE Hunting and Pecking", p). If the output=
 is
+ * greater than p, the output is set to qnr, a quadratic non-residue.
+ * Since this happens with very low probability, using the same qnr is fin=
e.
+ */
 static struct l_ecc_scalar *sae_pwd_value(const struct l_ecc_curve *curve,
-						uint8_t *pwd_seed)
+						uint8_t *pwd_seed, uint8_t *qnr)
 {
 	uint8_t pwd_value[L_ECC_SCALAR_MAX_BYTES];
 	uint8_t prime[L_ECC_SCALAR_MAX_BYTES];
 	ssize_t len;
+	int is_in_range;
 	struct l_ecc_scalar *p =3D l_ecc_curve_get_prime(curve);
 =

 	len =3D l_ecc_scalar_get_data(p, prime, sizeof(prime));
-
 	l_ecc_scalar_free(p);
 =

 	if (!kdf_sha256(pwd_seed, 32, "SAE Hunting and Pecking",
-			strlen("SAE Hunting and Pecking"), prime, len,
-			pwd_value, len))
+					strlen("SAE Hunting and Pecking"), prime, len,
+					pwd_value, len))
 		return NULL;
 =

+	/*
+	 * If pwd_value >=3D prime, this iteration should fail. We need a smooth
+	 * control flow, so we need to continue anyway.
+	 */
+	is_in_range =3D l_secure_memcmp(pwd_value, prime, len);
+	/*
+	 * We only consider is_in_range =3D=3D -1 as valid, meaning the value of =
the
+	 * MSB defines the mask.
+	 */
+	is_in_range =3D util_secure_fill_with_msb(is_in_range);
+
+	/*
+	 * libell has public Legendre symbol only for l_ecc_scalar, but they cann=
ot
+	 * be created if the coordinate is greater than the p. Hence, to avoid
+	 * control flow dependencies, we replace pwd_value by a dummy quadratic
+	 * non residue if we generate a value >=3D prime.
+	 */
+	util_secure_select((uint8_t) is_in_range, pwd_value, qnr, pwd_value, size=
of(pwd_value));
+
 	return l_ecc_scalar_new(curve, pwd_value, sizeof(pwd_value));
 }
 =

@@ -190,7 +214,7 @@ static struct l_ecc_scalar *sae_new_residue(const struc=
t l_ecc_curve *curve,
 	return s;
 }
 =

-static bool sae_is_quadradic_residue(const struct l_ecc_curve *curve,
+static uint8_t sae_is_quadradic_residue(const struct l_ecc_curve *curve,
 						struct l_ecc_scalar *value,
 						struct l_ecc_scalar *qr,
 						struct l_ecc_scalar *qnr)
@@ -213,7 +237,7 @@ static bool sae_is_quadradic_residue(const struct l_ecc=
_curve *curve,
 =

 	if (bytes <=3D 0) {
 		l_ecc_scalar_free(num);
-		return false;
+		return 0;
 	}
 =

 	if (rbuf[bytes / 8 - 1] & 1) {
@@ -221,20 +245,20 @@ static bool sae_is_quadradic_residue(const struct l_e=
cc_curve *curve,
 =

 		if (l_ecc_scalar_legendre(num) =3D=3D -1) {
 			l_ecc_scalar_free(num);
-			return true;
+			return 1;
 		}
 	} else {
 		l_ecc_scalar_multiply(num, num, qnr);
 =

 		if (l_ecc_scalar_legendre(num) =3D=3D 1) {
 			l_ecc_scalar_free(num);
-			return true;
+			return 1;
 		}
 	}
 =

 	l_ecc_scalar_free(num);
 =

-	return false;
+	return 0;
 }
 =

 /*
@@ -244,66 +268,95 @@ static bool sae_is_quadradic_residue(const struct l_e=
cc_curve *curve,
 static bool sae_compute_pwe(struct sae_sm *sm, char *password,
 				const uint8_t *addr1, const uint8_t *addr2)
 {
-	bool found =3D false;
+	uint8_t found =3D 0;
+	uint8_t is_residue;
+	uint8_t is_odd =3D 0;
 	uint8_t counter;
 	uint8_t pwd_seed[32];
+	uint8_t x[L_ECC_SCALAR_MAX_BYTES];
+	uint8_t x_cand[L_ECC_SCALAR_MAX_BYTES];
 	struct l_ecc_scalar *pwd_value;
-	uint8_t random[32];
-	uint8_t *base =3D (uint8_t *) password;
-	size_t base_len =3D strlen(password);
-	uint8_t save[32] =3D { 0 };
+	uint8_t *dummy;
+	uint8_t *base;
+	size_t base_len;
 	struct l_ecc_scalar *qr;
 	struct l_ecc_scalar *qnr;
-	uint8_t x[L_ECC_SCALAR_MAX_BYTES];
+	uint8_t qnr_bin[L_ECC_SCALAR_MAX_BYTES] =3D {0};
 =

 	/* create qr/qnr prior to beginning hunting-and-pecking loop */
 	qr =3D sae_new_residue(sm->curve, true);
 	qnr =3D sae_new_residue(sm->curve, false);
+	l_ecc_scalar_get_data(qnr, qnr_bin, sizeof(qnr_bin));
+
+	/*
+	 * Allocate memory for the base, and set a random dummy to be used in
+	 * additional iterations, once a valid value is found
+	 */
+	base_len =3D strlen(password);
+	base =3D l_malloc(base_len * sizeof(*base));
+	dummy =3D l_malloc(base_len * sizeof(*dummy));
+	l_getrandom(dummy, base_len);
 =

-	for (counter =3D 1; counter <=3D 20; counter++) {
-		/* pwd-seed =3D H(max(addr1, addr2) || min(addr1, addr2),
-		 *                base || counter)
+	/*
+	 * Loop with constant time and memory access
+	 * We do 30 iterations instead of the 40 recommended to achieve a
+	 * resonnable security/complexity trade-off.
+	 */
+	for (counter =3D 1; counter <=3D 30; counter++) {
+		/*
+		 * Set base to either dummy or password, depending on found's value
+		 * A non-secure version would be:
+		 *  base =3D (found ? dummy : password);
+		 */
+		util_secure_select(found, dummy, (uint8_t *)password, base, base_len);
+
+		/*
+		 * pwd-seed =3D H(max(addr1, addr2) || min(addr1, addr2),
+		 *				base || counter)
 		 * pwd-value =3D KDF-256(pwd-seed, "SAE Hunting and Pecking", p)
 		 */
 		sae_pwd_seed(addr1, addr2, base, base_len, counter, pwd_seed);
+		/*
+		 * The case pwd_value > prime is handled inside, so that execution
+		 * can continue whatever the result is, without changing the outcome.
+		 */
+		pwd_value =3D sae_pwd_value(sm->curve, pwd_seed, qnr_bin);
 =

-		pwd_value =3D sae_pwd_value(sm->curve, pwd_seed);
-		if (!pwd_value)
-			continue;
-
-		if (sae_is_quadradic_residue(sm->curve, pwd_value, qr, qnr)) {
-			if (found =3D=3D false) {
-				l_ecc_scalar_get_data(pwd_value, x, sizeof(x));
-
-				memcpy(save, pwd_seed, 32);
+		/*
+		 * Check if the candidate is a valid x-coordinate on our curve, and
+		 * convert it from scalar to binary.
+		 */
+		is_residue =3D sae_is_quadradic_residue(sm->curve, pwd_value, qr, qnr);
+		l_ecc_scalar_get_data(pwd_value, x_cand, sizeof(x_cand));
 =

-				l_getrandom(random, 32);
-				base =3D random;
-				base_len =3D 32;
+		/*
+		 * If we already found the point, we overwrite x with itself.
+		 * Otherwise, we copy the new candidate into x.
+		 */
+		util_secure_select(found, x, x_cand, x, sizeof(x));
+		is_odd =3D util_secure_select_byte(found, is_odd, pwd_seed[31] & 0x01);
 =

-				found =3D true;
-			}
-		}
+		/*
+		 * found is 0 or 0xff here and is_residue is 0 or 1. Bitwise OR of them
+		 * (with is_residue converted to 0/0xff) handles this in constant time.
+		 */
+		found |=3D is_residue * 0xff;
 =

+		memset(pwd_seed, 0, sizeof(pwd_seed));
 		l_ecc_scalar_free(pwd_value);
 	}
 =

 	l_ecc_scalar_free(qr);
 	l_ecc_scalar_free(qnr);
+	l_free(dummy);
+	l_free(base);
 =

 	if (!found) {
 		l_error("max PWE iterations reached!");
 		return false;
 	}
+	sm->pwe =3D l_ecc_point_from_data(sm->curve, !is_odd + 2, x, sizeof(x));
 =

-	if (!(save[31] & 1))
-		sm->pwe =3D l_ecc_point_from_data(sm->curve,
-					L_ECC_POINT_TYPE_COMPRESSED_BIT1,
-					x, sizeof(x));
-	else
-		sm->pwe =3D l_ecc_point_from_data(sm->curve,
-					L_ECC_POINT_TYPE_COMPRESSED_BIT0,
-					x, sizeof(x));
 =

 	if (!sm->pwe) {
 		l_error("computing y failed, was x quadratic residue?");
diff --git a/src/util.h b/src/util.h
index edc6e777..93c7d619 100644
--- a/src/util.h
+++ b/src/util.h
@@ -71,4 +71,35 @@ static inline void util_set_bit(uint8_t *field, unsigned=
 int bit)
 	field[bit / 8] =3D 1 << (bit % 8);
 }
 =

+/*
+ * Returns either true_value or false_value (depending if mask is 0xFF or =
0x00
+ * respectively).
+ * This constant time selection method allows to keep an identical memory =

+ * access pattern.
+ */
+static inline uint8_t util_secure_select_byte(uint8_t mask, const uint8_t =
true_value,
+									  const uint8_t false_value)
+{
+	return (mask & true_value) | (~mask & false_value);
+}
+
+/*
+ * Copies either true_value or false_value (depending if mask is 0xFF or 0=
x00
+ * respectively) into dest. All three buffers are assumed to be the same s=
ize.
+ * This constant time selection method allows to keep an identical memory =

+ * access pattern.
+ */
+static inline void util_secure_select(uint8_t mask, const uint8_t *true_va=
lue,
+				const uint8_t *false_value, uint8_t *dest, size_t size)
+{
+	for(int i =3D 0; i < size; i++)
+		dest[i] =3D util_secure_select_byte(mask, true_value[i], false_value[i]);
+}
+
+/* Create a value filled with the MSB of the input. */
+static inline uint32_t util_secure_fill_with_msb(uint32_t val)
+{
+	return (uint32_t) (val >> (sizeof(val)*8 - 1)) * 0xFFFFFFFF;
+}
+
 #endif /* __UTIL_H */
-- =

2.25.4

--===============4958437968228030471==--

