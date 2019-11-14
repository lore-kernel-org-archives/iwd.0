Content-Type: multipart/mixed; boundary="===============1676856266226536479=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] station: fail if trying to scan while connecting
Date: Thu, 14 Nov 2019 10:59:59 -0800
Message-ID: <20191114185959.24875-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1676856266226536479==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If a scan is requested during the middle of a connection we should
return busy instead of attempting the scan. The kernel ends up coming
back with not supported in this case, which is misleading and
difficult to debug.
---
 src/station.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/station.c b/src/station.c
index 76cf20a1..0da352c3 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2751,6 +2751,9 @@ static struct l_dbus_message *station_dbus_scan(struc=
t l_dbus *dbus,
 	if (station->dbus_scan_id)
 		return dbus_error_busy(message);
 =

+	if (station->state =3D=3D STATION_STATE_CONNECTING)
+		return dbus_error_busy(message);
+
 	station->dbus_scan_id =3D station_scan_trigger(station, NULL,
 						station_dbus_scan_triggered,
 						new_scan_results,
-- =

2.17.1

--===============1676856266226536479==--

