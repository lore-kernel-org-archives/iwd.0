Content-Type: multipart/mixed; boundary="===============8180609294676534300=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] auto-t: include ssidTKIP.psk in Netconfig test
Date: Wed, 21 Apr 2021 08:36:15 -0700
Message-ID: <20210421153615.2256879-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8180609294676534300==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This file was not included when testNetconfig was introduced
and is required. My system was working fine as it was in my
local tree but has been missing and not passing for others.
---
 autotests/testNetconfig/ssidTKIP.psk | 6 ++++++
 1 file changed, 6 insertions(+)
 create mode 100644 autotests/testNetconfig/ssidTKIP.psk

diff --git a/autotests/testNetconfig/ssidTKIP.psk b/autotests/testNetconfig=
/ssidTKIP.psk
new file mode 100644
index 00000000..64e84f12
--- /dev/null
+++ b/autotests/testNetconfig/ssidTKIP.psk
@@ -0,0 +1,6 @@
+[IPv4]
+Address=3D192.168.1.10
+Gateway=3D192.168.1.1
+
+[Settings]
+AutoConnect=3Dfalse
-- =

2.26.2

--===============8180609294676534300==--

