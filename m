Content-Type: multipart/mixed; boundary="===============2141156651473266418=="
MIME-Version: 1.0
From: Michael Johnson <mjohnson459 at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 2/2] docs: Update IWD_DHCP_DEBUG values
Date: Tue, 17 May 2022 18:05:18 +0100
Message-ID: <20220517170518.144626-2-mjohnson459@gmail.com>
In-Reply-To: 20220517170518.144626-1-mjohnson459@gmail.com

--===============2141156651473266418==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use ``1`` and ``2`` for debug level to maintain compatibility with
existing settings.
---
 src/iwd.debug.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/iwd.debug.rst b/src/iwd.debug.rst
index 5a805562..e218c4a8 100644
--- a/src/iwd.debug.rst
+++ b/src/iwd.debug.rst
@@ -34,7 +34,7 @@ ENVIRONMENT
 =

 *$IWD_GENL_DEBUG* set to ``1`` enables printing Generic Netlink communicat=
ion with the kernel.
 =

-*$IWD_DHCP_DEBUG* set to ``1`` enables DHCP debugging.
+*$IWD_DHCP_DEBUG* set to ``1`` (info) or ``2`` (debug) to enabled DHCP log=
ging.
 =

 *$IWD_TLS_DEBUG* set to ``1`` enables TLS debugging.
 =

-- =

2.25.1

--===============2141156651473266418==--

