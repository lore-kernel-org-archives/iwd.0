Content-Type: multipart/mixed; boundary="===============7443308352645552451=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/3] test-runner: make default iwd_config_dir=/tmp
Date: Tue, 24 Mar 2020 13:24:01 -0700
Message-ID: <20200324202403.26860-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7443308352645552451==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The configuration value of iwd_config_dir was defaulting to /etc/iwd
which, in the context of test-runner, is probably not the best idea.
The system may have a main.conf file in /etc/iwd which could cause
tests to fail or behave unexpectedly.

In addition all tests which use iwd_config_dir set it to /tmp anyways.
Because of this, the new default value will be /tmp and no tests will
even need to bother setting this.

The configuration value itself is not being removed because it may be
useful to set arbitrary paths (e.g. /etc/iwd) for example when using
the shell functionality.
---
 tools/test-runner.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/test-runner.c b/tools/test-runner.c
index 1be3f640..1adb8377 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -2205,7 +2205,7 @@ static void create_network_and_run_tests(void *data, =
void *user_data)
 						HW_CONFIG_GROUP_SETUP,
 						HW_CONFIG_SETUP_IWD_CONF_DIR);
 		if (!iwd_config_dir)
-			iwd_config_dir =3D DAEMON_CONFIGDIR;
+			iwd_config_dir =3D "/tmp";
 =

 		iwd_pid =3D start_iwd(iwd_config_dir, wiphy_list,
 				iwd_ext_options, iwd_phys, test_name);
-- =

2.21.1

--===============7443308352645552451==--

