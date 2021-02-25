Content-Type: multipart/mixed; boundary="===============3309714922814495541=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 07/17] test-runner: remove concept of 'multi_test'
Date: Thu, 25 Feb 2021 14:00:56 -0800
Message-ID: <20210225220106.1728411-7-prestwoj@gmail.com>
In-Reply-To: <20210225220106.1728411-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3309714922814495541==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Though multi-test processes seemed like a good idea in terms of
efficiency, the additional code/special cases was not worth it
for the only two multi-test processes (dbus/haveged). Intead this
concept was removed completely and TestContext/Namespaces will
now start all processes for each individual test. This also is
fair to all tests as a previous failed test could end up bleeding
into future tests.
---
 tools/test-runner | 32 +++++++++++---------------------
 1 file changed, 11 insertions(+), 21 deletions(-)

diff --git a/tools/test-runner b/tools/test-runner
index 662931b1..d63faf8c 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -157,16 +157,13 @@ class Process:
 	'''
 		Start a process. If 'wait' is True the constructor will start
 		the process and wait for it to exit. No PID is tracked in this
-		case. If 'multi_test' is True this indicates the process is
-		run over the entire test run and will not be killed after each
-		test exits.
+		case.
 	'''
-	def __init__(self, args, wait=3DFalse, multi_test=3DFalse, env=3DNone, ct=
x=3DNone, check=3DFalse,
+	def __init__(self, args, wait=3DFalse, env=3DNone, ctx=3DNone, check=3DFa=
lse,
 				outfile=3DNone, namespace=3DNone, need_out=3DFalse):
 		self.args =3D args
 		self.wait =3D wait
 		self.name =3D args[0]
-		self.multi_test =3D multi_test
 		self.ret =3D None
 		self.ctx =3D ctx
 		self.write_fds =3D []
@@ -311,9 +308,7 @@ class Process:
 				raise Exception("Timed out waiting for socket")
 =

 	def __str__(self):
-		ret =3D str(self.args) + ' multi_test=3D%s' % str(self.multi_test)
-		ret +=3D '\n'
-		return ret
+		return str(self.args) + '\n'
 =

 class Interface:
 	def __init__(self, name, config):
@@ -528,7 +523,6 @@ class Namespace:
 	dbus_address =3D None
 	processes =3D []
 	radios =3D []
-	dbus_pid =3D None
 =

 	def __init__(self, args, name, radios):
 		self.name =3D name
@@ -539,7 +533,7 @@ class Namespace:
 		for r in radios:
 			Process(['iw', 'phy', r.name, 'set', 'netns', 'name', name], wait=3DTru=
e)
 =

-		self.dbus_pid =3D self.start_dbus(multi_test=3DFalse)
+		self.start_dbus()
 =

 	def reset(self):
 		self.radios =3D []
@@ -548,12 +542,11 @@ class Namespace:
 		if self.name =3D=3D "root":
 			self._bus =3D dbus.bus.BusConnection(address_or_type=3Dself.dbus_addres=
s)
 =

-		for p in [p for p in self.processes if p.multi_test is False]:
+		for p in self.processes:
 			print("Killing process %s" % p.name)
-			self.stop_process(p)
+			p.kill()
 =

-		if self.dbus_pid and not self.dbus_pid.multi_test:
-			os.remove(self.dbus_cfg)
+		self.processes =3D []
 =

 	def __del__(self):
 		print("Removing namespace %s" % self.name)
@@ -607,14 +600,12 @@ class Namespace:
 			f.write('</busconfig>\n')
 =

 		p =3D self.start_process(['dbus-daemon', '--config-file=3D%s' % self.dbu=
s_cfg],
-					wait=3DFalse, multi_test=3Dmulti_test)
+					wait=3DFalse)
 =

 		p.wait_for_socket(self.dbus_address.split('=3D')[1], wait=3D5)
 =

 		self._bus =3D dbus.bus.BusConnection(address_or_type=3Dself.dbus_address)
 =

-		return p
-
 	def start_iwd(self, config_dir =3D '/tmp', storage_dir =3D '/tmp/iwd'):
 		args =3D []
 		iwd_radios =3D ','.join([r.name for r in self.radios if r.use =3D=3D 'iw=
d'])
@@ -726,7 +717,7 @@ class TestContext(Namespace):
 		self.start_process(['dbus-monitor', '--address', self.dbus_address])
 =

 	def start_haveged(self):
-		self.start_process(['haveged'], multi_test=3DTrue)
+		self.start_process(['haveged'])
 =

 	def create_radios(self):
 		setup =3D self.hw_config['SETUP']
@@ -1085,6 +1076,8 @@ def pre_test(ctx, test, copied):
 =

 		subtests =3D pruned
 =

+	ctx.start_dbus()
+	ctx.start_haveged()
 	ctx.start_dbus_monitor()
 	ctx.start_radios()
 	ctx.create_namespaces()
@@ -1177,9 +1170,6 @@ def print_results(results):
 def run_auto_tests(ctx, args):
 	tests =3D build_test_list(args)
 =

-	ctx.start_dbus(multi_test=3DTrue)
-	ctx.start_haveged()
-
 	# Copy autotests/misc/{certs,secrets,phonesim} so any test can refer to t=
hem
 	shutil.copytree(args.testhome + '/autotests/misc/certs', '/tmp/certs')
 	shutil.copytree(args.testhome + '/autotests/misc/secrets', '/tmp/secrets')
-- =

2.26.2

--===============3309714922814495541==--

