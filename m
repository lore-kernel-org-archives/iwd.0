Content-Type: multipart/mixed; boundary="===============6705711008368888061=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/2] test-runner: run iwmon per-subtest
Date: Tue, 05 May 2020 09:03:17 -0700
Message-ID: <20200505160318.26419-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6705711008368888061==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Previously iwmon was running per-test, which would jumble any subtests
together into the same log file making it hard to parse. Now create
a separate directory for each subtest and put the monitor log and
pcap there.
---
 tools/test-runner.c | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/tools/test-runner.c b/tools/test-runner.c
index 88bb50e1..5874421c 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -1847,6 +1847,7 @@ static void run_py_tests(struct l_settings *hw_settin=
gs,
 	unsigned int max_exec_interval;
 	char *py_test =3D NULL;
 	struct test_stats *test_stats;
+	pid_t monitor_pid =3D -1;
 =

 	if (!l_settings_get_uint(hw_settings, HW_CONFIG_GROUP_SETUP,
 						HW_CONFIG_SETUP_MAX_EXEC_SEC,
@@ -1865,6 +1866,28 @@ start_next_test:
 	if (!py_test)
 		return;
 =

+	if (log) {
+		char *test_path;
+		char *ext;
+		char *full_path;
+
+		test_path =3D l_strdup_printf("%s/%s", test_name, py_test);
+		ext =3D strchr(test_path, '.');
+		ext[0] =3D '\0';
+
+		full_path =3D l_strdup_printf("%s/%s", log_dir, test_path);
+
+		mkdir(full_path, 0755);
+		if (chown(full_path, log_uid, log_gid) < 0)
+			l_error("chown failed %s", full_path);
+
+		l_free(full_path);
+
+		monitor_pid =3D start_monitor(test_path);
+
+		l_free(test_path);
+	}
+
 	argv[0] =3D "python3";
 	argv[1] =3D py_test;
 	argv[2] =3D NULL;
@@ -1928,6 +1951,11 @@ start_next_test:
 	l_free(py_test);
 	py_test =3D NULL;
 =

+	if (monitor_pid !=3D -1) {
+		kill_process(monitor_pid);
+		monitor_pid =3D -1;
+	}
+
 	goto start_next_test;
 }
 =

@@ -2040,7 +2068,6 @@ static void create_network_and_run_tests(void *data, =
void *user_data)
 	pid_t medium_pid =3D -1;
 	pid_t ofono_pid =3D -1;
 	pid_t phonesim_pid =3D -1;
-	pid_t monitor_pid =3D -1;
 	char *config_dir_path;
 	char *iwd_config_dir;
 	char **tmpfs_extra_stuff =3D NULL;
@@ -2186,9 +2213,6 @@ static void create_network_and_run_tests(void *data, =
void *user_data)
 		l_queue_foreach(wiphy_list, wiphy_up, NULL);
 	}
 =

-	if (log)
-		monitor_pid =3D start_monitor(test_name);
-
 	if (check_verbosity("tls"))
 		setenv("IWD_TLS_DEBUG", "on", true);
 =

@@ -2277,9 +2301,6 @@ static void create_network_and_run_tests(void *data, =
void *user_data)
 		stop_phonesim(phonesim_pid);
 	}
 =

-	if (monitor_pid > 0)
-		kill_process(monitor_pid);
-
 exit_hostapd:
 	destroy_hostapd_instances(hostapd_pids);
 =

-- =

2.21.1

--===============6705711008368888061==--

