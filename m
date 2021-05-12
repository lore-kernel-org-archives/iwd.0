Content-Type: multipart/mixed; boundary="===============4480713643428422227=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 03/11] ft: break up FT action parsing into two steps
Date: Wed, 12 May 2021 16:01:40 -0700
Message-ID: <20210512230148.370858-3-prestwoj@gmail.com>
In-Reply-To: <20210512230148.370858-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4480713643428422227==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is to prepare for multiple concurrent FT-over-DS action frames.
A list will be kept in netdev and for lookup reasons it needs to
parse the start of the frame to grab the aa/spa addresses. In this
call the IEs are also returned and passed to the new
ft_over_ds_parse_action_response.

For now the address checks have been moved into netdev, but this will
eventually turn into a queue lookup.
---
 src/ft.c     | 30 ++++++++++++++++++++----------
 src/ft.h     | 10 ++++++++--
 src/netdev.c | 18 ++++++++++++++++--
 3 files changed, 44 insertions(+), 14 deletions(-)

diff --git a/src/ft.c b/src/ft.c
index de754fd8..13733019 100644
--- a/src/ft.c
+++ b/src/ft.c
@@ -452,7 +452,7 @@ static bool mde_equal(const uint8_t *mde1, const uint8_=
t *mde2)
 	return memcmp(mde1, mde1, mde1[1] + 2) =3D=3D 0;
 }
 =

-static bool ft_over_ds_process_ies(struct ft_ds_info *info,
+bool ft_over_ds_parse_action_ies(struct ft_ds_info *info,
 					struct handshake_state *hs,
 					const uint8_t *ies,
 					size_t ies_len)
@@ -523,11 +523,15 @@ ft_error:
 	return -EBADMSG;
 }
 =

-int ft_over_ds_parse_action_response(struct ft_ds_info *info,
-					struct handshake_state *hs,
-					const uint8_t *frame, size_t frame_len)
+int ft_over_ds_parse_action_response(const uint8_t *frame, size_t frame_le=
n,
+					const uint8_t **spa_out,
+					const uint8_t **aa_out,
+					const uint8_t **ies_out,
+					size_t *ies_len)
 {
 	uint16_t status;
+	const uint8_t *aa;
+	const uint8_t *spa;
 =

 	if (frame_len < 16)
 		return -EINVAL;
@@ -540,17 +544,23 @@ int ft_over_ds_parse_action_response(struct ft_ds_inf=
o *info,
 	if (frame[1] !=3D 2)
 		return -EINVAL;
 =

-	if (memcmp(frame + 2, info->spa, 6))
-		return -ENOENT;
-	if (memcmp(frame + 8, info->aa, 6))
-		return -ENOENT;
+	spa =3D frame + 2;
+	aa =3D frame + 8;
 =

 	status =3D l_get_le16(frame + 14);
 	if (status !=3D 0)
 		return (int)status;
 =

-	if (!ft_over_ds_process_ies(info, hs, frame + 16, frame_len - 16))
-		return -EBADMSG;
+	if (spa_out)
+		*spa_out =3D spa;
+
+	if (aa_out)
+		*aa_out =3D aa;
+
+	if (ies_out && ies_len) {
+		*ies_out =3D frame + 16;
+		*ies_len =3D frame_len - 16;
+	}
 =

 	return 0;
 }
diff --git a/src/ft.h b/src/ft.h
index 3d1cfe30..6167e0d7 100644
--- a/src/ft.h
+++ b/src/ft.h
@@ -47,9 +47,15 @@ bool ft_build_authenticate_ies(struct handshake_state *h=
s,
 				const uint8_t *new_snonce, uint8_t *buf,
 				size_t *len);
 =

-int ft_over_ds_parse_action_response(struct ft_ds_info *info,
+int ft_over_ds_parse_action_response(const uint8_t *frame, size_t frame_le=
n,
+					const uint8_t **spa_out,
+					const uint8_t **aa_out,
+					const uint8_t **ies_out,
+					size_t *ies_len);
+bool ft_over_ds_parse_action_ies(struct ft_ds_info *info,
 					struct handshake_state *hs,
-					const uint8_t *frame, size_t frame_len);
+					const uint8_t *ies,
+					size_t ies_len);
 =

 struct auth_proto *ft_over_air_sm_new(struct handshake_state *hs,
 				ft_tx_authenticate_func_t tx_auth,
diff --git a/src/netdev.c b/src/netdev.c
index 9e7fc821..65627b9f 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -3769,12 +3769,26 @@ static void netdev_ft_response_frame_event(const st=
ruct mmpdu_header *hdr,
 	struct netdev_ft_over_ds_info *info =3D netdev->ft_ds_info;
 	int ret;
 	uint16_t status_code =3D MMPDU_STATUS_CODE_UNSPECIFIED;
+	const uint8_t *aa;
+	const uint8_t *spa;
+	const uint8_t *ies;
+	size_t ies_len;
 =

 	if (!info)
 		return;
 =

-	ret =3D ft_over_ds_parse_action_response(&info->super, netdev->handshake,
-						body, body_len);
+	ret =3D ft_over_ds_parse_action_response(body, body_len, &spa, &aa,
+						&ies, &ies_len);
+	if (ret !=3D 0)
+		return;
+
+	if (memcmp(spa, info->super.spa, 6))
+		return;
+	if (memcmp(aa, info->super.aa, 6))
+		return;
+
+	ret =3D ft_over_ds_parse_action_ies(&info->super, netdev->handshake,
+						ies, ies_len);
 	if (ret < 0)
 		return;
 =

-- =

2.31.1

--===============4480713643428422227==--

