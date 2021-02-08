Content-Type: multipart/mixed; boundary="===============6997656026782151144=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/3] fils: check return of ie_parse_rsne_from_data
Date: Mon, 08 Feb 2021 13:18:11 -0800
Message-ID: <20210208211812.612391-2-prestwoj@gmail.com>
In-Reply-To: <20210208211812.612391-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6997656026782151144==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/fils.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/fils.c b/src/fils.c
index acead506..3917ca40 100644
--- a/src/fils.c
+++ b/src/fils.c
@@ -108,9 +108,11 @@ static void fils_erp_tx_func(const uint8_t *eap_data, =
size_t len,
 =

 	ie_tlv_builder_init(&builder, ptr, sizeof(data) - 4);
 =

-	ie_parse_rsne_from_data(fils->hs->supplicant_ie,
+	if (ie_parse_rsne_from_data(fils->hs->supplicant_ie,
 				fils->hs->supplicant_ie[1] + 2,
-				&rsn_info);
+				&rsn_info) < 0)
+		return;
+
 	rsne =3D alloca(256);
 	ie_build_rsne(&rsn_info, rsne);
 =

-- =

2.26.2

--===============6997656026782151144==--

