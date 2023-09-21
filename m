Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2090.outbound.protection.outlook.com [40.107.7.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D3CBA26
	for <iwd@lists.linux.dev>; Thu, 21 Sep 2023 14:23:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MmXCbXjaAWJISrARG2QI8PHhkKudMbo2YIiI1xw0tYZkw7LT54nh6+j+z/6Rc7NQdE4psZMqOzqFAmm9J4gcR+jJw1xg9bajR5KCsYrKn+SOLNXhReddOTHfho9Mm/HmTLOU6F4ApTycCGZXpx553wI0NqmKvnXFFSwbI4nVi4pdlzQrypgWxPnMGPME2Ycs7nN72ntRssS9J7Ee0W1FcjCHtqBJ8WelXvIUENbX2/AHznx6qMMQ8UZJgDRyy8JD3EpscQc1HhELNg/AZPQD4Nm+3tQPzpTj/1PSi0cWNVumg7BTx/rsNZsMwM98lokCv+2AD0I3L5oOftGT4Ya9GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5f5QUOj/sa9waOZCVRc22bp5aNErFX7uqJbQvDD5GN8=;
 b=m/96SIP9iXKOxJxyeW4XGuOWKyKcb/uf154zfMbSXtvDoZwJTvD41YIXjJ7xhAhnH7ZyYrtd352Obw8dRheFM4+XGKqsKm2AidsqilxJZ+QYpxcl3rO6DZeJc3zL78jz28PGm5206vSEYi0ezaAJk3PvfIzaciucb6zASjH+a0tCAY7Zylowrf2u3SL3ppXHWupvfzQBi2jCHcaB7MGmPMoHechVsHegPG9fzAAGC8gx69NMAekhUwAW2Tq5jionSCq/wu5CZjyvcf4rq39q4e6PRECSTfSQEI0NW3wc2OxqBNVj6LVQOrPPZe6XcJo9THfNXfaZRjwxztoXJ52V6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5f5QUOj/sa9waOZCVRc22bp5aNErFX7uqJbQvDD5GN8=;
 b=GbIjbhOo+5psRF7lBwju/Lfvjs/zIVgEFYp/Cr4vSSpgXQjFyrNYg+3rIGswjkh2rXAS8BWlFPR9g+7/2H+PQrRc15H3qB7X+qA027TPeMKQOhEKxpSltcYCdpL3Z63fJmI9CYrNXTGUtTz3ayVr+tgHubn5E6vviikXtwlzl6M=
Received: from AM5PR0301MB2516.eurprd03.prod.outlook.com (2603:10a6:203:9::7)
 by PAWPR03MB9857.eurprd03.prod.outlook.com (2603:10a6:102:2e4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Thu, 21 Sep
 2023 14:23:08 +0000
Received: from AM5PR0301MB2516.eurprd03.prod.outlook.com
 ([fe80::999a:2fa9:f780:bf31]) by AM5PR0301MB2516.eurprd03.prod.outlook.com
 ([fe80::999a:2fa9:f780:bf31%12]) with mapi id 15.20.6813.017; Thu, 21 Sep
 2023 14:23:08 +0000
From: =?iso-8859-1?Q?Pedro_Andr=E9?= <PEDA@bang-olufsen.dk>
To: "iwd@lists.linux.dev" <iwd@lists.linux.dev>
CC: =?iso-8859-1?Q?Pedro_Andr=E9?= <PEDA@bang-olufsen.dk>
Subject: [PATCH] rank: add option to normalize using defined rate
Thread-Topic: [PATCH] rank: add option to normalize using defined rate
Thread-Index: AQHZ7Jck01Omh6Aox0SZX8e6GU2n0Q==
Date: Thu, 21 Sep 2023 14:23:08 +0000
Message-ID: <20230921142302.77637-1-peda@bang-olufsen.dk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM5PR0301MB2516:EE_|PAWPR03MB9857:EE_
x-ms-office365-filtering-correlation-id: 0016580f-a012-4c9e-4b31-08dbbaae476c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 jpWwK5KGkk9dtU06yKdLpdgtk/0YsUN0jGqFgQ1bWcOo/dIkmJ1g0MkQa7g9lhQnBwgn8HT2KlCUYhybSekSmiLEAarDso2r4dAiCkVQeQEGSGKXn5gPG/jNfUsJ3OR9HLw3j/ub3j8sHlx6QvJTomTOWZ9yQFZgrNUsleHLKQODj862y9UjcB21M14twYoF+8oIvMhQN7Jzy0WO6s6y4cR7cVevAfWyk5T7zIDu2+I+4tMlZbx2KvptBVSwl8KgZ4Vmz2FYoj2Uwbl6MAu0u7Oa6WNpmpdIlsvAU5nGwUOwPrul2IO4ouoNliA/51BznoCHavcwM4quJ7DP8VM8pes0i7jbTEyyVnC6HB0J1PGgSB08lSEQB+yZb68wy10ltXc/uhjg8kR+Bha7syP2So5TB5L3E0pOUh2Nmje0opHv6S3/Q6IRYh+tNXZ/By9BEC+wF2erz4sZUDS8F1RvAHAdiyThb6rk5JguP6fnvPsYEbU14qXVBgnhg1+ydPPsW4GkuVJJPvrQUUMqCk2g6rmpC9CizgsWNp4PuIwCMYmEK+usmOOGcVQp/P0t5zdEdQrgiLYjY2k/UbYo+2UYttLmMijKhFrvdqSO0EU6armDoid5uRLWpJGUa3MmXY58
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR0301MB2516.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(396003)(136003)(39850400004)(186009)(451199024)(1800799009)(2906002)(6916009)(66946007)(64756008)(66446008)(66476007)(66556008)(76116006)(41300700001)(91956017)(316002)(4326008)(5660300002)(8676002)(8976002)(8936002)(66899024)(71200400001)(86362001)(36756003)(1076003)(83380400001)(26005)(2616005)(107886003)(122000001)(38100700002)(478600001)(38070700005)(6506007)(6486002)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?0bsNqEkOa5UE8qMjQcjEwE+x1ETpir9JcR7kT4mmoSuIMzCwtDd8IkufFK?=
 =?iso-8859-1?Q?RUvkoVS8kSzQk571LuBfkb10Im7PSUtuXro2K/nRZ4tE0SHIvNn0pGwaJX?=
 =?iso-8859-1?Q?6+VT68r9Xh+K9y4Zn66N6mRw0iDKUXtqM/uR+cD9V1zP0PaP+9HizAndYy?=
 =?iso-8859-1?Q?Y9cy9T5IIRSPw444mLgBWFdadlEMwMMOOwSkwf7eVNnCjrEmf+4no9Qcoh?=
 =?iso-8859-1?Q?AJg9FnsLWPwPlJTq/cHlydO/0esq4H6bjlyAyfMwy1LSAFx13kC1yiV6PX?=
 =?iso-8859-1?Q?SoPHfwpLpnoKDMaWGgEUDT8cpetw+VprHxrJ8JYLgbtHUbkE59Vp7VoqtE?=
 =?iso-8859-1?Q?61DDBMjXirkbT71tpkyaFqqNPok9+HKHcj7uC8naPNbDNl0jRdiYNKzWZf?=
 =?iso-8859-1?Q?rMiMvGhbvLgz8oU0nMHxs+sVSmHVz+CkHYa5P4PzAc9v/bayidTUbgPGM4?=
 =?iso-8859-1?Q?uuMNhMF/8i75RZMRcP8jv87QN54WyG3AbuC2JkJ1fnNucoxXYluDElrh8q?=
 =?iso-8859-1?Q?iF4lLtCbfhq065RC9Rfaw4swCtEK09H9nVqtzG35x5pHTVWuSuJs4G0xNg?=
 =?iso-8859-1?Q?x/oBiJ3OxDIjrtUXLtY38lOCYxaqY3XxWOH7LzYJYHavhaS24zwZdoKGZX?=
 =?iso-8859-1?Q?x7QzGerVQOnh0GETi6KyXnYV6VkWUSxhAgLyO4bu7jjE65oScyyin36ko0?=
 =?iso-8859-1?Q?KwbF3h9VIH8b4ttITmHfd/0H03Skv5bXxqQSx96NXZ4c/0PJQiwSzNNCL+?=
 =?iso-8859-1?Q?yRu3VivBvw2E2X9B7Hd8mDJu5oUbpWgyOwGLCENO+g47vgq3RCXdJxWD/J?=
 =?iso-8859-1?Q?FlF5rKjYsXs0/V7VeWRynEUNnwmwK8r5T0wxBxhrkkdGBFsMuyW2gYnSDH?=
 =?iso-8859-1?Q?WgDDCuy78sXJLFE41wl15wBvp6+uQU8rD2WlPgtn3ZEelOtdSjx1fUiC0Y?=
 =?iso-8859-1?Q?pmghDW05JoSJ5YnZlcD3VphK3U9D9sQ71u1QcmBwt9HNhGmMc8U6krdPeC?=
 =?iso-8859-1?Q?80k1Ijdu2nAtPcwWNx1Xgy2VFckYThzGPMokHJyrv07QmEvk3eK4sojhB1?=
 =?iso-8859-1?Q?52haq4hbB5oTf30dPR6CknXP+q3UUPk3S5CdnjssWlfET7tUKb6vji2cz1?=
 =?iso-8859-1?Q?molgv64gB1Dob+LiqH7VIp6eHBm8M7m0BgSvU0VRTfIUd7A4kY8ddHo2rY?=
 =?iso-8859-1?Q?QtwtQrp/7jt2tP5bmP0PixPkgA3Qn+sF5DQ+tx986Y0HUTVCvIN32I9/V9?=
 =?iso-8859-1?Q?F4PIRxKLKA9BqSze3RWFEI8zVTpivIqhaGFh0g0XK93TlS7CQpwGRAmG/W?=
 =?iso-8859-1?Q?sdS5LoH+cjBPwA+J9vEmUh3VMs+Qy8kFkPyiBzOmWu9oaCf9z2h6ytKQ1+?=
 =?iso-8859-1?Q?cFoOYxfrN50FV6lPFRmTUBENl+mJQIY0QUXvnydyv7nDbAOiCuX5fDxbBY?=
 =?iso-8859-1?Q?5PHAXdEgVHT6H/i3mlZ9PtPoqEyt6IWvdU4H87Gb/8b9VV/I8YDeKkV9er?=
 =?iso-8859-1?Q?9/6gQnzbpsgjyBx3T/huVD2VqamP/HbF1NV7fU/l1bpa41xU9CzaIA/h0E?=
 =?iso-8859-1?Q?DgfIi1n9lYFSTrGN0YPWla5yEatDYiKfeye08PlN4rFo/jjldtrJN915+0?=
 =?iso-8859-1?Q?CQBsQs87O6ODw1vmJapS/rLxSqQrthDbhlt8nps2NPvTGRye0AvhKpXg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: bang-olufsen.dk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM5PR0301MB2516.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0016580f-a012-4c9e-4b31-08dbbaae476c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 14:23:08.8349
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A4pxTIaSnHEmkn+rZY73IUSKSzcXkQeoFgH8zAs/G7ysTEe2MsTuptEiXCNuvImYJ/D7UU7IWxUv1DNQjYEXtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR03MB9857

BSSID ranking relies on a quotient between the BSS data rate and
theoretical max data rate. This makes it so that when two or more BSSes
have the same SSID, the likelihood that higher frequency bands are
ranked first is high given their increased data throughput.
Such may not be ideal, for example, if one desires to connect to 2.4GHz
by default (if possible).

This tries to address such scenarios by introducing a new rank
configuration option where a necessary data rate (in bits/s) can be
provided. All BSSIDs that achieve or surpass this data rate will be
ranked identically before applying any other rank factors. If no value
is provided, the ranking process remains identical.
By using this configuration value in conjunction with already existing
ones, achieving a behaviour like preferring a certain band becomes more
accessible while guaranteeing that the first-ranked BSSID still complies
with minimal necessary data rate requirements.
---
 src/scan.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/src/scan.c b/src/scan.c
index 5a972efb..16d533e4 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -55,6 +55,7 @@
 /* User configurable options */
 static double RANK_5G_FACTOR;
 static double RANK_6G_FACTOR;
+static double RANK_NECESSARY_RATE;
 static uint32_t SCAN_MAX_INTERVAL;
 static uint32_t SCAN_INIT_INTERVAL;
=20
@@ -1625,14 +1626,15 @@ static void scan_bss_compute_rank(struct scan_bss *=
bss)
 {
 	static const double RANK_HIGH_UTILIZATION_FACTOR =3D 0.8;
 	static const double RANK_LOW_UTILIZATION_FACTOR =3D 1.2;
+	double data_rate;
 	double rank;
 	uint32_t irank;
-	/*
-	 * Maximum rate is 9607.8Mbps (HE)
-	 */
-	double max_rate =3D 9607800000;
=20
-	rank =3D (double)bss->data_rate / max_rate * USHRT_MAX;
+	data_rate =3D (double)bss->data_rate;
+	if (data_rate > RANK_NECESSARY_RATE)
+		data_rate =3D RANK_NECESSARY_RATE;
+
+	rank =3D data_rate / RANK_NECESSARY_RATE * USHRT_MAX;
=20
 	/* Prefer 5G networks over 2.4G and 6G */
 	if (bss->frequency >=3D 4900 && bss->frequency < 5900)
@@ -2363,6 +2365,14 @@ static int scan_init(void)
 					&RANK_6G_FACTOR))
 		RANK_6G_FACTOR =3D 1.0;
=20
+	/* Maximum rate is 9607.8Mbps (HE) */
+	if (!l_settings_get_double(config, "Rank", "NecessaryRate",
+				&RANK_NECESSARY_RATE))
+		RANK_NECESSARY_RATE =3D 9607800000;
+
+	if (RANK_NECESSARY_RATE > 9607800000)
+		RANK_NECESSARY_RATE =3D 9607800000;
+
 	if (!l_settings_get_uint(config, "Scan", "InitialPeriodicScanInterval",
 					&SCAN_INIT_INTERVAL))
 		SCAN_INIT_INTERVAL =3D 10;
--=20
2.39.2
