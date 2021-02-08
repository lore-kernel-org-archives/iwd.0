Content-Type: multipart/mixed; boundary="===============6318770564834845632=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/5] display: use l_strlcpy to avoid potential overflow
Date: Mon, 08 Feb 2021 12:19:54 -0800
Message-ID: <20210208201958.607049-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6318770564834845632==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If 'entry' exceeds the length of 'line' we could overflow. Instead
use l_strlcpy and pass in the remaining amount of data left in
the buffer.
---
 client/display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/client/display.c b/client/display.c
index 88bc913f..961ad419 100644
--- a/client/display.c
+++ b/client/display.c
@@ -419,7 +419,7 @@ static void display_completion_matches(char **matches, =
int num_matches,
 		}
 =

 		entry =3D l_strdup_printf("%-*s ", max_length, matches[index]);
-		strcpy(&line[line_used], entry);
+		l_strlcpy(&line[line_used], entry, sizeof(line) - line_used);
 		l_free(entry);
 =

 		line_used +=3D max_length + 1;
-- =

2.26.2

--===============6318770564834845632==--

