Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC302CA8
	for <iwd@lists.linux.dev>; Mon, 22 Jan 2024 20:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705957156; cv=none; b=NNBtFVaBjkCxHdgcuVk2gOluj2Zxzspsykhpvfh2pSJKgPsdkoPWxwrANMg5nqJv5p2vE3OPDh7CIPb+V8hyN/c/P//qARjhiPmI3Dke7eTZYrCRKiSp3L4aj8oZGhLhGq+auDsgcQP5RoK6cPAy0AR2icbBYvktqtAdMb3qusQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705957156; c=relaxed/simple;
	bh=0HPbsS+eezWZTgnNiZWnzCwlkmH4X2ZeijSm/9BadEg=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uNFeOFLStSdQ+Qjpshd24FhpnCzv5SPgbJoMKsyEdQ2rsya6QKat6Y0AQ9emOxL7AHQbjswwaoSYTpU4FcLOwHR0PJd/DaO6Mkmxlx47nQIbfQ8QcRcreCaZ4K9h2y34iLdymquHcGAtjBYlAIxmcR9QpkGOtNWFK+tI5AIMIw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=espindo.la; spf=pass smtp.mailfrom=espindo.la; dkim=pass (2048-bit key) header.d=espindo.la header.i=@espindo.la header.b=epu0b5Yc; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=espindo.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=espindo.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=espindo.la header.i=@espindo.la header.b="epu0b5Yc"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4TJjJG3kpBz9t0g;
	Mon, 22 Jan 2024 21:59:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=espindo.la; s=MBO0001;
	t=1705957150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Udfdm3ASbnqQPG1E5oCI3LaXm2YWMbmP0xm3vIL5mH0=;
	b=epu0b5Ycypci8TFJtShotd6XwlUq4bGiICqAoqVC8Jo42HvsjfvruOINZGSS7lmPh7XxVR
	+Y8j6uWKUZl/LItNx/uL5B5w0/CKYc51xuxUOF80xpM/YzEZFeapMFb7nKu5BONgNBGcrF
	xb0nth3xXtRaHw8LqK0nsYFLFG5eqJ69hC3cP+Q4YasngFpPj0hdmNmJlk71pRuyVdcOz7
	WwRCceUPzISqi4s6RgbZinijC1iE1F0EGrd5g4sRkp4ATTmrcUOGU6hVeOOkifKcZigi6D
	wlisWVuYnyZwc/7TrCuKnChl9NFqTbC/IdxhThcLIrLjL0SrX0HzMGTnuLX11Q==
From: Rafael =?utf-8?Q?=C3=81vila?= de =?utf-8?Q?Esp=C3=ADndola?=
 <rafael@espindo.la>
To: Denis Kenzior <denkenz@gmail.com>, James Prestwood <prestwoj@gmail.com>,
 iwd@lists.linux.dev
Subject: Re: Making udhcpc get a new lease when iwd connects to a network
In-Reply-To: <3aaec29e-7b05-4a2f-b92b-40fbdffa860e@gmail.com>
References: <87h6j670ye.fsf@espindo.la>
 <e1a35af8-0c7c-450b-9d96-fa8987e4c0d4@gmail.com>
 <3aaec29e-7b05-4a2f-b92b-40fbdffa860e@gmail.com>
Date: Mon, 22 Jan 2024 19:59:07 -0100
Message-ID: <87sf2p6q5g.fsf@espindo.la>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 4TJjJG3kpBz9t0g

Thanks!

I will take a look.

Cheers,
Rafael

Denis Kenzior <denkenz@gmail.com> writes:

> Hi James, Rafael,
>
>> 
>> I think the intended way is for the DHCP daemon to listen for the interface to 
>> set carrier up (from RTNL). This is how systemd-networkd does it, and AFAIK 
>
> Refer to https://docs.kernel.org/networking/operstates.html for an explanation 
> of how this is supposed to work.  The kernel will signal NO_CARRIER any time the 
> wlan interface is not associated and IF_UP once the interface is fully connected.
>
> Regards,
> -Denis
