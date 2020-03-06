Content-Type: multipart/mixed; boundary="===============3824079119331873482=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/4] eap: check MTU when loading identity
Date: Fri, 06 Mar 2020 09:48:41 -0800
Message-ID: <20200306174843.26578-2-prestwoj@gmail.com>
In-Reply-To: <20200306174843.26578-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3824079119331873482==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If the MTU was set very low an identity could exceed the maximum.
---
 src/eap.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/src/eap.c b/src/eap.c
index 012bd58e..816b5f9a 100644
--- a/src/eap.c
+++ b/src/eap.c
@@ -568,10 +568,17 @@ bool eap_load_settings(struct eap_state *eap, struct =
l_settings *settings,
 	 * octets. Support for an NAI length of 253 octets is RECOMMENDED.
 	 * ...
 	 * RADIUS is unable to support NAI lengths beyond 253 octets
+	 *
+	 * We also need to fail if the identity is too large for the set MTU
+	 * size minus 5 (header).
 	 */
-	if (eap->identity && strlen(eap->identity) > 253) {
-		l_error("Identity is too long");
-		goto err;
+	if (eap->identity) {
+		size_t id_len =3D strlen(eap->identity);
+
+		if (id_len > 253 || id_len > eap->mtu - 5) {
+			l_error("Identity is too long");
+			goto err;
+		}
 	}
 =

 	return true;
-- =

2.17.1

--===============3824079119331873482==--

