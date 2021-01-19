Content-Type: multipart/mixed; boundary="===============6191060499683667446=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/2] client: add diagnostic interface definition
Date: Tue, 19 Jan 2021 09:14:44 -0800
Message-ID: <20210119171445.389944-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6191060499683667446==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 client/dbus-proxy.h | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/client/dbus-proxy.h b/client/dbus-proxy.h
index a3304848..9c5c57e5 100644
--- a/client/dbus-proxy.h
+++ b/client/dbus-proxy.h
@@ -24,15 +24,16 @@
 =

 struct proxy_interface;
 =

-#define IWD_ADAPTER_INTERFACE          "net.connman.iwd.Adapter"
-#define IWD_ACCESS_POINT_INTERFACE     "net.connman.iwd.AccessPoint"
-#define IWD_AD_HOC_INTERFACE           "net.connman.iwd.AdHoc"
-#define IWD_AGENT_MANAGER_INTERFACE    "net.connman.iwd.AgentManager"
-#define IWD_DEVICE_INTERFACE           "net.connman.iwd.Device"
-#define IWD_KNOWN_NETWORK_INTREFACE    "net.connman.iwd.KnownNetwork"
-#define IWD_NETWORK_INTERFACE          "net.connman.iwd.Network"
-#define IWD_WSC_INTERFACE              "net.connman.iwd.SimpleConfiguratio=
n"
-#define IWD_STATION_INTERFACE          "net.connman.iwd.Station"
+#define IWD_ADAPTER_INTERFACE            "net.connman.iwd.Adapter"
+#define IWD_ACCESS_POINT_INTERFACE       "net.connman.iwd.AccessPoint"
+#define IWD_AD_HOC_INTERFACE             "net.connman.iwd.AdHoc"
+#define IWD_AGENT_MANAGER_INTERFACE      "net.connman.iwd.AgentManager"
+#define IWD_DEVICE_INTERFACE             "net.connman.iwd.Device"
+#define IWD_KNOWN_NETWORK_INTREFACE      "net.connman.iwd.KnownNetwork"
+#define IWD_NETWORK_INTERFACE            "net.connman.iwd.Network"
+#define IWD_WSC_INTERFACE                "net.connman.iwd.SimpleConfigurat=
ion"
+#define IWD_STATION_INTERFACE            "net.connman.iwd.Station"
+#define IWD_STATION_DIAGNOSTIC_INTERFACE "net.connman.iwd.StationDiagnosti=
c"
 =

 typedef bool (*proxy_property_match_func_t) (const void *a, const void *b);
 =

-- =

2.26.2

--===============6191060499683667446==--

