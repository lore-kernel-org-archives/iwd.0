Content-Type: multipart/mixed; boundary="===============5086226110855285568=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 1/3] test-runner: add support for PCI passthrough
Date: Thu, 28 Oct 2021 10:34:08 -0700
Message-ID: <20211028173410.86074-1-prestwoj@gmail.com>

--===============5086226110855285568==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Adding back in PCI passthrough support
---
 tools/test-runner | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/test-runner b/tools/test-runner
index 156b36cc..6c7a7e45 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -1649,6 +1649,7 @@ class Main:
 =

 	def start(self):
 		usb_adapters =3D None
+		pci_adapters =3D None
 =

 		qemu_table =3D [
 			'qemu-system-x86_64',
@@ -1691,7 +1692,7 @@ class Main:
 		if self.args.hw:
 			hw_conf =3D ConfigParser()
 			hw_conf.read(self.args.hw)
-			# TODO: Parse PCI adapters
+
 			if hw_conf.has_section('USBAdapters'):
 				# The actual key name of the adapter
 				# doesn't matter since all we need is the
@@ -1699,6 +1700,9 @@ class Main:
 				# anyways once in the VM.
 				usb_adapters =3D [v for v in hw_conf['USBAdapters'].values()]
 =

+			if hw_conf.has_section('PCIAdapters'):
+				pci_adapters =3D [v for v in hw_conf['PCIAdapters'].values()]
+
 		#
 		# Additional arguments not provided to test-runner which are
 		# needed once booted into the kernel.
@@ -1828,6 +1832,11 @@ class Main:
 							'-device',
 							'usb-host,hostbus=3D%s,hostaddr=3D%s' % \
 							(bus, addr)])
+		if pci_adapters:
+			qemu_cmdline.extend(['-enable-kvm'])
+			for addr in pci_adapters:
+				qemu_cmdline.extend(['-device', 'vfio-pci,host=3D%s' % addr])
+
 		if self.args.log:
 			#
 			# Creates a virtfs device that can be mounted. This mount
-- =

2.31.1

--===============5086226110855285568==--

