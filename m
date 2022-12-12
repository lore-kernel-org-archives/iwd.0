Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5376FC6
	for <iwd@lists.linux.dev>; Mon, 12 Dec 2022 20:07:09 +0000 (UTC)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 450865C0105;
	Mon, 12 Dec 2022 15:07:08 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 12 Dec 2022 15:07:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airpost.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm2; t=1670875628; x=
	1670962028; bh=k97tg8UyryEYSYUmjSqjlHjSh/MoIlswEXXCZ8gILXk=; b=k
	zaq9di/Pr5aSo09dQhu1OcFp/Zef8BF9fayFBBYxjd/Wpc064WrqUPBMUKgyDmCZ
	7An697GvXANjHWuDhCCVG+Jcx4tR7rNMWxNpgBu5G1XnHs6/YsmDC/Ps+9OxuBdv
	jAS1XKvT6wwiLgyOiJzK8nm0eLE5LansTtqKFa61mOljC6w3aKGzfbce0HdotGpd
	IGBcYFVt5X9gVxnQfYDHOTIOv0g/SxwE2lOC4Ri/Yf01yF01eW/K7iQTg2F8MLAR
	DBuAaSC0RW8J9wqSgIOHfcLzXyDtRnRN+xAV6diFQnmoTCl1yH3X0vYcUfIFjeUM
	Ch2Ij3dugf/fH8vfELluw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1670875628; x=
	1670962028; bh=k97tg8UyryEYSYUmjSqjlHjSh/MoIlswEXXCZ8gILXk=; b=n
	u6YdE4IPlbe9bHcdii2dTZFikWLel5quowJZkz79O7daZ/oJU68MOLCMKB9+7fvl
	XG0zPRgZl+SKP7dpHrGnRjGcn7b70DZaUI5Mj+hBtZ5bQz1fmw8CpOgPjIchcJVB
	eO4BX365xRL8zSC/QdZAyqI7TVmDTtDbey8IMpc+Uad3SGZ+2qQvSlb5jME3+OQk
	F2lCTzWNW5byQVe+gm0exCjJI2bdOzaf72SEYwLesPI+Wz6nUvIHj5Sc7UoXSTrY
	YU5nylO2Qzz/bnB6hH2B1I8G4GkqpVy8ZJZJBqWlI12Ei0fWWnxar5TpQc8phTNh
	hpc+YOeqOsrsQv+WpNxEg==
X-ME-Sender: <xms:7ImXY4BsBw0jILv50gqa_pYjxsiIQQ1gBMvaZ4bFd0IbkT2Mk5Fxjw>
    <xme:7ImXY6hOmoUXLtE20sSmsZzQIkppA5J7Rd2_Ku5y1E12JXQ5x3T9mmPKqj7XEbIjH
    b-J0vg0jWrHlzo0>
X-ME-Received: <xmr:7ImXY7nFnq_Na8hQ4KsYp1J-HBauMxGUOURNj_KagIbE0R-6JP6jpbWShwLUMfLM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekgddutdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhevhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpeeurhhu
    nhhoucffrghnthgrshcuoegurghnthgrshesrghirhhpohhsthdrnhgvtheqnecuggftrf
    grthhtvghrnheptdehveegieethefgteekhfelfedtjeehffehuefhffegudevfeeflefg
    hfetvdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epuggrnhhtrghssegrihhrphhoshhtrdhnvght
X-ME-Proxy: <xmx:7ImXY-zRrWUBJzhs_VCBdcsD7pH_iQEOzNF5wa5ygptDsCNldjum_A>
    <xmx:7ImXY9QtcN98Kuo1tL4YLykcRPyBts7tV5VvpT1L6Q87MNZY3ovr5A>
    <xmx:7ImXY5aXRoR-qLHbV0GmtWDPadCq_mn_uGWx7JVul7OdrXzi91vBzw>
    <xmx:7ImXY4ehW4Ksz74nhdjhHaU3P3qmSgXOnOITbogkE5yD_-_48a0wSg>
Feedback-ID: i1cfa4199:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Dec 2022 15:07:07 -0500 (EST)
Subject: Re: iwd release 1.30 onwards cannot find available networks
To: =?UTF-8?Q?Alvin_=c5=a0ipraga?= <ALSI@bang-olufsen.dk>
References: <b7ff5956-f571-d9d8-1f7b-f3025e2055ae@airpost.net>
 <b4ad714bbd162b1f7bc3302c9585adf8811ac929.camel@gmail.com>
 <126d2f2b-07ef-fd22-7656-dcd21f3cece0@airpost.net>
 <0df6f28d-4a77-dea2-dbf6-c83c6a25b8ae@gmail.com>
 <5056edba-fa23-b133-73ac-f8daa483cf23@airpost.net>
 <20221212193846.ub2ahzpl5eu2ylnu@bang-olufsen.dk>
Cc: Denis Kenzior <denkenz@gmail.com>, James Prestwood <prestwoj@gmail.com>,
 "iwd@lists.linux.dev" <iwd@lists.linux.dev>
From: Bruno Dantas <dantas@airpost.net>
Message-ID: <3e08f034-d795-2ba8-4213-b973e5366262@airpost.net>
Date: Mon, 12 Dec 2022 15:07:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20221212193846.ub2ahzpl5eu2ylnu@bang-olufsen.dk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi, Alvin.

> I guess you are entering this last if block, as the regdom is indeed
> changing during the periodic scan based on your logs. Then scan_notify()
> returns early rather than actually requesting the scan results
> (get_results = true; leave switch and continue the rest of the
> scan_notify() function).

I'm not sure why my regulatory domain is changing. I'm certainly not swapping network cards during a scan. Nor am I manually spoofing a different regdom. I'm at a loss on this one.

By the way, this bug only affects me at my workplace. At home, iwd 1.30 and 2.0 can scan for networks just fine. My workplace is a hospital with multiple wireless networks over which I have no control and no insight.

If Alvin's diagnosis is correct, maybe using a regdom change as a marker that wiphy went down is not always reliable. One thing is for sure: iwd 1.30 and iwd 2.0 are making an assumption that is not accurate when I'm at work, resulting in an inability to scan for networks.  

-Bruno
