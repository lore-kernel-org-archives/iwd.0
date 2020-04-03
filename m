Content-Type: multipart/mixed; boundary="===============4516784486060190764=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 01/17] dbus: Add P2P interface name defines
Date: Fri, 03 Apr 2020 18:14:14 +0200
Message-ID: <20200403161430.14168-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4516784486060190764==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/dbus.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/dbus.h b/src/dbus.h
index 6416fa42..ebae85d4 100644
--- a/src/dbus.h
+++ b/src/dbus.h
@@ -35,6 +35,8 @@
 #define IWD_AP_INTERFACE "net.connman.iwd.AccessPoint"
 #define IWD_ADHOC_INTERFACE "net.connman.iwd.AdHoc"
 #define IWD_STATION_INTERFACE "net.connman.iwd.Station"
+#define IWD_P2P_INTERFACE "net.connman.iwd.p2p.Device"
+#define IWD_P2P_PEER_INTERFACE "net.connman.iwd.p2p.Peer"
 =

 #define IWD_BASE_PATH "/net/connman/iwd"
 #define IWD_AGENT_MANAGER_PATH IWD_BASE_PATH
-- =

2.20.1

--===============4516784486060190764==--

