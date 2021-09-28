Content-Type: multipart/mixed; boundary="===============4443768621857718362=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 1/9] doc: add DisableOCV setting
Date: Tue, 28 Sep 2021 08:46:50 -0700
Message-ID: <20210928154658.2382597-1-prestwoj@gmail.com>

--===============4443768621857718362==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/iwd.config.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/iwd.config.rst b/src/iwd.config.rst
index 78ec284e..5cd2b06b 100644
--- a/src/iwd.config.rst
+++ b/src/iwd.config.rst
@@ -181,6 +181,13 @@ The group ``[General]`` contains general settings.
        off by default.  If you want to easily utilize Hotspot 2.0 networks,
        then setting ``DisableANQP`` to ``false`` is recommended.
 =

+   * - DisableOCV
+     - Value: **false**, true
+
+       Disable Operating Channel Validation. Support for this is not adver=
tised
+       by the kernel so if kernels/drivers exist which don't support OCV i=
t can
+       be disabled here.
+
 Network
 -------
 =

-- =

2.31.1

--===============4443768621857718362==--

