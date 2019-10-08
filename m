Content-Type: multipart/mixed; boundary="===============3955758048192644437=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [RFC] test-runner: log process output to host system
Date: Tue, 08 Oct 2019 12:10:27 -0700
Message-ID: <20191008191027.7128-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3955758048192644437==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

All the processes verbose output is just written to stdout, and very
hard to parse after the test runs. Having test-runner write the
processes output to separate log files is much nicer to view after
the test runs.

A read/write file system is created which is separate and isolated
from the current FS mount (which mounts the whole host file system).
Doing this requires the user to create a folder somewhere to be used
as the mount point. This folder is where all the log files will end
up after test-runner runs.

Since test-runner must be run as root, care was taken to keep the
log files owned by the user which runs test-runner. The UID/GID
are passed to the VM, and any log files created are chown'ed back
to the user who ran test-runner.

execute_program was refactored, and both verbose and log arguments
were removed. The verbose argument was not really required since
we can do check_verbosity(argv[0]) internally. The 'log' flag was
only used along with --shell, and now the user can simply use
--log instead of dumping /tmp/iwd.log.

You can use this feature by specifying --log[=3Dpath] to test-runner.
If no path is provided the current directory will be used. Using
the --log flag will result in all processes being run with the
--verbose flag.

A new folder will be created under the --log path. The folder will
be of the name "run-<year>-<month>-<dat>-<PID>". Under this folder
you will find any global process logs. These are processes that
are only run once for ALL tests (hwsim, ifconfig, dbus etc.). There
will also be folders for specific tests that were run. Inside these
test folders will be logs of processes that are run per-test (iwd,
hostapd, python etc.).
---
 tools/test-runner.c | 276 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 223 insertions(+), 53 deletions(-)

diff --git a/tools/test-runner.c b/tools/test-runner.c
index 88cc16a8..2ba5e17c 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -45,6 +45,7 @@
 #include <sys/reboot.h>
 #include <sys/time.h>
 #include <glob.h>
+#include <time.h>
 #include <ell/ell.h>
 =

 #include "linux/nl80211.h"
@@ -82,6 +83,10 @@ const char *debug_filter;
 static struct l_settings *hw_config;
 static bool native_hw;
 static bool shell;
+static bool log;
+static char log_dir[PATH_MAX];
+static uid_t log_uid;
+static gid_t log_gid;
 static const char *qemu_binary;
 static const char *kernel_image;
 static const char *exec_home;
@@ -168,6 +173,14 @@ static bool check_verbosity(const char *app)
 {
 	char **apps =3D verbose_apps;
 =

+	/*
+	 * All processes are verbose if logging is enabled. Kernel is a bit
+	 * different as we just pipe dmesg into a log file at the end of
+	 * execution.
+	 */
+	if (log && strcmp(app, "kernel") !=3D 0)
+		return true;
+
 	if (!apps)
 		return false;
 =

@@ -358,6 +371,7 @@ static bool start_qemu(void)
 	int num_pci =3D 0, num_usb =3D 0;
 	char **pci_keys =3D NULL;
 	char **usb_keys =3D NULL;
+	L_AUTO_FREE_VAR(char *, log_option) =3D NULL;
 =

 	has_virt =3D check_virtualization();
 =

@@ -388,7 +402,8 @@ static bool start_qemu(void)
 			"TESTVERBOUT=3D\'%s\' DEBUG_FILTER=3D\'%s\'"
 			"TEST_ACTION=3D%u TEST_ACTION_PARAMS=3D\'%s\' "
 			"TESTARGS=3D\'%s\' PATH=3D\'%s\' VALGRIND=3D%u"
-			"GDB=3D\'%s\' HW=3D\'%s\' SHELL=3D%u",
+			"GDB=3D\'%s\' HW=3D\'%s\' SHELL=3D%u "
+			"LOG_PATH=3D\'%s\' LOG_UID=3D\'%d\' LOG_GID=3D\'%d\'",
 			check_verbosity("kernel") ? "ignore_loglevel" : "quiet",
 			initcmd, cwd, verbose_opt ? verbose_opt : "none",
 			enable_debug ? debug_filter : "",
@@ -399,7 +414,9 @@ static bool start_qemu(void)
 			valgrind,
 			gdb_opt ? gdb_opt : "none",
 			hw_config ? "real" : "virtual",
-			shell);
+			shell,
+			log ? log_dir : "none",
+			log_uid, log_gid);
 =

 	if (hw_config) {
 		if (l_settings_has_group(hw_config, "PCIAdapters")) {
@@ -429,9 +446,10 @@ static bool start_qemu(void)
 	 * -kernel,-append,-cpu,-host parameters (7)
 	 * -enable-kvm and/or -usb (2)
 	 * PCI and/or USB parameters (num_pci * 2) (num_usb * 2)
+	 * Logging directory/device (2)
 	 */
 	argv =3D alloca(sizeof(qemu_argv) + sizeof(char *) *
-				(7 + (2 + (num_pci * 2) + (num_usb * 2))));
+				(7 + (2 + (num_pci * 2) + (num_usb * 2) + 2)));
 	memcpy(argv, qemu_argv, sizeof(qemu_argv));
 =

 	pos =3D (sizeof(qemu_argv) / sizeof(char *)) - 1;
@@ -480,6 +498,18 @@ static bool start_qemu(void)
 		}
 	}
 =

