Content-Type: multipart/mixed; boundary="===============6666855021706264269=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 4/4] station: disable roaming logic for auto-roaming cards
Date: Mon, 15 Mar 2021 10:29:31 -0700
Message-ID: <20210315172931.173107-4-prestwoj@gmail.com>
In-Reply-To: <20210315172931.173107-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6666855021706264269==
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
index 1a829fae..033e82b3 100644
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

--===============6666855021706264269==--

