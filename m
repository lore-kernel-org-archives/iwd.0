Content-Type: multipart/mixed; boundary="===============5269653981176762516=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 2/2] netdev: move ocvc setting to after connected check
Date: Tue, 05 Apr 2022 11:21:41 -0700
Message-ID: <20220405182141.855536-2-prestwoj@gmail.com>
In-Reply-To: 20220405182141.855536-1-prestwoj@gmail.com

--===============5269653981176762516==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

We cannot check 'handshake' until first checking that IWD is
connected.
---
 src/netdev.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 5ec7fe4a..e483edf8 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -4990,8 +4990,7 @@ static void netdev_sa_query_req_frame_event(const str=
uct mmpdu_header *hdr,
 	uint16_t transaction;
 	const uint8_t *oci;
 	struct netdev *netdev =3D user_data;
-	bool ocvc =3D netdev->handshake->supplicant_ocvc &&
-					netdev->handshake->authenticator_ocvc;
+	bool ocvc;
 =

 	if (body_len < 4) {
 		l_debug("SA Query request too short");
@@ -5001,6 +5000,9 @@ static void netdev_sa_query_req_frame_event(const str=
uct mmpdu_header *hdr,
 	if (!netdev->connected)
 		return;
 =

+	ocvc =3D netdev->handshake->supplicant_ocvc &&
+					netdev->handshake->authenticator_ocvc;
+
 	/* only care about SA Queries from our connected AP */
 	if (memcmp(hdr->address_2, netdev->handshake->aa, 6))
 		return;
-- =

2.34.1

--===============5269653981176762516==--

