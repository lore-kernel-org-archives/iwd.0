Content-Type: multipart/mixed; boundary="===============3468656893749691321=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/6] netdev: check AKMs instead of in_ft for require_handshake
Date: Thu, 05 Aug 2021 08:19:53 -0700
Message-ID: <20210805151958.288829-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3468656893749691321==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The 'in_ft' flag is going to be renamed/repurposed to be used
with reassociations as well as FT. Because of this the check
here is being re-worked to use the AKMs rather than this flag.
---
 src/netdev.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index deb780dc..ff9110ea 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -2510,11 +2510,10 @@ static void netdev_associate_event(struct l_genl_ms=
g *msg,
 =

 		ret =3D auth_proto_rx_associate(netdev->ap, frame, frame_len);
 		if (ret =3D=3D 0) {
-			bool fils =3D !!(netdev->handshake->akm_suite &
-					(IE_RSN_AKM_SUITE_FILS_SHA256 |
-					 IE_RSN_AKM_SUITE_FILS_SHA384 |
-					 IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA384 |
-					 IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA256));
+			bool require_handshake =3D IE_AKM_IS_FILS(
+					netdev->handshake->akm_suite) ||
+					IE_AKM_IS_FT(
+					netdev->handshake->akm_suite);
 =

 			auth_proto_free(netdev->ap);
 			netdev->ap =3D NULL;
@@ -2530,7 +2529,7 @@ static void netdev_associate_event(struct l_genl_msg =
*msg,
 			 * handshake and instead just keep the EAPoL state
 			 * machine for the rekeys.
 			 */
-			if (netdev->in_ft || fils)
+			if (require_handshake)
 				eapol_sm_set_require_handshake(netdev->sm,
 								false);
 =

-- =

2.31.1

--===============3468656893749691321==--

