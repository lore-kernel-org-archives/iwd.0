Content-Type: multipart/mixed; boundary="===============1537296022390087027=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 3/7] autotests: Test loading binary key formats in testEAP-TLS
Date: Mon, 25 Jan 2021 18:56:13 +0100
Message-ID: <20210125175617.2417412-3-andrew.zaborowski@intel.com>
In-Reply-To: <20210125175617.2417412-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1537296022390087027==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/misc/certs/cert-client.crt     | Bin 0 -> 1089 bytes
 autotests/misc/certs/cert-client.p12     | Bin 0 -> 2693 bytes
 autotests/testEAP-TLS/connection_test.py |   4 ++++
 autotests/testEAP-TLS/hw.conf            |   3 ++-
 autotests/testEAP-TLS/ssidEAP-TLS3.8021x |   2 +-
 autotests/testEAP-TLS/ssidEAP-TLS4.8021x |   9 +++++++++
 autotests/testEAP-TLS/ssidEAP-TLS4.conf  |  13 +++++++++++++
 7 files changed, 29 insertions(+), 2 deletions(-)
 create mode 100644 autotests/misc/certs/cert-client.crt
 create mode 100644 autotests/misc/certs/cert-client.p12
 create mode 100644 autotests/testEAP-TLS/ssidEAP-TLS4.8021x
 create mode 100644 autotests/testEAP-TLS/ssidEAP-TLS4.conf

