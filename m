Content-Type: multipart/mixed; boundary="===============1209681259819117260=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] frame-xchg: fix incorrect length check
Date: Mon, 22 Jun 2020 08:25:16 -0700
Message-ID: <20200622152516.22006-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1209681259819117260==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

frame_xchg_startv was using sizeof(mmpdu) to check the minimum length
for a frame. Instead mmpdu_header_len should be used since this checks
fc.order and returns either 24 or 28 bytes, not 28 bytes always.

This change adds the requirement that the first iovec in the array
must contain at least the first 2 bytes (mmpdu_fc) of the header.
This really shouldn't be a problem since all current users of
frame-xchg put the entire header (or entire frame) into the first
iovec in the array.
---
 src/frame-xchg.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/src/frame-xchg.c b/src/frame-xchg.c
index dd60e080..3744a4c1 100644
--- a/src/frame-xchg.c
+++ b/src/frame-xchg.c
@@ -1090,12 +1090,17 @@ uint32_t frame_xchg_startv(uint64_t wdev_id, struct=
 iovec *frame, uint32_t freq,
 	size_t frame_len;
 	struct iovec *iov;
 	uint8_t *ptr;
-	struct mmpdu_header *mpdu;
 =

 	for (frame_len =3D 0, iov =3D frame; iov->iov_base; iov++)
 		frame_len +=3D iov->iov_len;
 =

-	if (frame_len < sizeof(*mpdu)) {
+	/*
+	 * This assumes that the first iovec@least contains the mmpdu_fc
+	 * portion of the header used to calculate the minimum length.
+	 */
+	if (frame[0].iov_len >=3D 2 && frame_len <
+				mmpdu_header_len((const struct mmpdu_header *)
+				frame[0].iov_base)) {
 		l_error("Frame too short");
 		cb(-EMSGSIZE, user_data);
 		return 0;
-- =

2.21.1

--===============1209681259819117260==--

