Content-Type: multipart/mixed; boundary="===============0187223805467343602=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 5/6] client: add DPP interface
Date: Mon, 20 Dec 2021 16:07:46 -0800
Message-ID: <20211221000747.56696-5-prestwoj@gmail.com>
In-Reply-To: 20211221000747.56696-1-prestwoj@gmail.com

--===============0187223805467343602==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 client/dbus-proxy.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/client/dbus-proxy.h b/client/dbus-proxy.h
index 2a366d1b..1d6af5de 100644
--- a/client/dbus-proxy.h
+++ b/client/dbus-proxy.h
@@ -36,6 +36,7 @@ struct proxy_interface;
 #define IWD_STATION_DIAGNOSTIC_INTERFACE "net.connman.iwd.StationDiagnosti=
c"
 #define IWD_AP_DIAGNOSTIC_INTERFACE      "net.connman.iwd.AccessPointDiagn=
ostic"
 #define IWD_DAEMON_INTERFACE             "net.connman.iwd.Daemon"
+#define IWD_DPP_INTERFACE                "net.connman.iwd.DeviceProvisioni=
ng"
 =

 typedef bool (*proxy_property_match_func_t) (const void *a, const void *b);
 =

-- =

2.31.1

--===============0187223805467343602==--

