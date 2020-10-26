Content-Type: multipart/mixed; boundary="===============1325163060472729262=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v5 1/6] util: add util_ip_prefix_tohl
Date: Mon, 26 Oct 2020 11:05:39 -0700
Message-ID: <20201026180544.2130802-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1325163060472729262==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Parses an IP prefix notation string into prefix, start, end, and
netmask. All values are returned in host order.
---
 src/util.c | 95 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/util.h |  3 ++
 2 files changed, 98 insertions(+)

diff --git a/src/util.c b/src/util.c
index 13b01c81..5dc5f15d 100644
--- a/src/util.c
+++ b/src/util.c
@@ -28,6 +28,8 @@
 #include <stdio.h>
 #include <sys/uio.h>
 #include <sys/time.h>
+#include <netinet/in.h>
+#include <arpa/inet.h>
 =

 #include <ell/ell.h>
 =

@@ -218,3 +220,96 @@ const char *util_get_username(const char *identity)
 =

 	return identity;
 }
+
+static bool is_prefix_valid(uint32_t ip, unsigned int prefix)
+{
+	int i;
+
+	for (i =3D 31 - prefix; i >=3D 0; i--) {
+		if (ip & (1 << i))
+			return false;
+	}
+
+	return true;
+}
+
+/*
+ * Parse a prefix notation IP string (e.g. A.B.C.D/E) into an IP range and
+ * netmask. All returned IP addresses/mask will be in host order. The star=
t/end
+ * IP will only include the usable IP range where the last octet is not ze=
ro or
+ * 255.
+ */
+bool util_ip_prefix_tohl(const char *ip, uint8_t *prefix_out,
+				uint32_t *start_out, uint32_t *end_out,
+				uint32_t *mask_out)
+{
+	struct in_addr ia;
+	int i;
+	unsigned int prefix;
+	char no_prefix[16];
+	char *endp;
+	uint32_t start_ip;
+	uint32_t end_ip;
+	uint32_t netmask =3D 0xffffffff;
+	int len =3D strlen(ip) - 1;
+	bool found =3D false;
+	uint8_t dots =3D 0;
+
+	/* Count dots and find prefix offset */
+	for (i =3D 0; i <=3D len; i++) {
+		if (ip[i] =3D=3D '.')
+			dots++;
+		else if (ip[i] =3D=3D '/') {
+			found =3D true;
+			break;
+		}
+	}
+
+	if (!found || dots !=3D 3)
+		return false;
+
+	memcpy(no_prefix, ip, i);
+	no_prefix[i] =3D '\0';
+
+	/* Check if IP preceeding prefix is valid */
+	if (inet_aton(no_prefix, &ia) < 0 || ia.s_addr =3D=3D 0)
+		return false;
+
+	prefix =3D strtol(ip + i + 1, &endp, 0);
+	if (*endp !=3D '\0')
+		return false;
+
+	if (prefix < 1 || prefix > 31)
+		return false;
+
+	start_ip =3D ntohl(ia.s_addr);
+
+	if (!is_prefix_valid(start_ip, prefix))
+		return false;
+
+	/* Usable range is start + 1 .. end - 1 */
+	start_ip +=3D 1;
+
+	/* Calculate end IP and netmask */
+	end_ip =3D start_ip;
+	for (i =3D 31 - prefix; i >=3D 0; i--) {
+		end_ip |=3D (1 << i);
+		netmask &=3D ~(1 << i);
+	}
+
+	end_ip -=3D 1;
+
+	if (prefix_out)
+		*prefix_out =3D prefix;
+
+	if (start_out)
+		*start_out =3D start_ip;
+
+	if (end_out)
+		*end_out =3D end_ip;
+
+	if (mask_out)
+		*mask_out =3D netmask;
+
+	return true;
+}
diff --git a/src/util.h b/src/util.h
index 2679c117..e6b4747f 100644
--- a/src/util.h
+++ b/src/util.h
@@ -107,4 +107,7 @@ static inline uint32_t util_secure_fill_with_msb(uint32=
_t val)
 	return (uint32_t) (val >> (sizeof(val)*8 - 1)) * 0xFFFFFFFF;
 }
 =

+bool util_ip_prefix_tohl(const char *ip, uint8_t *prefix, uint32_t *start_=
out,
+				uint32_t *end_out, uint32_t *mask_out);
+
 #endif /* __UTIL_H */
-- =

2.26.2

--===============1325163060472729262==--

