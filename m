Content-Type: multipart/mixed; boundary="===============5488561139929085872=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 01/19] wscutil: Add device type category/subcategory string api
Date: Thu, 23 Apr 2020 18:24:29 +0200
Message-ID: <20200423162447.15750-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5488561139929085872==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

FTR ie.h is included for @microsoft_oui
---
 src/wscutil.c | 200 ++++++++++++++++++++++++++++++++++++++++++++++++++
 src/wscutil.h |   6 ++
 2 files changed, 206 insertions(+)

diff --git a/src/wscutil.c b/src/wscutil.c
index 4f22bd83..cb6d47c0 100644
--- a/src/wscutil.c
+++ b/src/wscutil.c
@@ -32,6 +32,7 @@
 #include <ell/ell.h>
 =

 #include "src/util.h"
+#include "src/ie.h"
 #include "src/wscutil.h"
 =

 const unsigned char wsc_wfa_oui[3] =3D { 0x00, 0x37, 0x2a };
@@ -2791,3 +2792,202 @@ bool wsc_pin_generate(char *pin)
 =

 	return true;
 }
+
+struct device_type_category_info {
+	const char *category_str;
+	unsigned int subcategory_max;
+	const char **subcategory_str;
+};
+
+/* WSC 2.0.5, Table 41 strings adapted to IWD DBus enum convention */
+struct device_type_category_info device_type_categories[] =3D {
+	[1] =3D {
+		"computer",
+		10,
+		(const char *[]) {
+			[1] =3D "pc",
+			[2] =3D "server",
+			[3] =3D "media-center",
+			[4] =3D "ultra-mobile-pc",
+			[5] =3D "notebook",
+			[6] =3D "desktop",
+			[7] =3D "mobile-internet-device",
+			[8] =3D "netbook",
+			[9] =3D "tablet",
+			[10] =3D "ultrabook",
+		},
+	},
+	[2] =3D {
+		"input device",
+		9,
+		(const char *[]) {
+			[1] =3D "keyboard",
+			[2] =3D "mouse",
+			[3] =3D "joystick",
+			[4] =3D "trackball",
+			[5] =3D "gaming-controller",
+			[6] =3D "remote",
+			[7] =3D "touchscreen",
+			[8] =3D "biometric-reader",
+			[9] =3D "barcode-reader",
+		},
+	},
+	[3] =3D {
+		"printer-scanner",
+		5,
+		(const char *[]) {
+			[1] =3D "printer-print-server",
+			[2] =3D "scanner",
+			[3] =3D "fax",
+			[4] =3D "copier",
+			[5] =3D "printer-scanner-fax-copier",
+		},
+	},
+	[4] =3D {
+		"camera",
+		4,
+		(const char *[]) {
+			[1] =3D "digital-still-camera",
+			[2] =3D "video-camera",
+			[3] =3D "web-camera",
+			[4] =3D "security-camera",
+		},
+	},
+	[5] =3D {
+		"storage",
+		1,
+		(const char *[]) {
+			[1] =3D "nas",
+		},
+	},
+	[6] =3D {
+		"network-infrastructure",
+		5,
+		(const char *[]) {
+			[1] =3D "ap",
+			[2] =3D "router",
+			[3] =3D "switch",
+			[4] =3D "gateway",
+			[5] =3D "bridge",
+		},
+	},
+	[7] =3D {
+		"display",
+		4,
+		(const char *[]) {
+			[1] =3D "television",
+			[2] =3D "electronic-picture-frame",
+			[3] =3D "projector",
+			[4] =3D "monitor",
+		},
+	},
+	[8] =3D {
+		"multimedia-device",
+		6,
+		(const char *[]) {
+			[1] =3D "dar",
+			[2] =3D "pvr",
+			[3] =3D "mcx",
+			[4] =3D "set-top-box",
+			[5] =3D "media-server-adapter-extender",
+			[6] =3D "portable-video-player",
+		},
+	},
+	[9] =3D {
+		"gaming-device",
+		5,
+		(const char *[]) {
+			[1] =3D "xbox",
+			[2] =3D "xbox360",
+			[3] =3D "playstation",
+			[4] =3D "game-console-adapter",
+			[5] =3D "portable-gaming-device",
+		},
+	},
+	[10] =3D {
+		"telephone",
+		5,
+		(const char *[]) {
+			[1] =3D "windows-mobile",
+			[2] =3D "single-mode-phone",
+			[3] =3D "dual-mode-phone",
+			[4] =3D "single-mode-smartphone",
+			[5] =3D "dual-mode-smartphone",
+		},
+	},
+	[11] =3D {
+		"audio-device",
+		7,
+		(const char *[]) {
+			[1] =3D "audio-tuner-receiver",
+			[2] =3D "speakers",
+			[3] =3D "portable-music-player",
+			[4] =3D "headset",
+			[5] =3D "headphones",
+			[6] =3D "microphone",
+			[7] =3D "home-theater-system",
+		},
+	},
+	[12] =3D {
+		"docking-device",
+		2,
+		(const char *[]) {
+			[1] =3D "computer-docking-station",
+			[2] =3D "media-kiosk",
+		},
+	},
+};
+
+bool wsc_device_type_to_dbus_str(const struct wsc_primary_device_type *val,
+					const char **category_str,
+					const char **subcategory_str)
+{
+	struct device_type_category_info *cat;
+
+	if (val->category >=3D L_ARRAY_SIZE(device_type_categories))
+		return false;
+
+	cat =3D &device_type_categories[val->category];
+
+	if (!cat->category_str)
+		return false;
+
+	if (category_str)
+		*category_str =3D cat->category_str;
+
+	if (!subcategory_str)
+		return true;
+
+	if (memcmp(val->oui, microsoft_oui, 3) || val->oui_type !=3D 4)
+		*subcategory_str =3D NULL;	/* Vendor-specific */
+	else if (val->subcategory <=3D cat->subcategory_max &&
+			cat->subcategory_str[val->subcategory])
+		*subcategory_str =3D cat->subcategory_str[val->subcategory];
+	else
+		*subcategory_str =3D NULL;	/* Unknown */
+
+	return true;
+}
+
+bool wsc_device_type_from_subcategory_str(struct wsc_primary_device_type *=
out,
+						const char *subcategory_str)
+{
+	struct device_type_category_info *cat =3D device_type_categories;
+	unsigned int i;
+
+	for (i =3D 1; i < L_ARRAY_SIZE(device_type_categories); i++, cat++) {
+		unsigned int j;
+
+		for (j =3D 1; j <=3D cat->subcategory_max; j++)
+			if (!strcasecmp(subcategory_str,
+					cat->subcategory_str[j])) {
+				out->category =3D i;
+				memcpy(out->oui, microsoft_oui, 3);
+				out->oui_type =3D 4;
+				out->subcategory =3D j;
+				return true;
+			}
+	}
+
+	return false;
+}
diff --git a/src/wscutil.h b/src/wscutil.h
index fc28a01e..45d72fbb 100644
--- a/src/wscutil.h
+++ b/src/wscutil.h
@@ -674,3 +674,9 @@ bool wsc_kdf(const void *kdk, void *output, size_t size=
);
 bool wsc_pin_is_valid(const char *pin);
 bool wsc_pin_is_checksum_valid(const char *pin);
 bool wsc_pin_generate(char *pin);
+
+bool wsc_device_type_to_dbus_str(const struct wsc_primary_device_type *val,
+					const char **category_str,
+					const char **subcategory_str);
+bool wsc_device_type_from_subcategory_str(struct wsc_primary_device_type *=
out,
+						const char *subcategory_str);
-- =

2.20.1

--===============5488561139929085872==--

