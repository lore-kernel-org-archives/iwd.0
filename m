Content-Type: multipart/mixed; boundary="===============0210625829955839248=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/2] test-runner: fix logging directory name
Date: Wed, 06 Nov 2019 13:38:15 -0800
Message-ID: <20191106213815.20555-2-prestwoj@gmail.com>
In-Reply-To: <20191106213815.20555-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0210625829955839248==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

localtime indexes month starting at zero so adding 1 gives us a folder
name with the correct month.
---
 tools/test-runner.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/test-runner.c b/tools/test-runner.c
index 1c807aea..163f53e7 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -3184,7 +3184,7 @@ int main(int argc, char *argv[])
 =

 			snprintf(log_dir, sizeof(log_dir), "%s/run-%d-%d-%d-%d",
 					optarg, timeinfo->tm_year,
-					timeinfo->tm_mon, timeinfo->tm_mday,
+					timeinfo->tm_mon + 1, timeinfo->tm_mday,
 					getpid());
 			mkdir(log_dir, 0755);
 =

-- =

2.17.1

--===============0210625829955839248==--

