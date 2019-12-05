Content-Type: multipart/mixed; boundary="===============5201028698443084887=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/7] iwmon: Print WSC AuthorizedMACs extended attributes
Date: Thu, 05 Dec 2019 04:22:38 +0100
Message-ID: <20191205032244.5957-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5201028698443084887==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 monitor/nlmon.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/monitor/nlmon.c b/monitor/nlmon.c
index 4c0e045f..82acb533 100644
--- a/monitor/nlmon.c
+++ b/monitor/nlmon.c
@@ -2763,9 +2763,25 @@ static void print_wsc_wfa_ext_version2(unsigned int =
level, const char *label,
 	print_attr(level, "%s: %x.%x", label, bytes[0] >> 4, bytes[0] & 0xf);
 }
 =

+static void print_wsc_wfa_ext_authorized_macs(unsigned int level,
+						const char *label,
+						const void *data, uint16_t size)
+{
+	if (size > 30 || size % 6 !=3D 0) {
+		printf("malformed packet\n");
+		return;
+	}
+
+	for (; size; size -=3D 6, data +=3D 6)
+		print_attr(level, "%s: %s", label, util_address_to_string(data));
+}
+
 static struct attr_entry wsc_wfa_ext_attr_entry[] =3D {
 	{ WSC_WFA_EXTENSION_VERSION2,			"Version2",
 		ATTR_CUSTOM,	{ .function =3D print_wsc_wfa_ext_version2 } },
+	{ WSC_WFA_EXTENSION_AUTHORIZED_MACS,		"Authorized MAC",
+		ATTR_CUSTOM,
+		{ .function =3D print_wsc_wfa_ext_authorized_macs } },
 	{ WSC_WFA_EXTENSION_NETWORK_KEY_SHAREABLE,
 						"Network Key Shareable",
 		ATTR_CUSTOM,	{ .function =3D print_wsc_bool } },
-- =

2.20.1

--===============5201028698443084887==--

