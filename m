Content-Type: multipart/mixed; boundary="===============8518657355704022351=="
MIME-Version: 1.0
From: Alvin =?unknown-8bit?q?=C5=A0ipraga?= <ALSI@bang-olufsen.dk>
Subject: [PATCH v2] auto-t: throw exception if hostapd can't send BSS
 transition req
Date: Thu, 28 Jan 2021 09:26:03 +0000
Message-ID: <20210128092601.1257918-1-alsi@bang-olufsen.dk>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8518657355704022351==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The testAPRoam autotest was silently failing on my machine until I
realized that my distribution hostapd (Arch Linux) is not built with
CONFIG_WNM_AP=3Dy. Indeed, it is also disabled by default in upstream
hostapd. This resulted in the send_bss_transition() function of
hostapd.py silently failing. With this change, throw an exception in
case the BSS_TM_REQ command does not succeed to hopefully save others
the time of debugging this problem.
---
 autotests/util/hostapd.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/autotests/util/hostapd.py b/autotests/util/hostapd.py
index 019d23ba..277a07b0 100644
--- a/autotests/util/hostapd.py
+++ b/autotests/util/hostapd.py
@@ -184,7 +184,10 @@ class HostapdCLI:
                         (addr, bss_info, op_class, chan_num, phy_num)]
             pref +=3D 1
 =

-        ctx.start_process(cmd, wait=3DTrue)
+        proc =3D ctx.start_process(cmd, wait=3DTrue, need_out=3DTrue)
+
+        if 'OK' not in proc.out:
+            raise Exception('BSS_TM_REQ failed, is hostapd built with CONF=
IG_WNM_AP=3Dy?')
 =

     def get_config_value(self, key):
         # first find the right config file
-- =

2.29.2
--===============8518657355704022351==--

