Content-Type: multipart/mixed; boundary="===============7274198431991139293=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 01/12] main: move module init into nl80211_appeared
Date: Fri, 11 Oct 2019 12:29:22 -0700
Message-ID: <20191011192933.13550-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7274198431991139293==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In preparation for integrating IWD_MODULE into modules which require
nl80211 we move the module init into the nl80211_appeared callback.
This will guarentee that the nl80211 is available during module init
and allow modules to get their own copy of nl80211 rather than needing
a set function (e.g. netdev_set_nl80211).

Since the dbus name request callback happens before this as well any
dbus module can also use IWD_MODULE and simply assume the dbus object
is ready.

plugin_init was also deferred to nl80211_appeared since some plugins
depend on modules being initialized.
---
 src/main.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

-v2:
 * Moved plugin_init after iwd_modules_init

diff --git a/src/main.c b/src/main.c
index b34da3d0..0e6fad14 100644
--- a/src/main.c
+++ b/src/main.c
@@ -147,6 +147,13 @@ static void nl80211_appeared(const struct l_genl_famil=
y_info *info,
 	l_debug("Found nl80211 interface");
 	nl80211 =3D l_genl_family_new(genl, NL80211_GENL_NAME);
 =

+	if (iwd_modules_init() < 0) {
+		l_main_quit();
+		return;
+	}
+
+	plugin_init(plugins, noplugins);
+
 	manager_init(nl80211, interfaces, nointerfaces);
 	anqp_init(nl80211);
 =

@@ -482,14 +489,9 @@ int main(int argc, char *argv[])
 	if (!netdev_init())
 		goto fail_netdev;
 =

-	if (iwd_modules_init() < 0)
-		goto fail_modules;
-
-	plugin_init(plugins, noplugins);
 	exit_status =3D l_main_run_with_signal(signal_handler, NULL);
 	plugin_exit();
 =

-fail_modules:
 	iwd_modules_exit();
 	netdev_exit();
 fail_netdev:
-- =

2.17.1

--===============7274198431991139293==--

