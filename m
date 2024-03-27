Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54E314D280
	for <iwd@lists.linux.dev>; Wed, 27 Mar 2024 19:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711567299; cv=none; b=PDvru7x4BO8/FgtvbvdfZCjh08989Qoojp2oZCbqTunB335Svq4AR8rBF9SS++jqyFuY5RirxXS0gdjDr2njNJ9KCh2p5oCQXfbDtgFS2DWA7mFWZt+93ky5SFCBy37mvrKkQssB0ZWOrdcuU7ycQeEeQrLdYdz8D1hQfCGY0ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711567299; c=relaxed/simple;
	bh=OXBfRgsMP0adkqh5IT77p658YAqxtZ7RyebPKmWwiKI=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:
	 Subject:Content-Type; b=U77speaoxwHM2k0Hbyf9hkDiNvWBR60sR61PRkQ2yqMqV2VzQCgev0u+yE3iJymOT/FgY9WxrjX2ITVcGguG7yXjb/FMx8zRhsjmxyPb9mGhHEyym8Gls4FL6B+NFmqsWckt8zQrregzl2x1Lp8xMEraNHVhmdnr7Lb571YYfPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=svenstaro.org; spf=pass smtp.mailfrom=svenstaro.org; dkim=pass (2048-bit key) header.d=svenstaro.org header.i=@svenstaro.org header.b=lD13ejFv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tkcM7Fo4; arc=none smtp.client-ip=64.147.123.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=svenstaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svenstaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svenstaro.org header.i=@svenstaro.org header.b="lD13ejFv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tkcM7Fo4"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 00F443200A16;
	Wed, 27 Mar 2024 15:21:35 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute6.internal (MEProxy); Wed, 27 Mar 2024 15:21:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenstaro.org;
	 h=cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711567295; x=1711653695; bh=9NRnfuXgI5
	Nd60ekbndesIkjYMaKki9veDh4Vagwgys=; b=lD13ejFvGv5ipSA3CwtDZ8hKL7
	ordqhqXy8w2EIecrEQQYj8f+T69peHMByZJRndH3FTg9R3y0myELc/mX1xj9GqJd
	8fJMZA8qJmO4mKHxUS8TnM2z9/XnZNnLnR+gft4swCw5c3F7l+CT4UAsvUPiEaY1
	rt2yxGuqkJjqgYaCAinaBmGNjj89qGsm9V7o1Q+9KrE6heOtFCn9o/cT3k+SBsGP
	lAnh4tHmi56iE9zupGba/neD2GXDWgZ3KGzZHzalWb3gNWWmo6/gTsyIQhxxf3iz
	PGX9M43ywsRGEsmT6y8fKOv2LIK6KpWsCp7HICms+mg4kdMIKuGGJXWRXxkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711567295; x=1711653695; bh=9NRnfuXgI5Nd60ekbndesIkjYMaK
	ki9veDh4Vagwgys=; b=tkcM7Fo4T5cqaEwFgMCtW/fZpnpPLFkYWEL6JYYEnTKQ
	tYgq4LTq+0xL+Y7qh/gWvQnD6GhUt2K0jQC7WA8eS0Vt9wFIFVwbivV0robd60Rk
	m3l2ZFbVHtKpYgO/Khc5u4Nq8nahsTyLkv7wLDxoAkdlnIsj91C+fXasiyrlb1tO
	/NPERup8dYAhXkZuNCXEe0nE9Cvfis1LfOHH51ih2glJiT4vyXy9iSELoU4OMcPw
	Df+YNiXegGxIiOmrM4fSb7H2yR9etOEMuQB0SNkdFNh9pKzd3zJ81/UKwoUafjRA
	By0h5fAAmYw/Cr63VuI+foGCr3nKDF2gDJWHiMZ03w==
