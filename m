Content-Type: multipart/mixed; boundary="===============0734508714882267888=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 06/11] wiphy: add 6Ghz support
Date: Fri, 25 Feb 2022 09:58:05 -0800
Message-ID: <20220225175810.2914413-6-prestwoj@gmail.com>
In-Reply-To: 20220225175810.2914413-1-prestwoj@gmail.com

--===============0734508714882267888==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/wiphy.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/src/wiphy.c b/src/wiphy.c
index b6b0f563..a52d0941 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -106,6 +106,7 @@ struct wiphy {
 	struct scan_freq_set *supported_freqs;
 	struct band *band_2g;
 	struct band *band_5g;
+	struct band *band_6g;
 	char *model_str;
 	char *vendor_str;
 	char *driver_str;
@@ -350,6 +351,11 @@ static void wiphy_free(void *data)
 		wiphy->band_5g =3D NULL;
 	}
 =

+	if (wiphy->band_6g) {
+		band_free(wiphy->band_6g);
+		wiphy->band_6g =3D NULL;
+	}
+
 	scan_freq_set_free(wiphy->supported_freqs);
 	watchlist_destroy(&wiphy->state_watches);
 	l_free(wiphy->model_str);
@@ -436,6 +442,9 @@ uint32_t wiphy_get_supported_bands(struct wiphy *wiphy)
 	if (wiphy->band_5g)
 		bands |=3D BAND_FREQ_5_GHZ;
 =

+	if (wiphy->band_6g)
+		bands |=3D BAND_FREQ_6_GHZ;
+
 	return bands;
 }
 =

@@ -739,6 +748,9 @@ const uint8_t *wiphy_get_supported_rates(struct wiphy *=
wiphy, unsigned int band,
 	case NL80211_BAND_5GHZ:
 		bandp =3D wiphy->band_5g;
 		break;
+	case NL80211_BAND_6GHZ:
+		bandp =3D wiphy->band_6g;
+		break;
 	default:
 		return NULL;
 	}
@@ -789,6 +801,9 @@ int wiphy_estimate_data_rate(struct wiphy *wiphy,
 	case BAND_FREQ_5_GHZ:
 		bandp =3D wiphy->band_5g;
 		break;
+	case BAND_FREQ_6_GHZ:
+		bandp =3D wiphy->band_6g;
+		break;
 	default:
 		return -ENOTSUP;
 	}
@@ -979,6 +994,9 @@ static void wiphy_print_basic_info(struct wiphy *wiphy)
 	if (wiphy->band_5g)
 		wiphy_print_band_info(wiphy->band_5g, "5Ghz Band");
 =

+	if (wiphy->band_6g)
+		wiphy_print_band_info(wiphy->band_6g, "6GHz Band");
+
 	if (wiphy->supported_ciphers) {
 		int len =3D 0;
 =

@@ -1193,6 +1211,9 @@ static void parse_supported_bands(struct wiphy *wiphy,
 		case NL80211_BAND_5GHZ:
 			bandp =3D &wiphy->band_5g;
 			break;
+		case NL80211_BAND_6GHZ:
+			bandp =3D &wiphy->band_6g;
+			break;
 		default:
 			continue;
 		}
-- =

2.34.1

--===============0734508714882267888==--

