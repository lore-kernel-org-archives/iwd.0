Content-Type: multipart/mixed; boundary="===============4138196367837795037=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 6/7] doc: document [General].RoamThreshold5G
Date: Fri, 07 May 2021 13:26:19 -0700
Message-ID: <20210507202620.93540-6-prestwoj@gmail.com>
In-Reply-To: <20210507202620.93540-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4138196367837795037==
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

--===============4138196367837795037==--

