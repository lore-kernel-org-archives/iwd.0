Content-Type: multipart/mixed; boundary="===============0255855544617442747=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH 1/2] client: Increase passphrase buffer to accommodate for nil
 byte
Date: Tue, 29 Oct 2019 15:33:08 -0700
Message-ID: <20191029223309.25581-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0255855544617442747==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 client/display.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/client/display.c b/client/display.c
index cd17ad84..74b50e2e 100644
--- a/client/display.c
+++ b/client/display.c
@@ -397,7 +397,7 @@ static void display_completion_matches(char **matches, =
int num_matches,
 =

 static struct masked_input {
 	bool use_mask;
-	char passphrase[MAX_PASSPHRASE_LEN];
+	char passphrase[MAX_PASSPHRASE_LEN + 1];
 	uint8_t point;
 	uint8_t end;
 } masked_input;
@@ -436,6 +436,7 @@ static void mask_input(void)
 				masked_input.passphrase + masked_input.point
 									+ 1,
 				rl_end - rl_point);
+
 		memset(masked_input.passphrase + rl_end, 0,
 				masked_input.end - rl_end);
 	}
@@ -453,7 +454,7 @@ done:
 =

 static void reset_masked_input(void)
 {
-	memset(masked_input.passphrase, 0, MAX_PASSPHRASE_LEN);
+	memset(masked_input.passphrase, 0, MAX_PASSPHRASE_LEN + 1);
 	masked_input.point =3D 0;
 	masked_input.end =3D 0;
 }
-- =

2.13.6

--===============0255855544617442747==--

