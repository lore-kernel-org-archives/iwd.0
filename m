Content-Type: multipart/mixed; boundary="===============8847542808713466270=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/6] test-runner: implement non_block_wait
Date: Fri, 13 Aug 2021 09:24:35 -0700
Message-ID: <20210813162440.793847-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8847542808713466270==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There was a common bit of code all over test-runner and utilities
which would wait for 'something' in a loop. At best these loops
would do the right thing and use the GLib.iteration call as to not
block the main loop, and at worst would not use it and just busy
wait.

Namespace.non_block_wait unifies all these into a single API to
a) do the wait correctly and b) prevent duplicate code.
---
 tools/test-runner | 80 ++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 65 insertions(+), 15 deletions(-)

diff --git a/tools/test-runner b/tools/test-runner
index 87f6ec6d..22e9066f 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -233,7 +233,7 @@ class Process:
 		if not wait and not check:
 			return
 =

-		self.pid.wait(timeout=3D5)
+		Namespace.non_block_wait(self.wait_for_process, 10, 1)
 		self.killed =3D True
 		self.ret =3D self.pid.returncode
 =

@@ -245,6 +245,13 @@ class Process:
 		if check and self.ret !=3D 0:
 			raise subprocess.CalledProcessError(returncode=3Dself.ret, cmd=3Dself.a=
rgs)
 =

+	def wait_for_process(self, timeout):
+		try:
+			self.pid.wait(timeout)
+			return True
+		except:
+			return False
+
 	def process_io(self, source):
 		data =3D source.read()
 =

@@ -312,12 +319,7 @@ class Process:
 		self.killed =3D True
 =

 	def wait_for_socket(self, socket, wait):
-		waited =3D 0
-		while not os.path.exists(socket):
-			sleep(0.5)
-			waited +=3D 0.5
-			if waited > wait:
-				raise Exception("Timed out waiting for socket")
+		Namespace.non_block_wait(os.path.exists, wait, socket)
 =

 	def __str__(self):
 		return str(self.args) + '\n'
@@ -641,7 +643,7 @@ class Namespace:
 		p =3D self.start_process(['dbus-daemon', '--config-file=3D%s' % self.dbu=
s_cfg],
 					wait=3DFalse, cleanup=3Dself._cleanup_dbus)
 =

-		p.wait_for_socket(self.dbus_address.split('=3D')[1], wait=3D5)
+		p.wait_for_socket(self.dbus_address.split('=3D')[1], 5)
 =

 		self._bus =3D dbus.bus.BusConnection(address_or_type=3Dself.dbus_address)
 =

@@ -699,15 +701,62 @@ class Namespace:
 =

 		return False
 =

-	def wait_for_dbus_service(self, service):
-		tries =3D 0
+	@staticmethod
+	def non_block_wait(func, timeout, *args, exception=3DTrue):
+		'''
+			Convenience function for waiting in a non blocking
+			manor using GLibs context iteration i.e. does not block
+			the main loop while waiting.
+
+			'func' will be called at least once and repeatedly until
+			either it returns success, throws an exception, or the
+			'timeout' expires.
+
+			'timeout' is the ultimate timeout in seconds
+
+			'*args' will be passed to 'func'
+
+			If 'exception' is an Exception type it will be raised.
+			If 'exception' is True a generic TimeoutError will be raised.
+			Any other value will not result in an exception.
+		'''
+		# Simple class for signaling the wait timeout
+		class Bool:
+			def __init__(self, value):
+				self.value =3D value
+
+		def wait_timeout_cb(done):
+			done.value =3D True
+			return False
+
+		mainloop =3D GLib.MainLoop()
+		done =3D Bool(False)
+
+		timeout =3D GLib.timeout_add_seconds(timeout, wait_timeout_cb, done)
+		context =3D mainloop.get_context()
+
+		while True:
+			context.iteration(may_block=3DFalse)
+
+			try:
+				ret =3D func(*args)
+				if ret:
+					GLib.source_remove(timeout)
+					return ret
+			except Exception as e:
+				GLib.source_remove(timeout)
+				raise e
 =

-		while not self._bus.name_has_owner(service):
-			if tries > 200:
-				raise TimeoutError('DBus service %s did not appear', service)
-			tries +=3D 1
 			sleep(0.1)
 =

+			if done.value =3D=3D True:
+				if isinstance(exception, Exception):
+					raise exception
+				elif type(exception) =3D=3D bool and exception:
+					raise TimeoutError("Timeout on non_block_wait")
+				else:
+					return
+
 	def __str__(self):
 		ret =3D 'Namespace: %s\n' % self.name
 		ret +=3D 'Processes:\n'
@@ -765,7 +814,8 @@ class TestContext(Namespace):
 			args.extend(['--no-register'])
 =

 		self.start_process(args)
-		self.wait_for_dbus_service('net.connman.hwsim')
+		self.non_block_wait(self._bus.name_has_owner, 20, 'net.connman.hwsim',
+					exception=3DTimeoutError('net.connman.hwsim did not appear'))
 =

 		for i in range(nradios):
 			name =3D 'rad%u' % i
-- =

2.31.1

--===============8847542808713466270==--

