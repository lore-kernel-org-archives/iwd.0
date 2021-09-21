Content-Type: multipart/mixed; boundary="===============0651137199375840948=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 2/4] nlmon: print Fast BSS Transition element
Date: Tue, 21 Sep 2021 13:44:46 -0700
Message-ID: <20210921204448.119199-2-prestwoj@gmail.com>
In-Reply-To: 20210921204448.119199-1-prestwoj@gmail.com

--===============0651137199375840948==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 monitor/nlmon.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/monitor/nlmon.c b/monitor/nlmon.c
index 191ebf02..4cf2b856 100644
--- a/monitor/nlmon.c
+++ b/monitor/nlmon.c
@@ -2177,6 +2177,64 @@ static void print_measurement_report(unsigned int le=
vel, const char *label,
 	}
 }
 =

+static void print_fast_bss_transition(unsigned int level, const char *labe=
l,
+							const void *data,
+							uint16_t size)
+{
+	struct ie_ft_info ft_info;
+	uint32_t mic_len =3D 16;
+
+	/* Most likely the MIC is 16 bytes */
+	if (ie_parse_fast_bss_transition_from_data(data - 2, size + 2,
+						mic_len, &ft_info) < 0) {
+		mic_len =3D 24;
+
+		/* Must be FILS, try 24 */
+		if (ie_parse_fast_bss_transition_from_data(data - 2, size + 2,
+						mic_len, &ft_info) < 0) {
+			print_attr(level + 1, "error parsing");
+			return;
+		}
+	}
+
+	print_attr(level, "%s", label);
+
+	if (ft_info.rsnxe_used)
+		print_attr(level + 1, "RSNXE Used set");
+
+	print_attr(level + 1, "MIC Element Count: %u",
+			ft_info.mic_element_count);
+	print_attr(level + 1, "MIC:");
+	print_hexdump(level + 2, ft_info.mic, mic_len);
+	print_attr(level + 1, "ANONCE:");
+	print_hexdump(level + 2, ft_info.anonce, sizeof(ft_info.anonce));
+	print_attr(level + 1, "SNONCE:");
+	print_hexdump(level + 2, ft_info.snonce, sizeof(ft_info.snonce));
+	print_attr(level + 1, "R0KHID:");
+	print_hexdump(level + 2, ft_info.r0khid, ft_info.r0khid_len);
+
+	if (ft_info.r1khid_present) {
+		print_attr(level + 1, "R1KHID:");
+		print_hexdump(level + 2, ft_info.r1khid, sizeof(ft_info.r1khid));
+	}
+
+	if (ft_info.gtk_len) {
+		print_attr(level + 1, "GTK Key ID: %u", ft_info.gtk_key_id);
+		print_attr(level + 1, "GTK RSC:");
+		print_hexdump(level + 2, ft_info.gtk_rsc, sizeof(ft_info.gtk_rsc));
+		print_attr(level + 1, "GTK:");
+		print_hexdump(level + 2, ft_info.gtk, ft_info.gtk_len);
+	}
+
+	if (ft_info.igtk_len) {
+		print_attr(level + 1, "IGTK Key ID: %u", ft_info.igtk_key_id);
+		print_attr(level + 1, "IGTK IPN:");
+		print_hexdump(level + 2, ft_info.igtk_ipn, sizeof(ft_info.igtk_ipn));
+		print_attr(level + 1, "IGTK:");
+		print_hexdump(level + 2, ft_info.igtk, ft_info.igtk_len);
+	}
+}
+
 static struct attr_entry ie_entry[] =3D {
 	{ IE_TYPE_SSID,				"SSID",
 		ATTR_CUSTOM,	{ .function =3D print_ie_ssid } },
@@ -2235,6 +2293,8 @@ static struct attr_entry ie_entry[] =3D {
 		ATTR_CUSTOM,	{ .function =3D print_measurement_request } },
 	{ IE_TYPE_MEASUREMENT_REPORT,		"Measurement Report",
 		ATTR_CUSTOM,	{ .function =3D print_measurement_report } },
+	{ IE_TYPE_FAST_BSS_TRANSITION,		"Fast BSS Transition",
+		ATTR_CUSTOM,	{ .function =3D print_fast_bss_transition } },
 	{ },
 };
 =

-- =

2.31.1

--===============0651137199375840948==--

