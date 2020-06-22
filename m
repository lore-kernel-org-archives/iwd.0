Content-Type: multipart/mixed; boundary="===============3482727579561959357=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2] test-runner: use WNOHANG option waiting for PID
Date: Mon, 22 Jun 2020 08:50:50 -0700
Message-ID: <20200622155050.24787-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3482727579561959357==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If an application has a bug and hangs on SIGTERM this causes
test-runner to hang as well. This is obviously an issue with
the application in question, but test-runner should have a way
of continuing onto the next test rather than hanging.

Instead we can use WNOHANG and a sleep to allow applications
some amount of time to exit, and if they haven't use SIGKILL
instead as well as print an error. Similar to how
wait_for_socket works. The timeout is hard coded to 2 seconds
(100ms sleep + 20 iterations).
---
 tools/test-runner.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

v2:
 - Removed extra check for i >=3D 20 since that is always going to be
   true if we get past the while loop
 - Added another waitpid after SIGKILL

diff --git a/tools/test-runner.c b/tools/test-runner.c
index f8677be5..83d5194d 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -626,14 +626,24 @@ exit:
 static void kill_process(pid_t pid)
 {
 	int status;
+	int i =3D 0;
 =

 	l_debug("Terminate pid: %d", pid);
 =

 	kill(pid, SIGTERM);
 =

 	do {
-		waitpid(pid, &status, 0);
-	} while (!WIFEXITED(status) && !WIFSIGNALED(status));
+		if (waitpid(pid, &status, WNOHANG) =3D=3D pid)
+			return;
+
+		usleep(100000);
+	} while (!WIFEXITED(status) && !WIFSIGNALED(status) && i++ < 20);
+
+	l_error("Failed to kill process %d gracefully", pid);
+	kill(pid, SIGKILL);
+
+	/* SIGKILL shouldn't need WNOHANG */
+	waitpid(pid, &status, 0);
 }
 =

 static bool wait_for_socket(const char *socket, useconds_t wait_time)
-- =

2.21.1

--===============3482727579561959357==--

