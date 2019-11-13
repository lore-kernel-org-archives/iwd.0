Content-Type: multipart/mixed; boundary="===============3469712705736813398=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] test-runner: make --log take a required argument
Date: Wed, 13 Nov 2019 09:55:50 -0800
Message-ID: <20191113175550.20873-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3469712705736813398==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This was a mistake in the original implementation. Since test-runner
is always run from the tools directory using --log with no directory
specified would result in many log files being put into the iwd tree.

Instead we can make --log take a required argument so its more
obvious where all the logs are going to go.
---
 tools/test-runner.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/tools/test-runner.c b/tools/test-runner.c
index 82f009ae..043e8cc7 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -3044,12 +3044,9 @@ static void usage(void)
 					" test is specified\n"
 					"\t\t\t\tthe 'shell' test"
 					" will be used\n"
-		"\t-l, --log [dir]		Directory used for log output. "
-					"If no directory\n"
-					"\t\t\t\tis specified the "
-					"current directory will be used\n"
-					"\t\t\t\tThis option sets --verbose on "
-					"all apps");
+		"\t-l, --log <dir>		Directory used for log output. "
+					"This option sets \n"
+					"\t\t\t\t--verbose on all apps");
 	l_info("Commands:\n"
 		"\t-A, --auto-tests <dirs>	Comma separated list of the "
 						"test configuration\n\t\t\t\t"
@@ -3069,7 +3066,7 @@ static const struct option main_options[] =3D {
 	{ "valgrind",	no_argument,       NULL, 'V' },
 	{ "hw",		required_argument, NULL, 'w' },
 	{ "shell",	optional_argument, NULL, 's' },
-	{ "log",	optional_argument, NULL, 'l' },
+	{ "log",	required_argument, NULL, 'l' },
 	{ "help",	no_argument,       NULL, 'h' },
 	{ }
 };
@@ -3100,7 +3097,7 @@ int main(int argc, char *argv[])
 	for (;;) {
 		int opt;
 =

-		opt =3D getopt_long(argc, argv, "A:q:k:v:g:UVldh", main_options,
+		opt =3D getopt_long(argc, argv, "A:q:k:v:g:l:UVdh", main_options,
 									NULL);
 		if (opt < 0)
 			break;
-- =

2.17.1

--===============3469712705736813398==--

