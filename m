Content-Type: multipart/mixed; boundary="===============3771007371672156700=="
MIME-Version: 1.0
From: Alvin Sipraga <ALSI@bang-olufsen.dk>
Subject: [PATCH] monitor: print survey info results
Date: Tue, 27 Oct 2020 12:31:25 +0000
Message-ID: <20201027122912.345502-1-alsi@bang-olufsen.dk>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3771007371672156700==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Example output:

  > Result: New Survey Results (0x33) len 76 [multi]         14.062327
    Interface Index: 6 (0x00000006)
    Survey Info: len 64
        Frequency: 2472 (0x000009a8)
        Noise dBm: -89
        Survey Time: 100 (0x0000000000000064)
        Busy Time: 4 (0x0000000000000004)
        RX Time: 3 (0x0000000000000003)
        TX Time: 0 (0x0000000000000000)
---
 monitor/nlmon.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/monitor/nlmon.c b/monitor/nlmon.c
index b4578c85..7b2fb539 100644
--- a/monitor/nlmon.c
+++ b/monitor/nlmon.c
@@ -4915,6 +4915,19 @@ static const struct attr_entry frame_types_table[] =
=3D {
 	{ }
 };
 =

+static const struct attr_entry survey_info_table[] =3D {
+	{ NL80211_SURVEY_INFO_FREQUENCY, "Frequency", ATTR_U32 },
+	{ NL80211_SURVEY_INFO_NOISE, "Noise dBm", ATTR_S8 },
+	{ NL80211_SURVEY_INFO_IN_USE, "Channel Currently In Use", ATTR_FLAG },
+	{ NL80211_SURVEY_INFO_TIME, "Survey Time", ATTR_U64 },
+	{ NL80211_SURVEY_INFO_TIME_BUSY, "Busy Time", ATTR_U64 },
+	{ NL80211_SURVEY_INFO_TIME_EXT_BUSY, "Busy Time Extension Channel", ATTR_=
U64 },
+	{ NL80211_SURVEY_INFO_TIME_RX, "RX Time", ATTR_U64 },
+	{ NL80211_SURVEY_INFO_TIME_TX, "TX Time", ATTR_U64 },
+	{ NL80211_SURVEY_INFO_TIME_SCAN, "Scan Time", ATTR_U64 },
+	{ }
+};
+
 static void print_cqm_event(unsigned int level, const char *label,
 					const void *data, uint16_t size)
 {
@@ -5596,7 +5609,7 @@ static const struct attr_entry attr_table[] =3D {
 	{ NL80211_ATTR_4ADDR,
 			"4-Address", ATTR_U8 },
 	{ NL80211_ATTR_SURVEY_INFO,
-			"Survey Info" },
+			"Survey Info", ATTR_NESTED, { survey_info_table } },
 	{ NL80211_ATTR_PMKID,
 			"PMKID", ATTR_BINARY },
 	{ NL80211_ATTR_MAX_NUM_PMKIDS,
-- =

2.29.0
--===============3771007371672156700==--

