Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D25915575E
	for <iwd@lists.linux.dev>; Mon, 11 Nov 2024 13:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731331618; cv=none; b=obnR66etwYX6EC1tdajSaBd9I9sFj/d1J8ZREH1xSRti9OzhYnKDAOzzojHyt6n3kn1SnBcROOvL5jj1b0pJN2zat9qmMfMWpGqC4olUu2a1ajkpGWSZxtvoaeko6rlvacfe0PRenlqTWPHY+Jpm3oV7GXWtfoeMCbTyePekdI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731331618; c=relaxed/simple;
	bh=HJZ37JY17+QlGdjuUZYhbY9+AZmkVx/8wsKBgP8/wb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=chtcgxanEpbid6SAYG8IilGyaKpCFuo11DiohsYR2+faoP3ba3ZD4FowYl9V8kMcUfYiHd9fEic9PW/NsV51Uk2akqhUES7fe1ycvf93HL8YJOQCjwKV1mzAwj+43T2eqwq1ZUrqJRWPl5XAzKBYnqusIQ1KNLoh7jVNDhUEBWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jKT7CPE5; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKT7CPE5"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3e60fca5350so2596767b6e.2
        for <iwd@lists.linux.dev>; Mon, 11 Nov 2024 05:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731331615; x=1731936415; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3QvBrY/18k+fUMB0h11zK7i/tGULB7QD5tLiDtBKxtg=;
        b=jKT7CPE5BsJ3WPVhpoVyi5KykKWDdXs0YXZGhx3MqynQQJHfLHJ8ip2MiB9N2Gd+sd
         7fwm2TeHsdfOSATHnyIVEmt69WSRJ4f7aOAcjH3JXtvL1L2VcjdjDkvGvuuoReR62K+M
         lJ/QgQP0eUKQAWXQnsUmJLDE6adiVpOsYGinvtjG+H61zWRlTRp6HUDpwp+zmQdGoSrR
         yjoMjyTWeGiUeZy6DEu97QlDH95EkeWuuNaLCW8bdRvl+khA0nsXu7AXYpf/X8O6rxTy
         DqUKXFYfom2ZkEiZQaYSyDZE/Pn6ebdrMNVbOF4ViDybbG5cXBHEGJcJaNxuVWXeBaqr
         hPIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731331615; x=1731936415;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3QvBrY/18k+fUMB0h11zK7i/tGULB7QD5tLiDtBKxtg=;
        b=SL3QB+EA5lSMZSi/SgXxC5CD9SUwkEPjkskFmh9L+xxwnjumZOJb2e2yj2eTO/XmY5
         D+MTqDLRr2ljT9qHBX/LiukfSXwn0EK0rneQKI01EO9Qul/1q5cTiXvwUJRwUYrvlaVb
         dPdg3sgtki8UAFUSVAHPEtDnOweRvYD5lZUSqeIScgIdvyGQ6p9WUeIs+zK0pPWlBWOU
         Es0CqzJSnE/vsoG9XNz3Y3xKpgFi9CvV5u+crszeqIY7R8uq8yZu5FtbyGNO4lNYALGH
         SqixNF7mJliE9hC77REOyTAFy1iUB1YqFOoK1m4X9GzT4X/TlYIy+dF8zhm/c9cj2sxC
         dFMA==
X-Gm-Message-State: AOJu0Yw7+lR5Zn5Ad7aWHRJbFY0sS4BbPH2FB23sgaaHwE7eqooATMyx
	c6GtJ4r3Nl/tcVJ/8XLkVRosfq/SifF7SYipxaElPDc0DEw6NcMFePAkXQ==
X-Google-Smtp-Source: AGHT+IHx6KRkbONe4Bcsuo+//nFx2f1jQhh4loSG9LlxeYCXcHe0/udbUdj2ClAJTvL8oQjrcHb8Ow==
X-Received: by 2002:a05:6808:18a0:b0:3e5:fa1c:ca6a with SMTP id 5614622812f47-3e79473b7f6mr10546201b6e.36.1731331615339;
        Mon, 11 Nov 2024 05:26:55 -0800 (PST)
Received: from [10.123.55.198] ([4.4.136.218])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e78cca4670sm2072363b6e.22.2024.11.11.05.26.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 05:26:54 -0800 (PST)
Message-ID: <3c07574e-5d85-4874-8268-65a9321546f9@gmail.com>
Date: Mon, 11 Nov 2024 05:26:53 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Calculation / algorithm of the 5 GHz vs. 2.4 GHz network
 selection
To: Martin Petzold <martin.petzold@tavla.de>
Cc: "iwd@lists.linux.dev" <iwd@lists.linux.dev>
References: <062550db-0b14-4576-9278-7bbb3c35e84c@tavla.de>
 <500df14d-6e5c-4c4c-abf4-c435bb382bbb@gmail.com>
 <942366c2-98ee-4757-b7c8-b9e6c54532aa@tavla.de>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <942366c2-98ee-4757-b7c8-b9e6c54532aa@tavla.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Martin,

