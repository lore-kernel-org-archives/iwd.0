Content-Type: multipart/mixed; boundary="===============5117283702348439561=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 05/17] p2p: Use WSC_RF_BAND_2_4_GHZ constant instead of 0x01
Date: Wed, 09 Sep 2020 01:49:21 +0200
Message-ID: <20200908234933.301439-5-andrew.zaborowski@intel.com>
In-Reply-To: <20200908234933.301439-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5117283702348439561==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/p2p.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/p2p.c b/src/p2p.c
index 9983b0fc..0ec83ac3 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -3184,7 +3184,7 @@ static void p2p_device_send_probe_resp(struct p2p_dev=
ice *dev,
 	wsc_info.primary_device_type =3D dev->device_info.primary_device_type;
 	l_strlcpy(wsc_info.device_name, dev->device_info.device_name,
 			sizeof(wsc_info.device_name));
-	wsc_info.rf_bands =3D 0x01;	/* 2.4GHz */
+	wsc_info.rf_bands =3D WSC_RF_BAND_2_4_GHZ;
 	wsc_info.version2 =3D true;
 =

 	wsc_data =3D wsc_build_probe_response(&wsc_info, &wsc_data_size);
-- =

2.25.1

--===============5117283702348439561==--

