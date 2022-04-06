Content-Type: multipart/mixed; boundary="===============1097513663042991915=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 05/10] test-runner: move BarChart into utils.py
Date: Wed, 06 Apr 2022 12:14:48 -0700
Message-ID: <20220406191453.978426-5-prestwoj@gmail.com>
In-Reply-To: 20220406191453.978426-1-prestwoj@gmail.com

--===============1097513663042991915==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 tools/run-tests | 43 +------------------------------------------
 tools/utils.py  | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 42 deletions(-)

diff --git a/tools/run-tests b/tools/run-tests
index 92ba324a..c4013258 100755
--- a/tools/run-tests
+++ b/tools/run-tests
@@ -22,7 +22,7 @@ import dbus.mainloop.glib
 from gi.repository import GLib
 =

 from runner import Runner
-from utils import Process, Namespace
+from utils import Process, Namespace, BarChart
 =

 config =3D None
 intf_id =3D 0
@@ -291,47 +291,6 @@ class Hostapd:
 		for f in glob("/tmp/eap_sim_db*"):
 			os.remove(f)
 =

-class BarChart():
-	def __init__(self, height=3D10, max_width=3D80):
-		self._height =3D height
-		self._max_width =3D max_width
-		self._values =3D []
-		self._max_value =3D 0
-		self._min_value =3D 0
-
-	def add_value(self, value):
-		if len(self._values) =3D=3D 0:
-			self._max_value =3D int(1.01 * value)
-			self._min_value =3D int(0.99 * value)
-		elif value > self._max_value:
-			self._max_value =3D int(1.01 * value)
-		elif value < self._min_value:
-			self._min_value =3D int(0.99 * value)
-
-		self._values.append(value)
-
-	def _value_to_stars(self, value):
-		# Need to scale value (range of min_value -> max_value) to
-		# a range of 0 -> height
-		#
-		# Scaled =3D ((value - min_value) / ( max_value - min_value)) * (Height =
- 0) + 0
-
-		return int(((value - self._min_value) /
-			(self._max_value - self._min_value)) * self._height)
-
-	def __str__(self):
-		# Need to map value from range 0 - self._height
-		ret =3D ''
-
-		for i, value in enumerate(self._values):
-			stars =3D self._value_to_stars(value)
-			ret +=3D '[%3u] ' % i + '%-10s' % ('*' * stars) + '\t\t\t%d\n' % value
-
-		ret +=3D '\n'
-
-		return ret
-
-
 class TestContext(Namespace):
 	'''
 		Contains all information for a given set of tests being run
diff --git a/tools/utils.py b/tools/utils.py
index 4c71e934..c2478ff2 100644
--- a/tools/utils.py
+++ b/tools/utils.py
@@ -453,3 +453,43 @@ class Namespace:
 		ret +=3D '=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D\n\n'
 =

 		return ret
+
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
-- =

2.34.1

--===============1097513663042991915==--

