Content-Type: multipart/mixed; boundary="===============9141677152780625141=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 15/17] test-runner: start haveged in foreground
Date: Thu, 25 Feb 2021 14:01:04 -0800
Message-ID: <20210225220106.1728411-15-prestwoj@gmail.com>
In-Reply-To: <20210225220106.1728411-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============9141677152780625141==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

haveged was forking itself which then prevented test-runner from
cleaning it up.
---
 tools/test-runner | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/test-runner b/tools/test-runner
index 19272774..412998ba 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -770,7 +770,7 @@ class TestContext(Namespace):
 		self.start_process(['dbus-monitor', '--address', self.dbus_address])
 =

 	def start_haveged(self):
-		self.start_process(['haveged'])
+		self.start_process(['haveged', '-F'])
 =

 	def create_radios(self):
 		setup =3D self.hw_config['SETUP']
-- =

2.26.2

--===============9141677152780625141==--

