Content-Type: multipart/mixed; boundary="===============8690074027702820088=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/7] test-runner: remove ofono/hardcoded IWD options
Date: Wed, 16 Sep 2020 10:08:09 -0700
Message-ID: <20200916170814.660095-2-prestwoj@gmail.com>
In-Reply-To: <20200916170814.660095-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8690074027702820088==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 tools/test-runner | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/test-runner b/tools/test-runner
index d1e1d42c..f18fa325 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -607,7 +607,6 @@ class TestContext:
 			return
 		elif sim_keys !=3D 'ofono':
 			os.environ['IWD_SIM_KEYS'] =3D sim_keys
-			self.iwd_extra_options =3D '--plugin=3Dsim_hardcoded'
 			return
 =

 		if not find_binary(['ofonod']) or not find_binary(['phonesim']):
@@ -616,8 +615,6 @@ class TestContext:
 =

 		Process(['ifconfig', 'lo', 'up'], wait=3DTrue)
 =

-		self.iwd_extra_options =3D '--plugin=3Dofono'
-
 		os.environ['OFONO_PHONESIM_CONFIG'] =3D '/tmp/phonesim.conf'
 =

 		phonesim_args =3D ['phonesim', '-p', '12345', '/usr/share/phonesim/defau=
lt.xml']
-- =

2.26.2

--===============8690074027702820088==--

