Content-Type: multipart/mixed; boundary="===============0524533258794345534=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] test-runner: create pcap when logging
Date: Thu, 02 Apr 2020 10:01:56 -0700
Message-ID: <20200402170156.3349-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0524533258794345534==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 tools/test-runner.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/tools/test-runner.c b/tools/test-runner.c
index 5b37a790..88bb50e1 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -1608,14 +1608,24 @@ static void terminate_iwd(pid_t iwd_pid)
 =

 static pid_t start_monitor(const char *test_name)
 {
-	char *argv[4];
+	char *argv[6];
+	char *write_arg;
+	pid_t pid;
+
+	write_arg =3D l_strdup_printf("%s/%s/monitor.pcap", log_dir, test_name);
 =

 	argv[0] =3D "iwmon";
 	argv[1] =3D "--nortnl";
 	argv[2] =3D "--nowiphy";
-	argv[3] =3D NULL;
+	argv[3] =3D "--write";
+	argv[4] =3D write_arg;
+	argv[5] =3D NULL;
 =

-	return execute_program(argv, environ, false, test_name);
+	pid =3D execute_program(argv, environ, false, test_name);
+
+	l_free(write_arg);
+
+	return pid;
 }
 =

 static bool create_tmpfs_extra_stuff(char **tmpfs_extra_stuff)
-- =

2.21.1

--===============0524533258794345534==--

