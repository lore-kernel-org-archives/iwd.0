Content-Type: multipart/mixed; boundary="===============8736716662300648507=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 3/4] nlmon: print Mobility Domain element
Date: Tue, 21 Sep 2021 13:44:47 -0700
Message-ID: <20210921204448.119199-3-prestwoj@gmail.com>
In-Reply-To: 20210921204448.119199-1-prestwoj@gmail.com

--===============8736716662300648507==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 monitor/nlmon.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/monitor/nlmon.c b/monitor/nlmon.c
index 4cf2b856..ec7fc03a 100644
--- a/monitor/nlmon.c
+++ b/monitor/nlmon.c
@@ -2235,6 +2235,30 @@ static void print_fast_bss_transition(unsigned int l=
evel, const char *label,
 	}
 }
 =

+static void print_mobility_domain(unsigned int level, const char *label,
+					const void *data, uint16_t size)
+{
+	uint16_t mdid;
+	bool ft_over_ds;
+	bool resource_req;
+
+	print_attr(level, "%s", label);
+
+	if (ie_parse_mobility_domain_from_data(data - 2, size + 2, &mdid,
+					&ft_over_ds, &resource_req) < 0) {
+		print_attr(level + 1, "error parsing");
+		return;
+	}
+
+	print_attr(level + 1, "MDID: %04x", mdid);
+
+	if (ft_over_ds)
+		print_attr(level + 1, "FT-over-DS bit set");
+
+	if (resource_req)
+		print_attr(level + 1, "Resource Request Protocol bit set");
+}
+
 static struct attr_entry ie_entry[] =3D {
 	{ IE_TYPE_SSID,				"SSID",
 		ATTR_CUSTOM,	{ .function =3D print_ie_ssid } },
@@ -2295,6 +2319,8 @@ static struct attr_entry ie_entry[] =3D {
 		ATTR_CUSTOM,	{ .function =3D print_measurement_report } },
 	{ IE_TYPE_FAST_BSS_TRANSITION,		"Fast BSS Transition",
 		ATTR_CUSTOM,	{ .function =3D print_fast_bss_transition } },
+	{ IE_TYPE_MOBILITY_DOMAIN,		"Mobility Domain",
+		ATTR_CUSTOM,	{ .function =3D print_mobility_domain } },
 	{ },
 };
 =

-- =

2.31.1

--===============8736716662300648507==--

