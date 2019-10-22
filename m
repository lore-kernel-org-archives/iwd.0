Content-Type: multipart/mixed; boundary="===============0972592874761206699=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH 1/7] t-runner: Fix mem leak with sim keys
Date: Tue, 22 Oct 2019 16:13:11 -0700
Message-ID: <20191022231317.11634-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0972592874761206699==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use l_settings_get_value instead of l_settings_get_string to
prevent unnecessary memory duplication.
---
 tools/test-runner.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/test-runner.c b/tools/test-runner.c
index 4551c6c1..430e18e3 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -1961,8 +1961,8 @@ static void create_network_and_run_tests(void *data, =
void *user_data)
 						HW_CONFIG_SETUP_TMPFS_EXTRAS,
 									':');
 =

-	sim_keys =3D l_settings_get_string(hw_settings, HW_CONFIG_GROUP_SETUP,
-			"sim_keys");
+	sim_keys =3D l_settings_get_value(hw_settings, HW_CONFIG_GROUP_SETUP,
+								"sim_keys");
 =

 	if (sim_keys) {
 		if (!strcmp(sim_keys, "ofono")) {
-- =

2.13.6

--===============0972592874761206699==--

