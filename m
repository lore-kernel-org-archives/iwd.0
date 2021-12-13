Content-Type: multipart/mixed; boundary="===============8170943769735110578=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski at intel.com>
To: iwd at lists.01.org
Subject: [PATCH] doc: Extend the IP configuration agent API
Date: Mon, 13 Dec 2021 16:03:39 +0100
Message-ID: <20211213150339.65543-1-andrew.zaborowski@intel.com>

--===============8170943769735110578==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Basically convert the flat dictionary parameter passed to the agent with
configuration bits such as local address and gateway address, into an
array of such dictionaries.  While it's possible to set up multiple
subnets on one IPv4 network this is mostly meant for IPv6 where a set of
RFCs and recommendations document how multiple Router Advertisements can
be received on a network and, if some of them don't have the "managed"
but set, we end up with multiple addresses assigned through SLAAC.  On
our own request we may also be assigned multiple addresses within each
subnet through DHCP.

There are no plans to support such setups at this time but being a
public API it needs to be future proof.
---
 doc/agent-api.txt | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/doc/agent-api.txt b/doc/agent-api.txt
index 250628eb..f348a37d 100644
--- a/doc/agent-api.txt
+++ b/doc/agent-api.txt
@@ -145,32 +145,41 @@ Methods		void Release() [noreply]
 			agent, because when this method gets called it has
 			already been unregistered.
 =

-		void ConfigureIPv4(object device, string interface, dict config)
+		void ConfigureIPv4(object device, string interface,
+				   array(dict) configs)
 =

 			This method gets called during a connection setup
 			when a new set of IPv4 configuration values is to
 			be written to a network interface.  The connection
 			is aborted if the method call returns an error or
-			times out.  The 'config' dictionary (a{sv}) maps
-			string keys to values of types defined per key.
+			times out.  The 'configs' array contains a set of
+			IP configurations, one for each subnet that is
+			present on the network.  Each subnet configuration
+			dictionary (a{sv}) maps string keys to values of
+			types defined per key.
 =

 			The following key/value pairs are used, but more
-			may be added in future versions.
+			may be added in future versions.  This dictionary
+			is defined in the same way for IPv4 and IPv6.
 =

 			string Method - Indicates whether the local address
-			was set statically (value "static") or obtained
-			automatically such as through DHCP (value "auto").
-			Even when the address was obtained from the remote
-			end some configuration bits, such as DNS addresses,
-			may have been overridden locally.
-
-			string Address - Local IP address string.
+			on this subnet was set statically (value "static") or
+			obtained automatically such as through DHCP (value
+			"auto", inclused SLAAC for IPv6).  Even when the
+			address was obtained from the remote end some
+			configuration bits, such as DNS addresses, may have
+			been overridden locally.
 =

 			byte PrefixLength - Holds the prefix-length of the
 			local subnet.  For IPv4 this maps to the netmask.
 =

-			string Gateway [optional] - Local subnet's gateway
-			address if one exists.
+			array(string, uint16) Addresses - Local IP address
+			strings and their integer relative preference values.
+			Addresses with a lower value in the second element
+			are preferred.
+
+			string Gateway [optional] - The subnet's gateway or
+			router address if one exists.
 =

 			array(string) DomainNameServers [optional] - Holds
 			the list of DNS addresses configured if any exist.
@@ -180,7 +189,8 @@ Methods		void Release() [noreply]
 =

 			Possible Errors: net.connman.iwd.Agent.Error.Canceled
 =

-		void ConfigureIPv6(object device, string interface, dict config)
+		void ConfigureIPv6(object device, string interface,
+				   array(dict) configs)
 =

 			Same as ConfigureIPv4 above but for IPv6.
 =

-- =

2.32.0

--===============8170943769735110578==--

