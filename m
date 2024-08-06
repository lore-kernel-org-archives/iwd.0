Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD7822066
	for <iwd@lists.linux.dev>; Tue,  6 Aug 2024 17:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722965926; cv=none; b=blnhHYf6CR020l7Z6cmqodCcRhswNgC9P0Y4w7SMaSTAJoKVcXs3LM6DPwjDk43ORfYzEzsSHPn5jKjhyzzSxS4Q+unMT2cTr0BTHxQ5Np9mA6IJUE+5iRqBp52Efgg9jVRB6ZZTUq1O8BheGHqd9nSrfCLK/NSjyxlJ+zbbwGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722965926; c=relaxed/simple;
	bh=EBT4hiFUATcqOgbWRqrTFuz3weGQikglP+H+epxOzJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JRoXQFqGzJosYtDwXGaEQTND58CPDR0+MaQDSY+TH1NVIKbZT9dqPjVxpXD8E9mrT8u4tGJPv0qVoignc+c+YE4439wLHMRb18DzqRZYHqtKQ1oWKqrv87svZS4hRef7SDp3d6AaE0EVq35j2ZWaBgoTyg9J4kWIwdTpGtnbb/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vonhaugwitz.com; spf=pass smtp.mailfrom=vonhaugwitz.com; dkim=pass (2048-bit key) header.d=vonhaugwitz.com header.i=@vonhaugwitz.com header.b=TXqxFdF2; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vonhaugwitz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vonhaugwitz.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vonhaugwitz.com header.i=@vonhaugwitz.com header.b="TXqxFdF2"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4WdgWs2fjQz9svS;
	Tue,  6 Aug 2024 19:38:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vonhaugwitz.com;
	s=MBO0001; t=1722965913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gCo3sGaoyeiSWZqCw18jgE/Ao2bZ4vtOm9R2T8fGbwA=;
	b=TXqxFdF2ffdDkirPLycqIPn8sYWqj6CQeAxdd1+YlQ1dIWdwBjvy58RiD3giZA+lSfl0LI
	wukYEbQzJwtjlah+F1vWm/iXn39B20DJ5dP8JI05Nf4zPnixuOtKkEbJBqE3hLl7MnQ2RD
	j77d0vFI2ogUUZfy2lDys4mcnWNAiuGH9/vPOF4FsM/TIIKZUZ5WfVS+UlnWumB4OjZ6cD
	Qkj9rHR6eJdA+rhTm95cgc/Z/dK/s+e0f7O9ClOgtAHI6yjlqk/zIno5A+6My/iZ31Wl1T
	xolOCPt0wluLnMVMKYC3jQ0ZghFI/Fvd4xq15nI/BPjgh+4VcIfNYkcEFHD4mg==
Date: Tue, 6 Aug 2024 19:38:30 +0200
From: Hannes von Haugwitz <hannes@vonhaugwitz.com>
To: James Prestwood <prestwoj@gmail.com>
Cc: Grant Erickson <gerickson@nuovations.com>, iwd@lists.linux.dev
Subject: Re: IPv6 Privacy Extension support?
Message-ID: <20240806173830.GA25@magnesium.vonhaugwitz.com>
References: <20240301144608.GA25@magnesium.vonhaugwitz.com>
 <629785cf-77c3-4b14-ab58-d4b2c75f254a@gmail.com>
 <20240304193253.GA25@magnesium.vonhaugwitz.com>
 <BBC776B8-57F8-460D-A1CC-FD3B5A522311@nuovations.com>
 <047c2dfc-ca69-4117-a3a6-66790b9814db@gmail.com>
 <20240804210103.GA25@magnesium.vonhaugwitz.com>
 <70e5936f-c789-4f56-a275-e1b559ea27fe@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70e5936f-c789-4f56-a275-e1b559ea27fe@gmail.com>
X-Rspamd-Queue-Id: 4WdgWs2fjQz9svS

On Mon, Aug 05, 2024 at 05:44:39AM -0700, James Prestwood wrote:
> I was still not sure exactly what needs to be done. If the sysctl setting is
> all thats needed, this is an easy feature, but you had said setting that
> manually still doesn't enable the privacy extensions? Is the issue maybe
> that IWD removes the wlan0 interface on startup? So setting that sysctl
> setting manually, then starting IWD, is clearing it?
> 
> Is use_tempaddr still set as expected after IWD start?

I set the following kernel parameters via sysctl.d/60-ipv6_privacy.conf:

net.ipv6.conf.all.use_tempaddr = 2
net.ipv6.conf.default.use_tempaddr = 2

After restarting IWD use_tempaddr for wlan0 is set as expected:

# sysctl net.ipv6.conf.wlan0.use_tempaddr
net.ipv6.conf.wlan0.use_tempaddr = 2

Best regards

Hannes
