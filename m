Content-Type: multipart/mixed; boundary="===============1102825729992751641=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] test-runner: move ofono/phonesim logs into test dir
Date: Thu, 14 Nov 2019 11:57:51 -0800
Message-ID: <20191114195751.27895-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1102825729992751641==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

These two processes are executed per-test so they can be passed the
test name and have the logs stored only in tests that actually need
them rather than at the top level.
---
 tools/test-runner.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/test-runner.c b/tools/test-runner.c
index 075f56d6..5e10f542 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -940,7 +940,7 @@ static void start_loopback(void)
 	loopback_started =3D true;
 }
 =

-static pid_t start_phonesim(void)
+static pid_t start_phonesim(const char *test_name)
 {
 	char *argv[5];
 =

@@ -954,7 +954,7 @@ static pid_t start_phonesim(void)
 =

 	setenv("OFONO_PHONESIM_CONFIG", "/tmp/phonesim.conf", true);
 =

-	return execute_program(argv, environ, false, NULL);
+	return execute_program(argv, environ, false, test_name);
 }
 =

 static void stop_phonesim(pid_t pid)
@@ -962,7 +962,7 @@ static void stop_phonesim(pid_t pid)
 	kill_process(pid);
 }
 =

-static pid_t start_ofono(void)
+static pid_t start_ofono(const char *test_name)
 {
 	char *argv[5];
 	bool verbose =3D check_verbosity(BIN_OFONO);
@@ -980,7 +980,7 @@ static pid_t start_ofono(void)
 =

 	start_loopback();
 =

-	return execute_program(argv, environ, false, NULL);
+	return execute_program(argv, environ, false, test_name);
 }
 =

 static void stop_ofono(pid_t pid)
@@ -2205,8 +2205,8 @@ static void create_network_and_run_tests(void *data, =
void *user_data)
 	}
 =

 	if (ofono_req) {
-		phonesim_pid =3D start_phonesim();
-		ofono_pid =3D start_ofono();
+		phonesim_pid =3D start_phonesim(test_name);
+		ofono_pid =3D start_ofono(test_name);
 	}
 =

 	set_wiphy_list(wiphy_list);
-- =

2.17.1

--===============1102825729992751641==--

