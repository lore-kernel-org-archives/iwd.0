Content-Type: multipart/mixed; boundary="===============2010214163083429549=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3] test-runner: log process output to host system
Date: Mon, 04 Nov 2019 11:44:30 -0800
Message-ID: <20191104194430.30169-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2010214163083429549==
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
 tools/test-runner.c | 299 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 244 insertions(+), 55 deletions(-)

diff --git a/tools/test-runner.c b/tools/test-runner.c
index 1049f9d4..6eff1847 100644
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
@@ -168,6 +173,21 @@ static bool check_verbosity(const char *app)
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
+	/*
+	 * Turn on output if this is a unit test run. Nothing should output
+	 * anything except the tests themselves and the kernel.
+	 */
+	if (test_action =3D=3D ACTION_UNIT_TEST && strcmp(app, "kernel") !=3D 0)
+		return true;
+
 	if (!apps)
 		return false;
 =

@@ -358,6 +378,7 @@ static bool start_qemu(void)
 	int num_pci =3D 0, num_usb =3D 0;
 	char **pci_keys =3D NULL;
 	char **usb_keys =3D NULL;
+	L_AUTO_FREE_VAR(char *, log_option) =3D NULL;
 =

 	has_virt =3D check_virtualization();
 =

@@ -388,7 +409,8 @@ static bool start_qemu(void)
 			"TESTVERBOUT=3D\'%s\' DEBUG_FILTER=3D\'%s\'"
 			"TEST_ACTION=3D%u TEST_ACTION_PARAMS=3D\'%s\' "
 			"TESTARGS=3D\'%s\' PATH=3D\'%s\' VALGRIND=3D%u"
-			"GDB=3D\'%s\' HW=3D\'%s\' SHELL=3D%u",
+			"GDB=3D\'%s\' HW=3D\'%s\' SHELL=3D%u "
+			"LOG_PATH=3D\'%s\' LOG_UID=3D\'%d\' LOG_GID=3D\'%d\'",
 			check_verbosity("kernel") ? "ignore_loglevel" : "quiet",
 			initcmd, cwd, verbose_opt ? verbose_opt : "none",
 			enable_debug ? debug_filter : "",
@@ -399,7 +421,9 @@ static bool start_qemu(void)
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
@@ -429,9 +453,10 @@ static bool start_qemu(void)
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
@@ -480,6 +505,18 @@ static bool start_qemu(void)
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
@@ -492,15 +529,27 @@ static bool start_qemu(void)
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
+	char *log_name =3D argv[0];
 =

 	if (!argv[0])
 		return -1;
 =

+	/*
+	 * We have to special case this. execute_program automatically logs to
+	 * <process>.log, which would put all iwd output into valgrind.log
+	 * rather than iwd.log. Since we are explicitly having valgrind output
+	 * to a log file we can assume any output from this is only IWD, and not
+	 * valgrind.
+	 */
+	if (!strcmp(log_name, "valgrind"))
+		log_name =3D "iwd";
+
 	str =3D l_strjoinv(argv, ' ');
 	l_debug("Executing: %s", str);
 	l_free(str);
@@ -512,21 +561,34 @@ static pid_t execute_program(char *argv[], char *envp=
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
+		L_AUTO_FREE_VAR(char *, log_file) =3D NULL;
 =

-			if (fd =3D=3D -1)
-				exit(EXIT_FAILURE);
+		verbose =3D check_verbosity(argv[0]);
 =

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
+				log_file =3D l_strdup_printf("%s/%s/%s.log",
+						log_dir, test_name, log_name);
+			} else
+				log_file =3D l_strdup_printf("%s/%s.log",
+						log_dir, log_name);
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

@@ -633,8 +695,7 @@ static bool start_dbus_daemon(void)
 	if (check_verbosity("dbus"))
 		setenv("DBUS_VERBOSE", "1", true);
 =

-	pid =3D execute_program(argv, environ, false,
-					check_verbosity("dbus"), false);
+	pid =3D execute_program(argv, environ, false, NULL);
 	if (pid < 0)
 		return false;
 =

@@ -645,7 +706,7 @@ static bool start_dbus_daemon(void)
 		argv[0] =3D "dbus-monitor";
 		argv[1] =3D "--system";
 		argv[2] =3D NULL;
-		execute_program(argv, environ, false, true, false);
+		execute_program(argv, environ, false, NULL);
 	}
 =

 	l_debug("D-Bus is running");
@@ -661,7 +722,7 @@ static bool start_haveged(void)
 	argv[0] =3D "haveged";
 	argv[1] =3D NULL;
 =

-	pid =3D execute_program(argv, environ, true, false, false);
+	pid =3D execute_program(argv, environ, true, NULL);
 	if (pid < 0)
 		return false;
 =

@@ -683,7 +744,7 @@ static bool set_interface_state(const char *if_name, bo=
ol isUp)
 	argv[2] =3D state;
 	argv[3] =3D NULL;
 =

