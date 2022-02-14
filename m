Content-Type: multipart/mixed; boundary="===============7914451491938636645=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v3 10/10] doc: document DPP ConfigureEnrollee()
Date: Mon, 14 Feb 2022 13:48:09 -0800
Message-ID: <20220214214809.1017870-10-prestwoj@gmail.com>
In-Reply-To: 20220214214809.1017870-1-prestwoj@gmail.com

--===============7914451491938636645==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/device-provisioning-api.txt | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/doc/device-provisioning-api.txt b/doc/device-provisioning-api.=
txt
index bf54c5fe..529aeeb0 100644
--- a/doc/device-provisioning-api.txt
+++ b/doc/device-provisioning-api.txt
@@ -37,3 +37,19 @@ Methods		string StartEnrollee()
 						net.connman.iwd.NotConfigured
 						net.connman.iwd.NotSupported
 						net.connman.iwd.Busy
+
+		string ConfigureEnrollee(string uri)
+
+			Start a DPP configurator with an enrollees URI.
+			Ultimately the configuration itself remains the same as
+			StartConfigurator(). This API is to handle the use case
+			where the enrollee has shared its URI to IWD.
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

--===============7914451491938636645==--

