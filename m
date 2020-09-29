Content-Type: multipart/mixed; boundary="===============4374136230491457568=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/8] test-runner: Enable --p2p when creating interfaces
Date: Tue, 29 Sep 2020 18:37:11 +0200
Message-ID: <20200929163717.754459-8-andrew.zaborowski@intel.com>
In-Reply-To: <20200929163717.754459-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4374136230491457568==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Enable p2p for the hwsim radios so that we can test P2P.  This can be
made optional for the tests but it seems safe to enable always.
---
 tools/test-runner | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/test-runner b/tools/test-runner
index f2b75bc0..00a0978a 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -303,7 +303,7 @@ class VirtualRadio(Radio):
 		self.disable_cipher =3D None
 		self.disable_iftype =3D None
 =

-		args =3D ['hwsim', '--create', '--name', self.name, '--nointerface']
+		args =3D ['hwsim', '--create', '--name', self.name, '--nointerface', '--=
p2p']
 =

 		if config:
 			self.disable_iftype =3D config.get('iftype_disable', False)
-- =

2.25.1

--===============4374136230491457568==--

