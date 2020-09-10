Content-Type: multipart/mixed; boundary="===============0539421531858528581=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 19/26] auto-t: update testAgent to use TestContext
Date: Thu, 10 Sep 2020 11:58:48 -0700
Message-ID: <20200910185855.27833-19-prestwoj@gmail.com>
In-Reply-To: <20200910185855.27833-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0539421531858528581==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This hides iwctl output unless verbose is specified
---
 autotests/testAgent/agent_test.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/autotests/testAgent/agent_test.py b/autotests/testAgent/agent_=
test.py
index 80d2ce83..60465d3f 100644
--- a/autotests/testAgent/agent_test.py
+++ b/autotests/testAgent/agent_test.py
@@ -10,6 +10,7 @@ from iwd import PSKAgent
 from iwd import NetworkType
 import testutil
 import subprocess
+from config import ctx
 =

 class Test(unittest.TestCase):
 =

@@ -57,7 +58,7 @@ class Test(unittest.TestCase):
     def test_connection_with_other_agent(self):
         wd =3D IWD()
 =

-        iwctl =3D subprocess.Popen(['iwctl', '-P', 'secret_ssid2'])
+        iwctl =3D ctx.start_process(['iwctl', '-P', 'secret_ssid2']).pid
         # Let iwctl to start and register its agent.
         wd.wait(2)
 =

@@ -72,7 +73,7 @@ class Test(unittest.TestCase):
 =

         wd =3D IWD()
 =

-        iwctl =3D subprocess.Popen(['iwctl', '-P', 'secret_ssid2'])
+        iwctl =3D ctx.start_process(['iwctl', '-P', 'secret_ssid2']).pid
         # Let iwctl to start and register its agent.
         wd.wait(2)
 =

-- =

2.21.3

--===============0539421531858528581==--

