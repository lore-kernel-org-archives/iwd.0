Content-Type: multipart/mixed; boundary="===============8695081167881207251=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 09/10] auto-t: wpas.py: add configurator_remove
Date: Tue, 11 Jan 2022 16:55:57 -0800
Message-ID: <20220112005558.1158405-9-prestwoj@gmail.com>
In-Reply-To: 20220112005558.1158405-1-prestwoj@gmail.com

--===============8695081167881207251==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

wpa_supplicant has a limited number of configurator IDs, and its
good practice to remove them after we are done.
---
 autotests/util/wpas.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/autotests/util/wpas.py b/autotests/util/wpas.py
index f8ef3357..b750ce31 100644
--- a/autotests/util/wpas.py
+++ b/autotests/util/wpas.py
@@ -282,6 +282,12 @@ class Wpas:
         self.wait_for_event('DPP-AUTH-SUCCESS')
         self.wait_for_event('DPP-CONF-SENT')
 =

+    def dpp_configurator_remove(self):
+        self._ctrl_request('DPP_CONFIGURATOR_REMOVE *')
+        self.wait_for_result()
+        self._ctrl_request('DPP_BOOTSTRAP_REMOVE *')
+        self.wait_for_result()
+
     # Probably needed: remove references to self so that the GC can call _=
_del__ automatically
     def clean_up(self):
         if self.io_watch is not None:
-- =

2.31.1

--===============8695081167881207251==--

