Content-Type: multipart/mixed; boundary="===============1451013757948578565=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski at intel.com>
To: iwd at lists.01.org
Subject: [PATCH 1/4] p2p: Fix Device Address updates from Probe Requests
Date: Wed, 30 Mar 2022 19:33:57 +0200
Message-ID: <20220330173400.259961-1-andrew.zaborowski@intel.com>

--===============1451013757948578565==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

p2p_peer_update_existing may be called with a scan_bss struct built from
a Probe Request frame so it can't access bss->p2p_probe_resp_info even
if peer->bss was built from a Probe Response.  Check the source frame
type of the scan_bss struct before updating the Device Address.

This fixes one timing issue that would make the autotest fail often.
---
 src/p2p.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/src/p2p.c b/src/p2p.c
index 4c90efb6..ebd0f62b 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -3655,11 +3655,15 @@ static bool p2p_peer_update_existing(struct scan_bs=
s *bss,
 	 * Some property changes may need to be notified here.
 	 */
 =

-	if (peer->device_addr =3D=3D peer->bss->addr)
-		peer->device_addr =3D bss->addr;
-	else
+	if (bss->source_frame =3D=3D SCAN_BSS_PROBE_RESP)
 		peer->device_addr =3D
 			bss->p2p_probe_resp_info->device_info.device_addr;
+	else if (bss->source_frame =3D=3D SCAN_BSS_PROBE_REQ && !l_memeqzero(
+			bss->p2p_probe_req_info->device_info.device_addr, 6))
+		peer->device_addr =3D
+			bss->p2p_probe_req_info->device_info.device_addr;
+	else
+		peer->device_addr =3D bss->addr;
 =

 	scan_bss_free(peer->bss);
 	peer->bss =3D bss;
-- =

2.32.0

--===============1451013757948578565==--

