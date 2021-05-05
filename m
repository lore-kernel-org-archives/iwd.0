Content-Type: multipart/mixed; boundary="===============3799522620510079994=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/3] station: add Roam() diagnostics method
Date: Wed, 05 May 2021 08:53:26 -0700
Message-ID: <20210505155328.431557-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3799522620510079994==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is being added as a developer method and should not be used
in production. For testing purposes though, it is quite useful as
it forces IWD to roam to a provided BSS and bypasses IWD's roaming
and ranking logic for choosing a roam candidate.

To use this a BSSID is provided as the only parameter. If this
BSS is not in IWD's current scan results -EINVAL will be returned.
If IWD knows about the BSS it will attempt to roam to it whether
that is via FT, FT-over-DS, or Reassociation. These details are
still sorted out in IWDs station_transition_start() logic.
---
 src/station.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/src/station.c b/src/station.c
index d2234e15..62eebfa2 100644
--- a/src/station.c
+++ b/src/station.c
@@ -3721,12 +3721,47 @@ static struct l_dbus_message *station_get_diagnosti=
cs(struct l_dbus *dbus,
 	return NULL;
 }
 =

+static struct l_dbus_message *station_force_roam(struct l_dbus *dbus,
+						struct l_dbus_message *message,
+						void *user_data)
+{
+	struct station *station =3D user_data;
+	struct scan_bss *target;
+	struct l_dbus_message_iter iter;
+	uint8_t *mac;
+	uint32_t mac_len;
+
+	if (!l_dbus_message_get_arguments(message, "ay", &iter))
+		goto invalid_args;
+
+	if (!l_dbus_message_iter_get_fixed_array(&iter, &mac, &mac_len))
+		goto invalid_args;
+
+	if (mac_len !=3D 6)
+		return dbus_error_invalid_args(message);
+
+	l_debug("Attempting roam to BSS "MAC, MAC_STR(mac));
+
+	target =3D network_bss_find_by_addr(station->connected_network, mac);
+	if (!target || target =3D=3D station->connected_bss)
+		return dbus_error_invalid_args(message);
+
+	station_transition_start(station, target);
+
+	return l_dbus_message_new_method_return(message);
+
+invalid_args:
+	return dbus_error_invalid_args(message);
+}
+
 static void station_setup_diagnostic_interface(
 					struct l_dbus_interface *interface)
 {
 	l_dbus_interface_method(interface, "GetDiagnostics", 0,
 				station_get_diagnostics, "a{sv}", "",
 				"diagnostics");
+	l_dbus_interface_method(interface, "Roam", 0, station_force_roam,
+				"", "ay", "mac");
 }
 =

 static void station_destroy_diagnostic_interface(void *user_data)
-- =

2.26.2

--===============3799522620510079994==--