+	if (log) {
+		/*
+		 * Create a virtfs device and tag it. This allows the guest to
+		 * mount 'logdir' in the path specified with --log.
+		 */
+		log_option =3D l_strdup_printf("local,path=3D%s,mount_tag=3Dlogdir,"
+					"security_model=3Dpassthrough,id=3Dlogdir",
+					log_dir);
+		argv[pos++] =3D "-virtfs";
+		argv[pos++] =3D log_option;
+	}
+
 	argv[pos] =3D NULL;
 =

 	execve(argv[0], argv, qemu_envp);
@@ -492,11 +522,12 @@ static bool start_qemu(void)
 }
 =

 static pid_t execute_program(char *argv[], char *envp[], bool wait,
-						bool verbose, bool log)
+				const char *test_name)
 {
 	int status;
 	pid_t pid, child_pid;
 	char *str;
+	bool verbose;
 =

 	if (!argv[0])
 		return -1;
@@ -512,18 +543,34 @@ static pid_t execute_program(char *argv[], char *envp=
[], bool wait,
 	}
 =

 	if (child_pid =3D=3D 0) {
-		if (!verbose) {
-			int fd;
-			char log_file[PATH_MAX];
-
-			if (!log)
-				fd =3D open("/dev/null", O_WRONLY);
-			else {
-				sprintf(log_file, "/tmp/%s.log", argv[0]);
-				fd =3D open(log_file, O_WRONLY | O_CREAT,
-							S_IRUSR | S_IWUSR);
-			}
+		int fd =3D -1;
+		char log_file[PATH_MAX];
 =

+		verbose =3D check_verbosity(argv[0]);
+
+		/* No stdout and no logging */
+		if (!verbose && !log)
+			fd =3D open("/dev/null", O_WRONLY);
+		else if (log && verbose) {
+			/*
+			 * Create the log file for this process. If no test name
+			 * was specified this is a 'global' process (only run
+			 * once, not per-test).
+			 */
+			if (test_name) {
+				sprintf(log_file, "%s/%s/%s.log",
+						log_dir, test_name, argv[0]);
+			} else
+				sprintf(log_file, "%s/%s.log",
+						log_dir, argv[0]);
+
+			fd =3D open(log_file, O_WRONLY | O_CREAT | O_APPEND,
+					S_IRUSR | S_IWUSR);
+			if (fchown(fd, log_uid, log_gid) < 0)
+				l_error("fchown failed");
+		}
+
+		if (fd > -1) {
 			dup2(fd, 1);
 			dup2(fd, 2);
 =

@@ -630,8 +677,7 @@ static bool start_dbus_daemon(void)
 	if (check_verbosity("dbus"))
 		setenv("DBUS_VERBOSE", "1", true);
 =

-	pid =3D execute_program(argv, environ, false,
-					check_verbosity("dbus"), false);
+	pid =3D execute_program(argv, environ, false, NULL);
 	if (pid < 0)
 		return false;
 =

@@ -642,7 +688,7 @@ static bool start_dbus_daemon(void)
 		argv[0] =3D "dbus-monitor";
 		argv[1] =3D "--system";
 		argv[2] =3D NULL;
-		execute_program(argv, environ, false, true, false);
+		execute_program(argv, environ, false, NULL);
 	}
 =

 	l_debug("D-Bus is running");
@@ -658,7 +704,7 @@ static bool start_haveged(void)
 	argv[0] =3D "haveged";
 	argv[1] =3D NULL;
 =

-	pid =3D execute_program(argv, environ, true, false, false);
+	pid =3D execute_program(argv, environ, true, NULL);
 	if (pid < 0)
 		return false;
 =

@@ -680,7 +726,7 @@ static bool set_interface_state(const char *if_name, bo=
ol isUp)
 	argv[2] =3D state;
 	argv[3] =3D NULL;
 =

-	pid =3D execute_program(argv, environ, true, false, false);
+	pid =3D execute_program(argv, environ, true, NULL);
 	if (pid < 0)
 		return false;
 =

@@ -702,7 +748,7 @@ static bool create_interface(const char *if_name, const=
 char *phy_name)
 	argv[7] =3D "managed";
 	argv[8] =3D NULL;
 =

-	pid =3D execute_program(argv, environ, true, false, false);
+	pid =3D execute_program(argv, environ, true, NULL);
 	if (pid < 0)
 		return false;
 =

@@ -720,7 +766,7 @@ static bool delete_interface(const char *if_name)
 	argv[3] =3D "del";
 	argv[4] =3D NULL;
 =

-	pid =3D execute_program(argv, environ, true, false, false);
+	pid =3D execute_program(argv, environ, true, NULL);
 	if (pid < 0)
 		return false;
 =

@@ -736,7 +782,7 @@ static bool list_interfaces(void)
 	argv[1] =3D "-a";
 	argv[2] =3D NULL;
 =

-	pid =3D execute_program(argv, environ, true, true, false);
+	pid =3D execute_program(argv, environ, true, NULL);
 	if (pid < 0)
 		return false;
 =

@@ -752,7 +798,7 @@ static bool list_hwsim_radios(void)
 	argv[1] =3D "--list";
 	argv[2] =3D NULL;
 =

-	pid =3D execute_program(argv, environ, true, true, false);
+	pid =3D execute_program(argv, environ, true, NULL);
 	if (pid < 0)
 		return false;
 =

@@ -800,8 +846,7 @@ static int create_hwsim_radio(const char *radio_name,
 =

 	argv[idx] =3D NULL;
 =

-	pid =3D execute_program(argv, environ, true,
-					check_verbosity(BIN_HWSIM), false);
+	pid =3D execute_program(argv, environ, true, NULL);
 	if (pid < 0)
 		return -1;
 =

@@ -820,7 +865,7 @@ static bool destroy_hwsim_radio(int radio_id)
 	argv[1] =3D destroy_param;
 	argv[2] =3D NULL;
 =

-	pid =3D execute_program(argv, environ, true, false, false);
+	pid =3D execute_program(argv, environ, true, NULL);
 	if (pid < 0)
 		return false;
 =

@@ -840,8 +885,7 @@ static pid_t register_hwsim_as_trans_medium(void)
 	argv[idx++] =3D BIN_HWSIM;
 	argv[idx++] =3D NULL;
 =

-	return execute_program(argv, environ, false,
-					check_verbosity(BIN_HWSIM), false);
+	return execute_program(argv, environ, false, NULL);
 }
 =

 static void terminate_medium(pid_t medium_pid)
@@ -865,13 +909,13 @@ static void start_loopback(void)
 	argv[2] =3D "127.0.0.1";
 	argv[3] =3D "up";
 	argv[4] =3D NULL;
-	execute_program(argv, environ, false, false, false);
+	execute_program(argv, environ, false, NULL);
 =

 	argv[0] =3D "route";
 	argv[1] =3D "add";
 	argv[2] =3D "127.0.0.1";
 	argv[3] =3D NULL;
-	execute_program(argv, environ, false, false, false);
+	execute_program(argv, environ, false, NULL);
 =

 	loopback_started =3D true;
 }
@@ -890,7 +934,7 @@ static pid_t start_phonesim(void)
 =

 	setenv("OFONO_PHONESIM_CONFIG", "/tmp/phonesim.conf", true);
 =

-	return execute_program(argv, environ, false, false, false);
+	return execute_program(argv, environ, false, NULL);
 }
 =

 static void stop_phonesim(pid_t pid)
@@ -916,7 +960,7 @@ static pid_t start_ofono(void)
 =

 	start_loopback();
 =

-	return execute_program(argv, environ, false, verbose, false);
+	return execute_program(argv, environ, false, NULL);
 }
 =

 static void stop_ofono(pid_t pid)
