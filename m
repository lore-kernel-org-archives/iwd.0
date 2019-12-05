Content-Type: multipart/mixed; boundary="===============0042293454369921820=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 7/7] doc: Generalize wsc-api method descriptions
Date: Thu, 05 Dec 2019 04:22:44 +0100
Message-ID: <20191205032244.5957-7-andrew.zaborowski@intel.com>
In-Reply-To: <20191205032244.5957-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0042293454369921820==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/wsc-api.txt | 42 +++++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/doc/wsc-api.txt b/doc/wsc-api.txt
index cfd34943..561824ce 100644
--- a/doc/wsc-api.txt
+++ b/doc/wsc-api.txt
@@ -4,21 +4,24 @@ SimpleConfiguration hierarchy
 Service		net.connman.iwd
 Interface	net.connman.iwd.SimpleConfiguration
 Object path	/net/connman/iwd/{phy0,phy1,...}/{1,2,...}
+Object path	/net/connman/iwd/{phy0,phy1,...}/p2p_peers/{aa_bb_cc_dd_ee_ff}
 =

 Methods		void PushButton()
 =

 			Start WSC (formerly known as WPS, Wi-Fi Protected
-			Setup) configuration in PushButton mode.
+			Setup) configuration in PushButton mode or trigger a
+			connection to a specific P2P peer.  The usage will
+			depend on which object this interface is found on.
 =

-			Any connected networks on the device will be
-			disconnected and scanning will commence to find the
-			access point in PushButton mode.  If multiple access
-			points are found, then a SessionOverlap error will be
-			returned.
+			In the first use case any connected networks on the
+			device will be disconnected and scanning will commence
+			to find the access point in PushButton mode.  If
+			multiple access points are found, then a
+			SessionOverlap error will be returned.
 =

 			This method returns once the configuration has been
-			completed and the network has been successfully
-			connected.
+			completed and the network or the P2P peer has been
+			successfully connected.
 =

 			Possible errors:
 			net.connman.iwd.SimpleConfiguration.SessionOverlap
@@ -28,6 +31,8 @@ Methods		void PushButton()
 			net.connman.iwd.Aborted
 			net.connman.iwd.Failed
 			net.connman.iwd.Busy
+			net.connman.iwd.InvalidArguments
+			net.connman.iwd.NotSupported
 =

 		string GeneratePin()
 =

@@ -35,10 +40,12 @@ Methods		void PushButton()
 			digit suitable for use by most user interfaces.
 =

 		void StartPin(string pin)
-			Start WSC in PIN mode.  If iwd's WSC configuration
-			indicates that the device does not support a display,
-			a static PIN from the main.conf configuration file is
-			used.  Contents of pin are ignored in this case.
+
+			Start WSC or connect to a specific P2P peer in PIN
+			mode.  If iwd's WSC configuration indicates that the
+			device does not support a display, a static PIN from
+			the main.conf configuration file is used.  Contents
+			of pin are ignored in this case.
 =

 			Otherwise, the pin provided will be utilized.  This
 			can be an automatically generated PIN that contains a
@@ -47,8 +54,8 @@ Methods		void PushButton()
 			8 digit PIN with an included check digit.
 =

 			This method returns once the configuration has been
-			completed and the network has been successfully
-			connected.
+			completed and the network or the P2P peer has been
+			successfully connected.
 =

 			Possible errors:
 			net.connman.iwd.SimpleConfiguration.NoCredentials
@@ -59,9 +66,10 @@ Methods		void PushButton()
 			net.connman.iwd.Busy
 			net.connman.iwd.InvalidArguments
 			net.connman.iwd.InvalidFormat
+			net.connman.iwd.NotSupported
 =

 		void Cancel()
 =

-			Aborts any ongoing WSC operations.  If no WSC
-			operation is ongoing, net.connman.iwd.NotAvailable is
-			returned.
+			Aborts any ongoing WSC operations or a P2P connection.
+			If no operation is ongoing, net.connman.iwd.NotAvailable
+			is returned.
-- =

2.20.1

--===============0042293454369921820==--

