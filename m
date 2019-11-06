Content-Type: multipart/mixed; boundary="===============1174049021237606680=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/2] test-runner: run iwmon if --log is used
Date: Wed, 06 Nov 2019 13:38:14 -0800
Message-ID: <20191106213815.20555-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1174049021237606680==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Now that execute_program handles logging automatically its trivial
to add iwmon to the test and get monitor logs as well as normal
process output.
---
 tools/test-runner.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/test-runner.c b/tools/test-runner.c
index 00989391..1c807aea 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -1592,6 +1592,18 @@ static void terminate_iwd(pid_t iwd_pid)
 	kill_process(iwd_pid);
 }
 =

+static pid_t start_monitor(const char *test_name)
+{
+	char *argv[4];
+
+	argv[0] =3D "iwmon";
+	argv[1] =3D "--nortnl";
+	argv[2] =3D "--nowiphy";
+	argv[3] =3D NULL;
+
+	return execute_program(argv, environ, false, test_name);
+}
+
 static bool create_tmpfs_extra_stuff(char **tmpfs_extra_stuff)
 {
 	size_t i =3D 0;
@@ -2004,6 +2016,7 @@ static void create_network_and_run_tests(void *data, =
void *user_data)
 	pid_t medium_pid =3D -1;
 	pid_t ofono_pid =3D -1;
 	pid_t phonesim_pid =3D -1;
+	pid_t monitor_pid =3D -1;
 	char *config_dir_path;
 	char *iwd_config_dir;
 	char **tmpfs_extra_stuff =3D NULL;
@@ -2149,6 +2162,9 @@ static void create_network_and_run_tests(void *data, =
void *user_data)
 		l_queue_foreach(wiphy_list, wiphy_up, NULL);
 	}
 =

+	if (log)
+		monitor_pid =3D start_monitor(test_name);
+
 	if (check_verbosity("tls"))
 		setenv("IWD_TLS_DEBUG", "on", true);
 =

@@ -2233,6 +2249,9 @@ static void create_network_and_run_tests(void *data, =
void *user_data)
 		stop_phonesim(phonesim_pid);
 	}
 =

+	if (monitor_pid > 0)
+		kill_process(monitor_pid);
+
 exit_hostapd:
 	destroy_hostapd_instances(hostapd_pids);
 =

-- =

2.17.1

--===============1174049021237606680==--

