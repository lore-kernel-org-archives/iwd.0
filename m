Content-Type: multipart/mixed; boundary="===============7718310229189425638=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v4 01/13] test-runner: add memory usage for debugging
Date: Mon, 28 Mar 2022 10:28:30 -0700
Message-ID: <20220328172842.1660272-2-prestwoj@gmail.com>
In-Reply-To: 20220328172842.1660272-1-prestwoj@gmail.com

--===============7718310229189425638==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In debug mode the test context is printed before each test. This
adds some additional information in there:

Available Memory: /proc/meminfo: MemAvailable
Last Test Delta: Change in usage between current and last test
Per-test Usage: Graph of usage relative to all past tests. This is
                useful for seeing a trend down/up of usage.
---
 tools/test-runner | 78 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 77 insertions(+), 1 deletion(-)

diff --git a/tools/test-runner b/tools/test-runner
index b0ec87a2..73a2cf61 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -807,6 +807,47 @@ class Namespace:
 =

 		return ret
 =

+class BarChart():
+	def __init__(self, height=3D10, max_width=3D80):
+		self._height =3D height
+		self._max_width =3D max_width
+		self._values =3D []
+		self._max_value =3D 0
+		self._min_value =3D 0
+
+	def add_value(self, value):
+		if len(self._values) =3D=3D 0:
+			self._max_value =3D int(1.01 * value)
+			self._min_value =3D int(0.99 * value)
+		elif value > self._max_value:
+			self._max_value =3D int(1.01 * value)
+		elif value < self._min_value:
+			self._min_value =3D int(0.99 * value)
+
+		self._values.append(value)
+
+	def _value_to_stars(self, value):
+		# Need to scale value (range of min_value -> max_value) to
+		# a range of 0 -> height
+		#
+		# Scaled =3D ((value - min_value) / ( max_value - min_value)) * (Height =
- 0) + 0
+
+		return int(((value - self._min_value) /
+			(self._max_value - self._min_value)) * self._height)
+
+	def __str__(self):
+		# Need to map value from range 0 - self._height
+		ret =3D ''
+
+		for i, value in enumerate(self._values):
+			stars =3D self._value_to_stars(value)
+			ret +=3D '[%3u] ' % i + '%-10s' % ('*' * stars) + '\t\t\t%d\n' % value
+
+		ret +=3D '\n'
+
+		return ret
+
+
 class TestContext(Namespace):
 	'''
 		Contains all information for a given set of tests being run
@@ -825,6 +866,8 @@ class TestContext(Namespace):
 		self.results =3D {}
 		self.mainloop =3D GLib.MainLoop()
 		self.namespaces =3D []
+		self._last_mem_available =3D 0
+		self._mem_chart =3D BarChart()
 =

 	def start_dbus_monitor(self):
 		if not self.is_verbose('dbus-monitor'):
@@ -1036,6 +1079,23 @@ class TestContext(Namespace):
 =

 		self.reset()
 =

+	def meminfo_to_dict(self):
+		def removesuffix(string, suffix):
+			if string.endswith(suffix):
+				return string[:-len(suffix)]
+			return string
+
+		ret =3D {}
+
+		with open('/proc/meminfo', 'r') as f:
+			data =3D f.read().strip().split('\n')
+
+		for l in data:
+			entry =3D l.split(':')
+			ret[entry[0]] =3D int(removesuffix(entry[1], 'kB'))
+
+		return ret
+
 	def __str__(self):
 		ret =3D 'Arguments:\n'
 		for arg in vars(self.args):
@@ -1048,6 +1108,16 @@ class TestContext(Namespace):
 		else:
 			ret +=3D '\tNo Hostapd instances\n'
 =

+		info =3D self.meminfo_to_dict()
+		self._mem_chart.add_value(info['MemAvailable'])
+
+		ret +=3D 'Available Memory: %u kB\n' % info['MemAvailable']
+		ret +=3D 'Last Test Delta: %+d kB\n' % (info['MemAvailable'] - self._las=
t_mem_available)
+		ret +=3D 'Per-test Usage:\n'
+		ret +=3D str(self._mem_chart)
+
+		self._last_mem_available =3D info['MemAvailable']
+
 		ret +=3D super().__str__()
 =

 		for n in self.namespaces:
@@ -1171,7 +1241,13 @@ def start_test(ctx, subtests, rqueue):
 	#
 	for s in subtests:
 		loader =3D unittest.TestLoader()
-		module =3D importlib.import_module(os.path.splitext(s)[0])
+		try:
+			module =3D importlib.import_module(os.path.splitext(s)[0])
+		except OSError as e:
+			dbg(subprocess.check_output("dmesg | tail -80", shell=3DTrue).decode('u=
tf-8'))
+			print(ctx)
+			raise e
+
 		subtest =3D loader.loadTestsFromModule(module)
 =

 		# The test suite is being (ab)used to get a bit more granularity
-- =

2.34.1

--===============7718310229189425638==--

