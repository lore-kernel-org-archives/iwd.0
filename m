Content-Type: multipart/mixed; boundary="===============5963364186829930191=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/4] scan: add duration scan_parameters
Date: Fri, 15 Nov 2019 10:06:06 -0800
Message-ID: <20191115180608.31564-2-prestwoj@gmail.com>
In-Reply-To: <20191115180608.31564-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5963364186829930191==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The kernel allows a scan duration and duration mandatory flag to be
set in scan requests. RRM requests can contain these values so they
have been added to scan_parameters.

Scanning with drivers which do not support EXT_FEATURE_SET_SCAN_DWELL
will not include these values in scan requests.
---
 src/scan.c | 13 +++++++++++++
 src/scan.h |  2 ++
 2 files changed, 15 insertions(+)

diff --git a/src/scan.c b/src/scan.c
index ad6d3ad4..8e50052c 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -396,6 +396,19 @@ static struct l_genl_msg *scan_build_cmd(struct scan_c=
ontext *sc,
 		l_free(scan_rates);
 	}
 =

+	if (wiphy_has_ext_feature(sc->wiphy,
+					NL80211_EXT_FEATURE_SET_SCAN_DWELL)) {
+		if (params->duration)
+			l_genl_msg_append_attr(msg,
+					NL80211_ATTR_MEASUREMENT_DURATION,
+					2, &params->duration);
+
+		if (params->duration_mandatory)
+			l_genl_msg_append_attr(msg,
+				NL80211_ATTR_MEASUREMENT_DURATION_MANDATORY,
+				0, NULL);
+	}
+
 done:
 	return msg;
 }
diff --git a/src/scan.h b/src/scan.h
index 6c5133aa..cbbbe21a 100644
--- a/src/scan.h
+++ b/src/scan.h
@@ -81,9 +81,11 @@ struct scan_parameters {
 	const uint8_t *extra_ie;
 	size_t extra_ie_size;
 	struct scan_freq_set *freqs;
+	uint16_t duration;
 	bool flush : 1;
 	bool randomize_mac_addr_hint : 1;
 	bool no_cck_rates : 1;
+	bool duration_mandatory : 1;
 	const char *ssid;	/* Used for direct probe request */
 };
 =

-- =

2.17.1

--===============5963364186829930191==--

