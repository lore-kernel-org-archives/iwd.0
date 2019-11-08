Content-Type: multipart/mixed; boundary="===============4653500665457620285=="
MIME-Version: 1.0
From: Martin/Geno <geno+dev@fireorbit.de>
Subject: [PATCH] fix doc iwd.network - correct section name is Settings
Date: Fri, 08 Nov 2019 18:24:11 +0100
Message-ID: <20191108172411.1929890-1-geno+dev@fireorbit.de>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4653500665457620285==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/iwd.network.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/iwd.network.rst b/src/iwd.network.rst
index 6c882353..756addf3 100644
--- a/src/iwd.network.rst
+++ b/src/iwd.network.rst
@@ -92,7 +92,7 @@ following the group definition.
 General Settings
 ----------------
 =

-The group ``[General]`` contains general settings.
+The group ``[Settings]`` contains general settings.
 =

 .. list-table::
    :header-rows: 0
@@ -269,7 +269,7 @@ Open Network (Hidden)
 =

 .. code-block::
 =

-   [General]
+   [Settings]
    Hidden=3Dtrue
 =

 Pre-Shared Key (PSK)
-- =

2.24.0

--===============4653500665457620285==--

