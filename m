Content-Type: multipart/mixed; boundary="===============6189283106535924397=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] test-runner: refactor/fix valgrind logging issue
Date: Tue, 05 Nov 2019 15:22:26 -0800
Message-ID: <20191105232226.11705-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6189283106535924397==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

After the logging changes verbose IWD with valgrind did not show any IWD
output. This commit fixes this by checking the verbosity against log_name
rather than argv[0] since log_name has a special case for valgrind/iwd.

The valgrind logic in start_iwd was refactored to only use the --log-fd
option rather than using --log-file in addition to --log-fd.
---
 tools/test-runner.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/tools/test-runner.c b/tools/test-runner.c
index 5ef9552e..a83e1252 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -564,7 +564,7 @@ static pid_t execute_program(char *argv[], char *envp[]=
, bool wait,
 		int fd =3D -1;
 		L_AUTO_FREE_VAR(char *, log_file) =3D NULL;
 =

-		verbose =3D check_verbosity(argv[0]);
+		verbose =3D check_verbosity(log_name);
 =

 		/* No stdout and no logging */
 		if (!verbose && !log)
@@ -1493,6 +1493,7 @@ static pid_t start_iwd(const char *config_dir, struct=
 l_queue *wiphy_list,
 	L_AUTO_FREE_VAR(char *, fd_option) =3D NULL;
 =

 	if (valgrind) {
+		L_AUTO_FREE_VAR(char *, valgrind_log);
 		int fd;
 =

 		argv[idx++] =3D "valgrind";
@@ -1501,21 +1502,22 @@ static pid_t start_iwd(const char *config_dir, stru=
ct l_queue *wiphy_list,
 		/*
 		 * Valgrind needs --log-fd if we want both stderr and stdout
 		 */
-		if (log) {
-			L_AUTO_FREE_VAR(char *, valgrind_log);
-
+		if (log)
 			valgrind_log =3D l_strdup_printf("%s/%s/valgrind.log",
 							log_dir, test_name);
-			fd =3D open(valgrind_log, O_WRONLY | O_CREAT | O_APPEND,
+		else
+			valgrind_log =3D l_strdup("/tmp/valgrind.log");
+
+		fd =3D open(valgrind_log, O_WRONLY | O_CREAT | O_APPEND,
 					S_IRUSR | S_IWUSR);
 =

+		if (log) {
 			if (fchown(fd, log_uid, log_gid) < 0)
 				l_error("chown failed");
+		}
 =

-			fd_option =3D l_strdup_printf("--log-fd=3D%d", fd);
-			argv[idx++] =3D fd_option;
-		} else
-			argv[idx++] =3D "--log-file=3D/tmp/valgrind.log";
+		fd_option =3D l_strdup_printf("--log-fd=3D%d", fd);
+		argv[idx++] =3D fd_option;
 	}
 =

 	if (strcmp(gdb_opt, "iwd") =3D=3D 0) {
-- =

2.17.1

--===============6189283106535924397==--

