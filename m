Content-Type: multipart/mixed; boundary="===============5129935158845970127=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH 3/7] t-runner: Fix mem leak caused by python test names
Date: Tue, 22 Oct 2019 16:13:13 -0700
Message-ID: <20191022231317.11634-3-tim.a.kourt@linux.intel.com>
In-Reply-To: <20191022231317.11634-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5129935158845970127==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 tools/test-runner.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/test-runner.c b/tools/test-runner.c
index 5045984c..faa5dfa1 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -1089,6 +1089,8 @@ static bool add_path(const char *path, int level, str=
uct l_queue *config_queue)
 		l_queue_insert(config_queue, entry, insert_test_entry, NULL);
 	}
 =

+	l_queue_destroy(py_test_queue, l_free);
+
 	closedir(dir);
 	return true;
 }
-- =

2.13.6

--===============5129935158845970127==--

