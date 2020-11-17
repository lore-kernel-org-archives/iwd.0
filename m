Content-Type: multipart/mixed; boundary="===============0914796812361883496=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/4] test-runner: introduce network namespaces
Date: Tue, 17 Nov 2020 12:53:01 -0800
Message-ID: <20201117205304.3542997-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0914796812361883496==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Our simulated environment was really only meant to test air-to-air
communication by using mac80211_hwsim. Protocols like DHCP use IP
communication which starts to fall apart when using hwsim radios.
Mainly unicast sockets do not work since there is no underlying
network infrastructure.

In order to simulate a more realistic environment network namespaces
are introduced in this patch. This allows wireless phy's to be added
to a network namespace and unique IWD instances manage those phys.
This is done automatically when 'NameSpaces' entries are configured
in hw.conf:

[SETUP]
num_radios=3D2

[NameSpaces]
ns0=3Drad1,...

This will create a namespace named ns0, and add rad1 to that
namespace. rad1 will not appear as a phy in what's being called the
'root' namespace (the default namespace).

As far as a test is concerned you can create a new IWD() class and
pass the namespace in. This will start a new IWD instance in that
namespace:

ns0 =3D ctx.get_namespace('ns0')
wd_ns0 =3D IWD(start_iwd=3DTrue, namespace=3Dns0)

'wd_ns0' can now be used to interact with IWD in that namespace, just
like any other IWD class object.
---
 tools/test-runner | 298 ++++++++++++++++++++++++++++++----------------
 1 file changed, 196 insertions(+), 102 deletions(-)

diff --git a/tools/test-runner b/tools/test-runner
index 803d4da5..3a9cfce2 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -126,6 +126,9 @@ dev_table =3D [
 	DevInfo('/proc/self/fd/2', '/dev/stderr')
 ]
 =

+# Partial DBus config. The remainder (<listen>) will be filled in for each
+# namespace that is created so each individual dbus-daemon has its own soc=
ket
+# and address.
 dbus_config =3D '''
 <!DOCTYPE busconfig PUBLIC \
 "-//freedesktop//DTD D-Bus Bus Configuration 1.0//EN" \
@@ -133,7 +136,6 @@ dbus_config =3D '''
 busconfig.dtd\">
 <busconfig>
 <type>system</type>
-<listen>unix:path=3D/run/dbus/system_bus_socket</listen>
 <limit name=3D\"reply_timeout\">2147483647</limit>
 <auth>ANONYMOUS</auth>
 <allow_anonymous/>
@@ -151,7 +153,6 @@ busconfig.dtd\">
 <allow send_destination=3D\"*\" eavesdrop=3D\"true\"/>
 <allow eavesdrop=3D\"true\"/>
 </policy>
-</busconfig>
 '''
 class Process:
 	'''
