Content-Type: multipart/mixed; boundary="===============1286442360617455332=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/6] test-runner: use Process to start hostapd
Date: Tue, 07 Sep 2021 09:54:37 -0700
Message-ID: <20210907165439.9913-4-prestwoj@gmail.com>
In-Reply-To: <20210907165439.9913-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1286442360617455332==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Since the hostapd process object is tracked by the Hostapd class there
is no sense of keeping it in the process list as well.
---
 tools/test-runner | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/test-runner b/tools/test-runner
index fb52c57c..1fe5e843 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -499,7 +499,7 @@ class Hostapd:
 		if ctx.is_verbose('hostapd'):
 			args.append('-d')
 =

-		self.process =3D ctx.start_process(args)
+		self.process =3D Process(args)
 =

 		self.process.wait_for_socket(self.global_ctrl_iface, 30)
 =

-- =

2.31.1

--===============1286442360617455332==--

