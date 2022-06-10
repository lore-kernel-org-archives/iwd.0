Content-Type: multipart/mixed; boundary="===============9218048437382835250=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 3/3] build: ignore unknown warnings/pragmas for CC=clang
Date: Fri, 10 Jun 2022 12:52:42 -0700
Message-ID: <20220610195242.455453-3-prestwoj@gmail.com>
In-Reply-To: 20220610195242.455453-1-prestwoj@gmail.com

--===============9218048437382835250==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

IWD uses a few pragmas to ignore warnings which clang does
not support. For -Werror builds these cause build failures
but can be fixed by ignoring unknown warnings and pragmas.
---
 acinclude.m4 | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/acinclude.m4 b/acinclude.m4
index a66a3746..3fd96236 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -64,4 +64,9 @@ AC_DEFUN([COMPILER_FLAGS], [
 			CFLAGS+=3D" -Wcast-align"
 		fi
 	fi
+
+	if (test "$CC" =3D "clang"); then
+		CFLAGS+=3D" -Wno-unknown-warning-option"
+		CFLAGS+=3D" -Wno-unknown-pragmas"
+	fi
 ])
-- =

2.34.1

--===============9218048437382835250==--

