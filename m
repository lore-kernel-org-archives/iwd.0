Content-Type: multipart/mixed; boundary="===============0503245242409297009=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 01/11] hwsim: add --no-register option
Date: Thu, 17 Dec 2020 11:36:01 -0800
Message-ID: <20201217193611.1177006-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0503245242409297009==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Starts hwsim but does not register to mac80211_hwsim. This is to
allow autotests to disable hwsim, while still having the ability
to create/destroy radios over DBus.
---
 tools/hwsim.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/hwsim.c b/tools/hwsim.c
index 02053fa1..641a6c6f 100644
--- a/tools/hwsim.c
+++ b/tools/hwsim.c
@@ -151,6 +151,7 @@ static enum action {
 =

 static bool no_vif_attr;
 static bool p2p_attr;
+static bool no_register =3D false;
 static const char *radio_name_attr;
 static struct l_dbus *dbus;
 static struct l_queue *rules;
@@ -2347,6 +2348,9 @@ static void get_interface_done_initial(void *user_dat=
a)
 {
 	struct l_genl_msg *msg;
 =

+	if (no_register)
+		return;
+
 	msg =3D l_genl_msg_new_sized(HWSIM_CMD_REGISTER, 4);
 	l_genl_family_send(hwsim, msg, register_callback, NULL, NULL);
 }
@@ -2625,6 +2629,7 @@ static const struct option main_options[] =3D {
 	{ "version",	 no_argument,		NULL, 'v' },
 	{ "iftype-disable", required_argument,	NULL, 't' },
 	{ "cipher-disable", required_argument,	NULL, 'c' },
+	{ "no-register", no_argument,		NULL, 'r' },
 	{ "help",	 no_argument,		NULL, 'h' },
 	{ }
 };
@@ -2636,7 +2641,7 @@ int main(int argc, char *argv[])
 	for (;;) {
 		int opt;
 =

-		opt =3D getopt_long(argc, argv, ":L:CD:kndetc:ipvh", main_options,
+		opt =3D getopt_long(argc, argv, ":L:CD:kndetrc:ipvh", main_options,
 									NULL);
 		if (opt < 0)
 			break;
@@ -2682,6 +2687,9 @@ int main(int argc, char *argv[])
 		case 'c':
 			hwsim_disable_ciphers(optarg);
 			break;
+		case 'r':
+			no_register =3D true;
+			break;
 		case 'v':
 			printf("%s\n", VERSION);
 			return EXIT_SUCCESS;
-- =

2.26.2

--===============0503245242409297009==--

