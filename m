Content-Type: multipart/mixed; boundary="===============3985387184331867544=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v3 4/7] monitor: parse WFA OWE Transition IE
Date: Thu, 16 Sep 2021 09:30:43 -0700
Message-ID: <20210916163046.30817-4-prestwoj@gmail.com>
In-Reply-To: 20210916163046.30817-1-prestwoj@gmail.com

--===============3985387184331867544==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 monitor/nlmon.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

v3:
 * Print SSIDs that are non-utf8

diff --git a/monitor/nlmon.c b/monitor/nlmon.c
index 1a26f553..f705aa9c 100644
--- a/monitor/nlmon.c
+++ b/monitor/nlmon.c
@@ -1009,6 +1009,22 @@ static void print_ipv4(unsigned int level, const cha=
r *label,
 			addr[0], addr[1], addr[2], addr[3]);
 }
 =

+static void print_ie_wfa_owe_transition(unsigned int level, const char *la=
bel,
+						const void *data, uint16_t size)
+{
+	uint8_t bssid[6];
+	uint8_t ssid[32];
+	size_t ssid_len;
+
+	if (ie_parse_owe_transition(data, size, bssid, ssid, &ssid_len) < 0) {
+		print_attr(level + 1, "Error parsing");
+		return;
+	}
+
+	print_attr(level + 1, "BSSID: "MAC, MAC_STR(bssid));
+	print_attr(level + 1, "SSID: %s", util_ssid_to_utf8(ssid_len, ssid));
+}
+
 static void print_ie_vendor(unsigned int level, const char *label,
 				const void *data, uint16_t size)
 {
@@ -1054,6 +1070,10 @@ static void print_ie_vendor(unsigned int level, cons=
t char *label,
 		case 0x12:
 			print_ie_rsn_suites(level + 1, label, data, size);
 			return;
+		case 0x1c:
+			print_ie_wfa_owe_transition(level + 1, label,
+							data - 6, size + 6);
+			return;
 		default:
 			return;
 		}
-- =

2.31.1

--===============3985387184331867544==--

