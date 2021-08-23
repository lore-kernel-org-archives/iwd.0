Content-Type: multipart/mixed; boundary="===============1244872306465882966=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 3/4] sae: handle force_default_sae_group in scan_bss
Date: Mon, 23 Aug 2021 16:41:48 -0700
Message-ID: <20210823234149.610336-3-prestwoj@gmail.com>
In-Reply-To: <20210823234149.610336-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1244872306465882966==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Now a scan_bss object is passed to sae_sm_new in order to detect if
the BSS's vendor OUI matches ones in which SAE group negotiation is
broken. When an AP like this is found SAE will use group 19
unconditionally, and fail if group 19 does not work. Other groups
could be tried upon failure but per the spec group 19 must be supported
so there isn't much use in trying other, optional groups.

Note: the check on 'bss' was added in order to make unit testing
easier to integrate as including scan.c in unit tests opens up a
can of worms.
---
 src/netdev.c |  2 +-
 src/sae.c    | 27 +++++++++++++++++++++++++++
 src/sae.h    |  2 ++
 3 files changed, 30 insertions(+), 1 deletion(-)

v2:
 * Only force group 19 when sae_type is LOOPING
 * Increment group_retry when forcing group otherwise
   IWD would continue to try group 19 over and over

diff --git a/src/netdev.c b/src/netdev.c
index d886efad..87b9c3f0 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -3470,7 +3470,7 @@ static void netdev_connect_common(struct netdev *netd=
ev,
 	switch (hs->akm_suite) {
 	case IE_RSN_AKM_SUITE_SAE_SHA256:
 	case IE_RSN_AKM_SUITE_FT_OVER_SAE_SHA256:
-		netdev->ap =3D sae_sm_new(hs, netdev_sae_tx_authenticate,
+		netdev->ap =3D sae_sm_new(hs, bss, netdev_sae_tx_authenticate,
 						netdev_sae_tx_associate,
 						netdev);
 =

diff --git a/src/sae.c b/src/sae.c
index 5099473c..5b2c74fc 100644
--- a/src/sae.c
+++ b/src/sae.c
@@ -34,6 +34,7 @@
 #include "src/mpdu.h"
 #include "src/auth-proto.h"
 #include "src/sae.h"
+#include "src/scan.h"
 =

 /* SHA-512 is the highest supported hashing function as of 802.11-2020 */
 #define SAE_MAX_HASH_LEN 64
@@ -83,6 +84,8 @@ struct sae_sm {
 	sae_tx_associate_func_t tx_assoc;
 	void *user_data;
 	enum crypto_sae sae_type;
+
+	bool force_default_group : 1;
 };
 =

 static enum mmpdu_status_code sae_status_code(struct sae_sm *sm)
@@ -139,6 +142,24 @@ static int sae_choose_next_group(struct sae_sm *sm)
 	const unsigned int *ecc_groups =3D l_ecc_supported_ike_groups();
 	bool reset =3D sm->group_retry >=3D 0;
 =

+	/*
+	 * If this is a buggy AP in which group negotiation is broken use the
+	 * default group 19 and fail if this is a retry.
+	 */
+	if (sm->sae_type =3D=3D CRYPTO_SAE_LOOPING && sm->force_default_group) {
+		if (sm->group_retry !=3D -1) {
+			l_warn("Forced default group but was rejected!");
+			return -ENOENT;
+		}
+
+		l_debug("Forcing default SAE group 19");
+
+		sm->group_retry++;
+		sm->group =3D 19;
+
+		goto get_curve;
+	}
+
 	do {
 		sm->group_retry++;
 =

@@ -151,6 +172,8 @@ static int sae_choose_next_group(struct sae_sm *sm)
 		sae_reset_state(sm);
 =

 	sm->group =3D ecc_groups[sm->group_retry];
+
+get_curve:
 	sm->curve =3D l_ecc_curve_from_ike_group(sm->group);
 =

 	return 0;
@@ -1317,6 +1340,7 @@ static void sae_free(struct auth_proto *ap)
 }
 =

 struct auth_proto *sae_sm_new(struct handshake_state *hs,
+				struct scan_bss *bss,
 				sae_tx_authenticate_func_t tx_auth,
 				sae_tx_associate_func_t tx_assoc,
 				void *user_data)
@@ -1351,5 +1375,8 @@ struct auth_proto *sae_sm_new(struct handshake_state =
*hs,
 		sm->sae_type =3D CRYPTO_SAE_LOOPING;
 	}
 =

+	if (bss && bss->force_default_sae_group)
+		sm->force_default_group =3D true;
+
 	return &sm->ap;
 }
diff --git a/src/sae.h b/src/sae.h
index 668d084f..d8f9f2d7 100644
--- a/src/sae.h
+++ b/src/sae.h
@@ -23,6 +23,7 @@
 struct auth_proto;
 struct sae_sm;
 struct handshake_state;
+struct scan_bss;
 =

 typedef void (*sae_tx_authenticate_func_t)(const uint8_t *data, size_t len,
 						void *user_data);
@@ -31,6 +32,7 @@ typedef void (*sae_tx_associate_func_t)(void *user_data);
 bool sae_sm_is_h2e(struct auth_proto *ap);
 =

 struct auth_proto *sae_sm_new(struct handshake_state *hs,
+				struct scan_bss *bss,
 				sae_tx_authenticate_func_t tx_auth,
 				sae_tx_associate_func_t tx_assoc,
 				void *user_data);
-- =

2.31.1

--===============1244872306465882966==--

