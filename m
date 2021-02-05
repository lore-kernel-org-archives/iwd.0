Content-Type: multipart/mixed; boundary="===============8788933664986957839=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/3] test-runner: print Radio class path
Date: Fri, 05 Feb 2021 10:09:09 -0800
Message-ID: <20210205180911.320809-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8788933664986957839==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 tools/test-runner | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/test-runner b/tools/test-runner
index 3a766ef5..a9b13aa8 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -347,6 +347,8 @@ class VirtualRadio(Radio):
 		if self.disable_cipher:
 			ret +=3D '\tDisabled ciphers: %s\n' % self.disable_cipher
 =

+		ret +=3D '\tPath: %s' % self._radio.path
+
 		ret +=3D '\n'
 =

 		return ret
-- =

2.26.2

--===============8788933664986957839==--

