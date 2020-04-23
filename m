Content-Type: multipart/mixed; boundary="===============1624510597652424763=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 03/19] doc: List possible P2P peer category/subcategory values
Date: Thu, 23 Apr 2020 18:24:31 +0200
Message-ID: <20200423162447.15750-3-andrew.zaborowski@intel.com>
In-Reply-To: <20200423162447.15750-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1624510597652424763==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/p2p-peer-api.txt | 86 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 84 insertions(+), 2 deletions(-)

diff --git a/doc/p2p-peer-api.txt b/doc/p2p-peer-api.txt
index f52717aa..a7b310b0 100644
--- a/doc/p2p-peer-api.txt
+++ b/doc/p2p-peer-api.txt
@@ -22,12 +22,94 @@ Properties	string Name [readonly]
 		string DeviceCategory [readonly]
 =

 			The category part of the peer's declared
-			Primary Device Type.
+			Primary Device Type.  Takes one of the following
+			values, "unknown-device" being reported when the
+			device type is not one of those defined in the
+			Wi-Fi Simple Configuration specification:
+
+			'computer',
+			'input device',
+			'printer-scanner',
+			'camera',
+			'storage',
+			'network-infrastructure',
+			'display',
+			'multimedia-device',
+			'gaming-device',
+			'telephone',
+			'audio-device',
+			'docking-device',
+			'unknown-device'.
 =

 		string DeviceSubcategory [readonly, optional]
 =

 			The Sub Category part of the peer's declared
-			Primary Device Type.
+			Primary Device Type, if recognised by WSC.
+			Supported values are:
+
+			'pc',
+			'server',
+			'media-center',
+			'ultra-mobile-pc',
+			'notebook',
+			'desktop',
+			'mobile-internet-device',
+			'netbook',
+			'tablet',
+			'ultrabook',
+			'keyboard',
+			'mouse',
+			'joystick',
+			'trackball',
+			'gaming-controller',
+			'remote',
+			'touchscreen',
+			'biometric-reader',
+			'barcode-reader',
+			'printer-print-server',
+			'scanner',
+			'fax',
+			'copier',
+			'printer-scanner-fax-copier',
+			'digital-still-camera',
+			'video-camera',
+			'web-camera',
+			'security-camera',
+			'nas',
+			'ap',
+			'router',
+			'switch',
+			'gateway',
+			'bridge',
+			'television',
+			'electronic-picture-frame',
+			'projector',
+			'monitor',
+			'dar',
+			'pvr',
+			'mcx',
+			'set-top-box',
+			'media-server-adapter-extender',
+			'portable-video-player',
+			'xbox',
+			'xbox360',
+			'playstation',
+			'game-console-adapter',
+			'portable-gaming-device',
+			'windows-mobile',
+			'single-mode-phone',
+			'dual-mode-phone',
+			'single-mode-smartphone',
+			'dual-mode-smartphone',
+			'audio-tuner-receiver',
+			'speakers',
+			'portable-music-player',
+			'headset',
+			'headphones',
+			'microphone',
+			'home-theater-system',
+			'computer-docking-station',
+			'media-kiosk'.
 =

 		object Device [readonly]
 =

-- =

2.20.1

--===============1624510597652424763==--

