Content-Type: multipart/mixed; boundary="===============2519724041858491198=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 6/6] doc: document new [General].4WayOffload
Date: Fri, 02 Apr 2021 10:11:18 -0700
Message-ID: <20210402171118.915230-6-prestwoj@gmail.com>
In-Reply-To: <20210402171118.915230-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2519724041858491198==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This option will allow the 4-way handshake to be offloaded to
firmware if it supports it.
---
 src/iwd.config.rst | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/src/iwd.config.rst b/src/iwd.config.rst
index 478bd616..c9e67a2d 100644
--- a/src/iwd.config.rst
+++ b/src/iwd.config.rst
@@ -174,6 +174,21 @@ The group ``[General]`` contains general settings.
        off by default.  If you want to easily utilize Hotspot 2.0 networks,
        then setting ``DisableANQP`` to ``false`` is recommended.
 =

+   * - 4WayOffload
+     - Values: **false**, true
+
+       Enables the use of 4-way handshake offloading. Some drivers can off=
load
+       the 4-way handshake to firmware which may be required to support ce=
rtain
+       protocols that act on Authenticate/Associate frames (OWE, SAE, FT e=
tc)
+       for drivers which do not support Authenticate/Associate commands. T=
his
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

--===============2519724041858491198==--

