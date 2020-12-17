Content-Type: multipart/mixed; boundary="===============8503945104262402217=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 06/11] test-runner: add wait_for_dbus_service
Date: Thu, 17 Dec 2020 11:36:06 -0800
Message-ID: <20201217193611.1177006-6-prestwoj@gmail.com>
In-Reply-To: <20201217193611.1177006-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8503945104262402217==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Common API to wait for a DBus service to appear on the bus
---
 tools/test-runner | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/test-runner b/tools/test-runner
index bc580a41..d16c8885 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -616,6 +616,15 @@ class Namespace:
 =

 		return False
 =

+	def wait_for_dbus_service(self, service):
+		tries =3D 0
+
+		while not self._bus.name_has_owner(service):
+			if tries > 200:
+				raise TimeoutError('DBus service %s did not appear', service)
+			tries +=3D 1
+			sleep(0.1)
+
 	def __str__(self):
 		ret =3D 'Namespace: %s\n' % self.name
 		ret +=3D 'Processes:\n'
-- =

2.26.2

--===============8503945104262402217==--

