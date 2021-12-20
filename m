Content-Type: multipart/mixed; boundary="===============1549263640387053363=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 8/9] client: add DPP interface
Date: Mon, 20 Dec 2021 13:49:14 -0800
Message-ID: <20211220214915.34093-8-prestwoj@gmail.com>
In-Reply-To: 20211220214915.34093-1-prestwoj@gmail.com

--===============1549263640387053363==
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

--===============1549263640387053363==--