diff --git a/autotests/misc/certs/cert-client.crt b/autotests/misc/certs/ce=
rt-client.crt
new file mode 100644
index 0000000000000000000000000000000000000000..fb363f59593079fc54a5f44777c=
f6da1ae7885ab
GIT binary patch
literal 1089
zcmXqLVzD)7Vpd(i%*4pV#L4i}dfn>^&lDyDUN%mxHjlRNyo`+8tPBPfhNcF_Y|No7
zTs%6Sc_pbud5I;N`FV*s3ZZ#GS|LA8!L=3DeWw;(4~!M`XyF)y<UEMIIWZy*cO#>^w;
zoLW?pnU<NHSdyxcSzKJ2TBML(T4^X}AOp9GlTnO6Ing0EF*8Rm6=3DIx$oH(zcnSrUH
zxsjoffr)vPIIoGZp@D%hlxvV~sAwP$ahZfuVi8tnz?3la;8p^1D9p=3D1cL*dU7NI(%
ziBSnTR2W$qn41{+84Q{jxtN+585tg0^8XBJU2^EY(6`UgxhY>lTr0iQ7JVovobISS
zVfGq>#B7I_Jv};(uh%P(a)EYR>O=3De-xcIsH#_^Rb_%-lscuEI%IgIQH4n|EJy^>QP;P
zN^=3D{hlDl}GwnOCXua94pUY<F}n1`X~w~g+%CsPyi_Mi3;y1h!QWK-g&D@B{u+Z>lS
zn)0w+SpM(7J9Rv=3DbJR_z->%8aY87)cd%geD{f5YJmW78eO15R5P4Zp6fZ<%n0a=3Dy4
z;}UBMgq3#kH<q=3DZKYaD!p(*>sPN%H<SfhS1KFu!VPVlln9(+#qa&=3DW#^mD)3Ehu%r
zd_uGP|Mz;$dkSZibXokA7Ck*aH!@!B#&@F$-+e6>GchwVFfMMqWzcxtfD;%YvcfD(
z1`Ocnm*ry-V-b1t_4y_%XM=3Dk$`j;5by1U;?Xxou`gT_(a)LrOGUgiwqj)H;BCNxp&Dy
zV9WE3PqosOf9#73f2%oVVa<}NflGi*oD4J9-po6+>*9Ol=3Dm%yBVDvLG*cb~x4$i1-
z=3D6vh;WX;Ftvjm;Ejl4u&OlkJ+wv>HSd9<0k_Q(pGPbR|47VcRcHc{CmaLU7z*?LnI
zE-MErFsaY(%QktH>(?Y7`r9?S;AH^+PxGH&CMxO7`1SYXKY50=3DZl8YT`Q73TZg5!r
zuPpW9>K6>Xf=3DeW}PpMnWeQ-kJwL2bs3zuBz`FqV=3DH``%x>aLj=3DZGK8R?X>t2I%C2$
zzBb`~Z(r6hi|kwPAah!`>e0Nfr)1Z6Y&u%GAw5(6+Evjc&hV`5mb2I2DSGJmaapC;
zv6HDWi(CXg-dp0%VfA#{*B?v1<=3DhO_5<XxcX_2j{Q8cSn(a)z;Eg1&<{!Us?A^@k6U~
H@p=3DmYm{YHs

literal 0
HcmV?d00001

diff --git a/autotests/misc/certs/cert-client.p12 b/autotests/misc/certs/ce=
rt-client.p12
new file mode 100644
index 0000000000000000000000000000000000000000..e57a1bfde3a9a157605d2fdb558=
00c6a819e9b02
GIT binary patch
literal 2693
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

literal 0
HcmV?d00001

diff --git a/autotests/testEAP-TLS/connection_test.py b/autotests/testEAP-T=
LS/connection_test.py
index 1e390e69..c90b0ceb 100644
--- a/autotests/testEAP-TLS/connection_test.py
+++ b/autotests/testEAP-TLS/connection_test.py
@@ -66,11 +66,15 @@ class Test(unittest.TestCase):
     def test_eap_tls3(self):
         self.do_test_connection_success('ssidEAP-TLS3', 'abc')
 =

+    def test_eap_tls4(self):
+        self.do_test_connection_success('ssidEAP-TLS4')
+
     @classmethod
     def setUpClass(cls):
         IWD.copy_to_storage('ssidEAP-TLS.8021x')
         IWD.copy_to_storage('ssidEAP-TLS2.8021x')
         IWD.copy_to_storage('ssidEAP-TLS3.8021x')
+        IWD.copy_to_storage('ssidEAP-TLS4.8021x')
 =

     @classmethod
     def tearDownClass(cls):
diff --git a/autotests/testEAP-TLS/hw.conf b/autotests/testEAP-TLS/hw.conf
index 44cd4239..0ce95320 100644
--- a/autotests/testEAP-TLS/hw.conf
+++ b/autotests/testEAP-TLS/hw.conf
@@ -1,8 +1,9 @@
 [SETUP]
-num_radios=3D4
+num_radios=3D5
 tmpfs_extra_stuff=3D../misc/certs
 =

 [HOSTAPD]
 rad0=3DssidEAP-TLS.conf
 rad1=3DssidEAP-TLS2.conf
 rad2=3DssidEAP-TLS3.conf
+rad3=3DssidEAP-TLS4.conf
diff --git a/autotests/testEAP-TLS/ssidEAP-TLS3.8021x b/autotests/testEAP-T=
LS/ssidEAP-TLS3.8021x
index 1d9225f1..03d571e9 100644
--- a/autotests/testEAP-TLS/ssidEAP-TLS3.8021x
+++ b/autotests/testEAP-TLS/ssidEAP-TLS3.8021x
@@ -1,7 +1,7 @@
 [Security]
 EAP-Method=3DTLS
 EAP-TLS-CACert=3D/tmp/certs/cert-ca.pem
-EAP-TLS-ClientCert=3D/tmp/certs/cert-client.pem
+EAP-TLS-ClientCert=3D/tmp/certs/cert-client.crt
 EAP-TLS-ClientKey=3D/tmp/certs/cert-client-key-v2-des-ede3.pem
 EAP-Identity=3Dabc(a)example.com
 =

diff --git a/autotests/testEAP-TLS/ssidEAP-TLS4.8021x b/autotests/testEAP-T=
LS/ssidEAP-TLS4.8021x
new file mode 100644
index 00000000..61523310
--- /dev/null
+++ b/autotests/testEAP-TLS/ssidEAP-TLS4.8021x
@@ -0,0 +1,9 @@
+[Security]
+EAP-Method=3DTLS
+EAP-TLS-CACert=3D/tmp/certs/cert-ca.pem
+EAP-TLS-ClientKeyBundle=3D/tmp/certs/cert-client.p12
+EAP-TLS-ClientKeyPassphrase=3Dabc
+EAP-Identity=3Dabc@example.com
+
+[Settings]
+AutoConnect=3DFalse
diff --git a/autotests/testEAP-TLS/ssidEAP-TLS4.conf b/autotests/testEAP-TL=
S/ssidEAP-TLS4.conf
new file mode 100644
index 00000000..41c63c95
--- /dev/null
+++ b/autotests/testEAP-TLS/ssidEAP-TLS4.conf
@@ -0,0 +1,13 @@
+ctrl_interface=3D/var/run/hostapd
+hw_mode=3Dg
+channel=3D4
+ssid=3DssidEAP-TLS4
+
+wpa=3D3
+wpa_key_mgmt=3DWPA-EAP
+ieee8021x=3D1
+eap_server=3D1
+eap_user_file=3D/tmp/certs/eap-user-tls.text
+ca_cert=3D/tmp/certs/cert-ca.pem
+server_cert=3D/tmp/certs/cert-server.pem
+private_key=3D/tmp/certs/cert-server-key.pem
-- =

2.27.0

--===============1537296022390087027==--

