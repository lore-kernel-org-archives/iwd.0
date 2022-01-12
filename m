Content-Type: multipart/mixed; boundary="===============0865396427868493779=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 5/7] auto-t: wpas.py: increase timeout for auth protocol
Date: Wed, 12 Jan 2022 10:08:43 -0800
Message-ID: <20220112180845.1240661-5-prestwoj@gmail.com>
In-Reply-To: 20220112180845.1240661-1-prestwoj@gmail.com

--===============0865396427868493779==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Sometimes wpa_supplicant takes some time to respond to the initial
presence anouncements.
---
 autotests/util/wpas.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/autotests/util/wpas.py b/autotests/util/wpas.py
index b750ce31..440f6227 100644
--- a/autotests/util/wpas.py
+++ b/autotests/util/wpas.py
@@ -279,7 +279,7 @@ class Wpas:
 =

         self._rx_data =3D []
         self._ctrl_request(cmd)
-        self.wait_for_event('DPP-AUTH-SUCCESS')
+        self.wait_for_event('DPP-AUTH-SUCCESS', timeout=3D30)
         self.wait_for_event('DPP-CONF-SENT')
 =

     def dpp_configurator_remove(self):
-- =

2.31.1

--===============0865396427868493779==--

