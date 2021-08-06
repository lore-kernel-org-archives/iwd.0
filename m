Content-Type: multipart/mixed; boundary="===============6717449373860592784=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/5] dbus: add StationDebug interface definition
Date: Fri, 06 Aug 2021 16:02:10 -0700
Message-ID: <20210806230212.381657-3-prestwoj@gmail.com>
In-Reply-To: <20210806230212.381657-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6717449373860592784==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This will hold methods/properties for developers to use.
---
 src/dbus.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/dbus.h b/src/dbus.h
index b3896108..7703b37f 100644
--- a/src/dbus.h
+++ b/src/dbus.h
@@ -42,6 +42,7 @@
 #define IWD_P2P_WFD_INTERFACE "net.connman.iwd.p2p.Display"
 #define IWD_STATION_DIAGNOSTIC_INTERFACE "net.connman.iwd.StationDiagnosti=
c"
 #define IWD_AP_DIAGNOSTIC_INTERFACE "net.connman.iwd.AccessPointDiagnostic"
+#define IWD_STATION_DEBUG_INTERFACE "net.connman.iwd.StationDebug"
 =

 #define IWD_BASE_PATH "/net/connman/iwd"
 #define IWD_AGENT_MANAGER_PATH IWD_BASE_PATH
-- =

2.31.1

--===============6717449373860592784==--

