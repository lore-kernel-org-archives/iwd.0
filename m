Content-Type: multipart/mixed; boundary="===============2259493951225366559=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] test-runner: fix segfault running with --log non-root
Date: Thu, 02 Apr 2020 09:48:48 -0700
Message-ID: <20200402164848.1580-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2259493951225366559==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When running test-runner as non-root the environment variables
SUDO_GID/SUDO_UID were unset, causing atoi to segfault. This replaces
atoi with strtol, and checks the existance of SUDO_GID/SUDO_UID
before trying to turn it into an integer. This patch also allows
the uid/gid to be read from the user if running as non-root.

Note: running as non-root does require the users permissions to be
setup properly. Directories and files are created when running with
logging, so if the user running test-runner does not have these
permissions the creation of these files will fail.
---
 tools/test-runner.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/test-runner.c b/tools/test-runner.c
index 1adb8377..5b37a790 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -3095,6 +3095,8 @@ int main(int argc, char *argv[])
 	uint8_t actions =3D 0;
 	struct tm *timeinfo;
 	time_t t;
+	char *gid;
+	char *uid;
 =

 	l_log_set_stderr();
 =

@@ -3195,8 +3197,16 @@ int main(int argc, char *argv[])
 			time(&t);
 			timeinfo =3D localtime(&t);
 =

-			log_gid =3D atoi(getenv("SUDO_GID"));
-			log_uid =3D atoi(getenv("SUDO_UID"));
+			gid =3D getenv("SUDO_GID");
+			uid =3D getenv("SUDO_UID");
+
+			if (!gid || !uid) {
+				log_gid =3D getgid();
+				log_uid =3D getuid();
+			} else {
+				log_gid =3D strtol(gid, NULL, 10);
+				log_uid =3D strtol(uid, NULL, 10);
+			}
 =

 			snprintf(log_dir, sizeof(log_dir), "%s/run-%d-%d-%d-%d",
 					optarg, timeinfo->tm_year + 1900,
-- =

2.21.1

--===============2259493951225366559==--

