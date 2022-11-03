Received: from mail.pappacoda.it (mail.pappacoda.it [128.116.175.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B556079C1
	for <iwd@lists.linux.dev>; Thu,  3 Nov 2022 21:59:08 +0000 (UTC)
Received: from [192.168.178.107] (orino.pappacoda.it [128.116.201.23])
	by mail.pappacoda.it (Postfix) with ESMTPSA id 45D753D4D1;
	Thu,  3 Nov 2022 22:59:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pappacoda.it;
	s=20211226; t=1667512746;
	bh=tJkQXS27aAR7kDEtm9ltFUM90PcxHm5Y3gxz+erKNTs=;
	h=Date:From:Subject:To:Cc:In-Reply-To:References:From;
	b=B+v0z5lJKv064KlTQNOT6TbIicqdJissgRWjzjIejkguBhMi5G7VDwK3tCTI8L80K
	 dmg65tRl3VmYyofhG/2+UdLoaFAEAEASJsBUX7oVfhrxBu4x+Hz9JWo4SvN41k85wF
	 IoaCIcrelPwBkmJFC6vW2XboLkQy6j7tUh74XOlHk/UVh2v3eFeaE3DQQIBPkgAmGa
	 Kjd7tmlcc4CraEVV7vSzsaI2sJE/YMZZmVNPAEGKjgoIai0gKtQMVVfE0c11eTS67L
	 6O8tWceoP8dxGad6r61wgstuRiId29xFy+oYAIfKFH2nGeWx7GUT3cQ0JShRGpADli
	 pVarhTEdGzFCQ==
Date: Thu, 03 Nov 2022 22:58:59 +0100
From: Andrea Pappacoda <andrea@pappacoda.it>
Subject: Re: [PATCH 2/2] doc: document global MulticastDNS option
To: Denis Kenzior <denkenz@gmail.com>
Cc: iwd@lists.linux.dev
Message-Id: <B2LSKR.D7EWT15BQHCU@pappacoda.it>
In-Reply-To: <5TJSKR.MEMQ5IPV9F42@pappacoda.it>
References: <20221103105639.8289-1-andrea@pappacoda.it>
	<20221103105639.8289-2-andrea@pappacoda.it>
	<5aca9b77-5c66-7744-8e33-a0578b645408@gmail.com>
	<5TJSKR.MEMQ5IPV9F42@pappacoda.it>
X-Mailer: geary/43.0
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed

Hi again,

Il giorno gio 3 nov 2022 alle 22:31:53 +01:00:00, Andrea Pappacoda 
<andrea@pappacoda.it> ha scritto:
> As far as I understand, when no link-specific value is provided on 
> the D-Bus interface, resolved sets LLMNR to "yes"[1] and mDNS to 
> "no"[2]. It is possible that I have misinterpreted the code though, 
> so checking if this is actually the case could still be worth it.

Thinking about this more, I'm starting to see this as a bug in 
systemd-resolved. I've reported it on 
<https://github.com/systemd/systemd/issues/25252>.

For the time being, it may be better not to merge this.


