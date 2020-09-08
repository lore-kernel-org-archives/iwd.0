Content-Type: multipart/mixed; boundary="===============4116171050953977221=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 03/17] p2p: Do provisioning scan from the Interface Address
Date: Wed, 09 Sep 2020 01:49:19 +0200
Message-ID: <20200908234933.301439-3-andrew.zaborowski@intel.com>
In-Reply-To: <20200908234933.301439-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4116171050953977221==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

For WSC we should have been sending our probe requests from the same
address we're going to be doing EAP-WSC with the GO.  Somehow I was able
to connect to most devices without that but other implementations seem
to use the Interface Address (the P2P-Client's MAC), not the Device
Address (P2P-Device's MAC).  We could switch the order to first create
the new interface and scan from it is simpler to use the scan_context we
already have created on the device interface and set a different mac.
---
 src/p2p.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/p2p.c b/src/p2p.c
index 34ff94bf..6c36d5b0 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -1300,6 +1300,13 @@ static void p2p_provision_scan_start(struct p2p_devi=
ce *dev)
 						&params.extra_ie_size);
 	L_WARN_ON(!params.extra_ie);
 =

+	/*
+	 * Rather than create the new interface and create a new
+	 * scan_context on it, use the P2P-Device interface and set
+	 * params.source_mac to our future P2P-Client address.
+	 */
+	params.source_mac =3D dev->conn_addr;
+
 	/*
 	 * Initially scan just the Operating Channel the GO reported
 	 * during the negotiation.  In theory there's no guarantee that
-- =

2.25.1

--===============4116171050953977221==--

