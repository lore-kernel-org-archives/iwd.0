Content-Type: multipart/mixed; boundary="===============6933045038911739856=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/4] doc: add APRanges documentation
Date: Wed, 04 Nov 2020 08:52:26 -0800
Message-ID: <20201104165227.2782516-3-prestwoj@gmail.com>
In-Reply-To: <20201104165227.2782516-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6933045038911739856==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/iwd.config.rst | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/src/iwd.config.rst b/src/iwd.config.rst
index 96774092..5d3cfb3a 100644
--- a/src/iwd.config.rst
+++ b/src/iwd.config.rst
@@ -67,10 +67,23 @@ The group ``[General]`` contains general settings.
        obtain the dynamic addresses from the network through the built-in
        DHCP client.
 =

+       This also enables DHCP server when in AP mode when either
+       [General].APRanges is set or an AP profile is being used.
+
        The network configuration feature is disabled by default.  See
        ``[Network]`` settings for additional settings related to network
        configuration.
 =

+   * - APRanges
+     - Values: <IP in prefix notation>
+
+       Sets the range of IP's used for DHCP server (AP mode). The IP shoul=
d be
+       in prefix notation e.g. aaa.bbb.ccc.ddd/xx. AP's which are started =
in a
+       profile-less configuration will use this pool of IP's to set the AP=
's
+       interface address as well as default DHCP server options. Each AP w=
ill
+       get a new subnet from the range and clients will be addressed in th=
at
+       subnet to avoid IP conflicts if multiple AP's are started.
+
    * - UseDefaultInterface
      - Values: true, **false**
 =

-- =

2.26.2

--===============6933045038911739856==--

