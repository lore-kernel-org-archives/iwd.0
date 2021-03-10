Content-Type: multipart/mixed; boundary="===============5430109601574472504=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 6/6] station: disable roaming logic for auto-roaming cards
Date: Wed, 10 Mar 2021 12:27:46 -0800
Message-ID: <20210310202746.28475-6-prestwoj@gmail.com>
In-Reply-To: <20210310202746.28475-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5430109601574472504==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If the hardware roams automatically we want to be sure to not
react to CQM events and attempt to roam/disconnect on our own.

Note: this is only important for very new kernels where CQM
events were recently added to brcmfmac.
---
 src/station.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/station.c b/src/station.c
index f9fa0d71..fd985a1b 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2170,6 +2170,14 @@ static bool station_cannot_roam(struct station *stat=
ion)
 	const struct l_settings *config =3D iwd_get_config();
 	bool disabled;
 =

+	/*
+	 * Disable roaming with hardware that can roam automatically. Note this
+	 * is now required for recent kernels which have CQM event support on
+	 * this type of hardware (e.g. brcmfmac).
+	 */
+	if (wiphy_supports_fw_roam(station->wiphy))
+		return true;
+
 	if (!l_settings_get_bool(config, "Scan", "DisableRoamingScan",
 								&disabled))
 		disabled =3D false;
-- =

2.26.2

--===============5430109601574472504==--

