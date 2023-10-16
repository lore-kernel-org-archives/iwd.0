Received: from out-192.mta1.migadu.com (out-192.mta1.migadu.com [95.215.58.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BD0358BB
	for <iwd@lists.linux.dev>; Mon, 16 Oct 2023 20:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kazlauskas.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kazlauskas.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kazlauskas.me header.i=@kazlauskas.me header.b="xXNRF7qR"
Date: Mon, 16 Oct 2023 23:20:33 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kazlauskas.me;
	s=key1; t=1697487637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hduW66cSMqH07Mhqhl4CNwyZTYJtf1m58GlIkQEjFFs=;
	b=xXNRF7qRZVKhe6JU1lW1FQrt/A8lRg6q18u38+deHM1QJrBlAaDtlBI1Xc25vvlV3M/ucz
	XZ3I1fskNqvDz4tTnGMEc3SjYWYkT/ZxJxq9X9W4lfmfdxrSGqgOVXPft6swPMsSrOKUhi
	JootxkKEJs1YprKGjgnAWqeFMv4g3VE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Simonas Kazlauskas <iwd.lists.linux.dev@kazlauskas.me>
To: James Prestwood <prestwoj@gmail.com>
Cc: iwd@lists.linux.dev, Denis Kenzior <denkenz@gmail.com>
Subject: Re: Is the data rate estimation for 5GHz channels overly pessimistic?
Message-ID: <ncmtsi42vkdimzxsuktgfblp66agskivhuntdjlooyp7gglhgo@kwuxknllo527>
References: <xxpypqwyk3gjrwjmpuvxqdlipkrb3fbw7augfey5ovr3lgbgul@2tbf6xw2uo3z>
 <5780e1b2-8956-46bb-8116-b513cc564cea@gmail.com>
 <5ff58310-c5ee-4694-821a-0c802cdedb89@gmail.com>
 <bwuu4ra65fpfpenytgu5a6ftjpvyury4omx7ucy65cshorqskl@5ikhebki4wnk>
 <05aedfe6-82ad-4e41-a9fa-e9f8a5619947@gmail.com>
 <tkizdohkwpz4nfgjczdzltr7qhvjtcyyk6x3543dht2gmm7ssc@q7m4rq3r3sqx>
 <f7ced477-6fa4-4efd-bf54-817b100041ef@gmail.com>
 <ccb68e07-e4a0-4e50-b7e2-2a2044d38487@gmail.com>
 <30b6dad4-64b2-41ca-8712-053cb1396eaf@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <30b6dad4-64b2-41ca-8712-053cb1396eaf@gmail.com>
X-Migadu-Flow: FLOW_OUT

James,

Thank you for implementing the display of HE capabilities in `iwmon` – these do 
indeed show up in my scans now, false alert there.

> HE Capabilities: len 34
>     HE supported channel width set: bit  1: 40MHz/80MHz supported (5GHz/6GHz)
>         Rx HE-MCS Map <= 80MHz 1 Streams: MCS 0-11 supported
>         Rx HE-MCS Map <= 80MHz 2 Streams: MCS 0-11 supported
>         Rx HE-MCS Map <= 80MHz 3 Streams: MCS 0-11 supported
>         Rx HE-MCS Map <= 80MHz 4 Streams: MCS 0-11 supported
>         Tx HE-MCS Map <= 80MHz 1 Streams: MCS 0-11 supported
>         Tx HE-MCS Map <= 80MHz 2 Streams: MCS 0-11 supported
>         Tx HE-MCS Map <= 80MHz 3 Streams: MCS 0-11 supported
>         Tx HE-MCS Map <= 80MHz 4 Streams: MCS 0-11 supported
>     0d 01 08 9a 40 10 04 60 48 88 1f 43 81 1c 11 08  ....@..`H..C....
>     00 aa ff aa ff 7b 1c c7 71 1c c7 71 1c c7 71 1c  .....{..q..q..q.
>     c7 71                                            .q             

I’ve sent you and Denis both the pcap of the scan. I, unforunately, don’t think 
I’ll be able to hack on the test and/or data rate investigation much further 
before the weekend, but I’m happy to test out patches and such at any time.

Thanks,
S.
