Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06FC79C9
	for <iwd@lists.linux.dev>; Tue, 13 Dec 2022 20:15:14 +0000 (UTC)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 8561D5C01A5;
	Tue, 13 Dec 2022 15:15:13 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 13 Dec 2022 15:15:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airpost.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm2; t=1670962513; x=
	1671048913; bh=fVv6kBxgVw0eTwz6BvGVL9OzgJvhbHzXDRmolFXVGXY=; b=o
	nIQq/nA3f7QtBGWAQESO9w8u1gxxzOomkO+54fjo8yBR4AmhUOdbvJPtO3ijVlXc
	gdS/vpf41FS3AqkeHoNJEzA23rYJ+mwxBeF/PtSwhe9AR1EPkmxtmCm4TV2anpnO
	k0uYvUqetMqclpD6s3G6oJEL9B0Ko67yBBy/YwyeqOPq0pfq/WCdiiCE6t3IpfJY
	DCsAimurWKcN+sSiZ4X4/0R5K/ZGX8nT+hFxrnoEUJXRRi/BQhHrlQuGezI4mtyZ
	7bQP9MbsQ548/3NorgGWzqKPT872+33FPgt7o08p3ri5E/j4HjKDhW9Nx9sWyHpU
	GlDWWxxin6D9Z1nobk8MA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1670962513; x=
	1671048913; bh=fVv6kBxgVw0eTwz6BvGVL9OzgJvhbHzXDRmolFXVGXY=; b=Q
	VmsQuGAtgeuxYcq7288Jq7p2Lt0Xx4QTCGVgn4wYfHSR602lWRspVeasrCQ1+HSU
	9akqaEtcdAr5aH0doZBHKPZ1n7sT9mRrMWJIeEcSvwayCOB1chkWm5nTmar+9dGN
	74QI40PRGACL8t5+OXoV7Vg3d4azGEUX8UGDJVNcsxms5L9jjj1h+h7faZ/6wy8u
	LGxnA/QqMmXoXA7xyma/XsTj9Q4pbua27otRMgIE5n4AJRf+MtRTo2UaQcT+u8Bw
	rUmLZz2QIW+ZdYgy6ZFrOCPH/Ic4GTTg4Hc/yfOZRvGKehAEak2m5iEtI27uelUC
	5k2SpeSCQ57nwOAdmmotA==
X-ME-Sender: <xms:Ud2YY7ABpesvqrPDru44GZguPoDSCjOBUF3FCVe9oAI1Zj_T5cY2nQ>
    <xme:Ud2YYxj0-woFwUuy5QcpA3FQbw96HdNa4lpHbTZyJDt9ycL4Fd8i_JLozdUtCvmCf
    mOSiSamlc5MgbNT>
X-ME-Received: <xmr:Ud2YY2nWFNjnqZkO3LR92F52W6y0BNPUtTiWYxjCEZBl0PMbyd84yk-jLfRtVI0npw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedugdeiudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfhfvefhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepuehruhhn
    ohcuffgrnhhtrghsuceouggrnhhtrghssegrihhrphhoshhtrdhnvghtqeenucggtffrrg
    htthgvrhhnpeeghefgudekvdegueejieekgefggffftdehjeeitdduieffkefgkedvtdev
    hfeuvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepuggrnhhtrghssegrihhrphhoshhtrdhn
    vght
X-ME-Proxy: <xmx:Ud2YY9wMMbVF4NY9TjtdhxVI2XG7A3XdaCm6Wk_Uq4L3jdae2iZ1tg>
    <xmx:Ud2YYwTmgxaAIfJINmyuLzAmoHSOuXb-1PQAqmSo8UIfad7-rAK-aA>
    <xmx:Ud2YYwYkZxulSJZYVaUPOhbGLwFzvQi3DxtXq_P_a9AXcsr0EGVd-Q>
    <xmx:Ud2YY7cvPEp_sxdWEjhaR4ab5FfKMYM4RdWOsuHuqoWZQHztpmHRBA>
Feedback-ID: i1cfa4199:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Dec 2022 15:15:13 -0500 (EST)
Subject: Re: iwd release 1.30 onwards cannot find available networks
To: James Prestwood <prestwoj@gmail.com>, =?UTF-8?Q?Alvin_=c5=a0ipraga?=
 <ALSI@bang-olufsen.dk>
References: <b7ff5956-f571-d9d8-1f7b-f3025e2055ae@airpost.net>
 <b4ad714bbd162b1f7bc3302c9585adf8811ac929.camel@gmail.com>
 <126d2f2b-07ef-fd22-7656-dcd21f3cece0@airpost.net>
 <0df6f28d-4a77-dea2-dbf6-c83c6a25b8ae@gmail.com>
 <5056edba-fa23-b133-73ac-f8daa483cf23@airpost.net>
 <20221212193846.ub2ahzpl5eu2ylnu@bang-olufsen.dk>
 <615ceb63-e041-1990-81fa-568181681aa7@airpost.net>
 <59639a626260a24147be730f9703e0d766bd5f1b.camel@gmail.com>
Cc: Denis Kenzior <denkenz@gmail.com>,
 "iwd@lists.linux.dev" <iwd@lists.linux.dev>
From: Bruno Dantas <dantas@airpost.net>
Message-ID: <8705db73-b6e8-eea4-d2fd-271d1501c52d@airpost.net>
Date: Tue, 13 Dec 2022 15:15:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <59639a626260a24147be730f9703e0d766bd5f1b.camel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi, James.

> Maybe you missed Denis' email, but I've sent a patch that will
> hopefully fix your problem. Its on the list, or archives:
> 
> https://lore.kernel.org/iwd/20221212220857.1284874-1-prestwoj@gmail.com/T/#u

Oops. Sorry for missing that. Yes, I applied your patch and can confirm that it fixed the problem I was experiencing! Thank you so much. I'm much obliged.

Will your patch be included in the next release of iwd?

-Bruno

P.S. Just curious--what are your thoughts on why this bug would consistently affect me in one place (at hospital where I work) and consistently _not_ affect me in another (at home)? I'm at a loss.
