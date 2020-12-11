Content-Type: multipart/mixed; boundary="===============2497012562972151273=="
MIME-Version: 1.0
From: Ronan Pigott <rpigott314@gmail.com>
Subject: [PATCH] client: ignore control sequence length in prompt
Date: Thu, 10 Dec 2020 23:32:22 -0700
Message-ID: <20201211063222.67764-1-rpigott@berkeley.edu>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2497012562972151273==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Ronan Pigott <rpigott@berkeley.edu>

Readline uses the characters \001 and \002 to mark the start and end
of zero-length character sequnces in the prompt before prompt
expansion. Without these characters the input point can become offset
from the visual end of the prompt when performing some actions.
---

iwctl gets messed up if you press up and down once to recall and
then dismiss the last history line. This fixes that.

 client/display.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/client/display.c b/client/display.c
index b19759ea..88bc913f 100644
--- a/client/display.c
+++ b/client/display.c
@@ -39,7 +39,8 @@
 #include "client/command.h"
 #include "client/display.h"
 =

-#define IWD_PROMPT COLOR_GREEN "[iwd]" COLOR_OFF "# "
+#define IWD_PROMPT \
+	"\001" COLOR_GREEN "\002" "[iwd]" "\001" COLOR_OFF "\002" "# "
 #define LINE_LEN 81
 =

 static struct l_signal *window_change_signal;
-- =

2.29.2

--===============2497012562972151273==--

