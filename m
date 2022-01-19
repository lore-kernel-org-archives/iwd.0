Content-Type: multipart/mixed; boundary="===============4619102239713795294=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH] eap-pwd: add length checks for fragmented packets
Date: Wed, 19 Jan 2022 10:13:02 -0800
Message-ID: <20220119181302.2259778-1-prestwoj@gmail.com>

--===============4619102239713795294==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/eap-pwd.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/src/eap-pwd.c b/src/eap-pwd.c
index af373493..cd6684e7 100644
--- a/src/eap-pwd.c
+++ b/src/eap-pwd.c
@@ -669,6 +669,14 @@ static void eap_pwd_handle_request(struct eap_state *e=
ap,
 =

 		/* remove length of Total-Length parameter (2) */
 		pwd->rx_frag_total =3D l_get_be16(pkt + 1) - 2;
+
+		if (pwd->rx_frag_total < len - 2) {
+			l_error("Total-Length too small for remaining length");
+			pwd->rx_frag_total =3D 0;
+
+			return;
+		}
+
 		pwd->rx_frag_buf =3D l_malloc(pwd->rx_frag_total);
 =

 		/* skip copying Total-Length for easier processing later */
@@ -687,6 +695,12 @@ static void eap_pwd_handle_request(struct eap_state *e=
ap,
 =

 	/* more rx fragments */
 	if (pwd->rx_frag_buf) {
+		if (pwd->rx_frag_total - pwd->rx_frag_count <
+						(uint16_t) len - 1) {
+			l_error("Not enough room for fragment (%zu)", len - 1);
+			return;
+
+		}
 		/* continue building packet (not including PWD-Exch byte) */
 		memcpy(pwd->rx_frag_buf + pwd->rx_frag_count, pkt + 1, len - 1);
 		pwd->rx_frag_count +=3D (len - 1);
-- =

2.31.1

--===============4619102239713795294==--

