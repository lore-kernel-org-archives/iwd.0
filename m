Content-Type: multipart/mixed; boundary="===============5457365423983774473=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 4/7] fils: change fatal return code to -EPROTO
Date: Wed, 08 Sep 2021 11:19:01 -0700
Message-ID: <20210908181904.84594-4-prestwoj@gmail.com>
In-Reply-To: <20210908181904.84594-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5457365423983774473==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This keeps FILS consistent with what netdev expects for a fatal
auth-proto return.
---
 src/fils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/fils.c b/src/fils.c
index 7fffefb3..f661f1bf 100644
--- a/src/fils.c
+++ b/src/fils.c
@@ -289,7 +289,7 @@ static int fils_derive_key_data(struct fils_sm *fils)
 		if (ie_parse_rsne_from_data(fils->hs->supplicant_ie,
 						fils->hs->supplicant_ie[1] + 2,
 						&rsn_info) < 0)
-			return -EBADMSG;
+			return -EPROTO;
 =

 		rsn_info.num_pmkids =3D 1;
 		rsn_info.pmkids =3D fils->hs->pmk_r1_name;
-- =

2.31.1

--===============5457365423983774473==--

