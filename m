Content-Type: multipart/mixed; boundary="===============3411070378053915295=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 2/2] handshake: unref erp_cache when handshake is freed
Date: Tue, 03 Aug 2021 12:56:38 -0700
Message-ID: <20210803195638.138731-2-prestwoj@gmail.com>
In-Reply-To: <20210803195638.138731-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3411070378053915295==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This makes the erp_cache ownership more consisten rather than
relying on the ERP state to free the cache.
---
 src/handshake.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/handshake.c b/src/handshake.c
index 2bce6b8c..5f6b25f4 100644
--- a/src/handshake.c
+++ b/src/handshake.c
@@ -41,6 +41,7 @@
 #include "src/ie.h"
 #include "src/util.h"
 #include "src/handshake.h"
+#include "src/erp.h"
 =

 static inline unsigned int n_ecc_groups()
 {
@@ -106,6 +107,9 @@ void handshake_state_free(struct handshake_state *s)
 	l_free(s->mde);
 	l_free(s->fte);
 =

+	if (s->erp_cache)
+		erp_cache_put(s->erp_cache);
+
 	if (s->passphrase) {
 		explicit_bzero(s->passphrase, strlen(s->passphrase));
 		l_free(s->passphrase);
-- =

2.31.1

--===============3411070378053915295==--