-	pid =3D execute_program(argv, environ, true, false, false);
+	pid =3D execute_program(argv, environ, true, NULL);
 	if (pid < 0)
 		return false;
 =

@@ -705,7 +766,7 @@ static bool create_interface(const char *if_name, const=
 char *phy_name)
 	argv[7] =3D "managed";
 	argv[8] =3D NULL;
 =

-	pid =3D execute_program(argv, environ, true, false, false);
+	pid =3D execute_program(argv, environ, true, NULL);
 	if (pid < 0)
 		return false;
 =

@@ -723,7 +784,7 @@ static bool delete_interface(const char *if_name)
 	argv[3] =3D "del";
 	argv[4] =3D NULL;
 =

-	pid =3D execute_program(argv, environ, true, false, false);
+	pid =3D execute_program(argv, environ, true, NULL);
 	if (pid < 0)
 		return false;
 =

@@ -739,7 +800,7 @@ static bool list_interfaces(void)
 	argv[1] =3D "-a";
 	argv[2] =3D NULL;
 =

-	pid =3D execute_program(argv, environ, true, true, false);
+	pid =3D execute_program(argv, environ, true, NULL);
 	if (pid < 0)
 		return false;
 =

@@ -755,7 +816,7 @@ static bool list_hwsim_radios(void)
 	argv[1] =3D "--list";
 	argv[2] =3D NULL;
 =

-	pid =3D execute_program(argv, environ, true, true, false);
+	pid =3D execute_program(argv, environ, true, NULL);
 	if (pid < 0)
 		return false;
 =

@@ -803,8 +864,7 @@ static int create_hwsim_radio(const char *radio_name,
 =

 	argv[idx] =3D NULL;
 =

-	pid =3D execute_program(argv, environ, true,
-					check_verbosity(BIN_HWSIM), false);
+	pid =3D execute_program(argv, environ, true, NULL);
 	if (pid < 0)
 		return -1;
 =

@@ -823,7 +883,7 @@ static bool destroy_hwsim_radio(int radio_id)
 	argv[1] =3D destroy_param;
 	argv[2] =3D NULL;
 =

-	pid =3D execute_program(argv, environ, true, false, false);
+	pid =3D execute_program(argv, environ, true, NULL);
 	if (pid < 0)
 		return false;
 =

@@ -843,8 +903,7 @@ static pid_t register_hwsim_as_trans_medium(void)
 	argv[idx++] =3D BIN_HWSIM;
 	argv[idx++] =3D NULL;
 =

-	return execute_program(argv, environ, false,
-					check_verbosity(BIN_HWSIM), false);
+	return execute_program(argv, environ, false, NULL);
 }
 =

 static void terminate_medium(pid_t medium_pid)
@@ -868,13 +927,13 @@ static void start_loopback(void)
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
@@ -893,7 +952,7 @@ static pid_t start_phonesim(void)
 =

 	setenv("OFONO_PHONESIM_CONFIG", "/tmp/phonesim.conf", true);
 =

-	return execute_program(argv, environ, false, false, false);
+	return execute_program(argv, environ, false, NULL);
 }
 =

 static void stop_phonesim(pid_t pid)
@@ -919,7 +978,7 @@ static pid_t start_ofono(void)
 =

 	start_loopback();
 =

-	return execute_program(argv, environ, false, verbose, false);
+	return execute_program(argv, environ, false, NULL);
 }
 =

 static void stop_ofono(pid_t pid)
@@ -927,7 +986,8 @@ static void stop_ofono(pid_t pid)
 	kill_process(pid);
 }
 =

-static pid_t start_hostapd(char **config_files, struct wiphy **wiphys)
+static pid_t start_hostapd(char **config_files, struct wiphy **wiphys,
+				const char *test_name)
 {
 	char **argv;
 	pid_t pid;
@@ -974,7 +1034,7 @@ static pid_t start_hostapd(char **config_files, struct=
 wiphy **wiphys)
 		argv[idx++] =3D NULL;
 	}
 =

-	pid =3D execute_program(argv, environ, false, verbose, false);
+	pid =3D execute_program(argv, environ, false, log ? test_name : NULL);
 	if (pid < 0) {
 		goto exit;
 	}
@@ -1412,7 +1472,8 @@ hostapd_done:
 		(*phys_used)++;
 	}
 =

-	hostapd_pids_out[0] =3D start_hostapd(hostapd_config_file_paths, wiphys);
+	hostapd_pids_out[0] =3D start_hostapd(hostapd_config_file_paths, wiphys,
+						basename(config_dir_path));
 	hostapd_pids_out[1] =3D -1;
 =

 done:
