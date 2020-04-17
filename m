Content-Type: multipart/mixed; boundary="===============3928336293025676049=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH 2/2] station: Fix init return type
Date: Fri, 17 Apr 2020 10:20:53 -0700
Message-ID: <20200417172053.14320-2-tim.a.kourt@linux.intel.com>
In-Reply-To: <20200417172053.14320-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3928336293025676049==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/station.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/station.c b/src/station.c
index d57a0f8d..3b3bb30a 100644
--- a/src/station.c
+++ b/src/station.c
@@ -3250,7 +3250,7 @@ static int station_init(void)
 				&anqp_disabled))
 		anqp_disabled =3D true;
 =

-	return true;
+	return 0;
 }
 =

 static void station_exit(void)
-- =

2.13.6

--===============3928336293025676049==--

