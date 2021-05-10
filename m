Content-Type: multipart/mixed; boundary="===============7465899343659280875=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 11/11] doc: Document NetworkConfigurationEnabled in
 Daemon.GetInfo()
Date: Mon, 10 May 2021 10:58:06 +0200
Message-ID: <20210510085806.174213-11-andrew.zaborowski@intel.com>
In-Reply-To: <20210510085806.174213-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7465899343659280875==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/daemon-api.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/doc/daemon-api.txt b/doc/daemon-api.txt
index 439bf6f7..0e8b6b49 100644
--- a/doc/daemon-api.txt
+++ b/doc/daemon-api.txt
@@ -22,3 +22,9 @@ Methods		dict GetInfo()
 			state directory where network configuration and
 			runtime state files are kept (see $STATE_DIRECTORY in
 			iwd(8) and iwd.network(5)).
+
+			bool NetworkConfigurationEnabled - Whether network
+			configuration is enabled (see iwd(8)).  When true,
+			IWD configures the address, netmask, the resolver,
+			a route, the DHCP client or server (in station vs.
+			access point mode.)
-- =

2.27.0

--===============7465899343659280875==--

