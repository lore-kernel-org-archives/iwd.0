Content-Type: multipart/mixed; boundary="===============5459629522509032205=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] test-runner: print which file failed to fchown
Date: Thu, 21 Nov 2019 09:27:42 -0800
Message-ID: <20191121172742.16742-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5459629522509032205==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 tools/test-runner.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/test-runner.c b/tools/test-runner.c
index 5e10f542..71c5f14e 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -589,7 +589,7 @@ static pid_t execute_program(char *argv[], char *envp[]=
, bool wait,
 			fd =3D open(log_file, O_WRONLY | O_CREAT | O_APPEND,
 					S_IRUSR | S_IWUSR);
 			if (fchown(fd, log_uid, log_gid) < 0)
-				l_error("fchown failed");
+				l_error("failed to fchown %s", log_file);
 		}
 =

 		if (fd > -1) {
@@ -3190,7 +3190,7 @@ int main(int argc, char *argv[])
 			mkdir(log_dir, 0755);
 =

 			if (chown(log_dir, log_uid, log_gid) < 0)
-				l_error("fchown failed");
+				l_error("failed to fchown %s", log_dir);
 =

 			break;
 		case 'h':
-- =

2.17.1

--===============5459629522509032205==--

