Content-Type: multipart/mixed; boundary="===============7863377422392624842=="
MIME-Version: 1.0
From: Will Dietz <w@wdtz.org>
Subject: [PATCH] display: fix sources of crashing in completion callback
Date: Mon, 28 Oct 2019 15:14:37 -0500
Message-ID: <20191028201437.22406-1-w@wdtz.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7863377422392624842==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

* For some reason, the max_length parameter provided by readline
  (readline8.0p1) is smaller than max(strlen(matches[*]))?
  This seems like a bug but I'm not sure-- for now add a workaround
  and compute our own max_length value.  This might somehow not be a
  bug, perhaps measuring string length differently than raw strlen().
  Erring on defensive to ensure iwd isn't vulnerable to cleverly
  named SSID's (or set of SSID's).
* Assert in various bad situations, until this can be rewritten
  so that uncertain code under development is less user-hostile.
* Comment that if ssid name can be >=3D 81 it'll overflow the buffer
  I don't know if this is a thing to worry about.
* Fix wrapping check: in particular the inserted newline requires
  space (1char) and printf will write (up to) max_length + 1.
  Ensure space is available for all of this.

This is not pretty, but resolves the issues I've encountered thus far.
These loops take some attention to get right, which is probably why
various line-editing libraries try to handle this where possible.

AFAIK the code here exists in order to work with custom printing code
but FWIW readline and similar have routines for this
(used by default, I think?) which may be worth taking inspiration from
if licenses are compatible and no one wants to tackle this.

-----

Motivated by using `iwctl`, and attempting to complete with prefix
`station wlan0 connect <tab>`.  Problem was specific to location
(-> list of avail SSIDs and their names), I'll share anything
helpful from debuging logs or by trying to reproduce again
next time I'm able.
---
 client/display.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/client/display.c b/client/display.c
index c08183da..b6693681 100644
--- a/client/display.c
+++ b/client/display.c
@@ -30,6 +30,7 @@
 =

 #include <readline/history.h>
 #include <readline/readline.h>
+#include <assert.h>
 #include <ell/ell.h>
 =

 #include "agent.h"
@@ -364,6 +365,7 @@ static void display_completion_matches(char **matches, =
int num_matches,
 	char line[LINE_LEN];
 	size_t index;
 	size_t line_used;
+	size_t match_len;
 	char *input =3D rl_copy_text(0, rl_end);
 =

 	prompt =3D l_strdup_printf("%s%s\n", IWD_PROMPT, input);
@@ -372,8 +374,16 @@ static void display_completion_matches(char **matches,=
 int num_matches,
 	display_text(prompt);
 	l_free(prompt);
 =

+	// Fix max_length, account for quoting (apparently??)
+	for (index =3D 1; matches[index]; index++) {
+		match_len =3D strlen(matches[index]);
+		max_length =3D match_len > max_length ? match_len : max_length;
+	}
+
 	for (index =3D 1, line_used =3D 0; matches[index]; index++) {
-		if ((line_used + max_length) > LINE_LEN) {
+		assert(index <=3D num_matches);
+		assert(strlen(matches[index]) <=3D max_length);
+		if ((line_used + max_length + 1 + 1 /* :( */) >=3D LINE_LEN) {
 			strcpy(&line[line_used], "\n");
 =

 			display_text(line);
@@ -381,10 +391,11 @@ static void display_completion_matches(char **matches=
, int num_matches,
 			line_used =3D 0;
 		}
 =

+		// XXX: entry > LINE_LEN, if possible, will overflow 'line'! :(
 		entry =3D l_strdup_printf("%-*s ", max_length, matches[index]);
+		assert(strlen(entry) =3D=3D max_length + 1);
 		strcpy(&line[line_used], entry);
 		l_free(entry);
-
 		line_used +=3D max_length + 1;
 	}
 =

-- =

2.23.0

--===============7863377422392624842==--

