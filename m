Content-Type: multipart/mixed; boundary="===============4255694947830470142=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 2/2] test-runner: fix logging directory name
Date: Wed, 06 Nov 2019 13:42:49 -0800
Message-ID: <20191106214249.21038-2-prestwoj@gmail.com>
In-Reply-To: <20191106214249.21038-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4255694947830470142==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

localtime indexes month starting at zero so adding 1 gives us a folder
name with the correct month.

The year is also set as 'years since 1900', so we need to add 1900 to
the year to get the actual year.
---
 tools/test-runner.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/test-runner.c b/tools/test-runner.c
index 1c807aea..82f009ae 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -3183,8 +3183,8 @@ int main(int argc, char *argv[])
 			log_uid =3D atoi(getenv("SUDO_UID"));
 =

 			snprintf(log_dir, sizeof(log_dir), "%s/run-%d-%d-%d-%d",
-					optarg, timeinfo->tm_year,
-					timeinfo->tm_mon, timeinfo->tm_mday,
+					optarg, timeinfo->tm_year + 1900,
+					timeinfo->tm_mon + 1, timeinfo->tm_mday,
 					getpid());
 			mkdir(log_dir, 0755);
 =

-- =

2.17.1

--===============4255694947830470142==--

