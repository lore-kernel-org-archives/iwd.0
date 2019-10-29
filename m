Content-Type: multipart/mixed; boundary="===============3248170432869421203=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH] client: Separate command option words by dash
Date: Tue, 29 Oct 2019 10:41:32 -0700
Message-ID: <20191029174132.19734-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3248170432869421203==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 client/command.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/client/command.h b/client/command.h
index 2161c075..d906dc9b 100644
--- a/client/command.h
+++ b/client/command.h
@@ -23,7 +23,7 @@
 #define COMMAND_OPTION_USERNAME		"username"
 #define COMMAND_OPTION_PASSWORD		"password"
 #define COMMAND_OPTION_PASSPHRASE	"passphrase"
-#define COMMAND_OPTION_DONTASK		"dontask"
+#define COMMAND_OPTION_DONTASK		"dont-ask"
 =

 typedef char *(*command_completion_func_t) (const char *text, int state);
 =

-- =

2.13.6

--===============3248170432869421203==--

