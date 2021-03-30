Content-Type: multipart/mixed; boundary="===============3305678549132832889=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 6/7] doc: document new [General].4WayOffload
Date: Tue, 30 Mar 2021 11:48:07 -0700
Message-ID: <20210330184808.744574-6-prestwoj@gmail.com>
In-Reply-To: <20210330184808.744574-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3305678549132832889==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This option will allow the 4-way handshake to be offloaded to
firmware if it supports it.
---
 src/iwd.config.rst | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/src/iwd.config.rst b/src/iwd.config.rst
index 478bd616..e2060312 100644
--- a/src/iwd.config.rst
+++ b/src/iwd.config.rst
@@ -174,6 +174,20 @@ The group ``[General]`` contains general settings.
        off by default.  If you want to easily utilize Hotspot 2.0 networks,
        then setting ``DisableANQP`` to ``false`` is recommended.
 =

+   * - 4WayOffload
+     - Values: **false**, true
+
+       Enables the use of 4-way handshake offloading. Some drivers can off=
load
+       the 4-way handshake to firmware which is needed for protocols which
+       act on Authenticate/Associate frames such as Fast Transition. This
+       option is turned off by default as it is not widely tested.
+
+       Note: There seems to be a bug in the brcmfmac driver/firmware where=
 once
+       offloading is enabled (by turning on this option) it cannot be turn=
ed
+       off in the firmware without a hard reboot (or some means of restart=
ing
+       the firmware).
+
+
 Network
 ---------
 =

-- =

2.26.2

--===============3305678549132832889==--

