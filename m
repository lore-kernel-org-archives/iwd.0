Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CCCC8C7
	for <iwd@lists.linux.dev>; Fri,  9 Aug 2024 02:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723170144; cv=none; b=uQYMdGFChdSVO+okzpsrUfsq6CkauY+rT2Gt2EfMIUWtNhgyZdIvU2Vhi24suyFy9qhf1J7dJT7GZZpLydAAVbsfN8Tk3z0SG19GfrgBMhqrQChtmyTJfSJW48VvExWZKWUzU/i0QmTtGg8knMReUL/lKnOMvKIlrMXbsN9sgI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723170144; c=relaxed/simple;
	bh=ZVR959v8lMZAztQgZAY5Io/htssI/4hzbnPAPovW9DE=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=eKDzZr68su0AZ4dPDvB06TMtFDjQAIBit+m2DM+tAGMyvRJWeeLlyPgcj03I1WROTw5kBNkl3jzOdTSXqm+Jz4rW+Ugr//pzf87L83WJp6KOxqLhqrtJFo369bZ3REWc/DD8h1+r6Aj9lt//9jwRFS6mT5gWM46NqLKZFHo7cMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Tkimi3Ao; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Pman96gv; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Tkimi3Ao";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Pman96gv"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 82E33138FCE2;
	Thu,  8 Aug 2024 22:22:21 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
  by compute5.internal (MEProxy); Thu, 08 Aug 2024 22:22:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1723170141;
	 x=1723256541; bh=45mC0MfpDMf/f6/YEPfO5pFLWl2do5v7H7RAequTXqg=; b=
	Tkimi3Aogp7Ni5PPadW7jJL2lh2RXzEriZadmKyqcZx3mVMkmOjdAPoUkN6P7lyP
	IGhuw04XcW2CRnIT0DEhvFOL2cUzqtz8zmT8UAl3Xo1nMzBnHbNgD1mhJjWIYD7h
	c7GTnb25jDDoeoUFyD0IoVjppqU9uBwgwzsjHZ1PueuUDV6R17uoxr7+S8Z6GMzp
	l8X23UeBOJTPvssFcFLm/AA0j/1szALXhkDzRFmtHLadYBn4oOALkg3+TKl0Sh+8
	SKQbLHDVAiFAUvMFpI2qSRoOKOLAzmEsO5Mlmf3PTie6GeHoj59bQCWHlYsdX4+t
	QLJyig1BHxP19qsng21xHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723170141; x=
	1723256541; bh=45mC0MfpDMf/f6/YEPfO5pFLWl2do5v7H7RAequTXqg=; b=P
	man96gvxaNWuvjgj1poBUHj1afpxbylqsz/5As6r17FaGpfvE4yiCWrsxqLSq7KG
	2WhR+aCrqmGj+vwFysR1CcsEcVli3Jo5bCm7fzMASLVnqZduF1S6HHTbtQ7/ftgr
	xTggrzzZ40PJO0Yju+8nSn2qDGsGkmAWwcI/3LXS7GlfWW0YJTtrSExlzwX40kRQ
	MGMqZx3/ScoKWuli4jrc7a7ZExSMiPzrse76fPxANqZBSlO3yCJvu8W0A6lloYi+
	hgtacxQ6NpQARCDiXJ7Z9ls1SuBtZYRUHqkzMyFwX/sHwRbH9ZHH/WHDINl+x9QA
	sr705P2w7a7Ko/cb5yYSg==
X-ME-Sender: <xms:XX21ZpKm2H5dda2ebQoGFPJWkIahassMuamUt4Q9HzkN5Anhr01l6w>
    <xme:XX21ZlI0dBqcDn5p4X5521dA-YqIGHKcYfbitJ1w8eQMXRGYZKR7Fku338T2_Lw9J
    gaU2nAWB3jtzPx9klY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrleefgdehiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvkfgjfhfutgfgsehtjeertdertddtnecu
    hfhrohhmpedfofhoghgvnhhsucflvghnshgvnhdfuceomhhoghhjsehfrghsthhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepkeejveejhffghfdtieegveejgedthffhveek
    keegkeffudeghefhudfguedvuddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepmhhoghhjsehfrghsthhmrghilhdrtghomhdpnhgspghrtghp
    thhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhrvghsthifohhjse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepihifugeslhhishhtshdrlhhinhhugidruggv
    vh
X-ME-Proxy: <xmx:XX21ZhtLdPmAhdaw6Y3sTylZRmx0prvfzsI-aF_Wr3kpG-xkbDIuXg>
    <xmx:XX21ZqaoxZ3np0Zerb0U4JNLc4LmFV8B_y6v3R3GSqubkG5pnaHduQ>
    <xmx:XX21Zga3-WtdjFow3R5Mq3lL7A_70ChXCHRiiYXOQNJ-yrw5tJi6HQ>
    <xmx:XX21ZuDtMMK74iOiXWGA2_ZMrgil59HPQRjy69xHrmADYExM8VsHYA>
    <xmx:XX21Zrzijq8telFtJkOlI9pSmB7lbWxaJ6U4Mo1GGbayVKQO75IZ_MZb>
Feedback-ID: i9549465d:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 529F7A60079; Thu,  8 Aug 2024 22:22:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Fri, 09 Aug 2024 02:21:02 +0000
From: "Mogens Jensen" <mogj@fastmail.com>
To: "James Prestwood" <prestwoj@gmail.com>, iwd@lists.linux.dev
Message-Id: <e0c9ccff-7bbd-41bd-9b54-5495e30cdf89@app.fastmail.com>
In-Reply-To: <d571910b-77c8-4e47-8741-01867c535398@gmail.com>
References: <3554030d-7309-459c-8e91-ee34a0fe677b@app.fastmail.com>
 <d571910b-77c8-4e47-8741-01867c535398@gmail.com>
Subject: Re: iwd 2.19 segfault?
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Jul 22, 2024, at 11:25, James Prestwood wrote:
> Hi Mogens,
>
> This really isn't much to go on. Are there any IWD logs? A stack trace? 
> Core dump? etc.
>
> Thanks,
>
> James

Hi James,

Unfortunately not and the error has not occured since, which I find quite strange. That is also why I started this thread, to find out if anyone else have ever seen something like this.

However, I now run iwd with debugging enabled and that will hopefully reveal some more information, if the error occurs again.

Regards,
Mogens Jensen
