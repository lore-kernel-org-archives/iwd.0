Content-Type: multipart/mixed; boundary="===============0676537344530033725=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] doc: use real example for APRanges
Date: Tue, 01 Dec 2020 16:57:44 -0800
Message-ID: <20201202005744.276180-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0676537344530033725==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The docs just specified what a IP prefix looks like, not an
actual example. Though its not recommended to just copy paste
blindly, its still useful to have some value in the man pages
that actually works if someone just wants to get a DHCP server
working.
---
 src/iwd.config.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/iwd.config.rst b/src/iwd.config.rst
index 37438c6c..f74e31cf 100644
--- a/src/iwd.config.rst
+++ b/src/iwd.config.rst
@@ -86,7 +86,7 @@ The group ``[General]`` contains general settings.
      - Values: <IP in prefix notation>
 =

        Sets the range of IP's used for DHCP server (AP mode). The IP shoul=
d be
-       in prefix notation e.g. aaa.bbb.ccc.ddd/xx. AP's which are started =
in a
+       in prefix notation e.g. 192.168.1.0/24. AP's which are started in a
        profile-less configuration will use this pool of IP's to set the AP=
's
        interface address as well as default DHCP server options. Each AP w=
ill
        get a new subnet from the range and clients will be addressed in th=
at
-- =

2.26.2

--===============0676537344530033725==--

