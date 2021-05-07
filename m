Content-Type: multipart/mixed; boundary="===============1727374473506965022=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 5/6] doc: document [General].RoamThreshold5G
Date: Fri, 07 May 2021 11:24:22 -0700
Message-ID: <20210507182423.81194-5-prestwoj@gmail.com>
In-Reply-To: <20210507182423.81194-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1727374473506965022==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/iwd.config.rst | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/src/iwd.config.rst b/src/iwd.config.rst
index 478bd616..8e3662d4 100644
--- a/src/iwd.config.rst
+++ b/src/iwd.config.rst
@@ -131,7 +131,14 @@ The group ``[General]`` contains general settings.
    * - RoamThreshold
      - Value: rssi dBm value, from -100 to 1, default: **-70**
 =

-       This can be used to control how aggressively **iwd** roams.
+       This can be used to control how aggressively **iwd** roams from 2.4=
Ghz
+       networks.
+
+   * - RoamThreshold5G
+     - Value: rssi dBm value, from -100 to 1, default: **-76**
+
+       This value can be used to control how aggressively **iwd** roams fr=
om
+       5GHz networks.
 =

    * - RoamRetryInterval
      - Value: unsigned int value in seconds (default: **60**)
-- =

2.31.1

--===============1727374473506965022==--

