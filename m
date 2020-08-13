Content-Type: multipart/mixed; boundary="===============7638455709345985136=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 02/16] eapol: Use the require_handshake flag for FILS
Date: Thu, 13 Aug 2020 02:50:12 +0200
Message-ID: <20200813005026.294950-2-andrew.zaborowski@intel.com>
In-Reply-To: <20200813005026.294950-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7638455709345985136==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In both FT or FILS EAPoL isn't used for the initial handshake and only
for the later re-keys.  For FT we added the
eapol_sm_set_require_handshake mechanism to tell EAPoL to not require
the initial handshake and we can re-use it for FILS.
---
 src/eapol.c  | 10 ----------
 src/netdev.c | 16 +++++++++++-----
 2 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/src/eapol.c b/src/eapol.c
index b0036c10..b982e6b6 100644
--- a/src/eapol.c
+++ b/src/eapol.c
@@ -2390,16 +2390,6 @@ bool eapol_start(struct eapol_sm *sm)
 =

 	sm->started =3D true;
 =

-	/*
-	 * FILS only uses the 4-way for rekeys, so only started needs to be set,
-	 * then we wait for a rekey.
-	 */
-	if (sm->handshake->akm_suite & (IE_RSN_AKM_SUITE_FILS_SHA256 |
-			IE_RSN_AKM_SUITE_FILS_SHA384 |
-			IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA384 |
-			IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA256))
-		return true;
-
 	if (sm->require_handshake)
 		sm->timeout =3D l_timeout_create(eapol_4way_handshake_time,
 				eapol_timeout, sm, NULL);
diff --git a/src/netdev.c b/src/netdev.c
index 9e2690d3..5d3aa862 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -2071,6 +2071,12 @@ static void netdev_associate_event(struct l_genl_msg=
 *msg,
 	if (netdev->ap) {
 		ret =3D auth_proto_rx_associate(netdev->ap, frame, frame_len);
 		if (ret =3D=3D 0) {
+			bool fils =3D !!(netdev->handshake->akm_suite &
+					(IE_RSN_AKM_SUITE_FILS_SHA256 |
+					 IE_RSN_AKM_SUITE_FILS_SHA384 |
+					 IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA384 |
+					 IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA256));
+
 			auth_proto_free(netdev->ap);
 			netdev->ap =3D NULL;
 =

@@ -2081,15 +2087,15 @@ static void netdev_associate_event(struct l_genl_ms=
g *msg,
 			netdev->ignore_connect_event =3D false;
 =

 			/*
-			 * If in FT we need to prevent the 4-way handshake from
-			 * happening, and instead just wait for rekeys
+			 * If in FT and/or FILS we don't force an initial 4-way
+			 * handshake and instead just keep the EAPoL state
+			 * machine for the rekeys.
 			 */
-			if (netdev->in_ft) {
+			if (netdev->in_ft || fils)
 				eapol_sm_set_require_handshake(netdev->sm,
 								false);
-				netdev->in_ft =3D false;
-			}
 =

+			netdev->in_ft =3D false;
 			return;
 		} else if (ret =3D=3D -EAGAIN) {
 			/*
-- =

2.25.1

--===============7638455709345985136==--

