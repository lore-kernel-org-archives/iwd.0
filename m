Content-Type: multipart/mixed; boundary="===============3454313059197129722=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v5 2/6] unit: add test for util_ip_prefix_tohl
Date: Mon, 26 Oct 2020 11:05:40 -0700
Message-ID: <20201026180544.2130802-2-prestwoj@gmail.com>
In-Reply-To: <20201026180544.2130802-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3454313059197129722==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-util.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/unit/test-util.c b/unit/test-util.c
index f091f2c2..09af925e 100644
--- a/unit/test-util.c
+++ b/unit/test-util.c
@@ -27,6 +27,8 @@
 #include <stdio.h>
 #include <string.h>
 #include <assert.h>
+#include <netinet/in.h>
+#include <arpa/inet.h>
 #include <ell/ell.h>
 =

 #include "src/util.h"
@@ -115,6 +117,64 @@ static void get_username_test(const void *data)
 	assert(strcmp(test, "username") =3D=3D 0);
 }
 =

+static void ip_prefix_test(const void *data)
+{
+	unsigned int i;
+	char *invalid[] =3D {
+		"192.168.0.0", /* Not prefix notation */
+		"192.168./22", /* Incomplete notation */
+		"192.168.0.1/255", /* Too long prefix */
+		"192.168.0.1/0", /* Too short prefix */
+		"192.168.0.1/16", /* Invalid prefix */
+		"192.168.1.2.3/24", /* IP too long */
+	};
+
+	struct {
+		char *ip_prefix;
+		uint8_t prefix;
+		char *start;
+		char *end;
+		char *mask;
+	} valid[] =3D {
+		{"192.168.80.0/22", 22, "192.168.80.1",
+				"192.168.83.254", "255.255.252.0"},
+		{"192.168.128.0/20", 20, "192.168.128.1",
+				"192.168.143.254", "255.255.240.0"},
+		{"192.168.0.0/25", 25, "192.168.0.1",
+				"192.168.0.126", "255.255.255.128"},
+		{"192.168.0.0/29", 29, "192.168.0.1",
+				"192.168.0.6", "255.255.255.248"},
+		{"192.168.0.128/25", 25, "192.168.0.129",
+				"192.168.0.254", "255.255.255.128"},
+	};
+
+	for (i =3D 0; i < L_ARRAY_SIZE(invalid); i++)
+		assert(!util_ip_prefix_tohl(invalid[i], NULL, NULL,
+						NULL, NULL));
+
+	for (i =3D 0; i < L_ARRAY_SIZE(valid); i++) {
+		uint8_t prefix;
+		uint32_t start;
+		uint32_t end;
+		uint32_t mask;
+		struct in_addr ia;
+
+		assert(util_ip_prefix_tohl(valid[i].ip_prefix,
+						&prefix, &start, &end, &mask));
+
+		assert(valid[i].prefix =3D=3D prefix);
+
+		ia.s_addr =3D htonl(start);
+		assert(strcmp(inet_ntoa(ia), valid[i].start) =3D=3D 0);
+
+		ia.s_addr =3D htonl(end);
+		assert(strcmp(inet_ntoa(ia), valid[i].end) =3D=3D 0);
+
+		ia.s_addr =3D htonl(mask);
+		assert(strcmp(inet_ntoa(ia), valid[i].mask) =3D=3D 0);
+	}
+}
+
 int main(int argc, char *argv[])
 {
 	l_test_init(&argc, &argv);
@@ -122,6 +182,7 @@ int main(int argc, char *argv[])
 	l_test_add("/util/ssid_to_utf8/", ssid_to_utf8, ssid_samples);
 	l_test_add("/util/get_domain/", get_domain_test, NULL);
 	l_test_add("/util/get_username/", get_username_test, NULL);
+	l_test_add("/util/ip_prefix/", ip_prefix_test, NULL);
 =

 	return l_test_run();
 }
-- =

2.26.2

--===============3454313059197129722==--

