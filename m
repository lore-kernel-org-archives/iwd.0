Content-Type: multipart/mixed; boundary="===============9222669873967922235=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 5/6] test-runner: allow EAD-based autotests
Date: Thu, 17 Sep 2020 14:32:46 -0700
Message-ID: <20200917213247.788181-5-prestwoj@gmail.com>
In-Reply-To: <20200917213247.788181-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============9222669873967922235==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The virtual environment changed slightly adding two network adatpers
which are connected to the same backend so they can communicate with
each other (basically connected to a switch). The hostapd command
line was modified to allow no interfaces to be passed in which lets
us create zero radios but still specify a radius_config file.
---
 tools/test-runner | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/tools/test-runner b/tools/test-runner
index a320a3f0..6443af15 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -113,6 +113,7 @@ mount_table =3D [
 	MountInfo('tmpfs', '/dev/shm', 'mode=3D1777', MS_NOSUID|MS_NODEV|MS_STRIC=
TATIME),
 	MountInfo('tmpfs', '/run', 'mode=3D0755', MS_NOSUID|MS_NODEV|MS_STRICTATI=
ME),
 	MountInfo('tmpfs', '/var/lib/iwd', 'mode=3D0755', 0),
+	MountInfo('tmpfs', '/var/lib/ead', 'mode=3D0755', 0),
 	MountInfo('tmpfs', '/tmp', '', 0),
 	MountInfo('tmpfs', '/usr/share/dbus-1', 'mode=3D0755', MS_NOSUID|MS_NOEXE=
C|MS_NODEV|MS_STRICTATIME),
 	MountInfo('debugfs', '/sys/kernel/debug', '', 0)
@@ -377,6 +378,9 @@ class Hostapd:
 =

 		print("Initializing hostapd instances")
 =

+		ctx.start_process(['ip', 'link', 'set', 'eth0', 'up'], wait=3DTrue)
+		ctx.start_process(['ip', 'link', 'set', 'eth1', 'up'], wait=3DTrue)
+
 		self.global_ctrl_iface =3D '/var/run/hostapd/ctrl'
 =

 		self.instances =3D [HostapdInstance(c, r) for c, r in zip(configs, radio=
s)]
@@ -384,7 +388,10 @@ class Hostapd:
 		ifaces =3D [rad.interface.name for rad in radios]
 		ifaces =3D ','.join(ifaces)
 =

-		args =3D ['hostapd', '-i', ifaces, '-g', self.global_ctrl_iface]
+		args =3D ['hostapd', '-g', self.global_ctrl_iface]
+
+		if ifaces:
+			args.extend(['-i', ifaces])
 =

 		#
 		# Config files should already be present in /tmp. This appends
@@ -1034,6 +1041,7 @@ def run_tests():
 	os.environ['PATH'] =3D '%s/src' % args.testhome
 	os.environ['PATH'] +=3D ':%s/tools' % args.testhome
 	os.environ['PATH'] +=3D ':%s/client' % args.testhome
+	os.environ['PATH'] +=3D ':%s/wired' % args.testhome
 	os.environ['PATH'] +=3D ':' + args.path
 =

 	sys.path.append(args.testhome + '/autotests/util')
@@ -1219,7 +1227,7 @@ class Main:
 			'-machine', 'type=3Dq35,accel=3Dkvm:tcg',
 			'-nodefaults', '-no-user-config', '-monitor', 'none',
 			'-display', 'none', '-m', '192M', '-nographic', '-vga',
-			'none', '-net', 'none', '-no-acpi', '-no-hpet',
+			'none', '-no-acpi', '-no-hpet',
 			'-no-reboot', '-fsdev',
 			'local,id=3Dfsdev-root,path=3D/,readonly,security_model=3Dnone,multidev=
s=3Dremap',
 			'-device',
@@ -1238,6 +1246,13 @@ class Main:
 			'-cpu', 'host'
 		]
 =

+		# Add two ethernet devices for testing EAD
+		qemu_cmdline.extend([
+				'-net', 'nic,model=3Dvirtio',
+				'-net', 'nic,model=3Dvirtio',
+				'-net', 'user'
+		])
+
 		if usb_adapters:
 			for bus, addr in [s.split(',') for s in usb_adapters]:
 				qemu_cmdline.extend(['-usb',
-- =

2.26.2

--===============9222669873967922235==--

