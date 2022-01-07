Content-Type: multipart/mixed; boundary="===============0614214076702394330=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 2/2] dpp: memset header to fix uninitialized buffer
Date: Fri, 07 Jan 2022 09:58:49 -0800
Message-ID: <20220107175849.693241-2-prestwoj@gmail.com>
In-Reply-To: 20220107175849.693241-1-prestwoj@gmail.com

--===============0614214076702394330==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/dpp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/dpp.c b/src/dpp.c
index f62bcebb..20c27a57 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -656,6 +656,8 @@ static void dpp_send_config_response(struct dpp_sm *dpp=
, uint8_t status)
 	size_t json_len;
 	uint8_t *ptr =3D hdr + 24;
 =

+	memset(hdr, 0, sizeof(hdr));
+
 	l_put_le16(0x00d0, hdr);
 	memcpy(hdr + 4, dpp->auth_addr, 6);
 	memcpy(hdr + 10, netdev_get_address(dpp->netdev), 6);
-- =

2.31.1

--===============0614214076702394330==--

