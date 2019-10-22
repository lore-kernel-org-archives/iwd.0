Content-Type: multipart/mixed; boundary="===============6620431851501476120=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH 5/7] t-runner: Fix possible assignment of NULL pointer
Date: Tue, 22 Oct 2019 16:13:15 -0700
Message-ID: <20191022231317.11634-5-tim.a.kourt@linux.intel.com>
In-Reply-To: <20191022231317.11634-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6620431851501476120==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 tools/test-runner.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/test-runner.c b/tools/test-runner.c
index 2dc19726..0226dd15 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -2674,7 +2674,8 @@ static void run_tests(void)
 		test_action_str =3D ptr + 4;
 =

 		ptr =3D strchr(test_action_str, '\'');
-		*ptr =3D '\0';
+		if (ptr)
+			*ptr =3D '\0';
 =

 		if (!strcmp(test_action_str, "virtual"))
 			native_hw =3D false;
-- =

2.13.6

--===============6620431851501476120==--

