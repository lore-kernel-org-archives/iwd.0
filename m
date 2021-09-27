Content-Type: multipart/mixed; boundary="===============0708084575287222449=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 2/3] netdev: fix return value check for
 ft_over_ds_parse_action_ies
Date: Mon, 27 Sep 2021 15:41:35 -0700
Message-ID: <20210927224136.312226-2-prestwoj@gmail.com>
In-Reply-To: 20210927224136.312226-1-prestwoj@gmail.com

--===============0708084575287222449==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This returns a bool but was being treated as a signed int.
---
 src/netdev.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index d69962d1..a931d78e 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -4194,9 +4194,8 @@ static void netdev_ft_response_frame_event(const stru=
ct mmpdu_header *hdr,
 		goto ft_error;
 	}
 =

-	ret =3D ft_over_ds_parse_action_ies(&info->super, netdev->handshake,
-						ies, ies_len);
-	if (ret < 0)
+	if (!ft_over_ds_parse_action_ies(&info->super, netdev->handshake,
+						ies, ies_len))
 		goto ft_error;
 =

 	info->parsed =3D true;
-- =

2.31.1

--===============0708084575287222449==--

