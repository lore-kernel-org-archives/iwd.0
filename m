Content-Type: multipart/mixed; boundary="===============0273335791898494258=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 6/7] auto-t: wpas.py: add disconnect()
Date: Wed, 12 Jan 2022 10:08:44 -0800
Message-ID: <20220112180845.1240661-6-prestwoj@gmail.com>
In-Reply-To: 20220112180845.1240661-1-prestwoj@gmail.com

--===============0273335791898494258==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/util/wpas.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/autotests/util/wpas.py b/autotests/util/wpas.py
index 440f6227..6b845232 100644
--- a/autotests/util/wpas.py
+++ b/autotests/util/wpas.py
@@ -288,6 +288,9 @@ class Wpas:
         self._ctrl_request('DPP_BOOTSTRAP_REMOVE *')
         self.wait_for_result()
 =

+    def disconnect(self):
+        self._ctrl_request('DISCONNECT')
+
     # Probably needed: remove references to self so that the GC can call _=
_del__ automatically
     def clean_up(self):
         if self.io_watch is not None:
-- =

2.31.1

--===============0273335791898494258==--

