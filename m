Content-Type: multipart/mixed; boundary="===============5140771294591297833=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 3/6] nlmon: update to use ie_owe_transition_info
Date: Wed, 22 Sep 2021 11:26:52 -0700
Message-ID: <20210922182655.46220-3-prestwoj@gmail.com>
In-Reply-To: 20210922182655.46220-1-prestwoj@gmail.com

--===============5140771294591297833==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 monitor/nlmon.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/monitor/nlmon.c b/monitor/nlmon.c
index 191ebf02..c6e00af3 100644
--- a/monitor/nlmon.c
+++ b/monitor/nlmon.c
@@ -1012,17 +1012,16 @@ static void print_ipv4(unsigned int level, const ch=
ar *label,
 static void print_ie_wfa_owe_transition(unsigned int level, const char *la=
bel,
 						const void *data, uint16_t size)
 {
-	uint8_t bssid[6];
-	uint8_t ssid[32];
-	size_t ssid_len;
+	struct ie_owe_transition_info info;
 =

-	if (ie_parse_owe_transition(data, size, bssid, ssid, &ssid_len) < 0) {
+	if (ie_parse_owe_transition(data, size, &info) < 0) {
 		print_attr(level + 1, "Error parsing");
 		return;
 	}
 =

-	print_attr(level + 1, "BSSID: "MAC, MAC_STR(bssid));
-	print_attr(level + 1, "SSID: %s", util_ssid_to_utf8(ssid_len, ssid));
+	print_attr(level + 1, "BSSID: "MAC, MAC_STR(info.bssid));
+	print_attr(level + 1, "SSID: %s", util_ssid_to_utf8(info.ssid_len,
+								info.ssid));
 }
 =

 static void print_ie_vendor(unsigned int level, const char *label,
-- =

2.31.1

--===============5140771294591297833==--

