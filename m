Content-Type: multipart/mixed; boundary="===============6341877999935525249=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] test-runner: fix double free issue on subtest queue
Date: Wed, 23 Oct 2019 09:24:10 -0700
Message-ID: <20191023162410.27743-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6341877999935525249==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Coverity reported this as a leak, but the test queue is actually
getting freed later and does not need to be freed locally in add_path

This basically reverts c0863e5bc62f645f0bde144e4e906b7277866bf7
---
 tools/test-runner.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/test-runner.c b/tools/test-runner.c
index 1dfdb9af..d6334e83 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -1092,8 +1092,6 @@ static bool add_path(const char *path, int level, str=
uct l_queue *config_queue)
 		l_queue_insert(config_queue, entry, insert_test_entry, NULL);
 	}
 =

-	l_queue_destroy(py_test_queue, l_free);
-
 	closedir(dir);
 	return true;
 }
-- =

2.17.1

--===============6341877999935525249==--

