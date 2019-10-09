Content-Type: multipart/mixed; boundary="===============0442590819833685020=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] test-runner: allow all unit tests to be run in VM
Date: Wed, 09 Oct 2019 09:57:00 -0700
Message-ID: <20191009165700.12739-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0442590819833685020==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The -U parameter only allowed for a list of unit tests to be run.
Most of the time for sanity checking you want to run all the unit
tests so this has been changed to take an optional argument.

Now, the -U flag (by itself) will run all unit tests. Running a
single or list of unit tests can still be achieved by:

--unit-tests=3Dtest-eapol,test-crypto
---
 tools/test-runner.c | 48 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 37 insertions(+), 11 deletions(-)

diff --git a/tools/test-runner.c b/tools/test-runner.c
index 88cc16a8..b3e509c2 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -2364,28 +2364,54 @@ exit:
 =

 static void run_unit_tests(void)
 {
-	size_t i;
+	DIR *d;
+	struct dirent *dirent;
 	char *argv[2];
-	char *unit_test_abs_path;
-	char **unit_tests =3D l_strsplit(test_action_params, ',');
+	char *unit_test_abs_path =3D NULL;
+	char **unit_tests =3D NULL;
 =

-	if (!unit_tests || !unit_tests[0])
-		goto exit;
+	if (strcmp(test_action_params, "")) {
+		unit_tests =3D l_strsplit(test_action_params, ',');
+
+		if (!unit_tests || !unit_tests[0])
+			goto exit;
+	}
 =

 	if (chdir(top_level_path) < 0)
 		goto exit;
 =

-	for (i =3D 0; unit_tests[i]; i++) {
-		unit_test_abs_path =3D
-			l_strdup_printf("%s%s%s", top_level_path, "/unit/",
-								unit_tests[i]);
+	d =3D opendir("unit/");
+	if (!d)
+		goto exit;
+
+	while ((dirent =3D readdir(d)) !=3D NULL) {
+		struct stat st;
+
+		if (dirent->d_type !=3D DT_REG)
+			continue;
+
+		unit_test_abs_path =3D l_strdup_printf("%s%s%s", top_level_path,
+						"/unit/", dirent->d_name);
+
+		if (stat(unit_test_abs_path, &st) < 0)
+			goto next;
+
+		if (!(st.st_mode & S_IEXEC))
+			goto next;
+
+		if (unit_tests) {
+			if (!l_strv_contains(unit_tests, dirent->d_name))
+				goto next;
+		}
 =

 		argv[0] =3D unit_test_abs_path;
 		argv[1] =3D NULL;
 =

+		l_info("\n---------- Unit %s ----------", dirent->d_name);
 		execute_program(argv, environ, true,
 					check_verbosity("unit"), false);
 =

+next:
 		l_free(unit_test_abs_path);
 	}
 =

@@ -2850,7 +2876,7 @@ static void usage(void)
 =

 static const struct option main_options[] =3D {
 	{ "auto-tests",	required_argument, NULL, 'A' },
-	{ "unit-tests",	required_argument, NULL, 'U' },
+	{ "unit-tests",	optional_argument, NULL, 'U' },
 	{ "qemu",	required_argument, NULL, 'q' },
 	{ "kernel",	required_argument, NULL, 'k' },
 	{ "verbose",	required_argument, NULL, 'v' },
@@ -2887,7 +2913,7 @@ int main(int argc, char *argv[])
 	for (;;) {
 		int opt;
 =

-		opt =3D getopt_long(argc, argv, "A:U:q:k:v:g:Vdh", main_options,
+		opt =3D getopt_long(argc, argv, "A:q:k:v:g:UVdh", main_options,
 									NULL);
 		if (opt < 0)
 			break;
-- =

2.17.1

--===============0442590819833685020==--

