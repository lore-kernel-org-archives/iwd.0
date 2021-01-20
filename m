Content-Type: multipart/mixed; boundary="===============0639946178850134973=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/8] dbus: add AccessPointDiagnostic interface
Date: Wed, 20 Jan 2021 10:30:31 -0800
Message-ID: <20210120183036.477287-3-prestwoj@gmail.com>
In-Reply-To: <20210120183036.477287-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0639946178850134973==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/dbus.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/dbus.h b/src/dbus.h
index 93055bf6..f98ade7a 100644
--- a/src/dbus.h
+++ b/src/dbus.h
@@ -40,6 +40,7 @@
 #define IWD_P2P_SERVICE_MANAGER_INTERFACE "net.connman.iwd.p2p.ServiceMana=
ger"
 #define IWD_P2P_WFD_INTERFACE "net.connman.iwd.p2p.Display"
 #define IWD_STATION_DIAGNOSTIC_INTERFACE "net.connman.iwd.StationDiagnosti=
c"
+#define IWD_AP_DIAGNOSTIC_INTERFACE "net.connman.iwd.AccessPointDiagnostic"
 =

 #define IWD_BASE_PATH "/net/connman/iwd"
 #define IWD_AGENT_MANAGER_PATH IWD_BASE_PATH
-- =

2.26.2

--===============0639946178850134973==--

