Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6CC54F8D
	for <iwd@lists.linux.dev>; Wed, 24 Apr 2024 12:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713960453; cv=none; b=eZeO4y4LMkbB+fjbnKscGHTWHUhvEhPQXsGjO3YH1r4q+1EXiJpwEjBpDONake7YHv18MC8Q7ntXJHKmcLOandO7i7UarRJCqMTc8JjbT1eIeomC+5GVY7frEtLwpwM9xx07LUK5T+joPjbeIYgdY+64HXgypgAkrRLy67WvwJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713960453; c=relaxed/simple;
	bh=so5T988OKZKGyWb3VKqwPz/VKJjPjGPzB2aO14zaWNU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=r3G1K3jpE90SpezCZd5rKI0jCATj0zTWVvX+boZ/T5U3ob5dQjxcpP+nUjRBUMXp5PJWEGEBN/EQSitfNvuFYAe8f0iN1+qTpcDbzB9YOEWe2dBIXH3rUgZgIRxa+easAw4cLRJAkTlaKBf9/ncmQjNEL416UpDbWLErIpg+tmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TCnMoly4; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TCnMoly4"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-69b4043b7b3so39933296d6.1
        for <iwd@lists.linux.dev>; Wed, 24 Apr 2024 05:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713960451; x=1714565251; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=omfwagIFnxrV7t9WtpMNZXzOK3vT6DmdNPHMjSYAHQE=;
        b=TCnMoly4XLo/7NbfRV8TnWxDA+/VFMs3y4r/VR4n1Oe0r58BoNaACONBQT1BinLbBa
         VJsNEov5Z8YDTJ1NiZCX+mrBLoEjK8QL9+9WUx25dZ5mZUD5/vsxxdhq5BWXKFlsakey
         T2bHIIpJLwAO1rKcyJMtWqzsENOLJzFeRl7WBDW17VXKFxZqtx84Dt6wNYGJv9kwvFP6
         Zvoa0S17WqXBNhLkSi9vbTb2NwhmQywCI1ffy5XUvGr/xM+udwXwfG8CGSKNMXJeiNSP
         n0mj+aUfz1zWVZvBuMaH+Pm2OLjCnkXkJKUbTsk8t0KAYSb9bp4fbL+ix9PArCNMaSg0
         0AdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713960451; x=1714565251;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=omfwagIFnxrV7t9WtpMNZXzOK3vT6DmdNPHMjSYAHQE=;
        b=ieFBZX1CwdJhHWmwLXs68AEMhhO2shpnRzy/7XBsvm6w1BAnUmngk2pnuPS2LaLUnK
         6CfdQeyOS+PjG/sria49fclvWqRdlxioQK7JC9h69SnOQk9a8d8xZL629sJ3GnPeCgLX
         whYQsCNbRiZgQQlyJ4zamLIIMDN+QDpIgMwAmwbC3JRTwWxQK41rfdv+GgE7/E+kl8VJ
         Z2mW/qMH67i7GwRezOyDoFhTvhvSviEUNxlpr9IQz41qdtnqfzUcy/h7z7Ozp556bNrR
         rxh5SQ7HeraVrm7ij1mAXqCYKtmrYKsKy5XKq79RNFo5jZJspSHk8Yff4Q2exjaQ088M
         WKeA==
X-Forwarded-Encrypted: i=1; AJvYcCVATfc6OuLrLUYGNYzTBZygCl5CvqtApPxGccFOPGFe4jvZUgjTotA8L63J6NkRY3mCNccJo/U+65icOsbfyEQ7Xl/J
X-Gm-Message-State: AOJu0YxXwXzoSKsij4dqeuN1AjfwB7YjVJHSVi5renneEDMkUcV6NIgH
	Yb/KyUaCn3u0Ako8VXeCOP+xmq0blz6YsFqXSbl1W2c30QPxvmsG
X-Google-Smtp-Source: AGHT+IFklXaB5QEebWqaTdJ0y8OfjQxqL63TZyyAnZ2WeZgE8DgX3n8TMfM1FN65NHwpPugItHTTig==
X-Received: by 2002:a0c:f609:0:b0:6a0:946f:7e18 with SMTP id r9-20020a0cf609000000b006a0946f7e18mr1648981qvm.12.1713960451202;
        Wed, 24 Apr 2024 05:07:31 -0700 (PDT)
Received: from [10.102.4.159] ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id r15-20020a0c8d0f000000b006a045780b77sm3393748qvb.51.2024.04.24.05.07.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 05:07:30 -0700 (PDT)
Message-ID: <fd8371c5-38a4-4302-ba1b-fa4577c5492e@gmail.com>
Date: Wed, 24 Apr 2024 05:07:30 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] Basic SAE support for AP mode
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
To: John Brandt <brandtwjohn@gmail.com>, iwd@lists.linux.dev
References: <20240421125050.6649-1-brandtwjohn@gmail.com>
 <13851d8a-e91d-47e8-b9c1-0b1e7369edba@gmail.com>
In-Reply-To: <13851d8a-e91d-47e8-b9c1-0b1e7369edba@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 4/22/24 6:52 AM, James Prestwood wrote:
> Hi John,
>
> On 4/21/24 5:50 AM, John Brandt wrote:
>> This set of patches adds basic SAE support for IWD in AP mode. It has
>> been tested by connecting to IWD AP using wpa_supplicant. Note that this
>> does not yet correspond to WPA3, since WPA3 would also require the
>> support of Management Frame Protection.
>>
>> Normal client functionality has also been confirmed to still work. After
>> applying these patches it remains possible for IWD client to connect to
>> WPA3/SAE network.
>>
>> Remaining TODOs are to include better sanity-checking of received
>> frames.
>
> I took a quick pass and I'm impressed you took the initiative to 
> implement this. I do need to take a closer look from the spec side of 
> things but overall it looks good.
>
> Assuming we are compliant with the spec my only concern merging this 
> would be the TODOs. You do mention this is experimental and certain 
> checks are not done, but you'd be surprised at the number of people 
> using IWD in AP mode. The minute we merge this we're going to have 
> people using it, which in its current form would be insecure. I think 
> we first need to get the frame verification implemented as well as 
> MFP. But anyways, this is a good start and I'll give it a full review 
> when I have some time, hopefully this week.
>
> Thanks,
>
> James

Reviewed. I also forgot to mention the CI we have showed test-sae failed 
after your patches, so that will need to be addressed as well. I keep 
getting reminded I need to also email the patch submitter.

Thanks,

James

>
>>
>> John Brandt (11):
>>    ap: ability to advertise PSK and SAE
>>    ap: accept PSK/SAE in auth depending on config
>>    sae: add function sae_set_group
>>    sae: refactor and add function sae_calculate_keys
>>    sae: make sae_process_commit callable in AP mode
>>    sae: verify offered group in AP mode
>>    sae: support reception of Confirm frame by AP
>>    ap: add support to handle SAE authentication
>>    ap: enable start of 4-way HS after SAE
>>    eapol: support PTK derivation with SHA256
>>    eapol: encrypt key data for AKM-defined ciphers
>>
>>   src/ap.c    | 135 +++++++++++++++++++++++++++++++++-------
>>   src/eapol.c |  58 ++++++++++++-----
>>   src/sae.c   | 175 +++++++++++++++++++++++++++++++++-------------------
>>   3 files changed, 265 insertions(+), 103 deletions(-)
>>
