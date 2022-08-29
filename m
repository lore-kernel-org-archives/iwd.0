Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778074699
	for <iwd@lists.linux.dev>; Mon, 29 Aug 2022 17:36:09 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id e20so11067108wri.13
        for <iwd@lists.linux.dev>; Mon, 29 Aug 2022 10:36:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc;
        bh=Y0uxsS8vrws1d0DMmgdCkfHsloe+nE0GWY/7OyKDWU4=;
        b=kj4StaiNiF0haAaCFV8XwLVeY/8RisqRNITaPT0ug4yquKWejk8EBll9Lp7DdOGx8G
         o6m7gFP9XTVDe+6S92dlxwsDjKoDqtDvryQwXEAF370ZVU8kx/ZWjAudJeScdEVzijl6
         eZBov9OiLM8+v+blr9HhR0Ehc+YZ/jLULIEVWmo7IQY9cdVBbL5IGPirBirc/YwqKI10
         Luz+KLqCSOGnpUgiAQcwNIiVVfcAC85IGeehe/MUv/5D/hYe9y05lVr9AQceSaV+WwqT
         7o5iY0et4mK9WfktNa0dD/ItY2yd8MsLRoQEufn4hAcjfRexHbzs5E/FzkPCiYU0rWlI
         S19w==
X-Gm-Message-State: ACgBeo1OcCV7qWqodktEli3qq3OMmUnP6yf2QDLkD4FwpAjD2IutUJRr
	jCTlM0glgLwikaSWWGverqIZyu0DMDbP1Q==
X-Google-Smtp-Source: AA6agR70fK5vOLRD22dyEPEmksbiJ51DuAh+Y5SvCR8avNIzgclfVGeWAl3YHlboNTRDxXuWUAIMcg==
X-Received: by 2002:a5d:5c0a:0:b0:225:b956:4e56 with SMTP id cc10-20020a5d5c0a000000b00225b9564e56mr6872559wrb.218.1661794567339;
        Mon, 29 Aug 2022 10:36:07 -0700 (PDT)
Received: from iss.ger.corp.intel.com ([82.213.228.103])
        by smtp.gmail.com with ESMTPSA id q3-20020a1ce903000000b003a61306d79dsm9830551wmc.41.2022.08.29.10.36.06
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 10:36:07 -0700 (PDT)
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
To: iwd@lists.linux.dev
Subject: [PATCH 01/10] doc: Update Netconfig Agent API doc
Date: Mon, 29 Aug 2022 19:35:52 +0200
Message-Id: <20220829173601.1963953-1-andrew.zaborowski@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update ConfigureIPv{4,6}() parameters to simplify mapping our sets of
addresses and routes directly to D-Bus dictionaries.  Split Cancel()
into CancelIPv{4,6}().
---
 doc/agent-api.txt | 123 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 97 insertions(+), 26 deletions(-)

diff --git a/doc/agent-api.txt b/doc/agent-api.txt
index 250628eb..e9bb95ca 100644
--- a/doc/agent-api.txt
+++ b/doc/agent-api.txt
@@ -145,50 +145,121 @@ Methods		void Release() [noreply]
 			agent, because when this method gets called it has
 			already been unregistered.
 
-		void ConfigureIPv4(object device, string interface, dict config)
-
-			This method gets called during a connection setup
-			when a new set of IPv4 configuration values is to
-			be written to a network interface.  The connection
-			is aborted if the method call returns an error or
-			times out.  The 'config' dictionary (a{sv}) maps
-			string keys to values of types defined per key.
-
-			The following key/value pairs are used, but more
+		void ConfigureIPv4(object device, dict config)
+
+			This method gets called during connection setup
+			and later while the connection is operational
+			whenever a new set of IPv4 configuration values is to
+			be written to a network interface.  The connection is
+			aborted if the method call returns an error or times
+			out.
+
+			In case of a station-mode connection, the 'device'
+			parameter points at an object with a
+			net.connman.iwd.Device interface whose Name property
+			contains the name of network interface.  In case of a
+			P2P connection, the object will have
+			a net.connman.iwd.p2p.Peer interface whose
+			ConnectectedInterface property contains the name of
+			the target network interface.
+
+			The 'config' dictionary (a{sv}) maps string keys to
+			values of types defined per key.  Each call receives
+			the full set of values which supersede those from
+			previous calls.
+
+			The following key/value pairs are defined, but more
 			may be added in future versions.
 
 			string Method - Indicates whether the local address
 			was set statically (value "static") or obtained
 			automatically such as through DHCP (value "auto").
