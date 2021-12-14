Content-Type: multipart/mixed; boundary="===============2489273950658619387=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 01/10] dbus: add DPP interface
Date: Tue, 14 Dec 2021 10:12:16 -0800
Message-ID: <20211214181225.2308043-1-prestwoj@gmail.com>

--===============2489273950658619387==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/dbus.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/dbus.h b/src/dbus.h
index 7703b37f..bbc76608 100644
--- a/src/dbus.h
+++ b/src/dbus.h
@@ -43,6 +43,7 @@
 #define IWD_STATION_DIAGNOSTIC_INTERFACE "net.connman.iwd.StationDiagnosti=
c"
 #define IWD_AP_DIAGNOSTIC_INTERFACE "net.connman.iwd.AccessPointDiagnostic"
 #define IWD_STATION_DEBUG_INTERFACE "net.connman.iwd.StationDebug"
+#define IWD_DPP_INTERFACE "net.connman.iwd.DeviceProvisioning"
 =

 #define IWD_BASE_PATH "/net/connman/iwd"
 #define IWD_AGENT_MANAGER_PATH IWD_BASE_PATH
-- =

2.31.1

--===============2489273950658619387==--

