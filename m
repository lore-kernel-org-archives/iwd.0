Content-Type: multipart/mixed; boundary="===============9041492049259048855=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/2] auto-t: give testEAP-TTLS-MSCHAPv2 a longer timeout
Date: Thu, 14 Nov 2019 11:58:05 -0800
Message-ID: <20191114195806.27948-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============9041492049259048855==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When logging is turned on this test consistently fails due to a
timeout. Giving it a bit more time allows it to pass.
---
 autotests/testEAP-TTLS-MSCHAPv2/hw.conf | 1 +
 1 file changed, 1 insertion(+)

diff --git a/autotests/testEAP-TTLS-MSCHAPv2/hw.conf b/autotests/testEAP-TT=
LS-MSCHAPv2/hw.conf
index 406e830d..3535d56a 100644
--- a/autotests/testEAP-TTLS-MSCHAPv2/hw.conf
+++ b/autotests/testEAP-TTLS-MSCHAPv2/hw.conf
@@ -2,6 +2,7 @@
 num_radios=3D2
 tmpfs_extra_stuff=3D../misc/certs:eap-user-ttls-mschapv2.text
 start_iwd=3DFalse
+max_test_exec_interval_sec=3D45
 =

 [HOSTAPD]
 rad0=3DssidEAP-TTLS-MSCHAPv2.conf
-- =

2.17.1

--===============9041492049259048855==--

