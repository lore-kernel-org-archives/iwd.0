Content-Type: multipart/mixed; boundary="===============8513758618807281029=="
MIME-Version: 1.0
From: Torsten Schmitz <noreply.torsten at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH] auto-t: fix testP2P
Date: Tue, 09 Nov 2021 19:58:49 +0100
Message-ID: <CANvyuLWd7rvP8LvxCYza5kZZpffeze6Fa-nBUUmb7gT7fAqUEQ@mail.gmail.com>

--===============8513758618807281029==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

testP2P was failing with
FileNotFoundError: [Errno 2] No such file or directory:
'/tmp/wpa_supplicant.conf'
---
 tools/test-runner | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/test-runner b/tools/test-runner
index 9ae33301..5fc4285d 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -955,7 +955,7 @@ class TestContext(Namespace):

                else:
                        wpas_radios =3D [rad for rad in self.radios if
rad.name in settings]
-                       self.wpas_interfaces =3D
[rad.create_interface('wpa_supplicant.conf', 'wpas') \
+                       self.wpas_interfaces =3D
[rad.create_interface(settings[rad.name], 'wpas') \
                                                for rad in wpas_radios]

        def start_ofono(self):
--
2.33.1
--===============8513758618807281029==--

