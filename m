Content-Type: multipart/mixed; boundary="===============8357983640327575344=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v4 10/10] doc: document DPP interface
Date: Thu, 16 Dec 2021 10:08:54 -0800
Message-ID: <20211216180854.39470-10-prestwoj@gmail.com>
In-Reply-To: 20211216180854.39470-1-prestwoj@gmail.com

--===============8357983640327575344==
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

--===============8357983640327575344==--

