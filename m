Content-Type: multipart/mixed; boundary="===============7168127399893820767=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 5/7] ft: change fatal return code to -EPROTO
Date: Wed, 08 Sep 2021 11:19:02 -0700
Message-ID: <20210908181904.84594-5-prestwoj@gmail.com>
In-Reply-To: <20210908181904.84594-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7168127399893820767==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This keeps FT consistent with what netdev expects for a fatal
auth-proto return.
---
 src/ft.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/ft.c b/src/ft.c
index 13733019..c167f4bc 100644
--- a/src/ft.c
+++ b/src/ft.c
@@ -520,7 +520,7 @@ static int ft_process_ies(struct handshake_state *hs, c=
onst uint8_t *ies,
 	return 0;
 =

 ft_error:
-	return -EBADMSG;
+	return -EPROTO;
 }
 =

 int ft_over_ds_parse_action_response(const uint8_t *frame, size_t frame_le=
n,
-- =

2.31.1

--===============7168127399893820767==--

