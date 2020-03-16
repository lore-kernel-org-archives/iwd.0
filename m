Content-Type: multipart/mixed; boundary="===============4855018009734959881=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/4] test-runner: fix improper loading of radius_config
Date: Mon, 16 Mar 2020 12:22:41 -0700
Message-ID: <20200316192242.15588-3-prestwoj@gmail.com>
In-Reply-To: <20200316192242.15588-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4855018009734959881==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This key is special in hostapd, and was being treated as a normal hostapd
config file. This special radius config file needs to be kept unpaired from
any interfaces so now its passed in as a separate argument and appended to
the end of the hostapd execute command.
---
 tools/test-runner.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/tools/test-runner.c b/tools/test-runner.c
index 1f0bc4dd..320dea0b 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -989,7 +989,7 @@ static void stop_ofono(pid_t pid)
 }
 =

 static pid_t start_hostapd(char **config_files, struct wiphy **wiphys,
-				const char *test_name)
+				const char *test_name, const char *radius_conf)
 {
 	char **argv;
 	pid_t pid;
@@ -1029,6 +1029,9 @@ static pid_t start_hostapd(char **config_files, struc=
t wiphy **wiphys,
 		argv[idx++] =3D config_files[i];
 	}
 =

+	if (radius_conf)
+		argv[idx++] =3D (void *)radius_conf;
+
 	if (verbose) {
 		argv[idx++] =3D "-d";
 		argv[idx++] =3D NULL;
@@ -1358,6 +1361,7 @@ static bool configure_hostapd_instances(struct l_sett=
ings *hw_settings,
 	int i;
 	char **hostapd_config_file_paths;
 	struct wiphy **wiphys;
+	const char *radius_config =3D NULL;
 =

 	*phys_used =3D 0;
 =

@@ -1398,8 +1402,12 @@ static bool configure_hostapd_instances(struct l_set=
tings *hw_settings,
 			goto done;
 		}
 =

-		if (!strcmp(hostap_keys[i], "radius_server"))
+		if (!strcmp(hostap_keys[i], "radius_server")) {
+			radius_config =3D l_settings_get_value(hw_settings,
+						HW_CONFIG_GROUP_HOSTAPD,
+						"radius_server");
 			continue;
+		}
 =

 		for (wiphy_entry =3D l_queue_get_entries(wiphy_list);
 					wiphy_entry;
@@ -1478,7 +1486,8 @@ hostapd_done:
 	}
 =

 	hostapd_pids_out[0] =3D start_hostapd(hostapd_config_file_paths, wiphys,
-						basename(config_dir_path));
+						basename(config_dir_path),
+						radius_config);
 	hostapd_pids_out[1] =3D -1;
 =

 done:
-- =

2.21.1

--===============4855018009734959881==--

