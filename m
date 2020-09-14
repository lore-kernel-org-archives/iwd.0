Content-Type: multipart/mixed; boundary="===============3949892623684677582=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 3/5] netconfig: Don't bswap IP netmasks for __builtin_popcountl
Date: Mon, 14 Sep 2020 15:51:18 +0200
Message-ID: <20200914135120.463623-3-andrew.zaborowski@intel.com>
In-Reply-To: <20200914135120.463623-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3949892623684677582==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The __builtin_popcountl() value shouldn't change with the endianness.
---
 src/netconfig.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/netconfig.c b/src/netconfig.c
index de526460..ca76f475 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -152,7 +152,7 @@ static struct netconfig_ifaddr *netconfig_ipv4_get_ifad=
dr(
 =

 		if (netmask && inet_pton(AF_INET, netmask, &in_addr) > 0)
 			ifaddr->prefix_len =3D __builtin_popcountl(
-						L_BE32_TO_CPU(in_addr.s_addr));
+								in_addr.s_addr);
 		else
 			ifaddr->prefix_len =3D 24;
 =

@@ -187,7 +187,7 @@ static struct netconfig_ifaddr *netconfig_ipv4_get_ifad=
dr(
 =

 		if (netmask && inet_pton(AF_INET, netmask, &in_addr) > 0)
 			ifaddr->prefix_len =3D __builtin_popcountl(
-						L_BE32_TO_CPU(in_addr.s_addr));
+								in_addr.s_addr);
 		else
 			ifaddr->prefix_len =3D 24;
 =

-- =

2.25.1

--===============3949892623684677582==--

