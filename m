Content-Type: multipart/mixed; boundary="===============4003276903308754402=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 09/17] test-runner: allow radio remove failure
Date: Thu, 25 Feb 2021 14:00:58 -0800
Message-ID: <20210225220106.1728411-9-prestwoj@gmail.com>
In-Reply-To: <20210225220106.1728411-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4003276903308754402==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is somewhat of an open issue/TODO but for now this avoids
the exception caused by trying to remove a radio that has been
moved to a namespace. Once a radio is moved hwsim loses that phy
and can no longer interact with it. This causes the Destroy()
method call to fail.
---
 tools/test-runner | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/test-runner b/tools/test-runner
index 2fb7a613..62c4bd75 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -395,7 +395,12 @@ class VirtualRadio(Radio):
 	def __del__(self):
 		super().__del__()
 =

-		self._radio.remove()
+		# If the radio was moved into a namespace this will fail
+		try:
+			self._radio.remove()
+		except:
+			pass
+
 		self._radio =3D None
 =

 	def __str__(self):
-- =

2.26.2

--===============4003276903308754402==--

