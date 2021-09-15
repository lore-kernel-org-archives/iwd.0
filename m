Content-Type: multipart/mixed; boundary="===============6277682472350959165=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 12/13] auto-t: hostapd.py: add disable()
Date: Wed, 15 Sep 2021 10:36:23 -0700
Message-ID: <20210915173624.11917-12-prestwoj@gmail.com>
In-Reply-To: 20210915173624.11917-1-prestwoj@gmail.com

--===============6277682472350959165==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/util/hostapd.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/autotests/util/hostapd.py b/autotests/util/hostapd.py
index 07d27f1b..7cb3225a 100644
--- a/autotests/util/hostapd.py
+++ b/autotests/util/hostapd.py
@@ -152,6 +152,9 @@ class HostapdCLI(object):
         ctx.start_process(self.cmdline + ['disable']).wait()
         ctx.start_process(self.cmdline + ['enable']).wait()
 =

+    def disable(self):
+        ctx.start_process(self.cmdline + ['disable']).wait()
+
     def list_sta(self):
         proc =3D ctx.start_process(self.cmdline + ['list_sta'])
         proc.wait()
-- =

2.31.1

--===============6277682472350959165==--

