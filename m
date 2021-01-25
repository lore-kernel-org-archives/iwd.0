Content-Type: multipart/mixed; boundary="===============8233187612208332086=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 6/7] doc: Specify the DNS format as string lists
Date: Mon, 25 Jan 2021 18:56:16 +0100
Message-ID: <20210125175617.2417412-6-andrew.zaborowski@intel.com>
In-Reply-To: <20210125175617.2417412-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8233187612208332086==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/iwd.network.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/iwd.network.rst b/src/iwd.network.rst
index c0548052..083b2103 100644
--- a/src/iwd.network.rst
+++ b/src/iwd.network.rst
@@ -301,9 +301,9 @@ network configuration with the static addresses.
        The IPv4 address of the gateway (router). This field is `required` =
for
        the static configuration.
    * - DNS
-     - IPv4 address string
+     - IPv4 address string list, space delimited
 =

-       The IPv4 address of the Domain Name System (DNS). This field is
+       The IPv4 address(es) of the Domain Name System (DNS). This field is
        `optional`. DNS setting can be used to override the DNS entries rec=
eived
        from the DHCP server.
    * - Netmask
@@ -352,9 +352,9 @@ network configuration.
        The IPv6 address of the gateway (router). This field is `required` =
for
        the static configuration.
    * - DNS
-     - IPv6 address string
+     - IPv6 address string list, space delimited
 =

-       The IPv6 address of the Domain Name System (DNS). This field is
+       The IPv6 address(es) of the Domain Name System (DNS). This field is
        `optional`. DNS setting can be used to override the DNS entries rec=
eived
        from the DHCPv6 server or via Router Advertisements.
    * - DomainName
-- =

2.27.0

--===============8233187612208332086==--

