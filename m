Content-Type: multipart/mixed; boundary="===============4959131786939505114=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH] manpage: Add route prioritization setting
Date: Fri, 08 Nov 2019 11:37:43 -0800
Message-ID: <20191108193743.4372-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4959131786939505114==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/iwd.config.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/iwd.config.rst b/src/iwd.config.rst
index 56f019f6..dd04909c 100644
--- a/src/iwd.config.rst
+++ b/src/iwd.config.rst
@@ -170,6 +170,14 @@ The group ``[Network]`` contains network configuration=
 related settings.
 =

        If not specified, ``systemd`` is used as default.
 =

+   * - RoutePriorityOffset
+     - Values: uint32 value (default: **300**)
+
+       Configures a route priority offset used by the system to prioritize
+       the default routes. The route with lower priority offset is preferr=
ed.
+
+       If not specified, ``300`` is used as default.
+
 Blacklist
 ---------
 =

-- =

2.13.6

--===============4959131786939505114==--

