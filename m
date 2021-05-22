Content-Type: multipart/mixed; boundary="===============5031479085058292100=="
MIME-Version: 1.0
From: Alvin =?unknown-8bit?q?=C5=A0ipraga?= <ALSI@bang-olufsen.dk>
Subject: [PATCH] scan: parse NL80211_BSS_LAST_SEEN_BOOTTIME in units of
 nanoseconds
Date: Sat, 22 May 2021 12:06:25 +0000
Message-ID: <20210522120621.118459-1-alsi@bang-olufsen.dk>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5031479085058292100==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

NL80211_BSS_LAST_SEEN_BOOTTIME is expressed in nanoseconds, while BSS
timestamps are expressed in microseconds internally. Convert the
attribute to microseconds when using it to timestamp a BSS. This makes
iwd expire absent BSSes within 30 seconds as intended.
---
 src/scan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/scan.c b/src/scan.c
index a6f97c08f09b..8967706f35b9 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -1231,7 +1231,7 @@ static struct scan_bss *scan_parse_attr_bss(struct l_=
genl_attr *attr,
 			if (L_WARN_ON(len !=3D sizeof(uint64_t)))
 				break;
 =

-			bss->time_stamp =3D l_get_u64(data);
+			bss->time_stamp =3D l_get_u64(data) / L_NSEC_PER_USEC;
 			break;
 		}
 	}
-- =

2.31.1
--===============5031479085058292100==--

