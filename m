Content-Type: multipart/mixed; boundary="===============1455739983212374834=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/2] monitor: add support for parsing RRM Requests
Date: Thu, 14 Nov 2019 15:41:15 -0800
Message-ID: <20191114234116.22162-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1455739983212374834==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Only beacon requests are parsed for now
---
 monitor/nlmon.c | 124 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 124 insertions(+)

diff --git a/monitor/nlmon.c b/monitor/nlmon.c
index 15ff4ecb..b5734052 100644
--- a/monitor/nlmon.c
+++ b/monitor/nlmon.c
@@ -1861,6 +1861,110 @@ static void print_qos_map(unsigned int level, const=
 char *label,
 	print_attr(level, "QoS Map");
 }
 =

+static void print_measurement_request_beacon(unsigned int level,
+						const void *data,
+						uint16_t size)
+{
+	uint8_t mode;
+
+	if (size < 13)
+		return;
+
+	print_attr(level, "Operating Class: %u", l_get_u8(data));
+	print_attr(level, "Channel: %u", l_get_u8(data + 1));
+	print_attr(level, "Randomization Interval: %u", l_get_le16(data + 2));
+	print_attr(level, "Duration: %u", l_get_le16(data + 4));
+
+	mode =3D l_get_u8(data + 6);
+
+	switch (mode) {
+	case 0:
+		print_attr(level, "Measurement: Passive");
+		break;
+	case 1:
+		print_attr(level, "Measurement: Active");
+		break;
+	case 2:
+		print_attr(level, "Measurement: Table");
+		break;
+	default:
+		print_attr(level, "Measurement: Invalid (%u)", mode);
+		return;
+	}
+
+	print_attr(level, "BSSID: "MAC, MAC_STR(((const uint8_t *)data + 7)));
+}
+
+static const char *rrm_measurement_types[] =3D {
+	[0] =3D "Basic",
+	[1] =3D "Clear Channel Assessment",
+	[2] =3D "Receive Power Indication",
+	[3] =3D "Channel Load",
+	[4] =3D "Noise Histogram",
+	[5] =3D "Beacon",
+	[6] =3D "Frame",
+	[7] =3D "STA Statistics",
+	[8] =3D "LCI",
+	[9] =3D "Transmit Stream/Category Measurement",
+	[10] =3D "Multicast Diagnostics",
+	[11] =3D "Location Civic",
+	[12] =3D "Location Identifier",
+	[13] =3D "Directional Channel Quality",
+	[14] =3D "Directional Measurement",
+	[15] =3D "Directional Statistics",
+	[16] =3D "Fine Timing Measurement Range",
+	[255] =3D "Measurement Pause"
+};
+
+static void print_measurement_request(unsigned int level, const char *labe=
l,
+							const void *data,
+							uint16_t size)
+{
+	uint8_t mode;
+	uint8_t type;
+
+	print_attr(level, "Measurement Request");
+
+	if (size < 3)
+		return;
+
+	print_attr(level + 1, "Token: %u", l_get_u8(data));
+
+	mode =3D l_get_u8(data + 1);
+
+	print_attr(level + 1, "Request Mode: %u", mode);
+
+	if (util_is_bit_set(mode, 0))
+		print_attr(level + 2, "Parallel bit set");
+
+	if (util_is_bit_set(mode, 1))
+		print_attr(level + 2, "Enable bit set");
+
+	if (util_is_bit_set(mode, 2))
+		print_attr(level + 2, "Request bit set");
+
+	if (util_is_bit_set(mode, 3))
+		print_attr(level + 2, "Report bit set");
+
+	if (util_is_bit_set(mode, 4))
+		print_attr(level + 2, "Duration Mandatory set");
+
+	type =3D l_get_u8(data + 2);
+
+	if (type > 16 && type !=3D 255) {
+		print_attr(level + 1, "Type: Invalid (%u)", type);
+		return;
+	}
+
+	print_attr(level + 1, "Type: %s", rrm_measurement_types[type]);
+
+	switch (type) {
+	case 5:
+		print_measurement_request_beacon(level + 1, data + 3, size - 3);
+		break;
+	}
+}
+
 static struct attr_entry ie_entry[] =3D {
 	{ IE_TYPE_SSID,				"SSID",
 		ATTR_CUSTOM,	{ .function =3D print_ie_ssid } },
@@ -1911,6 +2015,8 @@ static struct attr_entry ie_entry[] =3D {
 		{ .function =3D print_ie_supported_operating_classes } },
 	{ IE_TYPE_QOS_MAP_SET,			"QoS Map",
 		ATTR_CUSTOM,	{ .function =3D print_qos_map } },
+	{ IE_TYPE_MEASUREMENT_REQUEST,		"Measurement Request",
+		ATTR_CUSTOM,	{ .function =3D print_measurement_request } },
 	{ },
 };
 =

@@ -3974,6 +4080,18 @@ static void print_public_action_frame(unsigned int l=
evel, const uint8_t *body,
 	}
 }
 =

+static void print_rm_request(unsigned int level, const uint8_t *body,
+				size_t body_len)
+{
+	if (body_len < 3)
+		return;
+
+	print_attr(level, "Dialog Token: %u", body[0]);
+	print_attr(level, "Repetitions: %u", l_get_le16(body + 1));
+
+	print_ie(level, "IEs", body + 3, body_len - 3);
+}
+
 static void print_rm_action_frame(unsigned int level, const uint8_t *body,
 					size_t body_len)
 {
@@ -3998,6 +4116,12 @@ static void print_rm_action_frame(unsigned int level=
, const uint8_t *body,
 		category =3D "Unknown";
 =

 	print_attr(level, "Radio Measurement Action: %s (%u)", category, body[0]);
+
+	switch (body[0]) {
+	case 0:
+		print_rm_request(level + 1, body + 1, body_len - 1);
+		break;
+	}
 }
 =

 static void print_action_mgmt_frame(unsigned int level,
-- =

2.17.1

--===============1455739983212374834==--

