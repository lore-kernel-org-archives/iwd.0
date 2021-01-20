Content-Type: multipart/mixed; boundary="===============8743345607677798181=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 5/8] client: add AccessPointDiagnostic interface definition
Date: Wed, 20 Jan 2021 10:30:33 -0800
Message-ID: <20210120183036.477287-5-prestwoj@gmail.com>
In-Reply-To: <20210120183036.477287-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8743345607677798181==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 client/dbus-proxy.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/client/dbus-proxy.h b/client/dbus-proxy.h
index 9c5c57e5..a3ca270a 100644
--- a/client/dbus-proxy.h
+++ b/client/dbus-proxy.h
@@ -34,6 +34,7 @@ struct proxy_interface;
 #define IWD_WSC_INTERFACE                "net.connman.iwd.SimpleConfigurat=
ion"
 #define IWD_STATION_INTERFACE            "net.connman.iwd.Station"
 #define IWD_STATION_DIAGNOSTIC_INTERFACE "net.connman.iwd.StationDiagnosti=
c"
+#define IWD_AP_DIAGNOSTIC_INTERFACE      "net.connman.iwd.AccessPointDiagn=
ostic"
 =

 typedef bool (*proxy_property_match_func_t) (const void *a, const void *b);
 =

-- =

2.26.2

--===============8743345607677798181==--

