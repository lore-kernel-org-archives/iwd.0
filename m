Content-Type: multipart/mixed; boundary="===============8322185204304325390=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 06/13] monitor: parse WFA OWE Transition IE
Date: Wed, 15 Sep 2021 10:36:17 -0700
Message-ID: <20210915173624.11917-6-prestwoj@gmail.com>
In-Reply-To: 20210915173624.11917-1-prestwoj@gmail.com

--===============8322185204304325390==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 monitor/nlmon.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/monitor/nlmon.c b/monitor/nlmon.c
index 1a26f553..177147c4 100644
--- a/monitor/nlmon.c
+++ b/monitor/nlmon.c
@@ -1009,6 +1009,21 @@ static void print_ipv4(unsigned int level, const cha=
r *label,
 			addr[0], addr[1], addr[2], addr[3]);
 }
 =

+static void print_ie_wfa_owe_transition(unsigned int level, const char *la=
bel,
+						const void *data, uint16_t size)
+{
+	uint8_t bssid[6];
+	char ssid[33];
+
+	if (ie_parse_owe_transition(data, size, bssid, ssid) < 0) {
+		print_attr(level + 1, "Error parsing");
+		return;
+	}
+
+	print_attr(level + 1, "BSSID: "MAC, MAC_STR(bssid));
+	print_attr(level + 1, "SSID: %s", ssid);
+}
+
 static void print_ie_vendor(unsigned int level, const char *label,
 				const void *data, uint16_t size)
 {
@@ -1054,6 +1069,10 @@ static void print_ie_vendor(unsigned int level, cons=
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

--===============8322185204304325390==--

