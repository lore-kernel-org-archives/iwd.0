Content-Type: multipart/mixed; boundary="===============6225159576092996658=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH v2 1/2] client: Increase passphrase buffer to accommodate for
 nil byte
Date: Tue, 29 Oct 2019 16:12:34 -0700
Message-ID: <20191029231235.7751-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6225159576092996658==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 client/display.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/client/display.c b/client/display.c
index cd17ad84..105d05cb 100644
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
@@ -453,7 +453,7 @@ done:
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

--===============6225159576092996658==--

