Content-Type: multipart/mixed; boundary="===============2300067311216133369=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 1/3] mpdu: expose mmpdu_header_len
Date: Mon, 21 Oct 2019 14:01:57 -0700
Message-ID: <20191021210159.8132-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2300067311216133369==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/mpdu.c | 2 +-
 src/mpdu.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/mpdu.c b/src/mpdu.c
index eb141c75..844e61d5 100644
--- a/src/mpdu.c
+++ b/src/mpdu.c
@@ -623,7 +623,7 @@ const struct mmpdu_header *mpdu_validate(const uint8_t =
*frame, int len)
 	}
 }
 =

-static size_t mmpdu_header_len(const struct mmpdu_header *mmpdu)
+size_t mmpdu_header_len(const struct mmpdu_header *mmpdu)
 {
 	return mmpdu->fc.order =3D=3D 0 ? 24 : 28;
 }
diff --git a/src/mpdu.h b/src/mpdu.h
index 4cf08d00..f3f7e4cd 100644
--- a/src/mpdu.h
+++ b/src/mpdu.h
@@ -408,3 +408,4 @@ struct mmpdu_deauthentication {
 =

 const struct mmpdu_header *mpdu_validate(const uint8_t *frame, int len);
 const void *mmpdu_body(const struct mmpdu_header *mpdu);
+size_t mmpdu_header_len(const struct mmpdu_header *mmpdu);
-- =

2.17.1

--===============2300067311216133369==--

