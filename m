Content-Type: multipart/mixed; boundary="===============6264080947772681009=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 04/13] station: Comment/whitespace fix
Date: Fri, 31 Jul 2020 03:31:27 +0200
Message-ID: <20200731013136.65057-4-andrew.zaborowski@intel.com>
In-Reply-To: <20200731013136.65057-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6264080947772681009==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/station.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/src/station.c b/src/station.c
index 0095d6c8..42d60942 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2282,7 +2282,7 @@ static bool station_retry_with_reason(struct station =
*station,
 	return station_try_next_bss(station);
 }
 =

-/* A bit more consise for trying to fit these into 80 characters */
+/* A bit more concise for trying to fit these into 80 characters */
 #define IS_TEMPORARY_STATUS(code) \
 	((code) =3D=3D MMPDU_STATUS_CODE_DENIED_UNSUFFICIENT_BANDWIDTH || \
 	(code) =3D=3D MMPDU_STATUS_CODE_DENIED_POOR_CHAN_CONDITIONS || \
@@ -2685,7 +2685,6 @@ static void station_disconnect_cb(struct netdev *netd=
ev, bool success,
 			reply =3D dbus_error_failed(station->disconnect_pending);
 =

 		dbus_pending_reply(&station->disconnect_pending, reply);
-
 	}
 =

 	station_enter_state(station, STATION_STATE_DISCONNECTED);
-- =

2.25.1

--===============6264080947772681009==--

