Content-Type: multipart/mixed; boundary="===============0413132995530255941=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/6] test-runner: don't use start_process for transient
 processes
Date: Tue, 07 Sep 2021 09:54:35 -0700
Message-ID: <20210907165439.9913-2-prestwoj@gmail.com>
In-Reply-To: <20210907165439.9913-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0413132995530255941==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Any process which is short lived and  waited for should just use
Process directly as to not add to the process queue.
---
 tools/test-runner | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/test-runner b/tools/test-runner
index 210e4f5f..34fdb74a 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -464,8 +464,8 @@ class Hostapd:
 =

 		print("Initializing hostapd instances")
 =

-		ctx.start_process(['ip', 'link', 'set', 'eth0', 'up']).wait()
-		ctx.start_process(['ip', 'link', 'set', 'eth1', 'up']).wait()
+		Process(['ip', 'link', 'set', 'eth0', 'up']).wait()
+		Process(['ip', 'link', 'set', 'eth1', 'up']).wait()
 =

 		self.global_ctrl_iface =3D '/var/run/hostapd/ctrl'
 =

-- =

2.31.1

--===============0413132995530255941==--

