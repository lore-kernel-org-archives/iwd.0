Content-Type: multipart/mixed; boundary="===============2611948911810971272=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/8] ft: add ft_parse_action_response
Date: Thu, 15 Apr 2021 15:45:04 -0700
Message-ID: <20210415224508.1823614-4-prestwoj@gmail.com>
In-Reply-To: <20210415224508.1823614-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2611948911810971272==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Parses the APs response to the initial FT-over-DS action
frame. This sets up the handshake passed in to get it
ready for re-association.
---
 src/ft.c | 34 ++++++++++++++++++++++++++++++++++
 src/ft.h |  4 ++++
 2 files changed, 38 insertions(+)

diff --git a/src/ft.c b/src/ft.c
index 9e6935e8..7826653f 100644
--- a/src/ft.c
+++ b/src/ft.c
@@ -478,6 +478,40 @@ ft_error:
 	return -EBADMSG;
 }
 =

+int ft_parse_action_response(struct handshake_state *hs,
+				struct handshake_state *old,
+				const uint8_t *frame, size_t frame_len)
+{
+	uint16_t status =3D 0;
+
+	if (frame_len < 16)
+		goto parse_error;
+
+	/* Category FT */
+	if (frame[0] !=3D 6)
+		goto parse_error;
+
+	/* FT Action */
+	if (frame[1] !=3D 2)
+		goto parse_error;
+
+	if (memcmp(frame + 2, hs->spa, 6))
+		goto parse_error;
+
+	if (memcmp(frame + 8, hs->aa, 6))
+		goto parse_error;
+
+	status =3D l_get_le16(frame + 14);
+
+	if (status !=3D 0)
+		return (int)status;
+
+	return ft_process_ies(hs, frame + 16, frame_len - 16);
+
+parse_error:
+	return -EBADMSG;
+}
+
 static int ft_rx_action(struct auth_proto *ap, const uint8_t *frame,
 				size_t frame_len)
 {
diff --git a/src/ft.h b/src/ft.h
index 50090a03..a22196b6 100644
--- a/src/ft.h
+++ b/src/ft.h
@@ -36,6 +36,10 @@ bool ft_build_authenticate_ies(struct handshake_state *h=
s,
 struct handshake_state *ft_over_ds_handshake_new(struct netdev *netdev,
 						struct scan_bss *target);
 =

+int ft_parse_action_response(struct handshake_state *hs,
+				struct handshake_state *old,
+				const uint8_t *frame, size_t frame_len);
+
 struct auth_proto *ft_over_air_sm_new(struct handshake_state *hs,
 				ft_tx_authenticate_func_t tx_auth,
 				ft_tx_associate_func_t tx_assoc,
-- =

2.26.2

--===============2611948911810971272==--

