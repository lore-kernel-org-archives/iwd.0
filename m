Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CE93212
	for <iwd@lists.linux.dev>; Mon, 12 Dec 2022 17:52:53 +0000 (UTC)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id 2B6603200921;
	Mon, 12 Dec 2022 12:52:52 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 12 Dec 2022 12:52:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airpost.net; h=
	cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm2; t=1670867571; x=
	1670953971; bh=AAmX/n0cTV+N2ve9F0UmTv3Xu3jbdCQZHyeJGXnN7ls=; b=E
	vvZjH8K5cjkAaen3lUfUrowd1enctUl7z+vpaR07cc6Scax6RTqgeB5+Eb7ugSUp
	Lyb++2lKWvJjvgAqMW7Y/YMCxJ5EZGfen6Y2N3/f2r6CcyVQFRXRa0xvCkzdkLZD
	kH6bF98+fNRenpaPiMEENc45D+oz+PmqQeZm/duO3nP+9cLtl1F+HjnfPXUu0Tz3
	psJpcbwwkGWxfB/zE3lu5a770bJZzB3JSyw9BreHU+SNtT26ekzfa8brkYn4ld3T
	Uf6adM0AnWJGhjtyDBfslJpvCjP94zDPQ5xURy9bbBVGAKHeLXbwVh6S3bGWgigQ
	N8kjcBYVnU17oxF24G/+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1670867571; x=1670953971; bh=A
	AmX/n0cTV+N2ve9F0UmTv3Xu3jbdCQZHyeJGXnN7ls=; b=kCZZi3V7gGp7q1FOp
	AzHUxylI8xHwJ6uyyGVkGLEvDdGq15Ryqn5byUV7RXRxzm6poHL3tS4pZSM3OImC
	m23LQjNlPgDdu4lUgix/5g3ycaGEfafE/sLGAynKLto+8Y9d3rov3ZJYWMNGUMQw
	Lv6/ul/nZYiJE8kPap0+AFrM+0TU+c2fvDlkSE7lznZJj3MqAqq8fzrQhp41E44O
	q6I05Gi9XbYxni++NGJm+oyjL0bwZPG2w/XEDbH6iouCSz1UyP5kWSxomM9cPPMF
	Z3opzDTVCHXCi7hqBBUXfrEkHFbkFCoY+gJBzyaiNj1Z1RqNp53iBbEtLmCJTR1Y
	n0s4g==
X-ME-Sender: <xms:c2qXY_U1xlkfbOaMltRFymebnX-znT2rAdqrTYHW6nep2rEh8k79XQ>
    <xme:c2qXY3kzscmC5osco7c-imEf0tvLsZgYjQn5Pj0X61C1j--gGLSZD4B0Dr6tF36cJ
    eYQq7MudIeNBcGX>
X-ME-Received: <xmr:c2qXY7b4nW12u0LGb066p7005hHP_K4hv8CEXSR5zONbdXliPMrws-1hibEcHQo2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekgdekvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpeeurhhunhho
    ucffrghnthgrshcuoegurghnthgrshesrghirhhpohhsthdrnhgvtheqnecuggftrfgrth
    htvghrnhepkeehfedvgedvtdefvdetjeeugefftdfhgffhgfethfffudffgeeuheejheet
    uedtnecuffhomhgrihhnpehprghsthgvsghinhdrtghomhenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegurghnthgrshesrghirhhpohhsthdr
    nhgvth
X-ME-Proxy: <xmx:c2qXY6XVYfqUmU6H4wwaT0nKRnEzBr0arlovIIOzcKd6NlVL8sEwjA>
    <xmx:c2qXY5n5-ccrAfpLPaKI5nLNgSvBx_1LxJSu9ghWwahPaul4TTExRg>
    <xmx:c2qXY3dYoQPRoDcMbISygvEBFOggVPFv9anCbFHClIb0SOavli8dDg>
    <xmx:c2qXY4s2cWN-FuGIXrVsrdTj6lapLf9H6EhKUVStPgzTa-dcGTZEeA>
Feedback-ID: i1cfa4199:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Dec 2022 12:52:51 -0500 (EST)
Subject: Re: iwd release 1.30 onwards cannot find available networks
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <b7ff5956-f571-d9d8-1f7b-f3025e2055ae@airpost.net>
 <b4ad714bbd162b1f7bc3302c9585adf8811ac929.camel@gmail.com>
From: Bruno Dantas <dantas@airpost.net>
Message-ID: <126d2f2b-07ef-fd22-7656-dcd21f3cece0@airpost.net>
Date: Mon, 12 Dec 2022 12:52:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <b4ad714bbd162b1f7bc3302c9585adf8811ac929.camel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi, James.

> Thanks for taking initiative and bisecting. But its puzzling how this
> commit could have any effect. The only functional change is removing a
> pending request when the wiphy goes down, so not related to anything
> while the device is up/scanning.

It was my first git bisect, so it is certainly possible that I made a mistake. Regardless, the regression definitely appeared in release 1.30 and I excluded a regression in ell.

> Just to be clear, you are making sure IWD scans prior to calling 'get-
> networks' right? i.e. station wlan0 scan?

Yes, but the scan just hangs. I wait a full minute before interrupting the scan with Ctrl+c.

> But assuming IWD is scanning (or trying) we need to see some debug logs
> for IWD, and best if you could also get an iwmon trace when IWD starts
> up and issues scans, and when you call get-networks. More info how to
> do that here:

No problem. When using latest iwd 2.0, then letting it scan for a minute before interrupting, then running get-networks, here is the iwmon trace:
https://pastebin.com/h7gHrS2w

And "iwd -d" output:
https://pastebin.com/2y5hHfWa

I don't see Alvin's patch in the git commit history yet. Once it's been committed, I can recompile iwd 2.0 and test it.

Please let me know what you think of the iwmon and iwd debug output.

Thanks,
Bruno
