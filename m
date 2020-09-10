Content-Type: multipart/mixed; boundary="===============3439328029719025133=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 14/26] doc: update test runner docs
Date: Thu, 10 Sep 2020 11:58:43 -0700
Message-ID: <20200910185855.27833-14-prestwoj@gmail.com>
In-Reply-To: <20200910185855.27833-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3439328029719025133==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/test-runner.txt | 117 +++++++++++++-------------------------------
 1 file changed, 34 insertions(+), 83 deletions(-)

diff --git a/doc/test-runner.txt b/doc/test-runner.txt
index 2d45bedc..17d7bbb2 100644
--- a/doc/test-runner.txt
+++ b/doc/test-runner.txt
@@ -17,18 +17,21 @@ OS:
 =

 	Name:			Tested ver.:
 	 1. qemu		2.4.1
-	 2. Linux kernel	4.20
+	 2. Linux kernel	4.20+
 	 3. dbus-daemon		1.11.18
 	 4. ifconfig		2.10-alpha
 	 5. iw			3.17
 	 6. python		2.7
 	 7. haveged		no ver. avail.
-	 8. hostapd		commit id: 31d3692
+	 8. hostapd		recent
 	 9. <iwd>/tools/hwsim	0.0
 	10. <iwd>/src/iwd	0.0
+	11. ofono (optional)
+	12. phonesim (optional)
 =

-Note: You will need ell-key-crypto branch, not the master branch from the =
tree
-in step 2 above.
+Note: The version for hostapd is listed as 'recent'. Older hostapd versions
+will work but we are continually adopting new features from hostapd and us=
ing
+those to test. Its recommended to use a recent release of hostapd.
 =

 Note: The test-runner mounts host's file system in readonly mode and execu=
tes
 the above binaries inside of an emulated environment directly from it.
@@ -100,7 +103,6 @@ By default the test-runner will search for the kernel i=
mage in these locations:
 An arbitrary kernel image location can be specified by using '--kernel <pa=
th>'
 parameter into test-runner.
 =

-
 Running Automated Tests
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 Before running any tests, its expected that the folder /var/lib/iwd exists=
 on
@@ -113,8 +115,8 @@ By default, the automated test configuration directorie=
s reside in
 '<iwd>/autotests' and have a mandatory prefix of 'test'.
 =

 	<iwd>/autotests/test1
-                       /test2
-                         ...
+			/test2
+			...
 =

 The test configurations along with test cases in <iwd>/autotests/test*
 directories will be discovered and executed by test-runner in sequential
@@ -133,6 +135,10 @@ The command line may look as follows:
 =

 	$ sudo ./test-runner -t test1,test3,/home/test4
 =

+Glob matching is also supported when specifying a test list:
+
+	$ sudo ./test-runner -t testWPA*
+
 =

 Creating Test Configurations
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
@@ -145,7 +151,11 @@ A typical test configuration directory may consist of =
these types of files:
 	*Test or *Test.py	The set of test cases for IWD functionality
 				implemented using Python scripting language.
 				These files must have one of the two predefined
-				suffixes: 'Test' or 'Test.py'
+				suffixes: 'test' or 'test.py'. The file name
+				must also be more descriptive than simply 'test'.
+				e.g. 'connection_test' or 'failure_test'. Files
+				named 'test' will not be dynamically loaded due
+				to python module naming overlap.
 =

 	*.conf			A configuration file for an instance of hostapd
 	(Defined in hw.conf)	service.
@@ -164,6 +174,9 @@ A typical contents of a test configuration directory ma=
y look as follows:
 		networkScanTest
 		networkConnectTest.py
 =

+Note: Any additional files in your test directory will be copied to /tmp i=
nside
+the VM. These additional file should be referenced using /tmp/<file> inside
+any configuration file for hostapd.
 =

 Defining Network
 ----------------
@@ -187,61 +200,26 @@ supplicant running IWD:
 # has a range of [1, 100].
 num_radios=3D3
 =

-# Definition of the radio configuration identifiers. These identifiers are=
 used
-# to map the APs and IWD to the radios with the particular hardware proper=
ties.
-# This field is optional. If identifier is omitted from this list, then the
-# default radio properties will be used as they are defined in mac80211_hw=
sim
-# driver to satisfy a total number of radios requested in 'num_radios' fie=
ld.
-radio_confs=3Drad0:rad1
-
 # Maximum execution interval per Python script file in seconds. This field=
 is
 # optional.
 # Default: 20 seconds.
 #max_test_exec_interval_sec=3D5
 =

