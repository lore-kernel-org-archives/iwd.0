Content-Type: multipart/mixed; boundary="===============8970285904807131275=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH] handshake: use _hs directly in handshake_event
Date: Wed, 26 Jan 2022 09:41:00 -0800
Message-ID: <20220126174100.3162606-1-prestwoj@gmail.com>

--===============8970285904807131275==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Certain platforms/compilers were having issues with using the 'hs'
local in this macro (likely has something to do with the caller
also using a local 'hs' variable name). This caused a crash on these
platforms. Using the macro argument _hs directly fixes the crash.
---
 src/handshake.h | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/src/handshake.h b/src/handshake.h
index 34d4829d..7136087a 100644
--- a/src/handshake.h
+++ b/src/handshake.h
@@ -166,19 +166,18 @@ struct handshake_state {
 =

 #define handshake_event(_hs, event, ...)	\
 	(__extension__ ({	\
-		struct handshake_state *hs =3D (_hs);	\
 		bool freed =3D false;	\
 	\
-		if (hs->event_func && !hs->in_event) {	\
-			hs->in_event =3D true;	\
-			hs->event_func(hs, event, hs->user_data,	\
+		if ((_hs)->event_func && !(_hs)->in_event) {	\
+			(_hs)->in_event =3D true;	\
+			(_hs)->event_func((_hs), event, (_hs)->user_data,	\
 					##__VA_ARGS__); \
 	\
-			if (!hs->in_event) {	\
-				handshake_state_free(hs);	\
+			if (!(_hs)->in_event) {	\
+				handshake_state_free((_hs));	\
 				freed =3D true;	\
 			} else	\
-				hs->in_event =3D false;	\
+				(_hs)->in_event =3D false;	\
 		}	\
 		freed;	\
 	}))
-- =

2.31.1

--===============8970285904807131275==--

