Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858A734186
	for <iwd@lists.linux.dev>; Fri, 24 Nov 2023 16:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="gJrXF3Lr"
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1700844783; bh=SBGsy3Nz19QQPy3lSGEbMnjmOP1kiiUut/C+BtuyABM=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=gJrXF3LrCAotOTVCcdkoSVxz78YY93nA+OAOMSLS45HV9GSo0zsxvyI2XyZwbhcbU
	 N/2PN3Zk3JHxCCM+E/wDGw/AyqDb0kYX8J1TGFt4QKUl3q3SAXUdYghwxthnHHUlKG
	 wp8rqjw1z7/2m/BvpRZCE3JuqKVRi7DRKTi8AzwZtjdlz4jW/5p7T2ri97mi2pv93e
	 S9Gs2yhaT85MHSIsASGXE9ikJN0qwHmVlYoXaywolNSDW33qw3n7n84GM5hnN2Jevu
	 QZKSe34SrnHMFbBorkX4jwka3PpNMyMUnverCEmNC3pSnSOExYqNVZRS8EIDJDVQql
	 rlaM4SfBtJDAg==
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
Subject: Re: Wrong source MAC for DHCP requests with
 AddressRandomization=network
In-Reply-To: <0d1aaf1b-09b3-48c9-82ed-fa3a46cc56b2@gmail.com>
References: <87fs0ve52l.fsf@toke.dk>
 <0d1aaf1b-09b3-48c9-82ed-fa3a46cc56b2@gmail.com>
Date: Fri, 24 Nov 2023 17:53:03 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87plzzhz4g.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Denis Kenzior <denkenz@gmail.com> writes:

> Hi Toke,
>
> On 11/24/23 05:58, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Hi
>>=20
>> When setting AddressRandomization=3Dnetwork in main.conf, I am unable to
>> connect to networks because I don't get a DHCP reply after the L2
>> connection.
>>=20
>> Looking at a packet dump, it seems the DHCP request uses the wrong
>> source MAC in the request:
>>=20
>
> Can you try the following patch on the ell mailing list?  Here's the patc=
hwork=20
> link in case you're not subscribed:
> https://patchwork.kernel.org/project/ell/patch/20231124161740.1243946-1-d=
enkenz@gmail.com/

Yup, that resolves the issue so that I can connect. However, this is the
DHCP packets I see when moving between two networks (back and forth):


17:49:59.040639 1e:aa:ca:6d:0d:e0 > 92:0a:9a:27:ca:65, ethertype IPv4 (0x08=
00), length 342: 10.42.3.52.68 > 10.42.3.33.67: BOOTP/DHCP, Request from 1e=
:aa:ca:6d:0d:e0, length 300
17:49:59.392682 ba:06:75:75:30:90 > ff:ff:ff:ff:ff:ff, ethertype IPv4 (0x08=
00), length 342: 0.0.0.0.68 > 255.255.255.255.67: BOOTP/DHCP, Request from =
ba:06:75:75:30:90, length 300
17:49:59.396012 e6:49:86:36:22:bf > ba:06:75:75:30:90, ethertype IPv4 (0x08=
00), length 335: 10.42.3.97.67 > 10.42.3.102.68: BOOTP/DHCP, Reply, length =
293
17:49:59.396167 ba:06:75:75:30:90 > ff:ff:ff:ff:ff:ff, ethertype IPv4 (0x08=
00), length 342: 0.0.0.0.68 > 255.255.255.255.67: BOOTP/DHCP, Request from =
ba:06:75:75:30:90, length 300
17:49:59.397811 e6:49:86:36:22:bf > ba:06:75:75:30:90, ethertype IPv4 (0x08=
00), length 335: 10.42.3.97.67 > 10.42.3.102.68: BOOTP/DHCP, Reply, length =
293

17:50:03.306455 ba:06:75:75:30:90 > e6:49:86:36:22:bf, ethertype IPv4 (0x08=
00), length 342: 10.42.3.102.68 > 10.42.3.97.67: BOOTP/DHCP, Request from b=
a:06:75:75:30:90, length 300
17:50:03.614293 1e:aa:ca:6d:0d:e0 > ff:ff:ff:ff:ff:ff, ethertype IPv4 (0x08=
00), length 342: 0.0.0.0.68 > 255.255.255.255.67: BOOTP/DHCP, Request from =
1e:aa:ca:6d:0d:e0, length 300
17:50:03.619009 92:0a:9a:27:ca:65 > 1e:aa:ca:6d:0d:e0, ethertype IPv4 (0x08=
00), length 359: 10.42.3.33.67 > 10.42.3.52.68: BOOTP/DHCP, Reply, length 3=
17
17:50:03.619085 1e:aa:ca:6d:0d:e0 > ff:ff:ff:ff:ff:ff, ethertype IPv4 (0x08=
00), length 342: 0.0.0.0.68 > 255.255.255.255.67: BOOTP/DHCP, Request from =
1e:aa:ca:6d:0d:e0, length 300
17:50:03.620141 92:0a:9a:27:ca:65 > 1e:aa:ca:6d:0d:e0, ethertype IPv4 (0x08=
00), length 359: 10.42.3.33.67 > 10.42.3.52.68: BOOTP/DHCP, Reply, length 3=
17

As you can see, in each case, there's an initial unicast request that
contains the old MAC and IP. Which seems to be a bit counter productive
if this is supposed to be a privacy feature that doesn't leak addresses
across networks? :)

-Toke
