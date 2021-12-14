Content-Type: multipart/mixed; boundary="===============3761350975526812265=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 10/10] doc: document DPP interface
Date: Tue, 14 Dec 2021 10:12:25 -0800
Message-ID: <20211214181225.2308043-10-prestwoj@gmail.com>
In-Reply-To: 20211214181225.2308043-1-prestwoj@gmail.com

--===============3761350975526812265==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/device-provisioning.txt | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 doc/device-provisioning.txt

diff --git a/doc/device-provisioning.txt b/doc/device-provisioning.txt
new file mode 100644
index 00000000..444bac74
--- /dev/null
+++ b/doc/device-provisioning.txt
@@ -0,0 +1,32 @@
+Device Provisioning hierarchy
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
+
+Service		net.connman.iwd
+Interface	net.connman.iwd.DeviceProvisioning [Experimental]
+Object path	/net/connman/iwd/{phy0,phy1,...}/{1,2,...}
+
+Methods		string StartEnrollee(dict arguments)
+
+			Start a DPP enrollee. Currently only station devices are
+			supported. The method arguments should be a dictionary.
+			There are no required dictionary key/values but it may
+			include:
+
+			Information: string - Vendor specific info to advertise
+						in the URI (I:).
+			Host: string - Host information to advertise in the
+						URI (H:).
+
+			Returns the enrollees URI
+
+			Possible errors:	net.connman.iwd.InvalidArguments
+						net.connman.iwd.AlreadyExists
+						net.connman.iwd.NotAvailable
+
+		void Stop()
+
+			Stop an enrollee.
+
+			Possible errors:	net.connman.iwd.Busy
+						net.connman.iwd.Failed
+						net.connman.iwd.InvalidArguments
-- =

2.31.1

--===============3761350975526812265==--

