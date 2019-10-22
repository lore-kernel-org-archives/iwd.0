Content-Type: multipart/mixed; boundary="===============9156817641440223171=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH 4/7] t-runner: Fix out-of-bounds write
Date: Tue, 22 Oct 2019 16:13:14 -0700
Message-ID: <20191022231317.11634-4-tim.a.kourt@linux.intel.com>
In-Reply-To: <20191022231317.11634-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============9156817641440223171==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 tools/test-runner.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/test-runner.c b/tools/test-runner.c
index faa5dfa1..2dc19726 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -1636,7 +1636,7 @@ static void print_test_status(char *test_name, enum t=
est_status ts,
 =

 	interval_str =3D l_malloc(int_len);
 	memset(interval_str, ' ', int_len);
-	interval_str[int_len] =3D '\0';
+	interval_str[int_len - 1] =3D '\0';
 =

 	if (interval > 0)
 		sprintf(interval_str, "%.3f sec", interval);
-- =

2.13.6

--===============9156817641440223171==--

