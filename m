Content-Type: multipart/mixed; boundary="===============5208042394128803210=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v3 07/13] handshake: set extended key ID capable
Date: Thu, 07 Oct 2021 13:49:51 -0700
Message-ID: <20211007204957.3745985-7-prestwoj@gmail.com>
In-Reply-To: 20211007204957.3745985-1-prestwoj@gmail.com

--===============5208042394128803210==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/handshake.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/handshake.c b/src/handshake.c
index 58326dcd..ea1c5e4b 100644
--- a/src/handshake.c
+++ b/src/handshake.c
@@ -240,6 +240,7 @@ valid_ie:
 	s->group_management_cipher =3D info.group_management_cipher;
 	s->akm_suite =3D info.akm_suites;
 	s->supplicant_ocvc =3D info.ocvc;
+	s->ext_key_id_capable =3D info.extended_key_id;
 =

 	/*
 	 * Don't set MFP for OSEN otherwise EAPoL will attempt to negotiate a
-- =

2.31.1

--===============5208042394128803210==--

