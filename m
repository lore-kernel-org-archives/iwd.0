Content-Type: multipart/mixed; boundary="===============5660226672489943928=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/6] test-runner: remove special case for "root" namespace
Date: Tue, 07 Sep 2021 09:54:34 -0700
Message-ID: <20210907165439.9913-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5660226672489943928==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This was a placeholder at one point but modules grew to depend on it
being a string. Fix these dependencies and set the root namespace
name to None so there is no more special case needed to handle both
a named namespace and the original 'root' namespace.
---
 autotests/util/hwsim.py |  8 ++++----
 autotests/util/iwd.py   |  2 +-
 tools/test-runner       | 10 ++--------
 3 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/autotests/util/hwsim.py b/autotests/util/hwsim.py
index cc62495c..26092379 100755
--- a/autotests/util/hwsim.py
+++ b/autotests/util/hwsim.py
@@ -301,15 +301,15 @@ class Hwsim(iwd.AsyncOpAbstract):
     _instances =3D WeakValueDictionary()
 =

     def __new__(cls, namespace=3Dctx):
-        name =3D namespace.name
+        key =3D id(namespace)
 =

-        if name not in cls._instances.keys():
+        if key not in cls._instances.keys():
             obj =3D object.__new__(cls)
             obj._initialized =3D False
 =

-            cls._instances[name] =3D obj
+            cls._instances[key] =3D obj
 =

-        return cls._instances[name]
+        return cls._instances[key]
 =

     def __init__(self, namespace=3Dctx):
         if self._initialized:
diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index 730659ac..63b526fd 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -1053,7 +1053,7 @@ class IWD(AsyncOpAbstract):
         # reference so that __del__ gets called when it's released. This i=
s only
         # done for the root namespace in order to allow testutil to functi=
on
         # correctly in non-namespace tests.
-        if self.namespace.name =3D=3D "root":
+        if self.namespace.name is None:
             IWD._default_instance =3D weakref.ref(self)
 =

     def __del__(self):
diff --git a/tools/test-runner b/tools/test-runner
index 9e4d0780..210e4f5f 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -599,12 +599,6 @@ class Namespace:
 		return self._bus
 =

 	def start_process(self, args, env=3DNone, **kwargs):
-		# Special case for 'root' namespace (aka TestContext)
-		if self.name =3D=3D "root":
-			ns =3D None
-		else:
-			ns =3D self.name
-
 		if not env:
 			env =3D os.environ.copy()
 =

@@ -612,7 +606,7 @@ class Namespace:
 			# In case this process needs DBus...
 			env['DBUS_SYSTEM_BUS_ADDRESS'] =3D self.dbus_address
 =

-		p =3D Process(args, namespace=3Dns, env=3Denv, **kwargs)
+		p =3D Process(args, namespace=3Dself.name, env=3Denv, **kwargs)
 =

 		if not kwargs.get('wait', False):
 			self.processes.append(p)
@@ -791,7 +785,7 @@ class TestContext(Namespace):
 		such as processes, radios, interfaces and test results.
 	'''
 	def __init__(self, args):
-		self.name =3D "root"
+		self.name =3D None
 		self.processes =3D []
 		self.args =3D args
 		self.hw_config =3D None
-- =

2.31.1

--===============5660226672489943928==--

