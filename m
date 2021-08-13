Content-Type: multipart/mixed; boundary="===============8766933040318955687=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/6] auto-t: fix testAgent use of Process
Date: Fri, 13 Aug 2021 13:26:07 -0700
Message-ID: <20210813202612.809470-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8766933040318955687==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This test was accessing the subprocess object and calling terminate
which ends up causing issues with test-runners own process cleanup.
Instead kill() should be used.
---
 autotests/testAgent/agent_test.py | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/autotests/testAgent/agent_test.py b/autotests/testAgent/agent_=
test.py
index 7d3b6119..e2d6e49e 100644
--- a/autotests/testAgent/agent_test.py
+++ b/autotests/testAgent/agent_test.py
@@ -58,14 +58,13 @@ class Test(unittest.TestCase):
     def test_connection_with_other_agent(self):
         wd =3D IWD()
 =

-        iwctl =3D ctx.start_process(['iwctl', '-P', 'secret_ssid2']).pid
+        iwctl =3D ctx.start_process(['iwctl', '-P', 'secret_ssid2'])
         # Let iwctl to start and register its agent.
         wd.wait(2)
 =

         self.check_connection(wd, 'ssid2')
 =

-        iwctl.terminate()
-        iwctl.communicate()
+        iwctl.kill()
 =

         IWD.clear_storage()
 =

@@ -73,7 +72,7 @@ class Test(unittest.TestCase):
 =

         wd =3D IWD()
 =

-        iwctl =3D ctx.start_process(['iwctl', '-P', 'secret_ssid2']).pid
+        iwctl =3D ctx.start_process(['iwctl', '-P', 'secret_ssid2'])
         # Let iwctl to start and register its agent.
         wd.wait(2)
 =

@@ -84,8 +83,7 @@ class Test(unittest.TestCase):
 =

         wd.unregister_psk_agent(psk_agent)
 =

-        iwctl.terminate()
-        iwctl.communicate()
+        iwctl.kill()
 =

         IWD.clear_storage()
 =

-- =

2.31.1

--===============8766933040318955687==--

