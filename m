Received: from mout-b-105.mailbox.org (mout-b-105.mailbox.org [195.10.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83F71BD9D7
	for <iwd@lists.linux.dev>; Thu, 31 Oct 2024 09:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730367728; cv=none; b=hqLYfksWElsVUa3OaSRWRdjXkZiiYDYD1hP24z5oy0awzS67BfM64GQSDX8nB2ube3OjLtjRcEOKwJMbOe0f5puqKFZL7e8sqyYqQ5P/i4S6lYVQ9pwGsNDfkMYvOsXwqY+kpoGqK/zwInGlAxCwkDJyJjtUzjBxd8UkIw6o/r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730367728; c=relaxed/simple;
	bh=9PlbHMSNSKpXVBZgs1tkg673PiY9vY6J89ZIV8S6eus=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:Cc:
	 In-Reply-To:Content-Type; b=inkVDBzCf6A+H6cDNx0SlBfxaAr+PNrhshCUnmOqn7RGG6EMdL3zDzhU3fCk51gf0iiYrZ7eHN1qG+9jywQcmViIXEVQnnPA8xbK28qIBdbk2wsV7YesuKn60W67GnzyqSEuXEW8CGu486Q8EZr3ue+Du412Ie80tI3adfzVJho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de; spf=pass smtp.mailfrom=tavla.de; dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b=fD7N6wCs; arc=none smtp.client-ip=195.10.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tavla.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b="fD7N6wCs"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-105.mailbox.org (Postfix) with ESMTPS id 4XfJtH42Cjz9wMZ;
	Thu, 31 Oct 2024 10:41:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tavla.de; s=MBO0001;
	t=1730367719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AakRbrMHN6TC4VD5ee8jMev2K7QSpCp/4ZeM1x0FRNk=;
	b=fD7N6wCsx3FeZqa9mTfr8l5BiTpPaCa7JX0/ZHCQAmL5KB+/ZD9Qdz/hS7vvvpTVwjdTEl
	Yfiq1tSycpVlZFDVFbCJHt9xQOI5IiShGMBdpCRFzCB7NCkzzyAe4gHI4F5i7jmIoTzx2A
	9afqQzckGhgRzIo3sYdpAbQB6orXw2kT3cH6OyrnBajTcy1Vpz807XyCX4VWgFJKBecugO
	SlDMCDgMGcT1VibjPyQ3cEj8BH/pPjpu0iIyilAN0nSuyY0o/hmn7gmS30ms3VVpRz88OM
	Vlsb9H4gNGYnjdimQ7MmIrDsmOpG/hlW1xM4Rn3ofoODb5Ez+ygKl0SryiGsTw==
Message-ID: <43c03f86-08e8-4ca7-840d-9230efdd7b8e@tavla.de>
Date: Thu, 31 Oct 2024 10:41:58 +0100
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: How to disable power save (iwlwifi / brcmfmac)
From: Martin Petzold <martin.petzold@tavla.de>
To: Arend Van Spriel <arend.vanspriel@broadcom.com>
References: <3650c0e9-6d4e-45bb-ab44-ce5849d3ffe1@tavla.de>
Content-Language: en-GB, de-DE
Cc: iwd@lists.linux.dev
Organization: TAVLA Technology GmbH
In-Reply-To: <3650c0e9-6d4e-45bb-ab44-ce5849d3ffe1@tavla.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Arend,

Am 30.10.24 um 20:54 schrieb Martin Petzold:
> Hi,
>
> to disable "power save" with NetworkManager I used:
>
> -----
>
> [connection]
> wifi.powersave = 2
>
> -----
>
> However, using IWD (with iwlwifi or brcmfmac) I don't know how to get 
> this set:

I can't find any specific parameter using "modinfo brcmfmac". Does 
BCM4339 (Laird LWB 5) with brcmfmac (6.1.36) support power save?

Then it maybe could make sense to switch this off by using "sudo iw 
wlan0 set power_save off" or IWD configuration parameter 
"PowerSaveDisable=brcmfmac" in case there is some trouble with 
connection or roaming. We have a very strict web socket ping/pong (no 
loss accepted) this worked very well for years, however, it seems our 
problems are related to this (maybe single package losses, which may 
happen with power save enabled).

Thanks,

Martin

