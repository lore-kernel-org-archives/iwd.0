Content-Type: multipart/mixed; boundary="===============6632631354727184417=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/8] ft: separate ft_sm from ft_process_ies
Date: Thu, 15 Apr 2021 15:45:01 -0700
Message-ID: <20210415224508.1823614-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6632631354727184417==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

To prepare for some refactoring remove the ft_sm dependency
from ft_process_ies and instead only make it depend on the
handshake_state object.
---
 src/ft.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/src/ft.c b/src/ft.c
index ba9c3d2c..2c58787d 100644
--- a/src/ft.c
+++ b/src/ft.c
@@ -329,13 +329,13 @@ error:
 	return -EINVAL;
 }
 =

-static int ft_process_ies(struct ft_sm *ft, const uint8_t *ies, size_t ies=
_len)
+static int ft_process_ies(struct handshake_state *hs, const uint8_t *ies,
+			size_t ies_len)
 {
 	struct ie_tlv_iter iter;
 	const uint8_t *rsne =3D NULL;
 	const uint8_t *mde =3D NULL;
 	const uint8_t *fte =3D NULL;
-	struct handshake_state *hs =3D ft->hs;
 	uint32_t kck_len =3D handshake_state_get_kck_len(hs);
 	bool is_rsn;
 =

@@ -469,7 +469,7 @@ static int ft_process_ies(struct ft_sm *ft, const uint8=
_t *ies, size_t ies_len)
 	} else if (fte)
 		goto ft_error;
 =

-	return ft_tx_reassociate(ft);
+	return 0;
 =

 ft_error:
 	return -EBADMSG;
@@ -482,6 +482,7 @@ static int ft_rx_action(struct auth_proto *ap, const ui=
nt8_t *frame,
 	uint16_t status_code =3D MMPDU_STATUS_CODE_UNSPECIFIED;
 	const uint8_t *ies =3D NULL;
 	size_t ies_len;
+	int ret;
 =

 	if (!ft_parse_action_resp_frame(frame, frame_len, ft->hs->spa,
 						ft->hs->aa, &status_code,
@@ -492,7 +493,11 @@ static int ft_rx_action(struct auth_proto *ap, const u=
int8_t *frame,
 	if (status_code !=3D 0)
 		goto auth_error;
 =

-	return ft_process_ies(ft, ies, ies_len);
+	ret =3D ft_process_ies(ft->hs, ies, ies_len);
+	if (ret < 0)
+		goto auth_error;
+
+	return ft_tx_reassociate(ft);
 =

 auth_error:
 	return (int)status_code;
@@ -505,6 +510,7 @@ static int ft_rx_authenticate(struct auth_proto *ap, co=
nst uint8_t *frame,
 	uint16_t status_code =3D MMPDU_STATUS_CODE_UNSPECIFIED;
 	const uint8_t *ies =3D NULL;
 	size_t ies_len;
+	int ret;
 =

 	/*
 	 * Parse the Authentication Response and validate the contents
@@ -520,7 +526,11 @@ static int ft_rx_authenticate(struct auth_proto *ap, c=
onst uint8_t *frame,
 	if (status_code !=3D 0)
 		goto auth_error;
 =

-	return ft_process_ies(ft, ies, ies_len);
+	ret =3D ft_process_ies(ft->hs, ies, ies_len);
+	if (ret < 0)
+		goto auth_error;
+
+	return ft_tx_reassociate(ft);
 =

 auth_error:
 	return (int)status_code;
-- =

2.26.2

--===============6632631354727184417==--

