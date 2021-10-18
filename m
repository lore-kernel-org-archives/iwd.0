Content-Type: multipart/mixed; boundary="===============6174858987071716836=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 4/4] auto-t: add OCV to testSAQuery-spoofing
Date: Mon, 18 Oct 2021 15:33:59 -0700
Message-ID: <20211018223359.497849-4-prestwoj@gmail.com>
In-Reply-To: 20211018223359.497849-1-prestwoj@gmail.com

--===============6174858987071716836==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/testSAQuery-spoofing/ssidCCMP.conf | 1 +
 1 file changed, 1 insertion(+)

diff --git a/autotests/testSAQuery-spoofing/ssidCCMP.conf b/autotests/testS=
AQuery-spoofing/ssidCCMP.conf
index 517083bf..0b70c3df 100644
--- a/autotests/testSAQuery-spoofing/ssidCCMP.conf
+++ b/autotests/testSAQuery-spoofing/ssidCCMP.conf
@@ -9,3 +9,4 @@ wpa_passphrase=3Dsecret123
 ieee80211w=3D2
 wpa_key_mgmt=3DWPA-PSK-SHA256
 beacon_int=3D10
+ocv=3D1
-- =

2.31.1

--===============6174858987071716836==--

