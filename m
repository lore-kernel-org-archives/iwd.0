Content-Type: multipart/mixed; boundary="===============1107328163777845277=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 07/15] p2p: Fix parsing of Association Req P2P IEs
Date: Fri, 04 Jun 2021 03:50:44 +0200
Message-ID: <20210604015052.163727-7-andrew.zaborowski@intel.com>
In-Reply-To: <20210604015052.163727-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1107328163777845277==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

p2p_parse_association_req() already extracts the P2P IE payload from the
IE sequence, there's no need to call ie_tlv_extract_p2p_payload before
it.  Pass the IE sequence directly to p2p_parse_association_req().
---
 src/p2p.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/src/p2p.c b/src/p2p.c
index 7e828412..bc2d154d 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -898,22 +898,11 @@ static void p2p_group_event(enum ap_event_type type, =
const void *event_data,
 	case AP_EVENT_STATION_ADDED:
 	{
 		const struct ap_event_station_added_data *data =3D event_data;
-		L_AUTO_FREE_VAR(uint8_t *, p2p_data) =3D NULL;
-		ssize_t p2p_data_len;
 		L_AUTO_FREE_VAR(uint8_t *, wfd_data) =3D NULL;
 		ssize_t wfd_data_len;
 		struct p2p_association_req req_info;
 		int r;
 =

-		p2p_data =3D ie_tlv_extract_p2p_payload(data->assoc_ies,
-							data->assoc_ies_len,
-							&p2p_data_len);
-		if (!p2p_data) {
-			l_error("Missing or invalid P2P IEs: %s (%i)",
-				strerror(-p2p_data_len), (int) -p2p_data_len);
-			goto invalid_ie;
-		}
-
 		/*
 		 * We don't need to validate most of the Association Request
 		 * P2P IE contents as we already have all the information there
@@ -928,8 +917,8 @@ static void p2p_group_event(enum ap_event_type type, co=
nst void *event_data,
 		 * information shall be used by the P2P Group Owner for Group
 		 * Information Advertisement.
 		 */
-		r =3D p2p_parse_association_req(p2p_data, p2p_data_len,
-						&req_info);
+		r =3D p2p_parse_association_req(data->assoc_ies,
+						data->assoc_ies_len, &req_info);
 		if (r < 0) {
 			l_error("Can't parse P2P Association Request: %s (%i)",
 				strerror(-r), -r);
-- =

2.30.2

--===============1107328163777845277==--

