Content-Type: multipart/mixed; boundary="===============6906773458137574125=="
MIME-Version: 1.0
From: Alvin =?unknown-8bit?q?=C5=A0ipraga?= <ALSI@bang-olufsen.dk>
Subject: [PATCH 2/4] doc: describe MaximumPeriodicScanIntervalSetting
Date: Fri, 12 Feb 2021 15:41:14 +0000
Message-ID: <20210212154102.25255-2-alsi@bang-olufsen.dk>
In-Reply-To: <20210212154102.25255-1-alsi@bang-olufsen.dk>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6906773458137574125==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/iwd.config.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/iwd.config.rst b/src/iwd.config.rst
index b3c9491e..b5cfe9e7 100644
--- a/src/iwd.config.rst
+++ b/src/iwd.config.rst
@@ -293,6 +293,12 @@ No modification from defaults is normally required.
        **iwd** from issuing the periodic scans for the available networks =
while
        disconnected.  The behavior of the user-initiated scans isn't affec=
ted.
        The periodic scan is enabled by default.
+
+   * - MaximumPeriodicScanInterval
+     - Values: unsigned int value in seconds (default: **300**)
+
+       The maximum periodic scan interval.
+
    * - DisableRoamingScan
      - Values: true, **false**
 =

-- =

2.30.0
--===============6906773458137574125==--

