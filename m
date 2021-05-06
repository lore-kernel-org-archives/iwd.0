Content-Type: multipart/mixed; boundary="===============2503433471717492272=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/2] doc: Daemon DBus interface documentation
Date: Thu, 06 May 2021 23:28:28 +0200
Message-ID: <20210506212828.79315-2-andrew.zaborowski@intel.com>
In-Reply-To: <20210506212828.79315-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2503433471717492272==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/daemon-api.txt | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 doc/daemon-api.txt

diff --git a/doc/daemon-api.txt b/doc/daemon-api.txt
new file mode 100644
index 00000000..8256bb10
--- /dev/null
+++ b/doc/daemon-api.txt
@@ -0,0 +1,24 @@
+Daemon hierarchy
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Service		net.connman.iwd
+Interface	net.connman.iwd.Daemon [Experimental]
+Object path	/net/connman/iwd
+
+Methods		dict GetInfo()
+
+			Returns basic IWD daemon's status and configuration
+			properties.  Their values are global and may be useful
+			for D-Bus clients interacting with IWD, not so much
+			for the user.  The returned dictionary (a{sv}) maps
+			string keys to values of types defined per key.
+			Clients should ignore unknown keys.
+
+			The following key/value pairs are defined currently:
+
+			string Version - IWD release version,
+
+			string StateDirectory - Absolute path to the IWD
+			state directory where network configuration and
+			runtime state files are kept (see $STATE_DIRECTORY in
+			iwd(8) and iwd.network(5)).
-- =

2.27.0

--===============2503433471717492272==--

