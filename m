Content-Type: multipart/mixed; boundary="===============6544725888625946387=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 7/9] doc: document StartConfigurator
Date: Mon, 20 Dec 2021 13:49:13 -0800
Message-ID: <20211220214915.34093-7-prestwoj@gmail.com>
In-Reply-To: 20211220214915.34093-1-prestwoj@gmail.com

--===============6544725888625946387==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/device-provisioning.txt | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/doc/device-provisioning.txt b/doc/device-provisioning.txt
index 3ac2d934..bf54c5fe 100644
--- a/doc/device-provisioning.txt
+++ b/doc/device-provisioning.txt
@@ -23,3 +23,17 @@ Methods		string StartEnrollee()
 			Possible errors:	net.connman.iwd.Busy
 						net.connman.iwd.Failed
 						net.connman.iwd.InvalidArguments
+
+		string StartConfigurator()
+
+			Start a DPP configurator. Currently only connected
+			station devices are supported, and will only configure
+			the enrollee to the currently connected network.
+
+			Returns the configurator URI
+
+			Possible errors:	net.connman.iwd.NotAvailable
+						net.connman.iwd.NotConnected
+						net.connman.iwd.NotConfigured
+						net.connman.iwd.NotSupported
+						net.connman.iwd.Busy
-- =

2.31.1

--===============6544725888625946387==--

