Content-Type: multipart/mixed; boundary="===============0980034365879639085=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/6] test-runner: wait for individual hostapd control sockets
Date: Fri, 13 Aug 2021 09:24:36 -0700
Message-ID: <20210813162440.793847-2-prestwoj@gmail.com>
In-Reply-To: <20210813162440.793847-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0980034365879639085==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 tools/test-runner | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/test-runner b/tools/test-runner
index 22e9066f..90a5f87a 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -497,6 +497,9 @@ class Hostapd:
 =

 		self.process.wait_for_socket(self.global_ctrl_iface, 30)
 =

+		for hapd in self.instances:
+			self.process.wait_for_socket(hapd.intf.ctrl_interface, 30)
+
 	def attach_cli(self):
 		for hapd in self.instances:
 			hapd.cli =3D importlib.import_module('hostapd').HostapdCLI(config=3Dhap=
d.config)
-- =

2.31.1

--===============0980034365879639085==--

