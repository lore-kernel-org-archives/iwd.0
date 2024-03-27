Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB59D3D69
	for <iwd@lists.linux.dev>; Wed, 27 Mar 2024 19:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711566644; cv=none; b=Yr+0vm1PGx9jOo6kbM7VY8GMu1jGvmrc3YgoGGksqZU7hW4DV9+mwNBFveo9j6HdLoQbvC64usYeUbqXnOBC3mtKKrB2EyaAjEZqmVi9VqRHRrviVu44flEpJ5BVStFLPoFFIte+xJvPrq2U56x7pA+B8vh7+qGnt0/jtvPQDVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711566644; c=relaxed/simple;
	bh=siw118EGIGC0fbLadiG/dW93P0TEiN+lapm32e8rsuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FndKWaSiHLxQ6D6pImdeoY2BdoCy/mPuJcR0oZ5t7ecPINoN42nVabFUrUS73GpxUg3O7ZaRtbAJeY9n/3VI1a23/heN+E0iI4g2kbGsOor2Mi8daUQK22VkBvdCajwri/WI8aMoY+J60hfaPCzBJ6B/wDGITGDD/SOjGiSQkKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d5M5wmuc; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5M5wmuc"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-78a2a97c296so6610085a.2
        for <iwd@lists.linux.dev>; Wed, 27 Mar 2024 12:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711566642; x=1712171442; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QAyFiHLed//5+Foh04CUN2jYhRoD9nNFyslO4SVYknM=;
        b=d5M5wmucDWdyubkmzKzi1Q/4kpUM4IzhEq9qcadER/Q90Qvd2EmKuYOU+rfzpGs/iO
         mqn3bKvrpUTkNfDhr4BboYIAJ+I9dMMmflgm8wqzY95j50/M5GFnaLyaPsqoOCh2DyDb
         v1n1UaZYoWKVqwVXSXUxQZYLUqeOekbDWH1s6CuVf/KVFQsjwiLOJWpiDBrum9y1RWJv
         GLisD5mMLSgtHIUnA9sMucLhWDp0d5vRT8LIRCZhqxVEeBo2uV1245r8WDIqrSCS4dta
         UZa9iLTc6eBXCmir3oj10eS4tNSesMVXyOF45fkodUOMYjvcye57ZO+z3So5FDJ5dldJ
         wM4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711566642; x=1712171442;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QAyFiHLed//5+Foh04CUN2jYhRoD9nNFyslO4SVYknM=;
        b=s+ptRBRrxu0wg2e2/NMsXmXOaPTZECSXR3/731C8A4kO3T0DoSXSKLK8QS0eZj2h/m
         UlJRNsBVaQeBYBQf/5R6OkcElKsEx00oJXQ3GWFwbp2TCeWY8z+HGkBsdau2bJ+6hEA8
         lBa72FA75Mmxy6auzobpcX3121tcn6F6alDBfh8iqZBXQS403yDhYGj8wx7YdrpY0nOy
         K6d6nh9jjz9LJYj6gpOnrr4Sxs47Y9j/WAU+EqXYwSSd8eyaqsCPJJx8wyjFpBQ6ZEBp
         Wa3ucd1k36bg/bjpNQG5H6ZRKPf9fnCcYiI/kkgbtPUJTg3yVr1VsJIT6IBVGLCLrzth
         6fug==
X-Gm-Message-State: AOJu0Yw95t6vNnCNxWr7myqHMNkE3QURT9hi2sSDXvxZZ+psx0Su/Bpu
	a7qBgoS8ZdzepUBUiMtzW3ystItTss6E24z11TvGXLh6EvzkY9jsaPiLhW+z
X-Google-Smtp-Source: AGHT+IEpi8/MssjQLM081ymvmDa1moFdYWUAgBHdqWguJ9555lsFuDzzh73pemEtfDO8XlT5fi9rLA==
X-Received: by 2002:a05:620a:2442:b0:788:3121:bcb7 with SMTP id h2-20020a05620a244200b007883121bcb7mr584252qkn.20.1711566641679;
        Wed, 27 Mar 2024 12:10:41 -0700 (PDT)
Received: from [10.102.4.159] ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id 2-20020a05620a04c200b0078874069a89sm4092574qks.9.2024.03.27.12.10.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 12:10:41 -0700 (PDT)
Message-ID: <a4014794-040d-4cf7-8f24-ae4bc315141e@gmail.com>
Date: Wed, 27 Mar 2024 12:10:39 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Register EAPOL frame listeners earlier
Content-Language: en-US
To: Jeremy Whiting <jeremy.whiting@collabora.com>
Cc: iwd@lists.linux.dev, ed.smith@collabora.com,
 alvaro.soliverez@collabora.com
