Content-Type: multipart/mixed; boundary="===============8123777265631791047=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 6/6] auto-t: hostapd.py: remove get_freq()/get_config_value()
Date: Thu, 12 Aug 2021 16:12:33 -0700
Message-ID: <20210812231233.747743-6-prestwoj@gmail.com>
In-Reply-To: <20210812231233.747743-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8123777265631791047==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/util/hostapd.py | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/autotests/util/hostapd.py b/autotests/util/hostapd.py
index 1575d832..be6e1143 100644
--- a/autotests/util/hostapd.py
+++ b/autotests/util/hostapd.py
@@ -212,20 +212,6 @@ class HostapdCLI:
         if 'OK' not in proc.out:
             raise Exception('BSS_TM_REQ failed, is hostapd built with CONF=
IG_WNM_AP=3Dy?')
 =

-    def get_config_value(self, key):
-        # first find the right config file
-        with open(self.config, 'r') as f:
-            # read in config file and search for key
-            cfg =3D f.read()
-            match =3D re.search(r'%s=3D.*' % key, cfg)
-            if match:
-                return match.group(0).split('=3D')[1]
-        return None
-
-
-    def get_freq(self):
-        return chan_freq_map[int(self.get_config_value('channel'))]
-
     def ungraceful_restart(self):
         '''
             Ungracefully kill and restart hostapd
-- =

2.31.1

--===============8123777265631791047==--

