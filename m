Received: from mout-b-203.mailbox.org (mout-b-203.mailbox.org [195.10.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25D1BE4F
	for <iwd@lists.linux.dev>; Sun, 10 Nov 2024 15:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731251103; cv=none; b=e9QaCpI+QCMmIGpHMox76H8QPKjAm8PcHG8zjr7GlpZhgr63WhaK5Af9SgxRrr+HvBPhMHux5Gkw80B1cDrw5/6EN6mqkr+aER0rHr14g2JlHl/D0IC8hZZZLXOkowqgBZ2OH8m7hfp9OTPVA5aPqNF0ACnR22DZTa4eJFpY3xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731251103; c=relaxed/simple;
	bh=N/N78eVGK365YY4IPr9fryjneEAlSfQ/LnO+EjPHjvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=CmCYMmkBJKLWbGWBi3V0VAGKrnqqP8G99pRKiMkOgtlEA/VDeN8ajf7E6dkiNh0rwahFMdoZ3wUOxAThBSMAvhdEEuM8CMCOeN+Sv/Rqb9YoFyy8bYgtdcdENp/CHTFPYonCrsnzmNHKDFGgS0cYNr+iwTz1+LwFK5MbOtYy+jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de; spf=pass smtp.mailfrom=tavla.de; dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b=vvEF/Ahe; arc=none smtp.client-ip=195.10.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tavla.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b="vvEF/Ahe"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-203.mailbox.org (Postfix) with ESMTPS id 4XmbZ84gGDz9vCm;
	Sun, 10 Nov 2024 16:04:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tavla.de; s=MBO0001;
	t=1731251088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hGTj6nW1wBfedalwvxtGrdmWHqcceQVkH+TM55xQpTA=;
	b=vvEF/AheKdeCuKrTpUYFjcm4DCrB/ZTXrf23lungHK/4a/Wx3VuXgUCOwmptRxmhAZI/ML
	aiQYLWMdwBXkdag/63/8eKmnKZwvqUcCKHoXb13b/L7h0cqtIK+P3Dogaf87oDNPYfYeWH
	Ll0gf269X/29CURWZtuDQb66flXxWGWeGe2TGLQKxKXmiIGSCqa5in8eE/t/JJMtvzoOn+
	sD6q91ToVXWs7e+pduxWdZfznAAyJF7YMN3qxN1ZHhe01H9hN9z+R8PI2/hzj6I/+wEhFc
	8bywSk+y4biSVR+Fi+8Dw8RcIHgzOjLX4d7d9wzjDBTyRJQJSDP5PxH/eH0Wiw==
Message-ID: <942366c2-98ee-4757-b7c8-b9e6c54532aa@tavla.de>
Date: Sun, 10 Nov 2024 16:04:47 +0100
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: Calculation / algorithm of the 5 GHz vs. 2.4 GHz network
 selection
To: James Prestwood <prestwoj@gmail.com>
References: <062550db-0b14-4576-9278-7bbb3c35e84c@tavla.de>
 <500df14d-6e5c-4c4c-abf4-c435bb382bbb@gmail.com>
Content-Language: en-GB, de-DE
Cc: "iwd@lists.linux.dev" <iwd@lists.linux.dev>
From: Martin Petzold <martin.petzold@tavla.de>
Organization: TAVLA Technology GmbH
In-Reply-To: <500df14d-6e5c-4c4c-abf4-c435bb382bbb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

Am 28.10.24 um 12:35 schrieb James Prestwood:
> Hi Martin,
>
> On 10/26/24 12:28 PM, Martin Petzold wrote:
>> Dear James,
>>
>> could you please point me to the calculation / algorithm of the 5 GHz 
>> vs. 2.4 GHz network selection.
>
> In the future you can still ask anything on the mailing list, that way 
> others can use this info later on. First we separate network selection 
> and BSS selection. Network selection is simply a MRU (Most Recently 
> Used):
>
> https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/src/network.c#n235 
>
>
> Once a network is identified the individual BSS is selected. Each BSS 
> is given a rank which is heavily based on a theoretical data 
> throughput calculation. This is based on information the BSS 
> advertises. Basic rates, HT, VHT, EHT information is all used to 
> derive an estimated data throughput:
>
> https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/src/wiphy.c#n988 
>
>
> Only then does 5GHz and 2.4GHz come into play. There are configurable 
> weights that can get applied on top of the final rank including a 
> preference to 2.4GHz, 5GHz, or 6GHz:
>
> https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/src/scan.c#n1700 
>
>
Thanks, I checked already and will do some more calculations.


> The modifiers can be configured to prefer one band over the other in 
> main.conf:
>
> [Rank]
> BandModifier2_4GHz=1
> BandModifier5GHz=2
> BandModifier6GHz=3
>
> These values will be multiplied by the calculated rank.

Thanks. However, I am not sure if I understand your suggested values 
right. Therefore, some questions:

1. Would the stated values be something realistic? Or should it actually 
be decimals?

2. Does your suggestion mean higher ranking for 6 over 5 over 2.4 GHz? 
These are not the default values, right?

What we observe and would like to improve:

- We have two devices in a building with an enterprise roaming 
environment (Aruba) with 2.4 an 5 GHz network on the same SSID
- The building has very thick and obviously radio blocking walls (e.g. I 
don't have mobile network with my network provider; others have)
- We have our device and a recent MacBook Pro as a reference device
- Both devices are more or less at the same (fixed) place

Now we see, that our device (IWD+brcmfmac) almost always connects to the 
2.4 GHz network (only once I have seen 5 GHz connection). However, in 
this network the measured data rate is mostly around only 7-10 Mbit/s 
(in other setups we have 50 Mbit/s = backbone data rate in 2.4 GHz - so 
everything is working!). Sometimes there are connection losses, but with 
the latest patches things seem to be rather stable. In the very seldom 
cases our device connects to the 5GHz network, we have measured 180 Mbit/s.

The MacBook Pro mostly connects to the 5 GHz network (but also seen it 
on 2.4 GHz) and there we get measure data rates of crazy 280 Mbit/s 
(more than ours, because our device only has 1x1 MIMO)! However, if the 
MacBook Pro connects to the 2.4 GHz, the measured data rate also goes 
down to around 10 Mbit/s.

We don't know exactly why this happens (because usually 2.4 GHz would go 
better though walls), but maybe it is simple overloading of the 2.4 GHz 
bandwidth. But, we are not talking about a heavy crowded place. The 
infrastructure provider does not see any backbone or structural 
overload. But they are also not really supportive and precise on my 
questions.

We will now further improve our logs in order to understand the BSS 
selection better. But as far as I understand this is not easy because 
IWD does the initial connection, but brcmfmac could then change the BSS 
during roaming, which we then don't see in IWD event logs (right?). 
However, we can read out the connected BSS over time and compare.

3. Now I would actually like to give the 5 GHz network a higher 
preference, BUT without loosing the connection. I am worried about the 
device getting into a connection loop if I rank the 5 GHz networks a lot 
higher and then only connections to those BSS take place and maybe fail 
all the time (in terms of very bad connection and dropping after a short 
time). Also if I am right, I cannot really influence what brcmfmac does, 
right? Or will it only roam to same band BSSes?

4. I wonder, why do you somehow rank 2.4 GHz preferred in the default 
setup. Shouldn't the 5 GHz network always be preferred, if the signal is 
more or less okay (because there is far more bandwidth available and 
mostly all legacy devices fill up the 2.4 GHz)?

Thanks,

Martin

