Content-Type: multipart/mixed; boundary="===============1869947621223853503=="
MIME-Version: 1.0
From: Alvin =?unknown-8bit?q?=C5=A0ipraga?= <ALSI@bang-olufsen.dk>
Subject: [PATCH 3/3] doc: describe RoamRetryInterval setting
Date: Fri, 22 Jan 2021 13:37:01 +0000
Message-ID: <20210122133659.577139-3-alsi@bang-olufsen.dk>
In-Reply-To: <20210122133659.577139-1-alsi@bang-olufsen.dk>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1869947621223853503==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/iwd.config.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/iwd.config.rst b/src/iwd.config.rst
index 365494a4..0064dfd2 100644
--- a/src/iwd.config.rst
+++ b/src/iwd.config.rst
@@ -133,6 +133,13 @@ The group ``[General]`` contains general settings.
 =

        This can be used to control how aggressively **iwd** roams.
 =

+   * - RoamRetryInterval
+     - Value: unsigned int value in seconds (default: **60**)
+
+       Specifies how long **iwd** will wait before attempting to roam agai=
n if
+       the last roam attempt failed, or if the signal of the newly connect=
ed BSS
+       is still considered weak.
+
    * - ManagementFrameProtection
      - Values: 0, **1** or 2
 =

-- =

2.29.2
--===============1869947621223853503==--

