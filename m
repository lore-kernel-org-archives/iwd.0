Content-Type: multipart/mixed; boundary="===============2844706022984959639=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 06/18] man iwd.debug: Document IWD_GENL_DEBUG
Date: Sat, 11 Jul 2020 03:00:41 +0200
Message-ID: <20200711010053.224223-6-andrew.zaborowski@intel.com>
In-Reply-To: <20200711010053.224223-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2844706022984959639==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/iwd.debug.rst | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/iwd.debug.rst b/src/iwd.debug.rst
index 857738ef..5a805562 100644
--- a/src/iwd.debug.rst
+++ b/src/iwd.debug.rst
@@ -32,13 +32,15 @@ ENVIRONMENT
 =

 *$IWD_RTNL_DEBUG* set to ``1`` enables RTNL debugging.
 =

+*$IWD_GENL_DEBUG* set to ``1`` enables printing Generic Netlink communicat=
ion with the kernel.
+
 *$IWD_DHCP_DEBUG* set to ``1`` enables DHCP debugging.
 =

 *$IWD_TLS_DEBUG* set to ``1`` enables TLS debugging.
 =

-*$IWD_WSC_DEBUG_KEYS* set to ``1`` enables WSC debug keys.
+*$IWD_WSC_DEBUG_KEYS* set to ``1`` enables printing received WSC keys.
 =

 SEE ALSO
 =3D=3D=3D=3D=3D=3D=3D=3D
 =

-iwd(8),
+iwd(8), iwmon(1)
-- =

2.25.1

--===============2844706022984959639==--

