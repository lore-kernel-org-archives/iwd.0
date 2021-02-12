Content-Type: multipart/mixed; boundary="===============0635122793779154989=="
MIME-Version: 1.0
From: Alvin =?unknown-8bit?q?=C5=A0ipraga?= <ALSI@bang-olufsen.dk>
Subject: [PATCH 4/4] doc: describe InitialPeriodicScanInterval setting
Date: Fri, 12 Feb 2021 15:41:14 +0000
Message-ID: <20210212154102.25255-4-alsi@bang-olufsen.dk>
In-Reply-To: <20210212154102.25255-1-alsi@bang-olufsen.dk>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0635122793779154989==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/iwd.config.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/iwd.config.rst b/src/iwd.config.rst
index b5cfe9e7..478bd616 100644
--- a/src/iwd.config.rst
+++ b/src/iwd.config.rst
@@ -294,6 +294,11 @@ No modification from defaults is normally required.
        disconnected.  The behavior of the user-initiated scans isn't affec=
ted.
        The periodic scan is enabled by default.
 =

+   * - InitialPeriodicScanInterval
+     - Values: unsigned int value in seconds (default: **10**)
+
+       The initial periodic scan interval upon disconnect.
+
    * - MaximumPeriodicScanInterval
      - Values: unsigned int value in seconds (default: **300**)
 =

-- =

2.30.0
--===============0635122793779154989==--

