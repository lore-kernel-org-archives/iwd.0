Content-Type: multipart/mixed; boundary="===============8751252916503876287=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 6/6] test-runner: don't always print failure to remove ctrl
 interface
Date: Fri, 13 Aug 2021 13:26:12 -0700
Message-ID: <20210813202612.809470-6-prestwoj@gmail.com>
In-Reply-To: <20210813202612.809470-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8751252916503876287==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This can happen, particularly with SAQuery when hostapd is forcefully
killed. Better to only print when running in debug mode.
---
 tools/test-runner | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/test-runner b/tools/test-runner
index 5b8bdaf5..7e89d71c 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -541,7 +541,7 @@ class Hostapd:
 		try:
 			os.remove(self.global_ctrl_iface)
 		except:
-			dbg("Failed to remove %s" % self.global_ctrl_iface)
+			print("Failed to remove %s" % self.global_ctrl_iface)
 =

 		self.instances =3D None
 =

-- =

2.31.1

--===============8751252916503876287==--

