Content-Type: multipart/mixed; boundary="===============6515624784077756583=="
MIME-Version: 1.0
From: Shuai Wang <etrnls@gmail.com>
Subject: [PATCH] station: add dependency to device
Date: Thu, 05 Dec 2019 21:56:06 -0800
Message-ID: <20191206055606.24914-1-Etrnls@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6515624784077756583==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

scan_periodic_start triggered by station requires scan_wdev_add to be
called first from device.
---
 src/station.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/station.c b/src/station.c
index c6029423..fd346194 100644
--- a/src/station.c
+++ b/src/station.c
@@ -3225,3 +3225,4 @@ static void station_exit(void)
 =

 IWD_MODULE(station, station_init, station_exit)
 IWD_MODULE_DEPENDS(station, netconfig)
+IWD_MODULE_DEPENDS(station, device)
-- =

2.24.0

--===============6515624784077756583==--

