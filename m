Content-Type: multipart/mixed; boundary="===============7869628278963465649=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 10/17] test-runner: add better Hostapd cleanup
Date: Thu, 25 Feb 2021 14:00:59 -0800
Message-ID: <20210225220106.1728411-10-prestwoj@gmail.com>
In-Reply-To: <20210225220106.1728411-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7869628278963465649==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There were a few issues with the cleanup of Hostapd. First the
process was only being killed, which did not actually remove
the process from the list.

In addition, with EAP-SIM/AKA tests, hostapd created sim_db
unix socket files which it does not clean up.
---
 tools/test-runner | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/tools/test-runner b/tools/test-runner
index 62c4bd75..f6d7784d 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -449,6 +449,8 @@ class Hostapd:
 		process since hostapd can be started with multiple config files.
 	'''
 	def __init__(self, ctx, radios, configs, radius):
+		self.ctx =3D ctx
+
 		if len(configs) !=3D len(radios):
 			raise Exception("Config (%d) and radio (%d) list length not equal" % \
 						(len(configs), len(radios)))
@@ -531,7 +533,17 @@ class Hostapd:
 			dbg("Failed to remove %s" % self.global_ctrl_iface)
 =

 		self.instances =3D None
-		self.process.kill()
+
+		# Hostapd may have already been stopped
+		if self.process:
+			self.ctx.stop_process(self.process)
+
+		self.ctx =3D None
+
+		# Hostapd creates simdb sockets for EAP-SIM/AKA tests but does not
+		# clean them up.
+		for f in glob("/tmp/eap_sim_db*"):
+			os.remove(f)
 =

 dbus_count =3D 0
 =

-- =

2.26.2

--===============7869628278963465649==--

