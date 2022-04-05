Content-Type: multipart/mixed; boundary="===============4964043281214841741=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 1/2] netdev: check for connected in FT frame event
Date: Tue, 05 Apr 2022 11:21:40 -0700
Message-ID: <20220405182141.855536-1-prestwoj@gmail.com>

--===============4964043281214841741==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This frame could come unsolicited and cause a NULL dereference
if IWD is not connected.
---
 src/netdev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/netdev.c b/src/netdev.c
index 36d183e7..5ec7fe4a 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -4525,6 +4525,9 @@ static void netdev_ft_response_frame_event(const stru=
ct mmpdu_header *hdr,
 	size_t ies_len;
 	struct ft_ds_finder finder;
 =

+	if (!netdev->connected)
+		return;
+
 	ret =3D ft_over_ds_parse_action_response(body, body_len, &spa, &aa,
 						&ies, &ies_len);
 	if (ret < 0)
-- =

2.34.1

--===============4964043281214841741==--

