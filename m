Content-Type: multipart/mixed; boundary="===============2385046757327829522=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 02/10] erp: check return of hkdf_expand
Date: Wed, 16 Oct 2019 15:29:45 -0700
Message-ID: <20191016222953.513-2-prestwoj@gmail.com>
In-Reply-To: <20191016222953.513-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2385046757327829522==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/erp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/erp.c b/src/erp.c
index 22938c32..2884eb83 100644
--- a/src/erp.c
+++ b/src/erp.c
@@ -509,8 +509,9 @@ int erp_rx_packet(struct erp_state *erp, const uint8_t =
*pkt, size_t len)
 	l_put_be16(64, ptr);
 	ptr +=3D 2;
 =

-	hkdf_expand(L_CHECKSUM_SHA256, erp->r_rk, erp->cache->emsk_len,
-			info, ptr - info, erp->rmsk, erp->cache->emsk_len);
+	if (!hkdf_expand(L_CHECKSUM_SHA256, erp->r_rk, erp->cache->emsk_len,
+			info, ptr - info, erp->rmsk, erp->cache->emsk_len))
+		goto eap_failed;
 =

 	return 0;
 =

-- =

2.17.1

--===============2385046757327829522==--

