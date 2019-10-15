Content-Type: multipart/mixed; boundary="===============6575901720873551542=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH 1/2] eap-ttls: Address mem leak reported by coverity
Date: Tue, 15 Oct 2019 10:34:11 -0700
Message-ID: <20191015173412.11810-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6575901720873551542==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The issue has appeared in 6017dc573
---
 src/eap-ttls.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/eap-ttls.c b/src/eap-ttls.c
index 00559cb7..619c7efa 100644
--- a/src/eap-ttls.c
+++ b/src/eap-ttls.c
@@ -1089,7 +1089,7 @@ static bool eap_ttls_settings_load(struct eap_state *=
eap,
 						struct l_settings *settings,
 						const char *prefix)
 {
-	struct phase2_method *phase2 =3D l_new(struct phase2_method, 1);
+	struct phase2_method *phase2;
 	const char *phase2_method_name;
 	char setting[72];
 	uint8_t i;
@@ -1100,6 +1100,8 @@ static bool eap_ttls_settings_load(struct eap_state *=
eap,
 	if (!phase2_method_name)
 		return false;
 =

+	phase2 =3D l_new(struct phase2_method, 1);
+
 	snprintf(setting, sizeof(setting), "%sTTLS-Phase2-", prefix);
 =

 	for (i =3D 0; tunneled_non_eap_method_ops[i].name; i++) {
-- =

2.13.6

--===============6575901720873551542==--

