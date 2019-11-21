Content-Type: multipart/mixed; boundary="===============0985240793495061201=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v6] rrm: add packed struct for beacon reports
Date: Thu, 21 Nov 2019 13:36:31 -0800
Message-ID: <20191121213631.28834-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0985240793495061201==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

build_report_for_bss was refactored to use this packed structure rather
than l_put_* APIs.
---
 src/rrm.c | 64 ++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 40 insertions(+), 24 deletions(-)

-v6:
 * Used L_CPU_TO_LE* macros

diff --git a/src/rrm.c b/src/rrm.c
index 660565eb..cc940c05 100644
--- a/src/rrm.c
+++ b/src/rrm.c
@@ -122,6 +122,21 @@ struct rrm_state {
 	uint64_t last_request;
 };
 =

+/* 802.11, Section 9.4.2.22.7 */
+struct rrm_beacon_report {
+	uint8_t oper_class;
+	uint8_t channel;
+	__le64 scan_start_time;
+	__le16 duration;
+	uint8_t frame_info;
+	uint8_t rcpi;
+	uint8_t rsni;
+	uint8_t bssid[6];
+	uint8_t antenna_id;
+	__le32 parent_tsf;
+	uint8_t subelements[0];
+} __attribute__ ((packed));
+
 static struct l_queue *states;
 static struct l_genl_family *nl80211;
 static uint32_t netdev_watch;
@@ -225,6 +240,17 @@ static void rrm_build_measurement_report(struct rrm_re=
quest_info *info,
 		memcpy(to, report, report_len);
 }
 =

+/* 802.11 Table 9-154 */
+static uint8_t mdb_to_rcpi(int32_t mdb)
+{
+	if (mdb <=3D 10950)
+		return 0;
+	else if (mdb >=3D -10950 && mdb < 0)
+		return (uint8_t)((2 * (mdb + 11000)) / 100);
+	else
+		return 220;
+}
+
 /*
  * 802.11-2016 11.11.9.1 Beacon report
  *
@@ -246,38 +272,28 @@ static size_t build_report_for_bss(struct rrm_beacon_=
req_info *beacon,
 					struct scan_bss *bss,
 					uint8_t *to)
 {
-	uint8_t *start =3D to;
-
-	*to++ =3D beacon->oper_class;
-	*to++ =3D scan_freq_to_channel(bss->frequency, NULL);
-	l_put_le64(beacon->scan_start_time, to);
-	to +=3D 8;
-	l_put_le16(beacon->duration, to);
-	to +=3D 2;
-	*to++ =3D rrm_phy_type(bss);
-
-	/* 802.11 Table 9-154 - RCPI values */
-	if (bss->signal_strength < -10950)
-		*to++ =3D 0;
-	else if (bss->signal_strength >=3D -10950 && bss->signal_strength < 0)
-		*to++ =3D (uint8_t)((2 * (bss->signal_strength + 11000)) / 100);
-	else
-		*to++ =3D 220;
+	struct rrm_beacon_report *report =3D (struct rrm_beacon_report *) to;
+
+	report->oper_class =3D beacon->oper_class;
+	report->channel =3D scan_freq_to_channel(bss->frequency, NULL);
+	report->scan_start_time =3D L_CPU_TO_LE64(beacon->scan_start_time);
+	report->duration =3D L_CPU_TO_LE16(beacon->duration);
+	report->frame_info =3D rrm_phy_type(bss);
+	report->rcpi =3D mdb_to_rcpi(bss->signal_strength);
 =

 	/* RSNI not available (could get this from GET_SURVEY) */
-	*to++ =3D 255;
-	memcpy(to, bss->addr, 6);
-	to +=3D 6;
+	report->rsni =3D 255;
+	memcpy(report->bssid, bss->addr, 6);
 	/* Antenna identifier unknown */
-	*to++ =3D 0;
+	report->antenna_id =3D 0;
+
 	/*
 	 * 802.11 9.4.2.22.7 Beacon report
 	 *
 	 * "The Parent TSF field contains the lower 4 octets of the measuring
 	 *  STA's TSF timer value"
 	 */
-	l_put_le32((uint32_t)(bss->parent_tsf & 0xffffffff), to);
-	to +=3D 4;
+	report->parent_tsf =3D L_CPU_TO_LE32((uint32_t) bss->parent_tsf);
 =

 	/*
 	 * TODO: Support optional subelements
@@ -285,7 +301,7 @@ static size_t build_report_for_bss(struct rrm_beacon_re=
q_info *beacon,
 	 * (see "TODO: Support Reported Frame Body..." below)
 	 */
 =

-	return to - start;
+	return sizeof(struct rrm_beacon_report);
 }
 =

 static bool bss_in_request_range(struct rrm_beacon_req_info *beacon,
-- =

2.17.1

--===============0985240793495061201==--

