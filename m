Content-Type: multipart/mixed; boundary="===============0285709602314879401=="
MIME-Version: 1.0
From: Michael Johnson <mjohnson459 at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v3 2/2] docs: Show new usage of IWD_DHCP_DEBUG
Date: Wed, 18 May 2022 15:39:15 +0100
Message-ID: <20220518143915.105007-2-mjohnson459@gmail.com>
In-Reply-To: 20220518143915.105007-1-mjohnson459@gmail.com

--===============0285709602314879401==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/iwd.debug.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/iwd.debug.rst b/src/iwd.debug.rst
index 5a805562..3d4c8b58 100644
--- a/src/iwd.debug.rst
+++ b/src/iwd.debug.rst
@@ -40,6 +40,10 @@ ENVIRONMENT
 =

 *$IWD_WSC_DEBUG_KEYS* set to ``1`` enables printing received WSC keys.
 =

+The granularity of the DHCP logging can also be tailored by setting
+*$IWD_DHCP_DEBUG* to the maximum verbosity level, "debug", "info", "warn",=
 or
+"error".
+
 SEE ALSO
 =3D=3D=3D=3D=3D=3D=3D=3D
 =

-- =

2.25.1

--===============0285709602314879401==--

