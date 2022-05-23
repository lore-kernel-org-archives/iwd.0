Content-Type: multipart/mixed; boundary="===============1595107830264499378=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH] ft: remove frame type check in FT
Date: Mon, 23 May 2022 11:16:49 -0700
Message-ID: <20220523181649.33288-1-prestwoj@gmail.com>

--===============1595107830264499378==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

A user reported that IWD was failing to FT in some cases and this was
due to the AP setting the Retry bit in the frame type. This was
unexpected by IWD since it directly checks the frame type against
0x00b0 which does not account for any B8-B15 bits being set.

IWD doesn't need to verify the frame type field for a few reasons:
First mpdu_validate checks the management frame type, Second the kernel
checks prior to forwarding the event. Because of this the check was
removed completely.
---
 src/ft.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/src/ft.c b/src/ft.c
index 2b41ae18..2285a86f 100644
--- a/src/ft.c
+++ b/src/ft.c
@@ -122,16 +122,11 @@ static bool ft_parse_authentication_resp_frame(const =
uint8_t *data, size_t len,
 				uint16_t *out_status, const uint8_t **out_ies,
 				size_t *out_ies_len)
 {
-	const uint16_t frame_type =3D 0x00b0;
 	uint16_t status =3D 0;
 =

 	if (len < 30)
 		return false;
 =

-	/* Check FC =3D=3D Management Frame -> Authentication */
-	if (l_get_le16(data + 0) !=3D frame_type)
-		return false;
-
 	if (memcmp(data + 4, addr1, 6))
 		return false;
 	if (memcmp(data + 10, addr2, 6))
-- =

2.34.1

--===============1595107830264499378==--

