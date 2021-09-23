Content-Type: multipart/mixed; boundary="===============5805626626743482757=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 5/5] handshake: free chandef if already set
Date: Thu, 23 Sep 2021 15:57:28 -0700
Message-ID: <20210923225728.556306-5-prestwoj@gmail.com>
In-Reply-To: 20210923225728.556306-1-prestwoj@gmail.com

--===============5805626626743482757==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This can happen with FT, since the handshake object is reused.
---
 src/handshake.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/handshake.c b/src/handshake.c
index 10923fbf..642a25a7 100644
--- a/src/handshake.c
+++ b/src/handshake.c
@@ -1024,6 +1024,9 @@ bool handshake_state_add_ecc_sae_pt(struct handshake_=
state *s,
 void handshake_state_set_chandef(struct handshake_state *s,
 						struct band_chandef *chandef)
 {
+	if (s->chandef)
+		l_free(s->chandef);
+
 	s->chandef =3D chandef;
 }
 =

-- =

2.31.1

--===============5805626626743482757==--

