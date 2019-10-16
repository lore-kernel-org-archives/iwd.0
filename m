Content-Type: multipart/mixed; boundary="===============8019552535301873209=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 06/10] ie: fix uninitialized rx/tx_nss values
Date: Wed, 16 Oct 2019 15:29:49 -0700
Message-ID: <20191016222953.513-6-prestwoj@gmail.com>
In-Reply-To: <20191016222953.513-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8019552535301873209==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/ie.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/ie.c b/src/ie.c
index e90b5cfa..4bc56589 100644
--- a/src/ie.c
+++ b/src/ie.c
@@ -1912,9 +1912,9 @@ static int ie_parse_vht_capability(struct ie_tlv_iter=
 *vht_iter,
 	uint8_t rx_mcs_map[2];
 	uint8_t tx_mcs_map[2];
 	unsigned int max_rx_mcs =3D 0;
-	unsigned int rx_nss;
+	unsigned int rx_nss =3D 1;
 	unsigned int max_tx_mcs =3D 0;
-	unsigned int tx_nss;
+	unsigned int tx_nss =3D 1;
 	uint8_t ht_cap;
 	bool short_gi_20mhz;
 	bool short_gi_40mhz;
-- =

2.17.1

--===============8019552535301873209==--

