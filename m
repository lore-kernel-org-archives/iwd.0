Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0362031B
	for <iwd@lists.linux.dev>; Fri, 24 Nov 2023 12:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="csoMYLxU"
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1700827091; bh=k86ChJSs3irO7wxRruubV+FW0iYXJa34G4H17LpeA3Y=;
	h=From:To:Subject:Date:From;
	b=csoMYLxUaLq5uriwZNxUd09GK797ieqdrdBiEFHsHOv4kMuOCr6GG5YrK5qCSpQXA
	 eq4wfHcO6SFVvEJWvhBtB6qhRWMzpgP1onb5TV5wOViq4wuP3/lilmAbao/S4M8DbD
	 kOUJvy3gYxuDpYikqTaaGimfVlAfR3P5TGCw93qAdCOgg+V0W6pr8FcpBe7CC5ncSI
	 Q9B/QZBeNgkLz2pWNQaBYyoK3/gEcri4e6NBi02d10siSU7amslVi2zaid+POJJjeI
	 V6R2LA2ejHej7FqoTUy3+IDRf9MHAfXIVB+yHgkQVcV0M2ihtgRqj3iF8TpTW3ZFbT
	 SoJeS4/Nz6gPg==
To: iwd@lists.linux.dev
Subject: Wrong source MAC for DHCP requests with AddressRandomization=network
Date: Fri, 24 Nov 2023 12:58:10 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87fs0ve52l.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Hi

When setting AddressRandomization=network in main.conf, I am unable to
connect to networks because I don't get a DHCP reply after the L2
connection.

Looking at a packet dump, it seems the DHCP request uses the wrong
source MAC in the request:


12:42:27.268867 1e:aa:ca:6d:0d:e0 > ff:ff:ff:ff:ff:ff, ethertype IPv4 (0x0800), length 342: 0.0.0.0.68 > 255.255.255.255.67: BOOTP/DHCP, Request from 26:db:f3:cb:58:e2, length 300

Running 'dhcpcd' uses the right source MAC, and gets a reply:

12:42:28.631616 1e:aa:ca:6d:0d:e0 > ff:ff:ff:ff:ff:ff, ethertype IPv4 (0x0800), length 342: 0.0.0.0.68 > 255.255.255.255.67: BOOTP/DHCP, Request from 1e:aa:ca:6d:0d:e0, length 300
12:42:28.634842 92:0a:9a:27:ca:65 > 1e:aa:ca:6d:0d:e0, ethertype IPv4 (0x0800), length 359: 10.42.3.33.67 > 10.42.3.52.68: BOOTP/DHCP, Reply, length 317
12:42:28.635323 1e:aa:ca:6d:0d:e0 > ff:ff:ff:ff:ff:ff, ethertype IPv4 (0x0800), length 342: 0.0.0.0.68 > 255.255.255.255.67: BOOTP/DHCP, Request from 1e:aa:ca:6d:0d:e0, length 300
12:42:28.636450 92:0a:9a:27:ca:65 > 1e:aa:ca:6d:0d:e0, ethertype IPv4 (0x0800), length 359: 10.42.3.33.67 > 10.42.3.52.68: BOOTP/DHCP, Reply, length 317

The initial connection after starting iwd works, but connecting to
another network later fails, so it seems to be related to the
per-network MAC address selection. Changing the config to
AddressRandomization=once makes this issue go away.

This issue occurs with both iwd 2.8 and 2.9 (on Arch Linux and iwlwifi
hardware).

-Toke
