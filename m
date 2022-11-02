Received: from mail.pappacoda.it (mail.pappacoda.it [128.116.175.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D2324F5D
	for <iwd@lists.linux.dev>; Wed,  2 Nov 2022 20:23:56 +0000 (UTC)
Received: from [192.168.178.216] (orino.pappacoda.it [128.116.201.23])
	by mail.pappacoda.it (Postfix) with ESMTPSA id 6D2783CFF0;
	Wed,  2 Nov 2022 21:23:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pappacoda.it;
	s=20211226; t=1667420627;
	bh=kI4MCuXnzFj+k3TIS8xynSpoEwsB9JJaCV+GE582XkU=;
	h=Date:From:Subject:To:Cc:In-Reply-To:References:From;
	b=a/J4JPWln+ZmcZytkl01IXBgJrfPhJ63ax6lo39lvJzzISwLJvhJ2PaaZ+AK0xJGr
	 n4u4Rl+1T6JJ63Bygga7CB6cVAikEcEuf1THYvS6V/H938fUBs3vWRsTrpoJF8DQbR
	 M0CV7J9nA0Ir8wXD2zRwlXngcCT7bcoTDJA9yti9UzRVH7nmzHyvlG4oQLjpfPjd9h
	 xc5yMbwbzn794SyImSZYLDEQeqhnhaNrmT0RMsAIeEx6PP+eFnKzOUnSG15LhZfvEJ
	 PHeaNn+BIDI09RfYFseUcyKbvnPiN8rdGaZfYSK9UquDNMe1sBabn8CdW5E7zxcWTk
	 uLLkB89PMID5A==
Date: Wed, 02 Nov 2022 21:23:36 +0100
From: Andrea Pappacoda <andrea@pappacoda.it>
Subject: Re: MulticastDNS for all connections
To: James Prestwood <prestwoj@gmail.com>
Cc: iwd@lists.linux.dev
Message-Id: <CZLQKR.DUWHOW09XS8D@pappacoda.it>
In-Reply-To: <66b9f15578d9f7112e532a7174268b02b629360f.camel@gmail.com>
References: <A4TIKR.5DC9OCNE90W6@pappacoda.it>
	<66b9f15578d9f7112e532a7174268b02b629360f.camel@gmail.com>
X-Mailer: geary/43.0
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed

Hi James, thanks for your reply :)

Il giorno mar 1 nov 2022 alle 13:54:36 -07:00:00, James Prestwood 
<prestwoj@gmail.com> ha scritto:
> Currently the MulticastDNS option is only per-network, but systemd-
> resolved has a global setting itself according to the docs [1].
> 
> But I actually wonder if event setting MulticastDNS in IWD is doing
> anything:
> 
> "Multicast DNS will be enabled on a link only if the per-link and the
> global setting is on."
> 
> This would imply you need to set /etc/systemd/resolved.conf with
> MulticastDNS=true to even use mDNS at all? Or maybe you have already
> done this? And I see the problem, per-link settings are only in
> systemd-networkd, which you don't use...

Yes, MulticastDNS needs to be enabled globally in resolved.conf (it is 
enabled by default) and also be enabled by whoever is managing the 
network interface.

Enabling mDNS in specific networks by adding MulticastDNS=true in 
/var/lib/iwd/network-name works as expected.

> Like I said, I don't know much about mDNS but would a global option
> 'break' networks which don't support mDNS? Are you frequently
> connecting to many networks and needed to add this option to the
> profile each time?

I used to have mDNS globally enabled in NetworkManager, and it never 
created issues. As far as I understand, enabling mDNS simply allows you 
do to Multicast DNS queries on that network; it shouldn't interfere 
with non-multicast queries. I use mDNS every once in a while (on three 
different networks since last week), so I'd like to simply enable the 
global setting and forget about it.

> The fact that this depends on setting systemd-resolved's global option
> and the per-link option I would say this really should stay in 
> systemd-
> * itself. The IWD setting is kinda useless without the global option
> anyways. Plus systemd-networkd is much more flexible, you can match
> based on all kinds of things where IWD is very rigid (global or per-
> network).

iwd has an option that enables it to replace other network managers for 
simple use cases, EnableNetworkConfiguration=true, so it seems 
reasonable for somebody to not have any other connection manager 
installed, and for those use cases I'd say that iwd's coarseness is 
fine. I've applied a quick and dirty patch on top of version 1.30, and 
it seems to work without issues; mdns_global probably leaks, but this 
can't be applied on master anyway and I was just trying to figure out 
how easy it would be to add this feature.

diff --git a/src/netconfig.c b/src/netconfig.c
index 4a70b0ca..3e3c36a9 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -95,6 +95,7 @@ static struct l_queue *netconfig_list;
  */
 static uint32_t ROUTE_PRIORITY_OFFSET;
 static bool ipv6_enabled;
+static char* mdns_global;

 static void do_debug(const char *str, void *user_data)
 {
@@ -1432,6 +1433,11 @@ bool netconfig_load_settings(struct netconfig 
*netconfig,

 	mdns = l_settings_get_string(active_settings,
 					"Network", "MulticastDNS");
+	if (!mdns) {
+		const size_t mdns_global_size = strlen(mdns_global) + 1;
+		mdns = malloc(mdns_global_size);
+		memcpy(mdns, mdns_global, mdns_global_size);
+	}

 	if (l_settings_has_key(active_settings, "IPv4", "Address")) {
 		v4_address = netconfig_get_static4_address(active_settings);
@@ -1757,6 +1763,8 @@ static int netconfig_init(void)
 					&ipv6_enabled))
 		ipv6_enabled = false;

+	mdns_global = l_settings_get_string(iwd_get_config(), "Network", 
"MulticastDNS");
+
 	netconfig_list = l_queue_new();

 	return 0;


