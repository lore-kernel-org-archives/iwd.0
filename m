Content-Type: multipart/mixed; boundary="===============8017700710661229158=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v5 1/3] wiphy: add beacon bits to RM Enabled Capabilities
Date: Wed, 06 Nov 2019 16:59:13 -0800
Message-ID: <20191107005915.3899-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8017700710661229158==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This tells AP's that we support Passive, Active, and Table beacon
measurements.
---
 src/wiphy.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/wiphy.c b/src/wiphy.c
index ef22c0d3..eb0dfcc9 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -1037,6 +1037,8 @@ static void wiphy_setup_rm_enabled_capabilities(struc=
t wiphy *wiphy)
 =

 	wiphy->rm_enabled_capabilities[0] =3D IE_TYPE_RM_ENABLED_CAPABILITIES;
 	wiphy->rm_enabled_capabilities[1] =3D 5;
+	/* Bits: Passive (4), Active (5), and Beacon Table (6) capabilities */
+	wiphy->rm_enabled_capabilities[2] =3D 0x70;
 =

 	/*
 	 * TODO: Support at least Link Measurement if TX_POWER_INSERTION is
-- =

2.17.1

--===============8017700710661229158==--

