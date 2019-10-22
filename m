Content-Type: multipart/mixed; boundary="===============4352585841148341280=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH 7/7] t-runner: Check for errors after opening file
Date: Tue, 22 Oct 2019 16:13:17 -0700
Message-ID: <20191022231317.11634-7-tim.a.kourt@linux.intel.com>
In-Reply-To: <20191022231317.11634-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4352585841148341280==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 tools/test-runner.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/test-runner.c b/tools/test-runner.c
index 398494e6..1dfdb9af 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -524,6 +524,9 @@ static pid_t execute_program(char *argv[], char *envp[]=
, bool wait,
 							S_IRUSR | S_IWUSR);
 			}
 =

+			if (fd =3D=3D -1)
+				exit(EXIT_FAILURE);
+
 			dup2(fd, 1);
 			dup2(fd, 2);
 =

-- =

2.13.6

--===============4352585841148341280==--

