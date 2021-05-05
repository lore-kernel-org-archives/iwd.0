Content-Type: multipart/mixed; boundary="===============7311447434413115108=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 1/3] main: add a --developer,-E option
Date: Wed, 05 May 2021 11:23:53 -0700
Message-ID: <20210505182355.454265-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7311447434413115108==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This will enable developer features to be used. Currently the
only user of this will be StationDiagnostics.Roam() method which
should only be exposed in this mode.
---
 src/iwd.h  |  1 +
 src/main.c | 12 +++++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

v2:
 * Added this patch to replace the dbus config changes

diff --git a/src/iwd.h b/src/iwd.h
index 51548cbb..1be20df3 100644
--- a/src/iwd.h
+++ b/src/iwd.h
@@ -41,3 +41,4 @@ const char *iwd_get_iface_blacklist(void);
 =

 const char *iwd_get_phy_whitelist(void);
 const char *iwd_get_phy_blacklist(void);
+bool iwd_is_developer_mode(void);
diff --git a/src/main.c b/src/main.c
index 2ee6188c..8e965341 100644
--- a/src/main.c
+++ b/src/main.c
@@ -54,6 +54,7 @@ static const char *nointerfaces;
 static const char *phys;
 static const char *nophys;
 static const char *debugopt;
+static bool developeropt;
 static bool terminating;
 static bool nl80211_complete;
 =

@@ -126,6 +127,11 @@ const char *iwd_get_phy_blacklist(void)
 	return nophys;
 }
 =

+bool iwd_is_developer_mode(void)
+{
+	return developeropt;
+}
+
 static void usage(void)
 {
 	printf("iwd - Wireless daemon\n"
@@ -143,6 +149,7 @@ static void usage(void)
 }
 =

 static const struct option main_options[] =3D {
+	{ "developer",    no_argument,       NULL, 'E' },
 	{ "dbus-debug",   no_argument,       NULL, 'B' },
 	{ "version",      no_argument,       NULL, 'v' },
 	{ "interfaces",   required_argument, NULL, 'i' },
@@ -363,7 +370,7 @@ int main(int argc, char *argv[])
 	for (;;) {
 		int opt;
 =

-		opt =3D getopt_long(argc, argv, "Bi:I:p:P:d::vh",
+		opt =3D getopt_long(argc, argv, "EBi:I:p:P:d::vh",
 							main_options, NULL);
 		if (opt < 0)
 			break;
@@ -372,6 +379,9 @@ int main(int argc, char *argv[])
 		case 'B':
 			enable_dbus_debug =3D true;
 			break;
+		case 'E':
+			developeropt =3D true;
+			break;
 		case 'i':
 			interfaces =3D optarg;
 			break;
-- =

2.26.2

--===============7311447434413115108==--

