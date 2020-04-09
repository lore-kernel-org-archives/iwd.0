Content-Type: multipart/mixed; boundary="===============5611582399059320457=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH 2/3] main: Fix failure cleanup sequence
Date: Wed, 08 Apr 2020 18:44:16 -0700
Message-ID: <20200409014417.10029-2-tim.a.kourt@linux.intel.com>
In-Reply-To: <20200409014417.10029-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5611582399059320457==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/main.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/src/main.c b/src/main.c
index acd72131..b5ccc63b 100644
--- a/src/main.c
+++ b/src/main.c
@@ -476,12 +476,12 @@ int main(int argc, char *argv[])
 	exit_status =3D EXIT_FAILURE;
 =

 	if (!storage_create_dirs())
-		goto fail_dbus;
+		goto failed_dirs;
 =

 	genl =3D l_genl_new();
 	if (!genl) {
 		l_error("Failed to open generic netlink socket");
-		goto fail_genl;
+		goto failed_genl;
 	}
 =

 	if (getenv("IWD_GENL_DEBUG"))
@@ -490,7 +490,7 @@ int main(int argc, char *argv[])
 	rtnl =3D l_netlink_new(NETLINK_ROUTE);
 	if (!rtnl) {
 		l_error("Failed to open route netlink socket");
-		goto fail_rtnl;
+		goto failed_rtnl;
 	}
 =

 	if (getenv("IWD_RTNL_DEBUG"))
@@ -499,7 +499,7 @@ int main(int argc, char *argv[])
 	dbus =3D l_dbus_new_default(L_DBUS_SYSTEM_BUS);
 	if (!dbus) {
 		l_error("Failed to initialize D-Bus");
-		goto fail_dbus;
+		goto failed_dbus;
 	}
 =

 	if (enable_dbus_debug)
@@ -510,18 +510,24 @@ int main(int argc, char *argv[])
 	dbus_init(dbus);
 =

 	exit_status =3D l_main_run_with_signal(signal_handler, NULL);
+
 	plugin_exit();
 =

 	iwd_modules_exit();
 =

 	dbus_exit();
 	l_dbus_destroy(dbus);
-	storage_cleanup_dirs();
-fail_dbus:
-	l_genl_unref(genl);
-fail_rtnl:
+failed_dbus:
+
 	l_netlink_destroy(rtnl);
-fail_genl:
+failed_rtnl:
+
+	l_genl_unref(genl);
+failed_genl:
+
+	storage_cleanup_dirs();
+failed_dirs:
+
 	l_settings_free(iwd_config);
 =

 	l_timeout_remove(timeout);
-- =

2.13.6

--===============5611582399059320457==--

