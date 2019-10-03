Content-Type: multipart/mixed; boundary="===============8530475696083982651=="
MIME-Version: 1.0
From: Will Dietz <w@wdtz.org>
Subject: [PATCH] station: record dependency on netconfig module
Date: Thu, 03 Oct 2019 12:25:34 -0500
Message-ID: <20191003172534.1148-1-w@wdtz.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8530475696083982651==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The netconfig module must be initialized (netconfig_list, for example)
before station module can be used, record this to ensure that happens.
---
 src/station.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/station.c b/src/station.c
index 0666287..eed3a7f 100644
--- a/src/station.c
+++ b/src/station.c
@@ -3190,3 +3190,4 @@ static void station_exit(void)
 }
 =

 IWD_MODULE(station, station_init, station_exit)
+IWD_MODULE_DEPENDS(station, netconfig)
-- =

2.23.0

--===============8530475696083982651==--

