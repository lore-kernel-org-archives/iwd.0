Content-Type: multipart/mixed; boundary="===============6131907169372357382=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH] netdev: fix bug setting OWE IE length
Date: Thu, 03 Feb 2022 09:24:18 -0800
Message-ID: <20220203172418.87777-1-prestwoj@gmail.com>

--===============6131907169372357382==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The length was being set to whatever the last nl80211 attribute was,
not the length for the RESP_IE iteration.
---
 src/netdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/netdev.c b/src/netdev.c
index 4dc9ce94..cda0c7fc 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -2830,7 +2830,7 @@ process_resp_ies:
 					continue;
 =

 				owe_dh =3D data;
-				owe_dh_len =3D len;
+				owe_dh_len =3D ie_tlv_iter_get_length(&iter);
 =

 				break;
 =

-- =

2.31.1

--===============6131907169372357382==--

