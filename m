Content-Type: multipart/mixed; boundary="===============4120004241197613492=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/9] test-runner: have start_iwd take a storage dir
Date: Thu, 10 Dec 2020 09:45:19 -0800
Message-ID: <20201210174525.874021-3-prestwoj@gmail.com>
In-Reply-To: <20201210174525.874021-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4120004241197613492==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Allow the storage directory (default /tmp/iwd) to be configured
just like the state directory. This is in order to support multiple
IWD instances which require separate storage directories for network
provisioning files.
---
 tools/test-runner | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/test-runner b/tools/test-runner
index 3a9cfce2..c2ff7eff 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -559,7 +559,7 @@ class Namespace:
 =

 		self._bus =3D dbus.bus.BusConnection(address_or_type=3Dself.dbus_address)
 =

-	def start_iwd(self, config_dir =3D '/tmp'):
+	def start_iwd(self, config_dir =3D '/tmp', storage_dir =3D '/tmp/iwd'):
 		args =3D []
 		iwd_radios =3D ','.join([r.name for r in self.radios if r.use =3D=3D 'iw=
d'])
 =

@@ -575,7 +575,7 @@ class Namespace:
 		env =3D os.environ.copy()
 =

 		env['CONFIGURATION_DIRECTORY'] =3D config_dir
-		env['STATE_DIRECTORY'] =3D '/tmp/iwd'
+		env['STATE_DIRECTORY'] =3D storage_dir
 =

 		if self.is_verbose('iwd-dhcp'):
 			env['IWD_DHCP_DEBUG'] =3D '1'
-- =

2.26.2

--===============4120004241197613492==--

