Content-Type: multipart/mixed; boundary="===============4349384085137539671=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 1/9] dpp: use frame data directly in unwrap for config response
Date: Mon, 20 Dec 2021 13:49:07 -0800
Message-ID: <20211220214915.34093-1-prestwoj@gmail.com>

--===============4349384085137539671==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Rather than hard coding ad0, use the actual frame data. There really
isn't a reason this would differ (only status attribute) but just
in case its better to use the frame data directly.
---
 src/dpp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/src/dpp.c b/src/dpp.c
index 5e125265..69dbeb1e 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -391,7 +391,6 @@ static void dpp_handle_config_response_frame(const stru=
ct mmpdu_header *frame,
 	size_t wrapped_len =3D 0;
 	_auto_(l_free) uint8_t *unwrapped =3D NULL;
 	struct dpp_configuration *config;
-	uint8_t ad0[] =3D { 0x00, 0x10, 0x01, 0x00, 0x05 };
 =

 	if (dpp->state !=3D DPP_STATE_CONFIGURING)
 		return;
@@ -474,7 +473,7 @@ static void dpp_handle_config_response_frame(const stru=
ct mmpdu_header *frame,
 		return;
 	}
 =

-	unwrapped =3D dpp_unwrap_attr(ad0, sizeof(ad0), NULL, 0, dpp->ke,
+	unwrapped =3D dpp_unwrap_attr(ptr, wrapped - ptr - 4, NULL, 0, dpp->ke,
 					dpp->key_len, wrapped, wrapped_len,
 					&wrapped_len);
 	if (!unwrapped) {
-- =

2.31.1

--===============4349384085137539671==--

