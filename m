Content-Type: multipart/mixed; boundary="===============2205450865258895601=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/1] test-runner: use WNOHANG option waiting for PID
Date: Tue, 16 Jun 2020 09:32:29 -0700
Message-ID: <20200616163229.14429-2-prestwoj@gmail.com>
In-Reply-To: <20200616163229.14429-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2205450865258895601==
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
 tools/test-runner.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/test-runner.c b/tools/test-runner.c
index f8677be5..498f3be3 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -626,14 +626,23 @@ exit:
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
+	if (i >=3D 20) {
+		l_error("Failed to kill process %d gracefully", pid);
+		kill(pid, SIGKILL);
+	}
 }
 =

 static bool wait_for_socket(const char *socket, useconds_t wait_time)
-- =

2.21.1

--===============2205450865258895601==--

