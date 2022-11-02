Received: from mail.pappacoda.it (mail.pappacoda.it [128.116.175.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE6E27719
	for <iwd@lists.linux.dev>; Wed,  2 Nov 2022 21:55:32 +0000 (UTC)
Received: from [192.168.178.219] (orino.pappacoda.it [128.116.201.23])
	by mail.pappacoda.it (Postfix) with ESMTPSA id 96C8B3CFF0;
	Wed,  2 Nov 2022 22:55:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pappacoda.it;
	s=20211226; t=1667426128;
	bh=SMFaDl46xW1q8sb3jQVohvfEEI7weDVynePuQen+5/4=;
	h=Date:From:Subject:To:Cc:In-Reply-To:References:From;
	b=cdx3k0WECeYedCcmTdl25fG45ct/iAa7I8l8KxrvvO/w8CDtGlWuNJEZAALO60BrI
	 vy5UamI1pxT4xgYedHPqifs1mGqp7p4mYoA1t0PScIL6qSR1y4c4AGpC0DU84bUgT9
	 L2w5OGgGFwuEiqhVsTEtwa+RIaDYZ2vhGA3lnznHdJQ5Iseekhpe9RrCM+IXrt/Sfw
	 xhE1LZAvv/SHcOdNldPtEigl/4D8qH3X0mhVFXCMznyu6hINvOCDE1aj/gcbtkeWDW
	 YXsN3ZpC2AmC0z3DDQkKiyrmcDur82fdCPRWTycrOdBo2hIUdd6BslGOy4t6MMjU7h
	 lBD0HyAH0OZ+Q==
Date: Wed, 02 Nov 2022 22:55:19 +0100
From: Andrea Pappacoda <andrea@pappacoda.it>
Subject: Re: MulticastDNS for all connections
To: James Prestwood <prestwoj@gmail.com>
Cc: iwd@lists.linux.dev
Message-Id: <78QQKR.LWXY3PZ4TZEX@pappacoda.it>
In-Reply-To: <c1a5ac7f3d1efb63c66218c147d6188e3e8ebc51.camel@gmail.com>
References: <A4TIKR.5DC9OCNE90W6@pappacoda.it>
	<66b9f15578d9f7112e532a7174268b02b629360f.camel@gmail.com>
	<CZLQKR.DUWHOW09XS8D@pappacoda.it>
	<c1a5ac7f3d1efb63c66218c147d6188e3e8ebc51.camel@gmail.com>
X-Mailer: geary/43.0
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed

Il giorno mer 2 nov 2022 alle 13:47:57 -07:00:00, James Prestwood 
<prestwoj@gmail.com> ha scritto:
> I've attached a patch if you want to try it out. I quickly tested only
> that "resolvectl status" showed +mDNS or -mDNS depending on what it 
> was
> set to. In actuality this is probably enough since all we do is set 
> the
> value to systemd and let it handle it.

Thanks James, I can confirm that this works for me too.

I'll be using this patch locally for the time being, but it would be 
great to get this merged; I can update the documentation too and submit 
everything as a patch to the mailing list if you want (of course, you 
could do this yourself if you prefer) :)

Thanks again!


