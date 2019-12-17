Content-Type: multipart/mixed; boundary="===============0780216249674827788=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2] doc: describe hardware passthrough feature
Date: Tue, 17 Dec 2019 08:55:02 -0800
Message-ID: <20191217165502.7150-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0780216249674827788==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There are wiki's floating around, but I have consolidated the steps for
USB passthrough into our internal docs.
---
 doc/test-runner.txt | 62 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

-v2:
 * Fixed up some spelling mistakes/wordage

diff --git a/doc/test-runner.txt b/doc/test-runner.txt
index 1bc02ced..2d45bedc 100644
--- a/doc/test-runner.txt
+++ b/doc/test-runner.txt
@@ -389,6 +389,68 @@ if __name__ =3D=3D '__main__':
 	unittest.main()
 #~~~~~~~~~~~~~~~~~~ end of alwaysFailingTest.py ~~~~~~~~~~~~~~~~~~~~~~~~~
 =

+Using hardware passthrough
+---------------------------
+
+The --hw, -w flag lets you pass in a config file containing USB/PCI adapter
+addresses, which can then be used as radios inside the test/VM just as the
+virtual mac80211_hwsim radios are used. Note: physical radios cannot be us=
ed at
+the same time as mac80211_hwsim radios.
+
+Using this option, in some cases, does require some pre-configuration that=
 won't
+be described in this document. Specifically, PCI adapters are very involve=
d to
+get setup, and require special kernel boot options (on the host), BIOS cha=
nges,
+and most likely a lot of time to get the system working reliably. Because =
of
+this only USB adapters will be discussed in this document.
+
+If PCI passthrough is something you need, it would be best to follow this =
guide:
+
+https://wiki.archlinux.org/index.php/PCI_passthrough_via_OVMF
+
+First, whatever kernel you are using must contain the adapters driver and,=
 if
+required, firmware built in. The driver can be built in using 'make menuco=
nfig'
+and finding the correct driver for your adapter:
+
+Device Driver -> Network Device Support -> Wireless LAN
+
+Enable [*] the driver(s) you need, save, and exit.
+
+The firmware also needs to be built in, and this will require you finding =
the
+right firmware file (/lib/firmware/) required for your adapter and adding =
it to
+CONFIG_EXTRA_FIRMWARE in your .config file. It is sometimes not very obvio=
us
+what firmware you need. I have found that during the kernel boot some adap=
ters
+will print out if the firmware was not found, and the name of the firmware=
 file
+they expect. If you are having trouble finding the firmware file try conti=
nuing
+on and see what happens when test-runner starts. Google is also your frien=
d.
+
+Once you have the kernel built you can write your hardware config file for
+test-runner. Find the USB bus and device for the adapter:
+
+$ lsusb
+
+You should see your device listed with a 'Bus' and 'Device' number:
+
+$ Bus 001 Device 002: ........
+
+Put these into your passthrough config file under a 'USBAdapters' group:
+
+[USBAdapters]
+rad0=3D1,2
+
+Note: The 'rad#' does not matter at this time. These named keys will not
+correspond to rad0, rad1, etc in your test config file. This may change in=
 the
+future.
+
+You can then run test-runner using this config file:
+
+./test-runner -k <kernel> --hw passthrough.conf ...
+
+If running specific tests you need to ensure you have enough adapters defi=
ned
+in the config file, and that the adapters support the features you expect.=
 For
+example, some adapters cannot go into AP mode, or use certain channels. If=
 your
+test expects these features and the adapters do not support them, the test=
 will
+fail in sometimes unexpected ways.
+
 Using the 'shell' feature
 ---------------------------
 =

-- =

2.17.1

--===============0780216249674827788==--

