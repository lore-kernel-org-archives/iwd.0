Content-Type: multipart/mixed; boundary="===============4359259534390719237=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 4/8] auto-t: add OCV to testSAQuery-spoofing
Date: Tue, 19 Oct 2021 11:19:06 -0700
Message-ID: <20211019181910.558043-4-prestwoj@gmail.com>
In-Reply-To: 20211019181910.558043-1-prestwoj@gmail.com

--===============4359259534390719237==
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

--===============4359259534390719237==--

