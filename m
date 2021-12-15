Content-Type: multipart/mixed; boundary="===============0856452985042602062=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v3 11/11] doc: document DPP interface
Date: Wed, 15 Dec 2021 09:58:14 -0800
Message-ID: <20211215175814.2467124-11-prestwoj@gmail.com>
In-Reply-To: 20211215175814.2467124-1-prestwoj@gmail.com

--===============0856452985042602062==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/device-provisioning.txt | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 doc/device-provisioning.txt

diff --git a/doc/device-provisioning.txt b/doc/device-provisioning.txt
new file mode 100644
index 00000000..3ac2d934
--- /dev/null
+++ b/doc/device-provisioning.txt
@@ -0,0 +1,25 @@
+Device Provisioning hierarchy
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
+
+Service		net.connman.iwd
+Interface	net.connman.iwd.DeviceProvisioning [Experimental]
+Object path	/net/connman/iwd/{phy0,phy1,...}/{1,2,...}
+
+Methods		string StartEnrollee()
+
+			Start a DPP enrollee. Currently only station devices are
+			supported.
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

--===============0856452985042602062==--