@@ -1425,17 +1486,38 @@ done:
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
+			L_AUTO_FREE_VAR(char *, valgrind_log);
+
+			valgrind_log =3D l_strdup_printf("%s/%s/valgrind.log",
+							log_dir, test_name);
+			fd =3D open(valgrind_log, O_WRONLY | O_CREAT | O_APPEND,
+					S_IRUSR | S_IWUSR);
+
+			if (fchown(fd, log_uid, log_gid) < 0)
+				l_error("chown failed");
+
+			fd_option =3D l_strdup_printf("--log-fd=3D%d", fd);
+			argv[idx++] =3D fd_option;
+		} else
+			argv[idx++] =3D "--log-file=3D/tmp/valgrind.log";
 	}
 =

 	if (strcmp(gdb_opt, "iwd") =3D=3D 0) {
@@ -1492,8 +1574,7 @@ static pid_t start_iwd(const char *config_dir, struct=
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

@@ -1717,7 +1798,8 @@ struct test_stats {
 =

 static void run_py_tests(struct l_settings *hw_settings,
 					struct l_queue *test_queue,
-					struct l_queue *test_stats_queue)
+					struct l_queue *test_stats_queue,
+					const char *test_name)
 {
 	char *argv[3];
 	pid_t test_exec_pid, test_timer_pid =3D -1;
@@ -1748,8 +1830,7 @@ start_next_test:
 	argv[2] =3D NULL;
 =

 	print_test_status(py_test, TEST_STATUS_STARTED, 0);
-	test_exec_pid =3D execute_program(argv, environ, false,
-					check_verbosity("pytests"), false);
+	test_exec_pid =3D execute_program(argv, environ, false, test_name);
 =

 	gettimeofday(&time_before, NULL);
 =

@@ -1890,7 +1971,7 @@ static void set_reg_domain(const char *domain)
 	argv[3] =3D (char *) domain;
 	argv[4] =3D NULL;
 =

-	execute_program(argv, environ, false, false, false);
+	execute_program(argv, environ, false, NULL);
 }
 =

 static void wiphy_up(void *data, void *user_data)
@@ -1934,6 +2015,7 @@ static void create_network_and_run_tests(void *data, =
void *user_data)
 	int phys_used;
 	int num_radios;
 	struct test_entry *entry =3D data;
+	char *test_name =3D NULL;
 =

 	memset(hostapd_pids, -1, sizeof(hostapd_pids));
 =

@@ -1955,6 +2037,19 @@ static void create_network_and_run_tests(void *data,=
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
@@ -2079,7 +2174,7 @@ static void create_network_and_run_tests(void *data, =
void *user_data)
 			iwd_config_dir =3D DAEMON_CONFIGDIR;
 =

 		iwd_pid =3D start_iwd(iwd_config_dir, wiphy_list,
-				iwd_ext_options, iwd_phys);
+				iwd_ext_options, iwd_phys, test_name);
 =

 		if (iwd_pid =3D=3D -1)
 			goto exit_hostapd;
@@ -2097,7 +2192,8 @@ static void create_network_and_run_tests(void *data, =
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
@@ -2109,10 +2205,24 @@ static void create_network_and_run_tests(void *data=
, void *user_data)
 	if (iwd_pid > 0)
 		terminate_iwd(iwd_pid);
 =

-	if (valgrind)
+	/* /tmp/valgrind.log will only exist without logging turned on */
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
@@ -2255,13 +2365,21 @@ static void free_test_entry(void *data)
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

@@ -2411,8 +2529,7 @@ static void run_unit_tests(void)
 		argv[1] =3D NULL;
 =

 		l_info("\n---------- Unit %s ----------", dirent->d_name);
-		execute_program(argv, environ, true,
-					check_verbosity("unit"), false);
+		execute_program(argv, environ, true, NULL);
 =

 next:
 		l_free(unit_test_abs_path);
@@ -2663,6 +2780,38 @@ static void run_tests(void)
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
@@ -2871,7 +3020,13 @@ static void usage(void)
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
@@ -2891,6 +3046,7 @@ static const struct option main_options[] =3D {
 	{ "valgrind",	no_argument,       NULL, 'V' },
 	{ "hw",		required_argument, NULL, 'w' },
 	{ "shell",	optional_argument, NULL, 's' },
+	{ "log",	optional_argument, NULL, 'l' },
 	{ "help",	no_argument,       NULL, 'h' },
 	{ }
 };
@@ -2898,6 +3054,8 @@ static const struct option main_options[] =3D {
 int main(int argc, char *argv[])
 {
 	uint8_t actions =3D 0;
+	struct tm *timeinfo;
+	time_t t;
 =

 	l_log_set_stderr();
 =

@@ -2919,7 +3077,7 @@ int main(int argc, char *argv[])
 	for (;;) {
 		int opt;
 =

-		opt =3D getopt_long(argc, argv, "A:q:k:v:g:UVdh", main_options,
+		opt =3D getopt_long(argc, argv, "A:q:k:v:g:UVldh", main_options,
 									NULL);
 		if (opt < 0)
 			break;
@@ -2979,6 +3137,37 @@ int main(int argc, char *argv[])
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

--===============2010214163083429549==--

