Content-Type: multipart/mixed; boundary="===============7431109488620197753=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 5/8] auto-t: update hostapd.list_sta to use Process.out
Date: Mon, 16 Nov 2020 14:25:11 -0800
Message-ID: <20201116222514.3486808-5-prestwoj@gmail.com>
In-Reply-To: <20201116222514.3486808-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7431109488620197753==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Instead of list_sta() waiting for the PID itself it can
just use wait=3DTrue and grab the output out of the Process
class itself.
---
 autotests/util/hostapd.py | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/autotests/util/hostapd.py b/autotests/util/hostapd.py
index cf82c010..3f48bd57 100644
--- a/autotests/util/hostapd.py
+++ b/autotests/util/hostapd.py
@@ -152,11 +152,12 @@ class HostapdCLI:
         ctx.start_process(self.cmdline + ['enable'], wait=3DTrue)
 =

     def list_sta(self):
-        proc =3D ctx.start_process(self.cmdline + ['list_sta'])
-        proc.pid.wait()
-        lines =3D proc.pid.stdout.read().decode('utf-8')
+        proc =3D ctx.start_process(self.cmdline + ['list_sta'], wait=3DTru=
e)
 =

-        return [line for line in lines.split('\n') if line]
+        if not proc.out:
+            return []
+
+        return [line for line in proc.out.split('\n') if line]
 =

     def set_neighbor(self, addr, ssid, nr):
         cmd =3D self.cmdline + ['set_neighbor', addr, 'ssid=3D"%s"' % ssid=
, 'nr=3D%s' % nr]
-- =

2.26.2

--===============7431109488620197753==--

