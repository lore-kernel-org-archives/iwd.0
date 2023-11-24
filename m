Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7AC364D1
	for <iwd@lists.linux.dev>; Fri, 24 Nov 2023 17:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="NP07HF7E"
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1700848301; bh=+mCMZydcRgSybcfAasZvnu1v4OSKed1IJHwkhPDRQyM=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=NP07HF7EpFWA9HlpNYGZK8IttoryY150pkltvRLd5MaSIt8bW5XhX6jVjd3QAweQv
	 CanMwtgh/iGMKf63PuA9ntsTc3RhGYtulSPnvTtv3RSzDIbTotI+5E3xUVvA7RcbmF
	 k+NGDlVR7+ZOlH7F4dXg0qVhoekO5YcXmrzR4wEMYiYqqHQb6q/BMBwVH49dt+wHPy
	 i3Na7aRgZERxMwE5dgR6VgW3HS2oZCfiWCy7z08d3RYt/BEfoguoN1dlXIgMovAJMf
	 UqxxgVAzMwTS+vDXUtJdvS52wYEEZmnvxwXMcDF5xTiEAWgcUnjRJs4B46RZ9mzDSE
	 HeCSXM9OMKPQA==
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
Subject: Re: Wrong source MAC for DHCP requests with
 AddressRandomization=network
In-Reply-To: <c3854a08-c529-46e2-81ed-29cd4046de4f@gmail.com>
References: <87fs0ve52l.fsf@toke.dk>
 <0d1aaf1b-09b3-48c9-82ed-fa3a46cc56b2@gmail.com> <87plzzhz4g.fsf@toke.dk>
 <c3854a08-c529-46e2-81ed-29cd4046de4f@gmail.com>
Date: Fri, 24 Nov 2023 18:51:41 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87jzq7hweq.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Denis Kenzior <denkenz@gmail.com> writes:

> Hi Toke,
>
>> 
>> Yup, that resolves the issue so that I can connect. However, this is the
>> DHCP packets I see when moving between two networks (back and forth):
>> 
>
> Excellent.
>
>> 
>> 17:49:59.040639 1e:aa:ca:6d:0d:e0 > 92:0a:9a:27:ca:65, ethertype IPv4 (0x0800), length 342: 10.42.3.52.68 > 10.42.3.33.67: BOOTP/DHCP, Request from 1e:aa:ca:6d:0d:e0, length 300
>
> Looking at the timestamps, are you sure this isn't a DHCP RELEASE going out to 
> the old network?

Ah, yes, you're right, that's the release - my bad! Didn't realise a
release was also a "request" type at the top protocol level :)

So in that case, thanks for the quick fix!

-Toke
