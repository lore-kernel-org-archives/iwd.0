Content-Type: multipart/mixed; boundary="===============2049607975293075766=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/6] handshake: remove ERP cache pointer
Date: Tue, 03 Aug 2021 10:27:56 -0700
Message-ID: <20210803172759.123297-3-prestwoj@gmail.com>
In-Reply-To: <20210803172759.123297-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2049607975293075766==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/handshake.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/handshake.h b/src/handshake.h
index 2d51da7c..955e2eec 100644
--- a/src/handshake.h
+++ b/src/handshake.h
@@ -132,7 +132,6 @@ struct handshake_state {
 	uint8_t gtk_rsc[6];
 	uint8_t proto_version : 2;
 	unsigned int gtk_index;
-	struct erp_cache_entry *erp_cache;
 	bool support_ip_allocation : 1;
 	uint32_t client_ip_addr;
 	uint32_t subnet_mask;
-- =

2.31.1

--===============2049607975293075766==--

