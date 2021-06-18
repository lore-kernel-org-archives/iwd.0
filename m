Content-Type: multipart/mixed; boundary="===============5686292039541660189=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/3] station: Check if busy in station_get_diagnostics
Date: Fri, 18 Jun 2021 09:33:23 +0200
Message-ID: <20210618073324.67095-2-andrew.zaborowski@intel.com>
In-Reply-To: <20210618073324.67095-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5686292039541660189==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/station.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/station.c b/src/station.c
index 11711973..0b0cc59c 100644
--- a/src/station.c
+++ b/src/station.c
@@ -3768,6 +3768,9 @@ static struct l_dbus_message *station_get_diagnostics=
(struct l_dbus *dbus,
 	struct station *station =3D user_data;
 	int ret;
 =

+	if (station->get_station_pending)
+		return dbus_error_busy(message);
+
 	ret =3D netdev_get_current_station(station->netdev,
 				station_get_diagnostic_cb, station,
 				station_get_diagnostic_destroy);
-- =

2.30.2

--===============5686292039541660189==--

