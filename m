Content-Type: multipart/mixed; boundary="===============5077533839349157094=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/5] wiphy: add beacon bits to RM Enabled Capabilities
Date: Tue, 29 Oct 2019 10:50:40 -0700
Message-ID: <20191029175043.27745-2-prestwoj@gmail.com>
In-Reply-To: <20191029175043.27745-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5077533839349157094==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This tells AP's that we support Passive, Active, and Table beacon
measurements.
---
 src/wiphy.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/wiphy.c b/src/wiphy.c
index 36e6c73d..37d06bc7 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -961,6 +961,8 @@ static void wiphy_setup_rm_enabled_capabilities(struct =
wiphy *wiphy)
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

--===============5077533839349157094==--