-# List of paths inside of a test configuration directory for which
-# the symlinks will be created inside of /tmp. Such paths can be used
-# to specify an absolute path to the needed files inside of IWD and Hostapd
-# configuration files.
-# Example:
-#	 <some path>/test1/certs
-#		           misc
-#
-# certs and misc directories will be respectively mapped to:
-#
-#	 /tmp/certs
-#	      misc
-#
-# This field is optional.
-#tmpfs_extra_stuff=3Dcerts:misc
-
-# Flag to prevent test-runner from starting IWD. Therefore, it may later be
-# started from the python test cases.
-# This field is optional. Default: 1 (true)
-#start_iwd=3D0
-
-# Configuration directory to use for IWD daemon. IWD expects 'main.conf' t=
o be
-# inside of the specified directory.
-# This field is optional. Default: /etc/iwd
-#iwd_config_dir=3D/etc/iwd
-
 #
 # The following two configuration groups are examples of the radio
 # configurations.
 #
 # This group of settings allows to specify a set of properties for a radio=
. The
-# name of the group represents a radio identifier and must be predefined in
-# 'radio_confs' field inside of 'SETUP' group. This configuration group is
-# optional.
-# TODO: explain each one of the properties.
+# name of the group represents a radio identifier. These configuration gro=
ups
+# are optional.
 [rad0]
-channels=3D2
-p2p_device=3D1
-use_chanctx=3D1
 =

-# Properties of the second radio. This configuration group is optional.
-[rad1]
-p2p=3D0
+# For each radX group you can specify radio properties:
+# Disables the provided interface type(s):
+disable_iftype=3Dap,p2p
+
+# Disables the provided cipher types:
+disable_cipher=3Dccmp,bip
 =

 # 'HOSTAPD' configuration group identifies a set of access points (AP) for=
 the
 # current network topology. Each key/value pair represents a single AP tha=
t is
@@ -253,8 +231,12 @@ p2p=3D0
 [HOSTAPD]
 rad0=3Dap1.conf
 rad1=3Dap2.conf
-#~~~~~~~~~~~~~~~~~~ end of hw.conf ~~~~~~~~~~~~~~~~~~~~~~~~~
 =

+# 'radius_server' is a special option used to specify a hostapd instance w=
hich
+# acts as a radius server only (not an access point). This option does not
+# require an additional 'num_radios' to be used.
+radius_server=3Dradius.conf
+#~~~~~~~~~~~~~~~~~~ end of hw.conf ~~~~~~~~~~~~~~~~~~~~~~~~~
 =

 Configuring Access Points
 -------------------------
@@ -358,37 +340,6 @@ For more information on Python unit test framework ref=
er to the following page:
 =

 	http://pyunit.sourceforge.net/pyunit.html
 =

-
-Examples of the framework usage:
-
-#~~~~~~~~~~~~~~~~~~~~~~~~~ alwaysPassingTest.py ~~~~~~~~~~~~~~~~~~~~~~~~~
-#!/usr/bin/python
-
-import unittest
-
-class TestPassingCase(unittest.TestCase):
-
-	def test_pass(self):
-		self.assertTrue(True)
-
-if __name__ =3D=3D '__main__':
-	unittest.main()
-#~~~~~~~~~~~~~~~~~~ end of alwaysPassingTest.py ~~~~~~~~~~~~~~~~~~~~~~~~~
-
-#~~~~~~~~~~~~~~~~~~~~~~~~~ alwaysFailingTest.py ~~~~~~~~~~~~~~~~~~~~~~~~~
-#!/usr/bin/python
-
-import unittest
-
-class TestFailingCase(unittest.TestCase):
-
-	def test_fail(self):
-		self.assertTrue(False)
-
-if __name__ =3D=3D '__main__':
-	unittest.main()
-#~~~~~~~~~~~~~~~~~~ end of alwaysFailingTest.py ~~~~~~~~~~~~~~~~~~~~~~~~~
-
 Using hardware passthrough
 ---------------------------
 =

-- =

2.21.3

--===============3439328029719025133==--

