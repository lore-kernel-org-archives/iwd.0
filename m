Content-Type: multipart/mixed; boundary="===============0341601652982753179=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] test-runner: special case python3 verbose option
Date: Tue, 05 Nov 2019 15:36:04 -0800
Message-ID: <20191105233604.12933-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0341601652982753179==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Historically if you wanted to see output from a python test you needed
to specify -v pytests. This was also the case if IWD was started from
python.

Nearly every time I run test-runner I would specify "-v iwd,pytests"
only to get the IWD output on these specific tests.

Instead we can special case 'python3' (previously 'pytests') inside
execute_program so that turning on verbosity for 'iwd' also turns it
on for the python tests.
---
 tools/test-runner.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/tools/test-runner.c b/tools/test-runner.c
index a83e1252..00989391 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -541,13 +541,17 @@ static pid_t execute_program(char *argv[], char *envp=
[], bool wait,
 		return -1;
 =

 	/*
-	 * We have to special case this. execute_program automatically logs to
-	 * <process>.log, which would put all iwd output into valgrind.log
-	 * rather than iwd.log. Since we are explicitly having valgrind output
-	 * to a log file we can assume any output from this is only IWD, and not
-	 * valgrind.
+	 * We have a few special cases here:
+	 *
+	 * Since execute_program automatically logs to <process>.log this would
+	 * put all iwd output into valgrind.log rather than iwd.log. Since we
+	 * are explicitly having valgrind output to a log file we can assume any
+	 * output from this is only IWD, and not valgrind.
+	 *
+	 * python3 is special cased so that tests which start IWD manually can
+	 * still show IWD output when using -v iwd.
 	 */
-	if (!strcmp(log_name, "valgrind"))
+	if (!strcmp(log_name, "valgrind") || !strcmp(log_name, "python3"))
 		log_name =3D "iwd";
 =

 	str =3D l_strjoinv(argv, ' ');
-- =

2.17.1

--===============0341601652982753179==--

