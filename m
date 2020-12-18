Content-Type: multipart/mixed; boundary="===============5616826236863713770=="
MIME-Version: 1.0
From: Carlo Abelli <carlo@abelli.me>
Subject: [PATCH] doc: move EnableIPv6 under Network
Date: Fri, 18 Dec 2020 15:38:35 +0000
Message-ID: <JeV4Wk3SvSFU71O5N8M4n_9Zevtn3449VpZsEB05_kCXcFkbQUdW8w6Or5_vmIfqte6aiYRCyhaCzWyEsG9ZS0OPoTZ_ceXbYMceT8x0WL0=@abelli.me>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5616826236863713770==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The EnableIPv6 option is incorrectly documented under General but should
be documented under Network instead.
---
 src/iwd.config.rst | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/src/iwd.config.rst b/src/iwd.config.rst
index f74e31cf..365494a4 100644
--- a/src/iwd.config.rst
+++ b/src/iwd.config.rst
@@ -74,14 +74,6 @@ The group ``[General]`` contains general settings.
        ``[Network]`` settings for additional settings related to network
        configuration.

-   * - EnableIPv6
-     - Values: true, **false**
-
-       Sets the global default that tells **iwd** whether it should config=
ure
-       IPv6 addresses and routes (either provided via static settings,
-       Router Advertisements or DHCPv6 protocol).  This setting is disabled
-       by default.  This setting can also be overriden on a per-network ba=
sis.
-
    * - APRanges
      - Values: <IP in prefix notation>

@@ -186,6 +178,14 @@ The group ``[Network]`` contains network configuration=
 related settings.
    :widths: 20 80
    :align: left

+   * - EnableIPv6
+     - Values: true, **false**
+
+       Sets the global default that tells **iwd** whether it should config=
ure
+       IPv6 addresses and routes (either provided via static settings,
+       Router Advertisements or DHCPv6 protocol).  This setting is disabled
+       by default.  This setting can also be overriden on a per-network ba=
sis.
+
    * - NameResolvingService
      - Values: resolvconf, **systemd**

--
2.29.2


--===============5616826236863713770==--

