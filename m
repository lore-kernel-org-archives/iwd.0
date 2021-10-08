Content-Type: multipart/mixed; boundary="===============2788072140898506185=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH] netdev: set TK index to zero for FT
Date: Fri, 08 Oct 2021 11:50:05 -0700
Message-ID: <20211008185005.2911529-1-prestwoj@gmail.com>

--===============2788072140898506185==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Since FT re-uses the handshake the active TK index may be set to a
non-zero value.
---
 src/netdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/netdev.c b/src/netdev.c
index 1316a07b..18ac3e45 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -4405,6 +4405,7 @@ static void prepare_ft(struct netdev *netdev, const s=
truct scan_bss *target_bss)
 							target_bss->rsne);
 	memcpy(netdev->handshake->mde + 2, target_bss->mde, 3);
 =

+	netdev->handshake->active_tk_index =3D 0;
 	netdev->associated =3D false;
 	netdev->operational =3D false;
 	netdev->in_ft =3D true;
-- =

2.31.1

--===============2788072140898506185==--

