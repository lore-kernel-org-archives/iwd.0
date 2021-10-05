Content-Type: multipart/mixed; boundary="===============7330069164857705459=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 07/11] auto-t: iwd.py: make wait() a static method
Date: Tue, 05 Oct 2021 15:00:47 -0700
Message-ID: <20211005220051.4018694-7-prestwoj@gmail.com>
In-Reply-To: 20211005220051.4018694-1-prestwoj@gmail.com

--===============7330069164857705459==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This allows it to be used without initializing an IWD class:

IWD.wait(1)
---
 autotests/util/iwd.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index 63b526fd..d6a7fe06 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -1133,7 +1133,8 @@ class IWD(AsyncOpAbstract):
                                        ' condition was not met in '\
                                        + str(max_wait) + ' sec'))
 =

-    def wait(self, time):
+    @staticmethod
+    def wait(time):
         ctx.non_block_wait(lambda : False, time, exception=3DFalse)
 =

     @staticmethod
-- =

2.31.1

--===============7330069164857705459==--