On 11/10/24 7:04 AM, Martin Petzold wrote:
> Hi James,
>
> Am 28.10.24 um 12:35 schrieb James Prestwood:
>> Hi Martin,
>>
>> On 10/26/24 12:28 PM, Martin Petzold wrote:
>>> Dear James,
>>>
>>> could you please point me to the calculation / algorithm of the 5 
>>> GHz vs. 2.4 GHz network selection.
>>
>> In the future you can still ask anything on the mailing list, that 
>> way others can use this info later on. First we separate network 
>> selection and BSS selection. Network selection is simply a MRU (Most 
>> Recently Used):
>>
>> https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/src/network.c#n235 
>>
>>
>> Once a network is identified the individual BSS is selected. Each BSS 
>> is given a rank which is heavily based on a theoretical data 
>> throughput calculation. This is based on information the BSS 
>> advertises. Basic rates, HT, VHT, EHT information is all used to 
>> derive an estimated data throughput:
>>
>> https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/src/wiphy.c#n988 
>>
>>
>> Only then does 5GHz and 2.4GHz come into play. There are configurable 
>> weights that can get applied on top of the final rank including a 
>> preference to 2.4GHz, 5GHz, or 6GHz:
>>
>> https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/src/scan.c#n1700 
>>
>>
> Thanks, I checked already and will do some more calculations.
>
>
>> The modifiers can be configured to prefer one band over the other in 
>> main.conf:
>>
>> [Rank]
>> BandModifier2_4GHz=1
>> BandModifier5GHz=2
>> BandModifier6GHz=3
>>
>> These values will be multiplied by the calculated rank.
>
> Thanks. However, I am not sure if I understand your suggested values 
> right. Therefore, some questions:
>
> 1. Would the stated values be something realistic? Or should it 
> actually be decimals?
>
> 2. Does your suggestion mean higher ranking for 6 over 5 over 2.4 GHz? 
> These are not the default values, right?

These are not suggested values, just an example. You will have to decide 
what works for you. IWD will do its normal ranking calculation and come 
up with some number, R. Then:

if (2.4 GHz) {
    R = R * BandModifier2_4GHz;
else if (5 GHz) {
    R = R * BandModifier5GHz;
...


>
> What we observe and would like to improve:
>
> - We have two devices in a building with an enterprise roaming 
> environment (Aruba) with 2.4 an 5 GHz network on the same SSID
> - The building has very thick and obviously radio blocking walls (e.g. 
> I don't have mobile network with my network provider; others have)
> - We have our device and a recent MacBook Pro as a reference device
> - Both devices are more or less at the same (fixed) place
>
> Now we see, that our device (IWD+brcmfmac) almost always connects to 
> the 2.4 GHz network (only once I have seen 5 GHz connection). However, 
> in this network the measured data rate is mostly around only 7-10 
> Mbit/s (in other setups we have 50 Mbit/s = backbone data rate in 2.4 
> GHz - so everything is working!). Sometimes there are connection 
> losses, but with the latest patches things seem to be rather stable. 
> In the very seldom cases our device connects to the 5GHz network, we 
> have measured 180 Mbit/s.
>
> The MacBook Pro mostly connects to the 5 GHz network (but also seen it 
> on 2.4 GHz) and there we get measure data rates of crazy 280 Mbit/s 
> (more than ours, because our device only has 1x1 MIMO)! However, if 
> the MacBook Pro connects to the 2.4 GHz, the measured data rate also 
> goes down to around 10 Mbit/s.
>
> We don't know exactly why this happens (because usually 2.4 GHz would 
> go better though walls), but maybe it is simple overloading of the 2.4 
> GHz bandwidth. But, we are not talking about a heavy crowded place. 
> The infrastructure provider does not see any backbone or structural 
> overload. But they are also not really supportive and precise on my 
> questions.
So I would say you might want to modify the BandModifier5GHz value to 
something like 1.1 or 1.2 (10% or 20% increase in rank for 5GHz 
networks). Without seeing the actual ranking numbers though, I'm just 
guessing.
>
> We will now further improve our logs in order to understand the BSS 
> selection better. But as far as I understand this is not easy because 
> IWD does the initial connection, but brcmfmac could then change the 
> BSS during roaming, which we then don't see in IWD event logs 
> (right?). However, we can read out the connected BSS over time and 
> compare.
>
> 3. Now I would actually like to give the 5 GHz network a higher 
> preference, BUT without loosing the connection. I am worried about the 
> device getting into a connection loop if I rank the 5 GHz networks a 
> lot higher and then only connections to those BSS take place and maybe 
> fail all the time (in terms of very bad connection and dropping after 
> a short time). Also if I am right, I cannot really influence what 
> brcmfmac does, right? Or will it only roam to same band BSSes?
As far as roaming no, you can't influence brcmfmac. IWD does get 
notified when the firmware roams, but has no control over it.
>
> 4. I wonder, why do you somehow rank 2.4 GHz preferred in the default 
> setup. Shouldn't the 5 GHz network always be preferred, if the signal 
> is more or less okay (because there is far more bandwidth available 
> and mostly all legacy devices fill up the 2.4 GHz)?
Its based on the rank that IWD calculates for each BSS. For two BSS's 
that advertise the _exact_ same capabilities it comes down entirely to 
RSSI. Otherwise its heavily influenced by capabilities advertised. 
Basically the theoretical speed that it can support, which does take 
RSSI into account. Since 2.4GHz has much better penetration I'm assuming 
those BSS just have much better RSSI than 5GHz, but I can't say for sure 
without seeing logs. Its very easy to read the logs and see what IWD 
ranked each BSS.
>
> Thanks,
>
> Martin
>
