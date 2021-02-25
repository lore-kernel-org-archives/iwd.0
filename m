Content-Type: multipart/mixed; boundary="===============4269445401154166297=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 12/17] test-runner: reset namespaces on test completion
Date: Thu, 25 Feb 2021 14:01:01 -0800
Message-ID: <20210225220106.1728411-12-prestwoj@gmail.com>
In-Reply-To: <20210225220106.1728411-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4269445401154166297==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 tools/test-runner | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/test-runner b/tools/test-runner
index fccb6233..80bdae30 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -913,6 +913,9 @@ class TestContext(Namespace):
 		return None
 =

 	def stop_test_processes(self):
+		for n in self.namespaces:
+			n.reset()
+
 		self.namespaces =3D []
 		self.hostapd =3D None
 		self.wpas_interfaces =3D None
-- =

2.26.2

--===============4269445401154166297==--

