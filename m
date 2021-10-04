Content-Type: multipart/mixed; boundary="===============3056541371003260466=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 01/12] iwmon: add support for new key format
Date: Mon, 04 Oct 2021 09:48:51 -0700
Message-ID: <20211004164902.2274318-1-prestwoj@gmail.com>

--===============3056541371003260466==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The kernel has two ways SET_KEY/NEW_KEY messages can be structured.
This implements parsers for the new key format.
---
 monitor/nlmon.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 71 insertions(+), 1 deletion(-)

diff --git a/monitor/nlmon.c b/monitor/nlmon.c
index 728d7857..6ded9aa2 100644
--- a/monitor/nlmon.c
+++ b/monitor/nlmon.c
@@ -5863,6 +5863,76 @@ static void print_scan_flags(unsigned int level, con=
st char *label,
 	}
 }
 =

+static void print_key_type(unsigned int level, const char *label,
+					const void *data, uint16_t size)
+{
+	const uint8_t *ptr =3D data;
+	const char *str;
+
+	switch (*ptr) {
+	case NL80211_KEYTYPE_GROUP:
+		str =3D "Group";
+		break;
+	case NL80211_KEYTYPE_PAIRWISE:
+		str =3D "Pairwise";
+		break;
+	case NL80211_KEYTYPE_PEERKEY:
+		str =3D "Peerkey";
+		break;
+	default:
+		str =3D "Unknown";
+	}
+
+	print_attr(level, "%s: %s", label, str);
+}
+
+static void print_key_mode(unsigned int level, const char *label,
+					const void *data, uint16_t size)
+{
+	const uint8_t *ptr =3D data;
+	const char *str;
+
+	switch (*ptr) {
+	case NL80211_KEY_RX_TX:
+		str =3D "RX/TX";
+		break;
+	case NL80211_KEY_NO_TX:
+		str =3D "RX Only";
+		break;
+	case NL80211_KEY_SET_TX:
+		str =3D "Set TX";
+		break;
+	default:
+		str =3D "Unknown";
+	}
+
+	print_attr(level, "%s: %s", label, str);
+}
+
+static const struct attr_entry default_key_type_table[] =3D {
+	{ NL80211_KEY_DEFAULT_TYPE_UNICAST, "Unicast", ATTR_FLAG },
+	{ NL80211_KEY_DEFAULT_TYPE_MULTICAST, "Multicast", ATTR_FLAG },
+	{ }
+};
+
+static const struct attr_entry key_table[] =3D {
+	{ NL80211_KEY_DATA,		"Key Data",		ATTR_BINARY },
+	{ NL80211_KEY_IDX,		"Key Index",		ATTR_U8 },
+	{ NL80211_KEY_CIPHER,		"Key Cipher",		ATTR_CUSTOM,
+					{ .function =3D print_cipher_suite } },
+	{ NL80211_KEY_SEQ,		"Key Sequence",		ATTR_BINARY },
+	{ NL80211_KEY_DEFAULT,		"Default",		ATTR_FLAG },
+	{ NL80211_KEY_DEFAULT_MGMT,	"Default Management",	ATTR_FLAG },
+	{ NL80211_KEY_TYPE,		"Key Type",		ATTR_CUSTOM,
+					{ .function =3D print_key_type} },
+	{ NL80211_KEY_DEFAULT_TYPES,	"Default Key Types",	ATTR_NESTED,
+					{ default_key_type_table } },
+	{ NL80211_KEY_MODE,		"Key Mode",		ATTR_CUSTOM,
+					{ .function =3D print_key_mode } },
+	{ NL80211_KEY_DEFAULT_BEACON,	"Default Beacon",	ATTR_FLAG },
+	{ }
+};
+
 static const struct attr_entry attr_table[] =3D {
 	{ NL80211_ATTR_WIPHY,
 			"Wiphy", ATTR_U32 },
@@ -6038,7 +6108,7 @@ static const struct attr_entry attr_table[] =3D {
 	{ NL80211_ATTR_PREV_BSSID,
 			"Previous BSSID", ATTR_ADDRESS },
 	{ NL80211_ATTR_KEY,
-			"Key" },
+			"Key", ATTR_NESTED, { key_table } },
 	{ NL80211_ATTR_KEYS,
 			"Keys" },
 	{ NL80211_ATTR_PID,
-- =

2.31.1

--===============3056541371003260466==--