-			Even when the address was obtained from the remote
+			Even when addresses were obtained from the remote
 			end some configuration bits, such as DNS addresses,
 			may have been overridden locally.
 
-			string Address - Local IP address string.
-
-			byte PrefixLength - Holds the prefix-length of the
-			local subnet.  For IPv4 this maps to the netmask.
+			array(dict) Addresses - Local IP addresses.  Each
+			address is described by a set of key/value properties
+			as documented further down.
 
-			string Gateway [optional] - Local subnet's gateway
-			address if one exists.
+			array(dict) Routes - Routes for on-link and off-link
+			prefixes/subnets and default routers.  Each route is
+			described by a set of key/value properties as
+			documented further down.
 
 			array(string) DomainNameServers [optional] - Holds
-			the list of DNS addresses configured if any exist.
+			the list of DNS server addresses configured if any
+			exist.
 
 			array(string) DomainNames [optional] - Holds the
 			network's local domain names if any exist.
 
+			string MDNS [optional] - One of "true", "false" and
+			"resolve".  Controls whether Multicast DNS support is
+			to be enabled on the link.  When set to "resolve",
+			only resolution is enabled, but not host or service
+			registration and announcement (see systemd.network(5).)
+
+			The following properties are defined for local
+			addresses, but more may be added in the future:
+
+			string Address - Holds the IP address string.
+
+			byte PrefixLength [optional] - Prefix length
+			associated with the address's subnet (IPv4 only).
+
+			string Broadcast [optional] - Broadcast address
+			associated with the address's subnet (IPv4 only).
+
+			uint32 ValidLifetime [optional] - Remaining validity
+			and ownership time for this address assignment/lease,
+			in seconds at the time of the method call.
+			If absent the address doesn't expire.
+
+			uint32 PreferredLifetime [optional] - Number of
+			seconds left at the time of the method call for this
+			address to be preferred over other addresses.
+
+			The following properties are defined for routes,
+			but more may be added in the future:
+
+			string, byte Destination [optional] - Holds the
+			route's destination IP prefix string and the prefix
+			length in bits.  Absent for default routes.
+
+			string Router [optional] - Holds the router's IP
+			address.  Absent for on-link routes.
+
+			string PreferredSource [optional] - Route source IP
+			address.
+
+			uint32 Lifetime [optional] - Remaining route validity
+			time in seconds at the time of the method call.
+			If absent the route doesn't expire.
+
+			uint32 Priority - Relative route priority.
+
+			byte Preference [optional] - ICMPv6 route preference:
+			0 for medium, 1 for high and 3 for low.
+
+			uint32 MTU [optional] - Router MTU.
+
 			Possible Errors: net.connman.iwd.Agent.Error.Canceled
+					 net.connman.iwd.Agent.Error.Failed
 
-		void ConfigureIPv6(object device, string interface, dict config)
+		void ConfigureIPv6(object device, dict config)
 
 			Same as ConfigureIPv4 above but for IPv6.
 
-		void Cancel(object device, string interface,
-						string reason) [noreply]
+		void CancelIPv4(object device, string reason) [noreply]
 
-			This method gets called to indicate that the connection
-			request failed before a reply was returned.  The
-			argument will indicate why the request is being
-			cancelled and may be "out-of-range", "user-canceled",
-			"timed-out" or "shutdown".
+			This method gets called to indicate that the network
+			configuration was aborted before a reply was received
+			for an ongoing ConfigureIPv4 or ConfigureIPv6 call.
+			The last argument will indicate why the request is being
+			cancelled and may be one of: "aborted", "superseded",
+			"timed-out".
+
+		void CancelIPv6(object device, string reason) [noreply]
+
+			Same as CancelIPv4 above but for IPv6.
-- 
2.34.1

