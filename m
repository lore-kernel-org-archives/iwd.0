Content-Type: multipart/mixed; boundary="===============0240337062866409589=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v7 9/9] doc: document DPP ConfigureEnrollee()
Date: Tue, 22 Feb 2022 14:28:47 -0800
Message-ID: <20220222222847.2480099-9-prestwoj@gmail.com>
In-Reply-To: 20220222222847.2480099-1-prestwoj@gmail.com

--===============0240337062866409589==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/device-provisioning-api.txt | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

v7:
 * Changed some wording to be more explicit

diff --git a/doc/device-provisioning-api.txt b/doc/device-provisioning-api.=
txt
index bf54c5fe..0aba2557 100644
--- a/doc/device-provisioning-api.txt
+++ b/doc/device-provisioning-api.txt
@@ -37,3 +37,22 @@ Methods		string StartEnrollee()
 						net.connman.iwd.NotConfigured
 						net.connman.iwd.NotSupported
 						net.connman.iwd.Busy
+
+		string ConfigureEnrollee(string uri)
+
+			Start a DPP configurator with an enrollees URI.
+			Only connected station devices are supported and will
+			only configure the enrollee to the currently connected
+			network.
+
+			This API is to handle the use case where the enrollee
+			has shared its URI to IWD (unlike StartConfigurator)
+
+			The URI for IWD is also returned which could be used
+			in the same way as it is with StartConfigurator().
+
+			Possible errors:	net.connman.iwd.NotAvailable
+						net.connman.iwd.NotConnected
+						net.connman.iwd.NotConfigured
+						net.connman.iwd.NotSupported
+						net.connman.iwd.Busy
-- =

2.34.1

--===============0240337062866409589==--

