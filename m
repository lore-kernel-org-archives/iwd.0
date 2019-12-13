Content-Type: multipart/mixed; boundary="===============2531144109782569678=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH] manpage: Add section about IPv4 static network configuration
Date: Fri, 13 Dec 2019 14:03:59 -0800
Message-ID: <20191213220359.5778-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2531144109782569678==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/iwd.network.rst | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/src/iwd.network.rst b/src/iwd.network.rst
index 756addf3..6b068202 100644
--- a/src/iwd.network.rst
+++ b/src/iwd.network.rst
@@ -232,6 +232,51 @@ authentication configuration.
        method's negotiation is encrypted, a secure identity string can be
        provided.
 =

+Network Configuration Settings
+-------------------------------
+
+The group ``[IPv4]`` contains settings for Internet Protocol version 4 (IP=
v4)
+network configuration with the static addresses.
+
+.. list-table::
+   :header-rows: 0
+   :stub-columns: 0
+   :widths: 20 80
+   :align: left
+
+   * - Address
+     - IPv4 address string
+
+       The IPv4 address to assign. This field is `required` for the static
+       configuration.
+   * - Gateway
+     - IPv4 address string
+
+       The IPv4 address of the gateway (router). This field is `required` =
for
+       the static configuration.
+   * - DNS
+     - IPv4 address string
+
+       The IPv4 address of the Domain Name System (DNS). This field is
+       `optional`. DNS setting can be used to override the DNS entries rec=
eived
+       from the DHCP server.
+   * - Netmask
+     - IPv4 address string
+
+       The IPv4 address of the subnet. This field is `optional`. 255.255.2=
55.0
+       is used as default Netmask.
+   * - Broadcast
+     - IPv4 address string
+
+       The IPv4 address to be used for the broadcast. This field is `optio=
nal`.
+   * - DomainName
+     - string
+
+       The DomainName is the name of the local Internet domain. This field=
 is
+       `optional`. DomainName setting can be used to override the DomainNa=
me
+       value obtained from the DHCP server.
+
+
 Embedded PEMs
 -------------
 =

-- =

2.13.6

--===============2531144109782569678==--

