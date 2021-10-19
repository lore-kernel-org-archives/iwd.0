Content-Type: multipart/mixed; boundary="===============0801864686737403844=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH] station: disable OCV if offloading is supported
Date: Tue, 19 Oct 2021 14:28:22 -0700
Message-ID: <20211019212822.572360-1-prestwoj@gmail.com>

--===============0801864686737403844==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It was seen during testing that several offload-capable cards
were not including the OCI in the 4-way handshake. This made
any OCV capable AP unconnectable.

To be safe disable OCV on any cards that support offloading.
---
 src/station.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/src/station.c b/src/station.c
index a972b4fa..cbd72525 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1006,6 +1006,12 @@ static int station_build_handshake_rsn(struct handsh=
ake_state *hs,
 	struct ie_rsn_info info;
 	uint8_t *ap_ie;
 	bool disable_ocv;
+	bool offload =3D wiphy_has_ext_feature(wiphy,
+				NL80211_EXT_FEATURE_4WAY_HANDSHAKE_STA_PSK) ||
+			wiphy_has_ext_feature(wiphy,
+				NL80211_EXT_FEATURE_4WAY_HANDSHAKE_STA_1X) ||
+			wiphy_has_ext_feature(wiphy,
+					NL80211_EXT_FEATURE_SAE_OFFLOAD)
 =

 	memset(&info, 0, sizeof(info));
 =

@@ -1087,7 +1093,19 @@ build_ie:
 					&disable_ocv))
 		disable_ocv =3D false;
 =

-	info.ocvc =3D !disable_ocv && bss_info.ocvc && info.mfpc;
+	/*
+	 * Obviously do not enable OCV if explicitly disabled or no AP support.
+	 *
+	 * Not obviously hostapd rejects OCV support if MFPC is not enabled.
+	 * This is not really specified by the spec, but we have to work around
+	 * this limitation.
+	 *
+	 * Another limitation is full mac cards. With limited testing it was
+	 * seen that they do not include the OCI in the 4-way handshake yet
+	 * still advertise the capability. Because of this OCV is disabled if
+	 * any offload features are detected (since IWD prefers to use offload).
+	 */
+	info.ocvc =3D !disable_ocv && bss_info.ocvc && info.mfpc && !offload;
 =

 	/*
 	 * IEEE 802.11-2020 9.4.2.24.4 states extended key IDs can only be used
-- =

2.31.1

--===============0801864686737403844==--

