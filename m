Content-Type: multipart/mixed; boundary="===============7448424644034484079=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski at intel.com>
To: iwd at lists.01.org
Subject: [PATCH 3/3] p2p: Fix ie_tlv_extract_wfd_payload call typo
Date: Fri, 21 Jan 2022 11:24:39 +0100
Message-ID: <20220121102439.267357-3-andrew.zaborowski@intel.com>
In-Reply-To: 20220121102439.267357-1-andrew.zaborowski@intel.com

--===============7448424644034484079==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
WFD couldn't have worked with this typo, I must have introduced it
when generating patches somehow.

 src/p2p.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/p2p.c b/src/p2p.c
index a66f71e2..4c90efb6 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -938,7 +938,7 @@ static void p2p_group_event(enum ap_event_type type, co=
nst void *event_data,
 		p2p_clear_association_req(&req_info);
 =

 		if (dev->conn_own_wfd)
-			wfd_data =3D ie_tlv_extract_p2p_payload(data->assoc_ies,
+			wfd_data =3D ie_tlv_extract_wfd_payload(data->assoc_ies,
 							data->assoc_ies_len,
 							&wfd_data_len);
 =

-- =

2.32.0

--===============7448424644034484079==--

