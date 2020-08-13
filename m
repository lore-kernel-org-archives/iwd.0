Content-Type: multipart/mixed; boundary="===============4180694859487204380=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 10/16] eap-wsc: Zero a temporary buffer before freeing
Date: Thu, 13 Aug 2020 02:53:32 +0200
Message-ID: <20200813005338.295108-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4180694859487204380==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/eap-wsc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/eap-wsc.c b/src/eap-wsc.c
index ccb52979..ca915471 100644
--- a/src/eap-wsc.c
+++ b/src/eap-wsc.c
@@ -1157,11 +1157,13 @@ static bool load_hexencoded(struct l_settings *sett=
ings, const char *key,
 		return false;
 =

 	if (decoded_len !=3D len) {
+		explicit_bzero(decoded, decoded_len);
 		l_free(decoded);
 		return false;
 	}
 =

 	memcpy(to, decoded, len);
+	explicit_bzero(decoded, decoded_len);
 	l_free(decoded);
 =

 	return true;
-- =

2.25.1

--===============4180694859487204380==--

