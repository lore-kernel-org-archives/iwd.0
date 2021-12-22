Content-Type: multipart/mixed; boundary="===============3085684035395119883=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 2/2] dpp: init unwrapped pointer to NULL
Date: Wed, 22 Dec 2021 15:00:17 -0800
Message-ID: <20211222230017.12587-2-prestwoj@gmail.com>
In-Reply-To: 20211222230017.12587-1-prestwoj@gmail.com

--===============3085684035395119883==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fixes possible issues with auto-free on error paths
---
 src/dpp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/dpp.c b/src/dpp.c
index 941c3f07..a4a21b3d 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -780,7 +780,7 @@ static void dpp_handle_config_result_frame(struct dpp_s=
m *dpp,
 	const void *e_nonce =3D NULL;
 	const void *wrapped =3D NULL;
 	size_t wrapped_len;
-	_auto_(l_free) void *unwrapped;
+	_auto_(l_free) void *unwrapped =3D NULL;
 =

 	if (dpp->state !=3D DPP_STATE_CONFIGURING)
 		return;
-- =

2.31.1

--===============3085684035395119883==--

