Content-Type: multipart/mixed; boundary="===============3333661204084739185=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 06/15] p2p: Fix a leak of ie_tlv_extract_p2p_payload() result
Date: Fri, 04 Jun 2021 03:50:43 +0200
Message-ID: <20210604015052.163727-6-andrew.zaborowski@intel.com>
In-Reply-To: <20210604015052.163727-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3333661204084739185==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/p2p.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/p2p.c b/src/p2p.c
index 580eb53f..7e828412 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -1032,6 +1032,7 @@ static size_t p2p_group_write_p2p_ie(struct p2p_devic=
e *dev,
 =

 	case MPDU_MANAGEMENT_SUBTYPE_PROBE_RESPONSE:
 	{
+		L_AUTO_FREE_VAR(uint8_t *, tmp) =3D NULL;
 		struct p2p_probe_resp info =3D {};
 		const struct mmpdu_probe_request *req =3D
 			mmpdu_body(client_frame);
@@ -1045,8 +1046,8 @@ static size_t p2p_group_write_p2p_ie(struct p2p_devic=
e *dev,
 		 * Response frame if the received Probe Request frame does
 		 * not contain a P2P IE."
 		 */
-		if (!ie_tlv_extract_p2p_payload(req->ies, req_ies_len,
-							&req_p2p_data_size))
+		if (!(tmp =3D ie_tlv_extract_p2p_payload(req->ies, req_ies_len,
+							&req_p2p_data_size)))
 			return 0;
 =

 		info.capability =3D dev->capability;
-- =

2.30.2

--===============3333661204084739185==--

