Content-Type: multipart/mixed; boundary="===============0901866792226135094=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] client: add support for AP StartProfile
Date: Mon, 01 Feb 2021 09:17:17 -0800
Message-ID: <20210201171717.7215-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0901866792226135094==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

StartProfile was added to the AP interface but the required
command was never added to iwctl. This command requires a
profile exists in <configuration dir>/ap/. The syntax is as
follows:

ap <wlanX> start-profile <profile_name>
---
 client/ap.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/client/ap.c b/client/ap.c
index 81baa3fc..7130bb9a 100644
--- a/client/ap.c
+++ b/client/ap.c
@@ -235,11 +235,40 @@ static enum cmd_status cmd_show(const char *device_na=
me, char **argv, int argc)
 	return CMD_STATUS_TRIGGERED;
 }
 =

+static enum cmd_status cmd_start_profile(const char *device_name,
+						char **argv, int argc)
+{
+	const struct proxy_interface *ap_i;
+
+	if (argc < 1)
+		return CMD_STATUS_INVALID_ARGS;
+
+	if (strlen(argv[0]) > 32) {
+		display("Network name cannot exceed 32 characters.\n");
+
+		return CMD_STATUS_INVALID_VALUE;
+	}
+
+	ap_i =3D device_proxy_find(device_name, IWD_ACCESS_POINT_INTERFACE);
+	if (!ap_i) {
+		display("No ap on device: '%s'\n", device_name);
+		return CMD_STATUS_INVALID_VALUE;
+	}
+
+	proxy_interface_method_call(ap_i, "StartProfile", "s",
+						check_errors_method_callback,
+						argv[0]);
+
+	return CMD_STATUS_TRIGGERED;
+}
+
 static const struct command ap_commands[] =3D {
 	{ NULL, "list", NULL, cmd_list, "List devices in AP mode", true },
 	{ "<wlan>", "start", "<\"network name\"> <passphrase>", cmd_start,
 		"Start an access point\n\t\t\t\t\t\t    called \"network "
 		"name\" with\n\t\t\t\t\t\t    a passphrase" },
+	{ "<wlan>", "start-profile", "<\"network name\">", cmd_start_profile,
+		"Start an access point based on a disk profile" },
 	{ "<wlan>", "stop", NULL,   cmd_stop, "Stop a started access\n"
 		"\t\t\t\t\t\t    point" },
 	{ "<wlan", "show", NULL, cmd_show, "Show AP info", false },
-- =

2.26.2

--===============0901866792226135094==--

