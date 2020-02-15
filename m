Content-Type: multipart/mixed; boundary="===============8791729238892625375=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 6/6] test: Handle missing agent calls in simple-agent
Date: Sat, 15 Feb 2020 01:17:48 +0100
Message-ID: <20200215001748.20819-6-andrew.zaborowski@intel.com>
In-Reply-To: <20200215001748.20819-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8791729238892625375==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Handle RequestPrivateKeyPassphrase and RequestUserNameAndPassword
---
 test/simple-agent | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/test/simple-agent b/test/simple-agent
index 79cee021..cdfc2076 100755
--- a/test/simple-agent
+++ b/test/simple-agent
@@ -35,6 +35,41 @@ class Agent(dbus.service.Object):
         print("returning (%s)" % (passphrase))
         return passphrase
 =

+    @dbus.service.method("net.connman.iwd.Agent",
+                            in_signature=3D'o',
+                            out_signature=3D's')
+    def RequestPrivateKeyPassphrase(self, path):
+        print("RequestPrivateKeyPassphrase (%s)" % (path))
+
+        print("Service credentials requested, type cancel to cancel")
+        passphrase =3D input('Answer: ')
+
+        if not passphrase or passphrase =3D=3D 'cancel':
+            raise Canceled("canceled")
+
+        print("returning (%s)" % (passphrase))
+        return passphrase
+
+    @dbus.service.method("net.connman.iwd.Agent",
+                            in_signature=3D'o',
+                            out_signature=3D'ss')
+    def RequestUserNameAndPassword(self, path):
+        print("RequestPrivateKeyPassphrase (%s)" % (path))
+
+        print("Service credentials requested, type cancel to cancel")
+        user =3D input('User name: ')
+
+        if not user or user =3D=3D 'cancel':
+            raise Canceled("canceled")
+
+        passwd =3D input('User password: ')
+
+        if not passwd or passwd =3D=3D 'cancel':
+            raise Canceled("canceled")
+
+        print("returning (%s, %s)" % (user, passwd))
+        return (user, passwd)
+
     @dbus.service.method("net.connman.iwd.Agent",
                             in_signature=3D's', out_signature=3D'')
     def Cancel(self, reason):
-- =

2.20.1

--===============8791729238892625375==--

