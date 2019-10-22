Content-Type: multipart/mixed; boundary="===============8280125635597566393=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] auto-t: hostapd: raise exception upon invalid config
Date: Tue, 22 Oct 2019 09:14:00 -0700
Message-ID: <20191022161400.7941-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8280125635597566393==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If the config file passed in is not found we would continue and
eventually something else would fail. Instead immediately raise an
exception to be more clear on what is actually failing.
---
 autotests/util/hostapd.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/autotests/util/hostapd.py b/autotests/util/hostapd.py
index 60750690..49047f38 100644
--- a/autotests/util/hostapd.py
+++ b/autotests/util/hostapd.py
@@ -45,6 +45,9 @@ class HostapdCLI:
                     interface =3D intf
                     break
 =

+        if not interface:
+            raise Exception('config %s not found' % config)
+
         self.ifname =3D interface.name
         self.socket_path =3D os.path.dirname(interface.ctrl_interface)
 =

-- =

2.17.1

--===============8280125635597566393==--

