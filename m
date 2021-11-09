Content-Type: multipart/mixed; boundary="===============1578885782344026255=="
MIME-Version: 1.0
From: Torsten Schmitz <noreply.torsten at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH] auto-t: fix testP2P
Date: Tue, 09 Nov 2021 20:46:58 +0100
Message-ID: <20211109194658.63795-1-noreply.torsten@gmail.com>
In-Reply-To: b9aee7ea-3064-07da-b637-bcec0e198cdd@gmail.com

--===============1578885782344026255==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

testP2P was failing with
FileNotFoundError: [Errno 2] No such file or directory: '/tmp/wpa_supplican=
t.conf'
---
 tools/test-runner | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/test-runner b/tools/test-runner
index 9ae33301..5fc4285d 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -955,7 +955,7 @@ class TestContext(Namespace):
 =

 		else:
 			wpas_radios =3D [rad for rad in self.radios if rad.name in settings]
-			self.wpas_interfaces =3D [rad.create_interface('wpa_supplicant.conf', '=
wpas') \
+			self.wpas_interfaces =3D [rad.create_interface(settings[rad.name], 'wpa=
s') \
 						for rad in wpas_radios]
 =

 	def start_ofono(self):
-- =

2.33.1

--===============1578885782344026255==--

