Content-Type: multipart/mixed; boundary="===============3399700322712464761=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 2/5] auto-t: hwsim.py: set NoVirtualInterface by default
Date: Tue, 05 Apr 2022 11:30:08 -0700
Message-ID: <20220405183011.856403-2-prestwoj@gmail.com>
In-Reply-To: 20220405183011.856403-1-prestwoj@gmail.com

--===============3399700322712464761==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There is really no reason to have hwsim create interfaces automatically
for test-runner. test-runner already does this for wpa_supplicant and
hostapd, and IWD can create the interface itself.
---
 autotests/util/hwsim.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/autotests/util/hwsim.py b/autotests/util/hwsim.py
index ce85f43d..80a847ad 100755
--- a/autotests/util/hwsim.py
+++ b/autotests/util/hwsim.py
@@ -314,6 +314,7 @@ class RadioList(collections.Mapping):
         args =3D dbus.Dictionary({
             'Name': name,
             'P2P': p2p_device,
+            'NoVirtualInterface': True,
         }, signature=3D'sv')
 =

         if iftype_disable:
-- =

2.34.1

--===============3399700322712464761==--

