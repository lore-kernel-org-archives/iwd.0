Content-Type: multipart/mixed; boundary="===============4055466884115271186=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH 2/2] client: Update rl_point to last known position
Date: Tue, 29 Oct 2019 15:33:09 -0700
Message-ID: <20191029223309.25581-2-tim.a.kourt@linux.intel.com>
In-Reply-To: <20191029223309.25581-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4055466884115271186==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Keep cursor's position consistent when passphrase is reaching
its maximum by adding characters in the middle of the string

This isn't practical behavior.
---
 client/display.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/client/display.c b/client/display.c
index 74b50e2e..fc280d31 100644
--- a/client/display.c
+++ b/client/display.c
@@ -408,7 +408,9 @@ static void mask_input(void)
 		return;
 =

 	if (rl_end > MAX_PASSPHRASE_LEN) {
-		rl_point =3D rl_end =3D MAX_PASSPHRASE_LEN;
+		rl_end =3D MAX_PASSPHRASE_LEN;
+		rl_point =3D masked_input.point;
+
 		goto set_mask;
 	}
 =

-- =

2.13.6

--===============4055466884115271186==--

