Content-Type: multipart/mixed; boundary="===============3875848828665454051=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 5/6] test-runner: start dmesg early with --follow
Date: Fri, 13 Aug 2021 13:26:11 -0700
Message-ID: <20210813202612.809470-5-prestwoj@gmail.com>
In-Reply-To: <20210813202612.809470-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3875848828665454051==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

dmesg was being called at the very end of testing and dumped into
a log file. If many tests were run this could take quite a long
time and was timing out the default process wait. Instead --follow
can be used (basically like 'tail') which prints messages as they
come and avoids the time consuming full dump at the end.
---
 tools/test-runner | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/test-runner b/tools/test-runner
index 90a5f87a..5b8bdaf5 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -604,8 +604,9 @@ class Namespace:
 		if not env:
 			env =3D os.environ.copy()
 =

-		# In case this process needs DBus...
-		env['DBUS_SYSTEM_BUS_ADDRESS'] =3D self.dbus_address
+		if hasattr(self, "dbus_address"):
+			# In case this process needs DBus...
+			env['DBUS_SYSTEM_BUS_ADDRESS'] =3D self.dbus_address
 =

 		p =3D Process(args, ctx=3Dself, namespace=3Dns, env=3Denv, **kwargs)
 =

@@ -1403,10 +1404,6 @@ def run_auto_tests(ctx, args):
 	shutil.rmtree('/tmp/secrets')
 	os.remove('/tmp/phonesim.conf')
 =

-	# Write out kernel log
-	if ctx.args.log:
-		ctx.start_process(["dmesg"], wait=3DTrue)
-
 def run_unit_tests(ctx, args):
 	os.chdir(args.testhome + '/unit')
 	units =3D build_unit_list(args)
@@ -1484,6 +1481,9 @@ def run_tests():
 				shutil.rmtree(f)
 			else:
 				os.remove(f)
+
+		# Start writing out kernel log
+		config.ctx.start_process(["dmesg", '--follow'])
 	elif args.monitor:
 		parent =3D os.path.abspath(os.path.join(args.monitor, os.pardir))
 		mount('mondir', parent, '9p', 0, 'trans=3Dvirtio,version=3D9p2000.L,msiz=
e=3D10240')
-- =

2.31.1

--===============3875848828665454051==--

