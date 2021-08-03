Content-Type: multipart/mixed; boundary="===============6590597873614293886=="
MIME-Version: 1.0
From: Michael Johnson <mjohnson459@gmail.com>
Subject: [PATCH] wiphy: set neighbor report capability flag
Date: Tue, 03 Aug 2021 15:19:07 +0100
Message-ID: <20210803141907.33819-1-mjohnson459@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6590597873614293886==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

As we send a neighbor report request after joining a network we should
be setting the flag in the radio measurement capabilities.

This is required by some Meraki access points.
---
 src/wiphy.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/src/wiphy.c b/src/wiphy.c
index e2222887..405b17be 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -1522,8 +1522,11 @@ static void wiphy_setup_rm_enabled_capabilities(stru=
ct wiphy *wiphy)
 =

 	wiphy->rm_enabled_capabilities[0] =3D IE_TYPE_RM_ENABLED_CAPABILITIES;
 	wiphy->rm_enabled_capabilities[1] =3D 5;
-	/* Bits: Passive (4), Active (5), and Beacon Table (6) capabilities */
-	wiphy->rm_enabled_capabilities[2] =3D 0x70;
+	/*
+	 * Bits: Neighbor Report (1), Passive (4), Active (5),
+	 * and Beacon Table (6) capabilities
+	 */
+	wiphy->rm_enabled_capabilities[2] =3D 0x72;
 =

 	/*
 	 * TODO: Support at least Link Measurement if TX_POWER_INSERTION is
-- =

2.25.1

--===============6590597873614293886==--

