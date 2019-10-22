Content-Type: multipart/mixed; boundary="===============3485999025198606332=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH 2/7] t-runner: Fix mem leak caused by unclosed dir
Date: Tue, 22 Oct 2019 16:13:12 -0700
Message-ID: <20191022231317.11634-2-tim.a.kourt@linux.intel.com>
In-Reply-To: <20191022231317.11634-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3485999025198606332==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 tools/test-runner.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/test-runner.c b/tools/test-runner.c
index 430e18e3..5045984c 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -2413,6 +2413,8 @@ next:
 		l_free(unit_test_abs_path);
 	}
 =

+	closedir(d);
+
 exit:
 	l_strfreev(unit_tests);
 }
-- =

2.13.6

--===============3485999025198606332==--

