Content-Type: multipart/mixed; boundary="===============1524329141200387302=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 1/6] monitor: print START_TIME_TSF/BSSID values
Date: Wed, 20 Nov 2019 09:31:41 -0800
Message-ID: <20191120173146.21452-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1524329141200387302==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 monitor/nlmon.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/monitor/nlmon.c b/monitor/nlmon.c
index 94d16979..4c0e045f 100644
--- a/monitor/nlmon.c
+++ b/monitor/nlmon.c
@@ -5578,6 +5578,10 @@ static const struct attr_entry attr_table[] =3D {
 			"FTM Responder" },
 	{ NL80211_ATTR_FTM_RESPONDER_STATS,
 			"FTM Responder Stats" },
+	{ NL80211_ATTR_SCAN_START_TIME_TSF,
+			"Scan Start Time", ATTR_U64 },
+	{ NL80211_ATTR_SCAN_START_TIME_TSF_BSSID,
+			"Scan Start Time BSSID", ATTR_ADDRESS },
 	{ }
 };
 =

-- =

2.17.1

--===============1524329141200387302==--