References: <20240326231151.607163-1-jeremy.whiting@collabora.com>
 <2959f53a-e038-4b17-9b12-26a1901842c0@gmail.com>
 <2cc42d-66046b00-3-734beb8@251373457>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <2cc42d-66046b00-3-734beb8@251373457>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jeremy,

On 3/27/24 11:53 AM, Jeremy Whiting wrote:
> On Wednesday, March 27, 2024 05:51 AM MDT, James Prestwood <prestwoj@gmail.com> wrote:
>
>> Hi Jeremy,
>>
>> On 3/26/24 4:11 PM, jeremy.whiting@collabora.com wrote:
>>> From: Ed Smith <ed.smith@collabora.com>
>>>
>>> If we register the main EAPOL frame listener as late as the associate
>>> event, it may not observe ptk_1_of_4. This defeats handling for early
>>> messages in eapol_rx_packet, which only sees messages once it has been
>>> registered.
>>>
>>> If we move registration to the authenticate event, then the EAPOL
>>> frame listeners should observe all messages, without any possible
>>> races. Note that the messages are not actually processed until
>>> eapol_start() is called, and we haven't moved that call site. All
>>> that's changing here is how early EAPOL messages can be observed.
>>> ---
>>>    src/netdev.c | 10 ++++++----
>>>    1 file changed, 6 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/src/netdev.c b/src/netdev.c
>>> index 09fac959..fc84c398 100644
>>> --- a/src/netdev.c
>>> +++ b/src/netdev.c
>>> @@ -2982,8 +2982,13 @@ static void netdev_authenticate_event(struct l_genl_msg *msg,
>>>    						NULL, netdev->user_data);
>>>    
>>>    		/* We have sent another CMD_AUTHENTICATE / CMD_ASSOCIATE */
>>> -		if (ret == 0 || ret == -EAGAIN)
>>> +		if (ret == 0 || ret == -EAGAIN) {
>>> +			if (!netdev->sm) {
>>> +				netdev->sm = eapol_sm_new(netdev->handshake);
>>> +				eapol_register(netdev->sm);
>>> +			}
>>>    			return;
>>> +		}
>>>    
>>>    		retry = kernel_will_retry_auth(status_code,
>>>    				L_CPU_TO_LE16(auth->algorithm),
>>> @@ -3099,9 +3104,6 @@ static void netdev_associate_event(struct l_genl_msg *msg,
>>>    			netdev->ap = NULL;
>>>    		}
>>>    
>>> -		netdev->sm = eapol_sm_new(netdev->handshake);
>>> -		eapol_register(netdev->sm);
>>> -
>>>    		/* Just in case this was a retry */
>>>    		netdev->ignore_connect_event = false;
>>>    
>> I need to have the CI email the original sender so you get notified, but
>> as Denis mentioned this still breaks FT because IWD does not use the
>> conventional CMD_AUTHENTICATE and instead sends an auth frame using
>> CMD_FRAME. This means that there is no authenticate event at all when FT
>> is involved. Because of this, no SM gets created (with this patch) which
>> breaks rekeys.
>>
>> After FT authentication netdev_ft_reassociate() is called which issues
>> the CMD_CONNECT call (this triggers association). So I think you would
>> need to both create the SM similar to where you did here, as well as
>> after it gets destroyed in here:
> I think I see. I've got a couple of questions though.
>
> 1. How if possible can I run the CI tests locally?

I'll be the first to admit, the documentation isn't great. But:

https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/doc/test-runner.txt

> 2. Should I instead just change the eapol_register that we removed from _associate_event to keep doing the _register if netdev->sm is null?
> i.e. Change the patch from removing the 2 lines to wrapping them in
> if (!netdev->sm) {
> }

That also could work. I would just comment it, since its really just to 
serve FT. Explicitly creating it in netdev_ft_reassociate may be more 
clear. Maybe Denis has a preference.

>
> At any rate I just sent a new patch with the suggested addition of registering after freeing in netdev_ft_reassociate. I can test that this afternoon, or try the other approach as well.
>
> thanks,
> Jeremy
>
>> https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/src/netdev.c#n4279
>>
>> For reference, this is the CI output with this patch:
>>
>> **Autotest Runner**
>> Test ID: testrunner
>> Desc: Runs IWD's autotest framework
>> Duration: 1868.49 seconds
>> **Result: FAIL**
>>
>> Output:
>> ```
>> testFT-8021x-roam,testFT-FILS,testNetconfigRoam,testPSK-roam,testSAE-roam
>>
>> Thanks,
>>
>> James
>>
