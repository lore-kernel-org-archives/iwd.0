Content-Type: multipart/mixed; boundary="===============0097642409848589427=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/2] monitor: add support for parsing RRM Reports
Date: Thu, 14 Nov 2019 15:41:16 -0800
Message-ID: <20191114234116.22162-2-prestwoj@gmail.com>
In-Reply-To: <20191114234116.22162-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0097642409848589427==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Only beacon reports are parsed for now
---
 monitor/nlmon.c | 84 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/monitor/nlmon.c b/monitor/nlmon.c
index b5734052..4053879f 100644
--- a/monitor/nlmon.c
+++ b/monitor/nlmon.c
@@ -1965,6 +1965,74 @@ static void print_measurement_request(unsigned int l=
evel, const char *label,
 	}
 }
 =

+static void print_measurement_report_beacon(unsigned int level,
+						const void *data,
+						uint16_t size)
+{
+	uint8_t frame_info;
+
+	if (size < 26)
+		return;
+
+	print_attr(level, "Operating Class: %u", l_get_u8(data));
+	print_attr(level, "Channel: %u", l_get_u8(data + 1));
+	print_attr(level, "Start Time: %"PRIu64, l_get_le64(data + 2));
+	print_attr(level, "Duration: %u", l_get_le16(data + 10));
+
+	frame_info =3D l_get_u8(data + 12);
+
+	print_attr(level, "PHY Type: %u", util_bit_field(frame_info, 0, 7));
+	print_attr(level, "Frame Type: %u", util_is_bit_set(frame_info, 7));
+	print_attr(level, "RCPI: %u", l_get_u8(data + 13));
+	print_attr(level, "RSNI: %u", l_get_u8(data + 14));
+	print_attr(level, "BSSID: "MAC, MAC_STR(((const uint8_t *)data + 15)));
+	print_attr(level, "Antenna ID: %u", l_get_u8(data + 21));
+	print_attr(level, "Parent TSF: %u", l_get_le32(data + 22));
+}
+
+static void print_measurement_report(unsigned int level, const char *label,
+							const void *data,
+							uint16_t size)
+{
+	uint8_t mode;
+	uint8_t type;
+
+	print_attr(level, "Measurement Report");
+
+	if (size < 3)
+		return;
+
+	print_attr(level + 1, "Token: %u", l_get_u8(data));
+
+	mode =3D l_get_u8(data + 1);
+
+	print_attr(level + 1, "Report Mode: %u", mode);
+
+	if (util_is_bit_set(mode, 0))
+		print_attr(level + 2, "Late bit set");
+
+	if (util_is_bit_set(mode, 1))
+		print_attr(level + 2, "Incapable bit set");
+
+	if (util_is_bit_set(mode, 2))
+		print_attr(level + 2, "Refused bit set");
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
+		print_measurement_report_beacon(level + 1, data + 3, size - 3);
+		break;
+	}
+}
+
 static struct attr_entry ie_entry[] =3D {
 	{ IE_TYPE_SSID,				"SSID",
 		ATTR_CUSTOM,	{ .function =3D print_ie_ssid } },
@@ -2017,6 +2085,8 @@ static struct attr_entry ie_entry[] =3D {
 		ATTR_CUSTOM,	{ .function =3D print_qos_map } },
 	{ IE_TYPE_MEASUREMENT_REQUEST,		"Measurement Request",
 		ATTR_CUSTOM,	{ .function =3D print_measurement_request } },
+	{ IE_TYPE_MEASUREMENT_REPORT,		"Measurement Report",
+		ATTR_CUSTOM,	{ .function =3D print_measurement_report } },
 	{ },
 };
 =

@@ -4092,6 +4162,17 @@ static void print_rm_request(unsigned int level, con=
st uint8_t *body,
 	print_ie(level, "IEs", body + 3, body_len - 3);
 }
 =

+static void print_rm_report(unsigned int level, const uint8_t *body,
+				size_t body_len)
+{
+	if (body_len < 1)
+		return;
+
+	print_attr(level, "Dialog Token: %u", body[0]);
+
+	print_ie(level, "IEs", body + 1, body_len - 1);
+}
+
 static void print_rm_action_frame(unsigned int level, const uint8_t *body,
 					size_t body_len)
 {
@@ -4121,6 +4202,9 @@ static void print_rm_action_frame(unsigned int level,=
 const uint8_t *body,
 	case 0:
 		print_rm_request(level + 1, body + 1, body_len - 1);
 		break;
+	case 1:
+		print_rm_report(level + 1, body + 1, body_len - 1);
+		break;
 	}
 }
 =

-- =

2.17.1

--===============0097642409848589427==--

