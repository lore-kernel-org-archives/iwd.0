Content-Type: multipart/mixed; boundary="===============1963213980565442572=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 5/5] test-runner: fix exception in Hostapd __del__
Date: Tue, 17 Aug 2021 09:45:01 -0700
Message-ID: <20210817164501.195027-5-prestwoj@gmail.com>
In-Reply-To: <20210817164501.195027-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1963213980565442572==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If Hostapd did not start there was no CLI instance created and
that member should be be accessed.
---
 tools/test-runner | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/test-runner b/tools/test-runner
index 895d4299..dc65cca4 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -546,6 +546,9 @@ class Hostapd:
 			print("Failed to remove %s" % self.global_ctrl_iface)
 =

 		for hapd in self.instances:
+			if not hapd.cli:
+				continue
+
 			hapd.cli._instances[hapd.config] =3D None
 			hapd.cli =3D None
 =

-- =

2.31.1

--===============1963213980565442572==--