X-ME-Sender: <xms:v3EEZpLzYN8MYBftXmkfB2e6N1HEE782uCbBPKX1ewJX90AmRS6BXw>
    <xme:v3EEZlL9qqVrRvbTKqO8vu71i4-SE9BfZnd4agLpWrY7IvSwzMbL-6kwQulWUQ8t7
    z6XRDmRlkPOCGMbMrA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudduiedgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
    nhdqjfgvnhgurhhikhcujfgrrghsvgdfuceomhgrihhlihhnghhlihhsthhssehsvhgvnh
    hsthgrrhhordhorhhgqeenucggtffrrghtthgvrhhnpeegfffhtedvtefhfefgteeitddt
    lefghefggfeuudejheefkeegtdehhfejledtheenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrghilhhinhhglhhishhtshesshhvvghnshht
    rghrohdrohhrgh
X-ME-Proxy: <xmx:v3EEZhvgXcTIDgFyDjsxCmjDssGJliEY7E1PFDbqdb9yQzqpb0WwAw>
    <xmx:v3EEZqYZGDstdS2ZqG30xlu1_2XzkoJNY8FsR3dKYOVULRA3M1WyFg>
    <xmx:v3EEZgbUmaUUDH-N_06-NPoElj9ET12govmV3Vbjvc2FPldm8Z5L4w>
    <xmx:v3EEZuBGa-F38svI_4JxJsTDwqpTuj4fKgVLEWkPdWx0_5_WVQD7Sw>
    <xmx:v3EEZpDFfu8kGNoBswdSwBIyfgdypB2YjKIVcLdkcizPZS2LKrdClA>
Feedback-ID: i6bf14966:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 08EB11700093; Wed, 27 Mar 2024 15:21:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-328-gc998c829b7-fm-20240325.002-gc998c829
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-Id: <07f49420-74e8-4954-bd87-9ae3290e86d3@app.fastmail.com>
In-Reply-To: <16f79ea4-32a2-47f5-b6a9-cfd911454a6a@gmail.com>
References: <699c79ff-0082-4602-9bb8-475722563c46@app.fastmail.com>
 <16f79ea4-32a2-47f5-b6a9-cfd911454a6a@gmail.com>
Date: Wed, 27 Mar 2024 20:21:14 +0100
From: "Sven-Hendrik Haase" <mailinglists@svenstaro.org>
To: "James Prestwood" <prestwoj@gmail.com>, iwd@lists.linux.dev
Subject: Re: iwd picking worse network despite better one available
Content-Type: text/plain

On Wed, Mar 27, 2024, at 19:54, James Prestwood wrote:
> Hi,
> 
> On 3/27/24 11:36 AM, Sven-Hendrik Haase wrote:
> > Hello,
> >
> > I've spent a good chunk of my evening looking into why iwd doesn't select the network I want it to select. I have a network "Home" with two APs. iwd seems to strongly prefer the AP that is further away and that has worse strength as measured by iwd.
> >
> >  From some testing, I believe it has to do with the AP rather than the wifi adapter. I tested a wifi adapter using mt7921e and one using iwlwifi and the result is the same in both cases. The APs are both pretty modern: The one iwd doesn't like is a FRITZ!Box 7590 AX while the one it likes is a FRITZ!Repeater 6000. From the log it seems that iwd is unable to perform a proper data rate estimation and then falls back to some default. At any rate, the rank would indicate that the estimated data rate plays an important role. If I use the developer mode to force roaming to the AP I want (named "better" in the log) then I'm able to use it perfectly well with a good data rate.
> >
> > As such I think this is a bug _somewhere_ but I'm not exactly sure where. I searched the configuration options but it seems it's not possible to turn off the data rate estimations for the ranking. I'd be perfectly happy to just go by signal strength. However, I suppose it would be better to actually fix the core problem in iwd.
> 
> IWD bases the ranking of BSS's heavily off the estimated data rate. If 
> that fails then as you see the rank is very low as it defaults back to 
> 802.11b rates. There are several IEs the AP sends which IWD parses, any 
> one of them could be either not included at all, or not be formatted 
> correctly, or an actual bug in the parsing code. Could you get an iwmon 
> capture of IWD scanning your APs so I could take a look and see exactly 
> why its failing? Then we can go from there.
> 
> Thanks,
> 
> James
> 

Hi James,

You should have received a pcap file of an iwd restart in a separate email. I hope there's some usable data in there for you.

Cheers,
Sven
