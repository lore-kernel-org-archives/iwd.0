Content-Type: multipart/mixed; boundary="===============5436564162227573322=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 4/4] nlmon: print RSNXE
Date: Tue, 21 Sep 2021 13:44:48 -0700
Message-ID: <20210921204448.119199-4-prestwoj@gmail.com>
In-Reply-To: 20210921204448.119199-1-prestwoj@gmail.com

--===============5436564162227573322==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 monitor/nlmon.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/monitor/nlmon.c b/monitor/nlmon.c
index ec7fc03a..5b96a24a 100644
--- a/monitor/nlmon.c
+++ b/monitor/nlmon.c
@@ -2259,6 +2259,23 @@ static void print_mobility_domain(unsigned int level=
, const char *label,
 		print_attr(level + 1, "Resource Request Protocol bit set");
 }
 =

+static void print_rsnx(unsigned int level, const char *label,
+					const void *data, uint16_t size)
+{
+	const uint8_t *ptr =3D data;
+	uint8_t field_size =3D bit_field(ptr[0], 0, 4);
+
+	print_attr(level, "%s", label);
+
+	print_attr(level + 1, "Field Size: %u", field_size);
+
+	if (test_bit(ptr, 4))
+		print_attr(level + 1, "Protected TWT Operations Support");
+
+	if (test_bit(ptr, 5))
+		print_attr(level + 1, "SAE Hash-to-Element");
+}
+
 static struct attr_entry ie_entry[] =3D {
 	{ IE_TYPE_SSID,				"SSID",
 		ATTR_CUSTOM,	{ .function =3D print_ie_ssid } },
@@ -2321,6 +2338,8 @@ static struct attr_entry ie_entry[] =3D {
 		ATTR_CUSTOM,	{ .function =3D print_fast_bss_transition } },
 	{ IE_TYPE_MOBILITY_DOMAIN,		"Mobility Domain",
 		ATTR_CUSTOM,	{ .function =3D print_mobility_domain } },
+	{ IE_TYPE_RSNX,				"RSNX",
+		ATTR_CUSTOM,	{ .function =3D print_rsnx } },
 	{ },
 };
 =

-- =

2.31.1

--===============5436564162227573322==--

