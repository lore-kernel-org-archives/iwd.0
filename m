Content-Type: multipart/mixed; boundary="===============2344523171756262394=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH] test-runner: allow wpa_supplicant to be used in --hw mode
Date: Tue, 26 Oct 2021 14:59:52 -0700
Message-ID: <20211026215952.1256143-1-prestwoj@gmail.com>

--===============2344523171756262394==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This lets test-runner's physical adapter pass-through to be used with
wpa_supplicant.
---
 tools/test-runner | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/tools/test-runner b/tools/test-runner
index a1967173..156b36cc 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -927,12 +927,32 @@ class TestContext(Namespace):
 		return frequencies
 =

 	def start_wpas_interfaces(self):
+
 		if 'WPA_SUPPLICANT' not in self.hw_config:
 			return
 =

 		settings =3D self.hw_config['WPA_SUPPLICANT']
-		wpas_radios =3D [rad for rad in self.radios if rad.name in settings]
-		self.wpas_interfaces =3D [rad.create_interface(settings[rad.name], 'wpas=
') for rad in wpas_radios]
+
+		if self.args.hw:
+			nradios =3D len(settings.items())
+
+			wpas_radios =3D self.radios[:nradios]
+			self.wpas_interfaces =3D []
+
+			#
+			# Physical radios most likely will use a different name
+			# than 'rad#' but the config file is referenced by these
+			# 'rad#' names. Iterate through both the settings and
+			# physical radios to create interfaces associated with
+			# each config file.
+			#
+			for vrad, hwrad in zip(settings.items(), wpas_radios):
+				self.wpas_interfaces.append(hwrad.create_interface(vrad[1], 'wpas'))
+
+		else:
+			wpas_radios =3D [rad for rad in self.radios if rad.name in settings]
+			self.wpas_interfaces =3D [rad.create_interface('wpa_supplicant.conf', '=
wpas') \
+						for rad in wpas_radios]
 =

 	def start_ofono(self):
 		sim_keys =3D self.hw_config['SETUP'].get('sim_keys', None)
-- =

2.31.1

--===============2344523171756262394==--