@@ -162,7 +163,7 @@ class Process:
 		test exits.
 	'''
 	def __init__(self, args, wait=3DFalse, multi_test=3DFalse, env=3DNone, ct=
x=3DNone, check=3DFalse,
-				outfile=3DNone):
+				outfile=3DNone, namespace=3DNone):
 		self.args =3D args
 		self.wait =3D wait
 		self.name =3D args[0]
@@ -172,6 +173,10 @@ class Process:
 		self.ret =3D None
 		self.ctx =3D ctx
 =

+		if namespace:
+			self.args =3D ['ip', 'netns', 'exec', namespace]
+			self.args.extend(args)
+
 		if ctx:
 			set_stdout =3D False
 =

@@ -209,7 +214,6 @@ class Process:
 					self.stdout =3D sys.__stdout__
 					self.stderr =3D sys.__stderr__
 =

-
 		self.pid =3D subprocess.Popen(self.args, stdout=3Dself.stdout, \
 							stderr=3Dself.stderr, env=3Denv, \
 							cwd=3Dos.getcwd())
@@ -233,9 +237,8 @@ class Process:
 =

 	def __del__(self):
 		print("Del process %s" % self.args)
-		if self.ctx and self.ctx.args.log:
-			self.stdout.close()
-			self.stderr.close()
+		self.stdout =3D None
+		self.stderr =3D None
 =

 	def kill(self, force=3DFalse):
 		print("Killing process %s" % self.args)
@@ -469,12 +472,172 @@ class Hostapd:
 		self.instances =3D None
 		self.process.kill()
 =

-class TestContext:
+dbus_count =3D 0
+
+class Namespace:
+	dbus_address =3D None
+	processes =3D []
+	radios =3D []
+
+	def __init__(self, args, name, radios):
+		self.name =3D name
+		self.radios =3D radios
+		self.args =3D args
+
+		Process(['ip', 'netns', 'add', name], wait=3DTrue)
+		for r in radios:
+			Process(['iw', 'phy', r.name, 'set', 'netns', 'name', name], wait=3DTru=
e)
+
+		self.start_dbus(multi_test=3DFalse)
+
+	def reset(self):
+		self.radios =3D []
+		self._bus =3D None
+
+		if self.name =3D=3D "root":
+			self._bus =3D dbus.bus.BusConnection(address_or_type=3Dself.dbus_addres=
s)
+
+		for p in [p for p in self.processes if p.multi_test is False]:
+			print("Killing process %s" % p.name)
+			self.stop_process(p)
+
+	def __del__(self):
+		print("Removing namespace %s" % self.name)
+		self.reset()
+
+		Process(['ip', 'netns', 'del', self.name], wait=3DTrue)
+
+	def get_bus(self):
+		return self._bus
+
+	def start_process(self, args, env=3DNone, **kwargs):
+		# Special case for 'root' namespace (aka TestContext)
+		if self.name =3D=3D "root":
+			ns =3D None
+		else:
+			ns =3D self.name
+
+		if not env:
+			env =3D os.environ.copy()
+
+		# In case this process needs DBus...
+		env['DBUS_SYSTEM_BUS_ADDRESS'] =3D self.dbus_address
+
+		p =3D Process(args, ctx=3Dself, namespace=3Dns, env=3Denv, **kwargs)
+
+		if not kwargs.get('wait', False):
+			self.processes.append(p)
+
+		return p
+
+	def stop_process(self, p, force=3DFalse):
+		p.kill(force)
+		self.processes.remove(p)
+
+	def is_process_running(self, process):
+		for p in self.processes:
+			if p.name =3D=3D process:
+				return True
+		return False
+
+	def start_dbus(self, multi_test=3DTrue):
+		global dbus_count
+
+		self.dbus_address =3D 'unix:path=3D/tmp/dbus%d' % dbus_count
+		dbus_cfg =3D '/tmp/dbus%d.conf' % dbus_count
+		dbus_count +=3D 1
+
+		with open(dbus_cfg, 'w+') as f:
+			f.write(dbus_config)
+			f.write('<listen>%s</listen>\n' % self.dbus_address)
+			f.write('</busconfig>\n')
+
+		p =3D self.start_process(['dbus-daemon', '--config-file=3D%s' % dbus_cfg=
],
+					wait=3DFalse, multi_test=3Dmulti_test)
+
+		p.wait_for_socket(self.dbus_address.split('=3D')[1], wait=3D5)
+
+		self._bus =3D dbus.bus.BusConnection(address_or_type=3Dself.dbus_address)
+
+	def start_iwd(self, config_dir =3D '/tmp'):
+		args =3D []
+		iwd_radios =3D ','.join([r.name for r in self.radios if r.use =3D=3D 'iw=
d'])
+
+		if self.args.valgrind:
+			args.extend(['valgrind', '--leak-check=3Dfull', '--track-origins=3Dyes',
+						'--log-file=3D/tmp/valgrind.log'])
+
+		args.extend(['iwd', '-p', iwd_radios])
+
+		if self.is_verbose(args[0]):
+			args.append('-d')
+
+		env =3D os.environ.copy()
+
+		env['CONFIGURATION_DIRECTORY'] =3D config_dir
+		env['STATE_DIRECTORY'] =3D '/tmp/iwd'
+
+		if self.is_verbose('iwd-dhcp'):
+			env['IWD_DHCP_DEBUG'] =3D '1'
+
+		if self.is_verbose('iwd-tls'):
+			env['IWD_TLS_DEBUG'] =3D '1'
+
+		if self.is_verbose('iwd-genl'):
+			env['IWD_GENL_DEBUG'] =3D '1'
+
+		pid =3D self.start_process(args, env=3Denv)
+		return pid
+
+	def is_verbose(self, process):
+		process =3D os.path.basename(process)
+
+		if self.args is None:
+			return False
+
+		# every process is verbose when logging is enabled
+		if self.args.log:
+			return True
+
+		if process in self.args.verbose:
+			return True
+
+		# Special case here to enable verbose output with valgrind running
+		if process =3D=3D 'valgrind' and 'iwd' in self.args.verbose:
+			return True
+
+		# Handle any glob matches
+		for item in self.args.verbose:
+			if process in glob(item):
+				return True
+
+		return False
+
+	def __str__(self):
+		ret =3D 'Namespace: %s\n' % self.name
+		ret +=3D 'Processes:\n'
+		for p in self.processes:
+			ret +=3D '\t%s\n' % str(p.args)
+
+		ret +=3D 'Radios:\n'
+		if len(self.radios) > 0:
+			for r in self.radios:
+				ret +=3D '\t%s\n' % str(r)
+		else:
+			ret +=3D '\tNo Radios\n'
+
+		ret +=3D 'DBus Address: %s\n' % self.dbus_address
+		ret +=3D '=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D\n\n'
+
+		return ret
+
+class TestContext(Namespace):
 	'''
 		Contains all information for a given set of tests being run
 		such as processes, radios, interfaces and test results.
 	'''
 	def __init__(self, args):
+		self.name =3D "root"
 		self.processes =3D []
 		self.args =3D args
 		self.hw_config =3D None
@@ -484,31 +647,15 @@ class TestContext:
 		self.cur_iface_id =3D 0
 		self.radios =3D []
 		self.loopback_started =3D False
-		self.iwd_extra_options =3D None
 		self.results =3D {}
 		self.mainloop =3D GLib.MainLoop()
-
-	def start_process(self, args, **kwargs):
-		p =3D Process(args, ctx=3Dself, **kwargs)
-
-		if not kwargs.get('wait', False):
-			self.processes.append(p)
-
-		return p
-
-	def start_dbus(self):
-		with open('/usr/share/dbus-1/system.conf', 'w+') as f:
-			f.write(dbus_config)
-
-		os.mkdir('/run/dbus', 755)
-
-		self.start_process(['dbus-daemon', '--system', '--nosyslog'], multi_test=
=3DTrue)
+		self.namespaces =3D []
 =

 	def start_dbus_monitor(self):
 		if not self.is_verbose('dbus-monitor'):
 			return
 =

-		self.start_process(['dbus-monitor', '--system'])
+		self.start_process(['dbus-monitor', '--address', self.dbus_address])
 =

 	def start_haveged(self):
 		self.start_process(['haveged'], multi_test=3DTrue)
@@ -561,38 +708,6 @@ class TestContext:
 		else:
 			self.create_radios()
 =

-	def start_iwd(self, config_dir =3D '/tmp'):
-		args =3D []
-		iwd_radios =3D ','.join([r.name for r in self.radios if r.use =3D=3D 'iw=
d'])
-
-		if self.args.valgrind:
-			args.extend(['valgrind', '--leak-check=3Dfull', '--track-origins=3Dyes',
-						'--log-file=3D/tmp/valgrind.log'])
-
-		args.extend(['iwd', '-p', iwd_radios])
-
-		if self.is_verbose(args[0]):
-			args.append('-d')
-
-		if self.iwd_extra_options:
-			args.append(self.iwd_extra_options)
-
-		env =3D os.environ.copy()
-		env['CONFIGURATION_DIRECTORY'] =3D config_dir
-		env['STATE_DIRECTORY'] =3D '/tmp/iwd'
-
-		if self.is_verbose('iwd-dhcp'):
-			env['IWD_DHCP_DEBUG'] =3D '1'
-
-		if self.is_verbose('iwd-tls'):
-			env['IWD_TLS_DEBUG'] =3D '1'
-
-		if self.is_verbose('iwd-genl'):
-			env['IWD_GENL_DEBUG'] =3D '1'
-
-		pid =3D self.start_process(args, env=3Denv)
-		return pid
-
 	def start_hostapd(self):
 		if not 'HOSTAPD' in self.hw_config:
 			return
@@ -677,66 +792,39 @@ class TestContext:
 =

 		print("Ofono started")
 =

-	def is_verbose(self, process):
-		process =3D os.path.basename(process)
+	def create_namespaces(self):
+		if not self.hw_config.has_section('NameSpaces'):
+			return
 =

-		if self.args is None:
-			return False
+		for key, value in self.hw_config.items('NameSpaces'):
+			radio_names =3D value.split(',')
+			# Gather up radio objects for this namespace
+			radios =3D [rad for rad in self.radios if rad.name in radio_names]
 =

-		# every process is verbose when logging is enabled
-		if self.args.log:
-			return True
+			# Remove radios from 'root' namespace
+			self.radios =3D list(set(self.radios) - set(radios))
 =

-		if process in self.args.verbose:
-			return True
+			self.namespaces.append(Namespace(self.args, key, radios))
 =

-		# Special case here to enable verbose output with valgrind running
-		if process =3D=3D 'valgrind' and 'iwd' in self.args.verbose:
-			return True
-
-		# Handle any glob matches
-		for item in self.args.verbose:
-			if process in glob(item):
-				return True
-
-		return False
+	def get_namespace(self, ns):
+		for n in self.namespaces:
+			if n.name =3D=3D ns:
+				return n
 =

-	def stop_process(self, p, force=3DFalse):
-		p.kill(force)
-		self.processes.remove(p)
+		return None
 =

 	def stop_test_processes(self):
-		self.radios =3D []
+		self.namespaces =3D []
 		self.hostapd =3D None
 		self.wpas_interfaces =3D None
-		self.iwd_extra_options =3D None
 =

-		for p in [p for p in self.processes if p.multi_test is False]:
-			print("Killing process %s" % p.name)
-			self.stop_process(p)
-
-	def is_process_running(self, process):
-		for p in self.processes:
-			if p.name =3D=3D process:
-				return True
-		return False
+		self.reset()
 =

 	def __str__(self):
 		ret =3D 'Arguments:\n'
 		for arg in vars(self.args):
 			ret +=3D '\t --%s %s\n' % (arg, str(getattr(self.args, arg)))
 =

-		ret +=3D 'Processes:\n'
-		for p in self.processes:
-			ret +=3D '\t%s\n' % str(p.args)
-
-		ret +=3D 'Radios:\n'
-		if len(self.radios) > 0:
-			for r in self.radios:
-				ret +=3D '\t%s\n' % str(r)
-		else:
-			ret +=3D '\tNo Radios\n'
-
 		ret +=3D 'Hostapd:\n'
 		if self.hostapd:
 			for h in self.hostapd.instances:
@@ -744,6 +832,11 @@ class TestContext:
 		else:
 			ret +=3D '\tNo Hostapd instances\n'
 =

+		ret +=3D super().__str__()
+
+		for n in self.namespaces:
+			ret +=3D n.__str__()
+
 		return ret
 =

 def prepare_sandbox():
@@ -921,6 +1014,7 @@ def pre_test(ctx, test):
 =

 	ctx.start_dbus_monitor()
 	ctx.start_radios()
+	ctx.create_namespaces()
 	ctx.start_hostapd()
 	ctx.start_wpas_interfaces()
 	ctx.start_ofono()
-- =

2.26.2

--===============0914796812361883496==--

