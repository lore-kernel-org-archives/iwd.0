Content-Type: multipart/mixed; boundary="===============1072027286618709760=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] test-runner: fix crash if ofono is not installed
Date: Thu, 12 Mar 2020 17:49:34 -0400
Message-ID: <20200312214934.1396794-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1072027286618709760==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The goto was jumping to a label which freed the wiphy list which
had not yet been initialized. This also fixes another similar issue
if chdir fails (in this case tmpfs_extra_stuff would get freed
before being allocated).
---
 tools/test-runner.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/test-runner.c b/tools/test-runner.c
index 34a94ed7..04c4265f 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -2075,7 +2075,7 @@ static void create_network_and_run_tests(void *data, =
void *user_data)
 	if (chdir(config_dir_path) < 0) {
 		l_error("Failed to change to test directory: %s",
 							strerror(errno));
-		goto exit_hwsim;
+		goto free_hw_settings;
 	}
 =

 	tmpfs_extra_stuff =3D
@@ -2099,7 +2099,7 @@ static void create_network_and_run_tests(void *data, =
void *user_data)
 =

 			if (!ofono_found || !phonesim_found) {
 				l_info("ofono or phonesim not found, skipping");
-				goto exit_hwsim;
+				goto free_tmpfs_extra;
 			}
 =

 			ofono_req =3D true;
@@ -2270,7 +2270,6 @@ exit_hostapd:
 remove_abs_paths:
 	remove_absolute_path_dirs(tmpfs_extra_stuff);
 =

-exit_hwsim:
 	/*
 	 * If running in hwsim mode, we want to completely free/destroy the
 	 * wiphy list since it will be re-populated on the next test. For the
@@ -2282,8 +2281,10 @@ exit_hwsim:
 	else
 		l_queue_foreach(wiphy_list, wiphy_reset, NULL);
 =

-	l_settings_free(hw_settings);
+free_tmpfs_extra:
 	l_strfreev(tmpfs_extra_stuff);
+free_hw_settings:
+	l_settings_free(hw_settings);
 }
 =

 struct stat_totals {
-- =

2.24.1

--===============1072027286618709760==--

