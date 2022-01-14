Content-Type: multipart/mixed; boundary="===============8409779986874471191=="
MIME-Version: 1.0
From: Diederik de Haas <didi.debian at cknow.org>
To: iwd at lists.01.org
Subject: [PATCH] doc: fix overriden -> overridden
Date: Fri, 14 Jan 2022 18:56:41 +0100
Message-ID: <20220114175641.12351-1-didi.debian@cknow.org>

--===============8409779986874471191==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/iwd.config.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/iwd.config.rst b/src/iwd.config.rst
index 5cd2b06b..54943702 100644
--- a/src/iwd.config.rst
+++ b/src/iwd.config.rst
@@ -205,7 +205,7 @@ The group ``[Network]`` contains network configuration =
related settings.
        Sets the global default that tells **iwd** whether it should config=
ure
        IPv6 addresses and routes (either provided via static settings,
        Router Advertisements or DHCPv6 protocol).  This setting is disabled
-       by default.  This setting can also be overriden on a per-network ba=
sis.
+       by default.  This setting can also be overridden on a per-network b=
asis.
 =

    * - NameResolvingService
      - Values: resolvconf, **systemd**
-- =

2.34.1

--===============8409779986874471191==--

