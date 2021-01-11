Content-Type: multipart/mixed; boundary="===============1824620198072134696=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 5/8] dbus: add diagnostic interface definition
Date: Mon, 11 Jan 2021 09:12:36 -0800
Message-ID: <20210111171239.472372-5-prestwoj@gmail.com>
In-Reply-To: <20210111171239.472372-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1824620198072134696==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/dbus.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/dbus.h b/src/dbus.h
index 045b1bcb..3e2018d8 100644
--- a/src/dbus.h
+++ b/src/dbus.h
@@ -39,6 +39,7 @@
 #define IWD_P2P_PEER_INTERFACE "net.connman.iwd.p2p.Peer"
 #define IWD_P2P_SERVICE_MANAGER_INTERFACE "net.connman.iwd.p2p.ServiceMana=
ger"
 #define IWD_P2P_WFD_INTERFACE "net.connman.iwd.p2p.Display"
+#define IWD_STATION_DIAGNOSTIC_INTERFACE "net.connman.iwd.StationDiagnosti=
c"
 =

 #define IWD_BASE_PATH "/net/connman/iwd"
 #define IWD_AGENT_MANAGER_PATH IWD_BASE_PATH
-- =

2.26.2

--===============1824620198072134696==--

