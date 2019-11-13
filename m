Content-Type: multipart/mixed; boundary="===============7503996235209075647=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] test-runner: erase valgrind log after each test
Date: Wed, 13 Nov 2019 11:41:02 -0800
Message-ID: <20191113194102.30627-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7503996235209075647==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

After changing the valgrind log to --log-fd, it appears that
the log file just gets appended, where before it was overwritten.
This makes test print out all previous tests valgrind results.

Now after printing out the valgrind info we can erase the file
for the next test.
---
 tools/test-runner.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/test-runner.c b/tools/test-runner.c
index 043e8cc7..075f56d6 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -2226,10 +2226,14 @@ static void create_network_and_run_tests(void *data=
, void *user_data)
 		terminate_iwd(iwd_pid);
 =

 	/* /tmp/valgrind.log will only exist without logging turned on */
-	if (valgrind && !log)
+	if (valgrind && !log) {
 		if (system("cat /tmp/valgrind.log"))
 			l_info("cat /tmp/valgrind.log failed");
 =

+		if (system("echo \"\" > /tmp/valgrind.log"))
+			l_info("Failed to reset /tmp/valgrind.log");
+	}
+
 	if (log) {
 		L_AUTO_FREE_VAR(char *, dmesg);
 		L_AUTO_FREE_VAR(char *, kernel_log);
-- =

2.17.1

--===============7503996235209075647==--

