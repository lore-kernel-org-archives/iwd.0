Content-Type: multipart/mixed; boundary="===============1528577489189921082=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 6/6] test-runner: move process tracking out of Namespace
Date: Tue, 07 Sep 2021 09:54:39 -0700
Message-ID: <20210907165439.9913-6-prestwoj@gmail.com>
In-Reply-To: <20210907165439.9913-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1528577489189921082==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Since Process.processes is a weak reference dictionary any process
put in this dict will disappear if all references are lost. This
is much better than keeping a list in the Namespace which will hold
the references forever until test-runner manually kills them all at
the end of the test. This does still need to be done for daemon
processes but everything else can just go away when it is no longer
needed.
---
 tools/test-runner | 40 +++++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/tools/test-runner b/tools/test-runner
index bd0034c2..b0d6554d 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -57,12 +57,9 @@ def dbg(*s, **kwargs):
 =

 def exit_vm():
 	if config:
-		for p in config.ctx.processes:
+		for p in Process.get_all():
 			print("Process %s still running!" % p.args[0])
 			p.kill()
-			p =3D None
-
-		config.ctx.processes =3D []
 =

 	if config.ctx and config.ctx.results:
 		print_results(config.ctx.results)
@@ -178,6 +175,7 @@ class Process(subprocess.Popen):
 		self.out =3D ''
 		self.hup =3D False
 		self.killed =3D False
+		self.namespace =3D namespace
 =

 		if not self.ctx:
 			global config
@@ -219,6 +217,15 @@ class Process(subprocess.Popen):
 				raise subprocess.CalledProcessError(returncode=3Dself.returncode,
 									cmd=3Dargs)
 =

+	@classmethod
+	def get_all(cls):
+		return cls.processes.values()
+
+	@classmethod
+	def kill_all(cls):
+		for p in cls.processes.values():
+			p.kill()
+
 	@staticmethod
 	def _write_io(instance, data, stdout=3DTrue):
 		for f in instance.write_fds:
@@ -321,8 +328,6 @@ class Process(subprocess.Popen):
 		self.cleanup =3D None
 		self.killed =3D True
 =

-		if self in self.ctx.processes:
-			self.ctx.processes.remove(self)
 	# Override kill()
 	def kill(self, force=3DFalse):
 		if self.killed:
@@ -588,7 +593,6 @@ dbus_count =3D 0
 class Namespace:
 	def __init__(self, args, name, radios):
 		self.dbus_address =3D None
-		self.processes =3D []
 		self.name =3D name
 		self.radios =3D radios
 		self.args =3D args
@@ -607,10 +611,7 @@ class Namespace:
 =

 		self.radios =3D []
 =

-		for p in list(self.processes):
-			p.kill()
-
-		self.processes =3D []
+		Process.kill_all()
 =

 	def __del__(self):
 		print("Removing namespace %s" % self.name)
@@ -628,19 +629,14 @@ class Namespace:
 			# In case this process needs DBus...
 			env['DBUS_SYSTEM_BUS_ADDRESS'] =3D self.dbus_address
 =

-		p =3D Process(args, namespace=3Dself.name, env=3Denv, **kwargs)
-
-		if not kwargs.get('wait', False):
-			self.processes.append(p)
-
-		return p
+		return Process(args, namespace=3Dself.name, env=3Denv, **kwargs)
 =

 	def stop_process(self, p, force=3DFalse):
 		p.kill(force)
 =

 	def is_process_running(self, process):
-		for p in self.processes:
-			if p.args[0] =3D=3D process:
+		for p in Process.get_all():
+			if p.namespace =3D=3D self.name and p.args[0] =3D=3D process:
 				return True
 		return False
 =

@@ -698,8 +694,7 @@ class Namespace:
 		if self.is_verbose('iwd-acd'):
 			env['IWD_ACD_DEBUG'] =3D '1'
 =

-		pid =3D self.start_process(args, env=3Denv)
-		return pid
+		return self.start_process(args, env=3Denv)
 =

 	def is_verbose(self, process, log=3DTrue):
 		process =3D os.path.basename(process)
@@ -786,7 +781,7 @@ class Namespace:
 	def __str__(self):
 		ret =3D 'Namespace: %s\n' % self.name
 		ret +=3D 'Processes:\n'
-		for p in self.processes:
+		for p in Process.get_all():
 			ret +=3D '\t%s' % str(p)
 =

 		ret +=3D 'Radios:\n'
@@ -808,7 +803,6 @@ class TestContext(Namespace):
 	'''
 	def __init__(self, args):
 		self.name =3D None
-		self.processes =3D []
 		self.args =3D args
 		self.hw_config =3D None
 		self.hostapd =3D None
-- =

2.31.1

--===============1528577489189921082==--

