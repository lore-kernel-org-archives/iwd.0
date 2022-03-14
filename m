Content-Type: multipart/mixed; boundary="===============6840545365516277944=="
MIME-Version: 1.0
From: =?utf-8?q?Vladim=C3=ADr_Dudr_=3Cvladimir_at_tango-dj=2Ecz=3E?=
To: iwd at lists.01.org
Subject: [PATCH] client: make grey really grey
Date: Mon, 14 Mar 2022 21:49:45 +0100
Message-ID: <20220314204944.246498-1-vladimir@tango-dj.cz>

--===============6840545365516277944==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello, =

I dared to fix displaying of grey color for iwctl. I tested in Kitty,
Xterm, Termite, foot and Alarcitty.

\e[1;30m is bold black, often, but not always displayed bright black or
bold bright black. In case it is displayed as real black it is
invisible. \e[1;90m is explicit bold bright black.

\e[37m is white, therefore it is not suitable to be
labeled as GREY, which is \e[90m. Anyway, this define is used only in
header, so matching the color to BOLDGRAY seems intuitive. =


Cheers, =

Vladim=C3=ADr
---
 client/display.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/client/display.h b/client/display.h
index b5df944a..7747c6a0 100644
--- a/client/display.h
+++ b/client/display.h
@@ -23,8 +23,8 @@
 struct command;
 struct command_family;
 =

-#define COLOR_BOLDGRAY	"\x1B[1;30m"
-#define COLOR_GRAY	"\x1b[37m"
+#define COLOR_BOLDGRAY	"\x1B[1;90m"
+#define COLOR_GRAY	"\x1b[90m"
 #define COLOR_GREEN	"\x1b[32m"
 #define COLOR_RED	"\x1B[0;91m"
 #define COLOR_BLUE	"\x1B[94m"
-- =

2.35.1

--===============6840545365516277944==--