@@ -924,7 +968,8 @@ static void stop_ofono(pid_t pid)
 	kill_process(pid);
 }
 =

-static pid_t start_hostapd(char **config_files, struct wiphy **wiphys)
+static pid_t start_hostapd(char **config_files, struct wiphy **wiphys,
+				const char *test_name)
 {
 	char **argv;
 	pid_t pid;
@@ -971,7 +1016,7 @@ static pid_t start_hostapd(char **config_files, struct=
 wiphy **wiphys)
 		argv[idx++] =3D NULL;
 	}
 =

-	pid =3D execute_program(argv, environ, false, verbose, false);
+	pid =3D execute_program(argv, environ, false, log ? test_name : NULL);
 	if (pid < 0) {
 		goto exit;
 	}
@@ -1409,7 +1454,8 @@ hostapd_done:
 		(*phys_used)++;
 	}
 =

-	hostapd_pids_out[0] =3D start_hostapd(hostapd_config_file_paths, wiphys);
+	hostapd_pids_out[0] =3D start_hostapd(hostapd_config_file_paths, wiphys,
+						basename(config_dir_path));
 	hostapd_pids_out[1] =3D -1;
 =

 done:
@@ -1422,17 +1468,35 @@ done:
 }
 =

 static pid_t start_iwd(const char *config_dir, struct l_queue *wiphy_list,
-		const char *ext_options, int num_phys)
+		const char *ext_options, int num_phys, const char *test_name)
 {
 	char *argv[13], **envp;
 	char *iwd_phys =3D NULL;
 	pid_t ret;
 	int idx =3D 0;
+	L_AUTO_FREE_VAR(char *, fd_option) =3D NULL;
+	char valgrind_log[PATH_MAX];
 =

 	if (valgrind) {
+		int fd;
+
 		argv[idx++] =3D "valgrind";
 		argv[idx++] =3D "--leak-check=3Dfull";
-		argv[idx++] =3D "--log-file=3D/tmp/valgrind.log";
+
+		/*
+		 * Valgrind needs --log-fd if we want both stderr and stdout
+		 */
+		if (log) {
+			snprintf(valgrind_log, sizeof(valgrind_log),
+					"%s/%s/valgrind.log", log_dir,
+					test_name);
+			fd =3D open(valgrind_log, O_WRONLY | O_CREAT | O_APPEND,
+					S_IRUSR | S_IWUSR);
+
+			fd_option =3D l_strdup_printf("--log-fd=3D%d", fd);
+			argv[idx++] =3D fd_option;
+		} else
+			argv[idx++] =3D "--log-file=3D/tmp/valgrind.log";
 	}
 =

 	if (strcmp(gdb_opt, "iwd") =3D=3D 0) {
@@ -1489,8 +1553,7 @@ static pid_t start_iwd(const char *config_dir, struct=
 l_queue *wiphy_list,
 	envp =3D l_strv_append_printf(envp, "STATE_DIRECTORY=3D%s",
 							DAEMON_STORAGEDIR);
 =

-	ret =3D execute_program(argv, envp, false,
-					check_verbosity(BIN_IWD), shell);
+	ret =3D execute_program(argv, envp, false, test_name);
 =

 	l_strv_free(envp);
 =

@@ -1714,7 +1777,8 @@ struct test_stats {
 =

 static void run_py_tests(struct l_settings *hw_settings,
 					struct l_queue *test_queue,
-					struct l_queue *test_stats_queue)
+					struct l_queue *test_stats_queue,
+					const char *test_name)
 {
 	char *argv[3];
 	pid_t test_exec_pid, test_timer_pid =3D -1;
@@ -1745,8 +1809,7 @@ start_next_test:
 	argv[2] =3D NULL;
 =

 	print_test_status(py_test, TEST_STATUS_STARTED, 0);
-	test_exec_pid =3D execute_program(argv, environ, false,
-					check_verbosity("pytests"), false);
+	test_exec_pid =3D execute_program(argv, environ, false, test_name);
 =

 	gettimeofday(&time_before, NULL);
 =

@@ -1887,7 +1950,7 @@ static void set_reg_domain(const char *domain)
 	argv[3] =3D (char *) domain;
 	argv[4] =3D NULL;
 =

-	execute_program(argv, environ, false, false, false);
+	execute_program(argv, environ, false, NULL);
 }
 =

 static void wiphy_up(void *data, void *user_data)
@@ -1931,6 +1994,7 @@ static void create_network_and_run_tests(void *data, =
void *user_data)
 	int phys_used;
 	int num_radios;
 	struct test_entry *entry =3D data;
+	char *test_name =3D NULL;
 =

 	memset(hostapd_pids, -1, sizeof(hostapd_pids));
 =

@@ -1952,6 +2016,19 @@ static void create_network_and_run_tests(void *data,=
 void *user_data)
 =

 	l_info("Configuring network...");
 =

+	if (log) {
+		char *log_path;
+
+		test_name =3D basename(config_dir_path);
+		log_path =3D l_strdup_printf("%s/%s", log_dir, test_name);
+
+		mkdir(log_path, 0755);
+		if (chown(log_path, log_uid, log_gid) < 0)
+			l_error("chown failed");
+
+		l_free(log_path);
+	}
+
 	if (chdir(config_dir_path) < 0) {
 		l_error("Failed to change to test directory: %s",
 							strerror(errno));
@@ -2076,7 +2153,7 @@ static void create_network_and_run_tests(void *data, =
void *user_data)
 			iwd_config_dir =3D DAEMON_CONFIGDIR;
 =

 		iwd_pid =3D start_iwd(iwd_config_dir, wiphy_list,
-				iwd_ext_options, iwd_phys);
+				iwd_ext_options, iwd_phys, test_name);
 =

 		if (iwd_pid =3D=3D -1)
 			goto exit_hostapd;
@@ -2094,7 +2171,8 @@ static void create_network_and_run_tests(void *data, =
void *user_data)
 	set_wiphy_list(wiphy_list);
 =

 	if (!shell)
-		run_py_tests(hw_settings, test_queue, test_stats_queue);
+		run_py_tests(hw_settings, test_queue, test_stats_queue,
+				test_name);
 	else {
 		if (system("/bin/sh"))
 			l_info("executing /bin/sh failed");
@@ -2106,10 +2184,23 @@ static void create_network_and_run_tests(void *data=
, void *user_data)
 	if (iwd_pid > 0)
 		terminate_iwd(iwd_pid);
 =

-	if (valgrind)
+	if (valgrind && !log)
 		if (system("cat /tmp/valgrind.log"))
 			l_info("cat /tmp/valgrind.log failed");
 =

+	if (log) {
+		L_AUTO_FREE_VAR(char *, dmesg);
+		L_AUTO_FREE_VAR(char *, kernel_log);
+
+		kernel_log =3D l_strdup_printf("%s/kernel.log", log_dir);
+		dmesg =3D l_strdup_printf("dmesg > %s", kernel_log);
+
+		if (system(dmesg))
+			l_error("dmesg failed");
+		if (chown(kernel_log, log_uid, log_gid))
+			l_error("chown failed");
+	}
+
 	if (ofono_req) {
 		loopback_started =3D false;
 		stop_ofono(ofono_pid);
@@ -2252,13 +2343,21 @@ static void free_test_entry(void *data)
 =

 static void run_auto_tests(void)
 {
-	L_AUTO_FREE_VAR(char*, test_home_path);
-	L_AUTO_FREE_VAR(char*, env_path);
+	L_AUTO_FREE_VAR(char*, test_home_path) =3D NULL;
+	L_AUTO_FREE_VAR(char*, env_path) =3D NULL;
 	int i;
 	struct l_queue *test_config_queue;
 	struct l_queue *test_stat_queue;
 	char **test_config_dirs;
 =

+	if (log) {
+		if (mount("logdir", log_dir, "9p", 0,
+					"trans=3Dvirtio,version=3D9p2000.L") < 0) {
+			l_error("Mounting %s failed", log_dir);
+			return;
+		}
+	}
+
 	env_path =3D l_strdup_printf("%s/src:%s/tools:%s", top_level_path,
 					top_level_path, getenv("PATH"));
 =

@@ -2383,8 +2482,7 @@ static void run_unit_tests(void)
 		argv[0] =3D unit_test_abs_path;
 		argv[1] =3D NULL;
 =

-		execute_program(argv, environ, true,
-					check_verbosity("unit"), false);
+		execute_program(argv, environ, true, NULL);
 =

 		l_free(unit_test_abs_path);
 	}
@@ -2632,6 +2730,38 @@ static void run_tests(void)
 		return;
 	}
 =

+	ptr =3D strstr(cmdline, "LOG_GID=3D");
+	if (ptr) {
+		*ptr =3D '\0';
+		test_action_str =3D ptr + 9;
+		ptr =3D strchr(test_action_str, '\'');
+		*ptr =3D '\0';
+		log_gid =3D atoi(test_action_str);
+	}
+
+	ptr =3D strstr(cmdline, "LOG_UID=3D");
+	if (ptr) {
+		*ptr =3D '\0';
+		test_action_str =3D ptr + 9;
+		ptr =3D strchr(test_action_str, '\'');
+		*ptr =3D '\0';
+		log_uid =3D atoi(test_action_str);
+	}
+
+	ptr =3D strstr(cmdline, "LOG_PATH=3D");
+	if (ptr) {
+		*ptr =3D '\0';
+		test_action_str =3D ptr + 10;
+
+		ptr =3D strchr(test_action_str, '\'');
+		*ptr =3D '\0';
+
+		if (strcmp(test_action_str, "none")) {
+			log =3D true;
+			strcpy(log_dir, test_action_str);
+		}
+	}
+
 	ptr =3D strstr(cmdline, "SHELL=3D");
 	if (ptr) {
 		*ptr =3D '\0';
@@ -2839,7 +2969,13 @@ static void usage(void)
 					"\t\t\t\tbut no test will be run. If no"
 					" test is specified\n"
 					"\t\t\t\tthe 'shell' test"
-					" will be used");
+					" will be used\n"
+		"\t-l, --log [dir]		Directory used for log output. "
+					"If no directory\n"
+					"\t\t\t\tis specified the "
+					"current directory will be used\n"
+					"\t\t\t\tThis option sets --verbose on "
+					"all apps");
 	l_info("Commands:\n"
 		"\t-A, --auto-tests <dirs>	Comma separated list of the "
 						"test configuration\n\t\t\t\t"
@@ -2859,6 +2995,7 @@ static const struct option main_options[] =3D {
 	{ "valgrind",	no_argument,       NULL, 'V' },
 	{ "hw",		required_argument, NULL, 'w' },
 	{ "shell",	optional_argument, NULL, 's' },
+	{ "log",	optional_argument, NULL, 'l' },
 	{ "help",	no_argument,       NULL, 'h' },
 	{ }
 };
@@ -2866,6 +3003,8 @@ static const struct option main_options[] =3D {
 int main(int argc, char *argv[])
 {
 	uint8_t actions =3D 0;
+	struct tm *timeinfo;
+	time_t t;
 =

 	l_log_set_stderr();
 =

@@ -2887,7 +3026,7 @@ int main(int argc, char *argv[])
 	for (;;) {
 		int opt;
 =

-		opt =3D getopt_long(argc, argv, "A:U:q:k:v:g:Vdh", main_options,
+		opt =3D getopt_long(argc, argv, "A:U:q:k:v:g:Vldh", main_options,
 									NULL);
 		if (opt < 0)
 			break;
@@ -2947,6 +3086,37 @@ int main(int argc, char *argv[])
 			break;
 		case 's':
 			shell =3D true;
+			break;
+		case 'l':
+			/*
+			 * Setup the log directory. This is created under the
+			 * passed in log dir (--log) in the format:
+			 * <logdir>/run-<year>-<month>-<day>-<PID>
+			 *
+			 * The created log dir is then chown'ed to the user
+			 * who started test-runner, as are all files created
+			 * under this directory.
+			 */
+			log =3D true;
+
+			if (!optarg)
+				optarg =3D ".";
+
+			time(&t);
+			timeinfo =3D localtime(&t);
+
+			log_gid =3D atoi(getenv("SUDO_GID"));
+			log_uid =3D atoi(getenv("SUDO_UID"));
+
+			snprintf(log_dir, sizeof(log_dir), "%s/run-%d-%d-%d-%d",
+					optarg, timeinfo->tm_year,
+					timeinfo->tm_mon, timeinfo->tm_mday,
+					getpid());
+			mkdir(log_dir, 0755);
+
+			if (chown(log_dir, log_uid, log_gid) < 0)
+				l_error("fchown failed");
+
 			break;
 		case 'h':
 			usage();
-- =

2.17.1

--===============3955758048192644437==--

