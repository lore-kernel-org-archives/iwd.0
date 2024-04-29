Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBB94D5A2
	for <iwd@lists.linux.dev>; Mon, 29 Apr 2024 12:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714392020; cv=none; b=cd5JbhSzPid5imsPsvV08JLQbE2MdcIphGiG23e5Mb8wOHTpyiEH0VNRAF/It/LP2jySQrQr5axResihYr8hHG8SzeS5TT+a/UYt+zECcHp7CYHc4SavGtV7eZjVbfOk0umTZu33tfh+0egQQ/mXYEXBQITv+cDlta74fFfPQaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714392020; c=relaxed/simple;
	bh=bnTpqCM0f5XTco3GtGcTPSPSMCkrlMBFe6uJLEJVACk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ph1zbFsaF59siNE1wqpGo8cuTSIgcwaKbgw/hfhNaur2vNWJpZae1wWJJY2t3uXEwTkSva4yPE73sQ8lh+8Jnq8lNWhldw0f5xPdkJzO0UkC+jdGQnKchCUS4bfuUSNovES4Pxah9rEFkDWN1dgcpUhweziIinHVaJQEZbayQpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KajtMnjb; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KajtMnjb"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6ecff9df447so4216005b3a.1
        for <iwd@lists.linux.dev>; Mon, 29 Apr 2024 05:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714392019; x=1714996819; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JsbgdLMwGChfzJjZ1K+vy4CpCP1mdNSdqC04kIPpl6c=;
        b=KajtMnjbg8oEeEwg9fW4b15hOOidyCl6ayvs8RVvyRGhfwX1aQyBxozkAgh8xlKUEt
         DPF5vrlqEl2aOZVGt3Wb3Fdi7rrLaO+spyzdrKB7rCuhWLft3eKbRG/HtYxfY+DQQyLY
         AXQJF+JJOFZFCaHtyPcQ8Sx0+mcTmBNkgbwkAhxBWrLqfmLBF4RrPmLIROXgQcBHifID
         sTMufxknPDyQd2eplTlh7VJoUFxgr1K4TpvY/u/3m3liRBKIYpGdHp4f+2CsFEGqRReK
         wuKbeo+7HHDEm0G2OMVVRayxTaaKzHhuJ96ViLJZdzbMOzjGGGfLaWcuGqXwdQqHmPpz
         G2rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714392019; x=1714996819;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JsbgdLMwGChfzJjZ1K+vy4CpCP1mdNSdqC04kIPpl6c=;
        b=foelhlwvQWsx4mYXtuz5OcB3GV1u4KwfW6uA0si4/eiBSAnyMW7WbiWN/aiUXQ0wxZ
         QXmaB8UBxl9KTqK7Xxhvbvw19doYMGMGF3AQ7I5bBdJRVK2lSCcSSebY6O5++PYs7r0j
         SCfvNs56pMqcNS1qOey47CMo35JAo6xMdPwkL03oH013iISRFV5XjkEVnLtB987Q794I
         9TTOsTyewHe7Q84SiTqrjXVWySXvp9UIGdFZZQdBUlG+nTnJL+FiZvsih7EB6A2JBb9k
         vUWO5Yl5gOM+ZPVl3NS9DFQVUIUhtMNtxiCC0NcXgq7RDwbD36PufmpnnuIQWCHCGha8
         p74Q==
X-Forwarded-Encrypted: i=1; AJvYcCWdtWq4rU/dtOH7X7kqqiFhA38n1omqRVG6lgFrmDB0SS3KDpO+VWaoVkYVfq8EnnN6TJnbX43Tomaqf1GyztnCYQvX
X-Gm-Message-State: AOJu0Yy0SJU6UfwbRepdnpK5qS2xqm940Pr0p3Br+ELPOPb9qrSeUH+Z
	VGbVOwHMDokcYlP3d1UjOurYqAFiH9LFJoaui/1OzO/01ktmSFA7
X-Google-Smtp-Source: AGHT+IH/P4/jar6P4MR82iWikH7WeohxQc8z05cs9xjqm8hchbjoG2DeUViNT+1/LTVpa+wEPSajQw==
X-Received: by 2002:a05:6a00:8c6:b0:6ea:b9ef:f482 with SMTP id s6-20020a056a0008c600b006eab9eff482mr13992410pfu.24.1714392018520;
        Mon, 29 Apr 2024 05:00:18 -0700 (PDT)
Received: from [192.168.1.68] (h67-204-152-76.bendor.broadband.dynamic.tds.net. [67.204.152.76])
        by smtp.gmail.com with ESMTPSA id ga23-20020a056a00621700b006e7243bbd35sm19750264pfb.172.2024.04.29.05.00.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 05:00:18 -0700 (PDT)
Message-ID: <6d9bac04-4522-49b3-879c-809b7e4f533f@gmail.com>
Date: Mon, 29 Apr 2024 05:00:15 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] Basic SAE support for AP mode
To: John Brandt <brandtwjohn@gmail.com>, iwd@lists.linux.dev
References: <20240421125050.6649-1-brandtwjohn@gmail.com>
 <13851d8a-e91d-47e8-b9c1-0b1e7369edba@gmail.com>
 <fd8371c5-38a4-4302-ba1b-fa4577c5492e@gmail.com>
 <32416c35-4279-4e3a-9633-89cb71c7ce1d@gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <32416c35-4279-4e3a-9633-89cb71c7ce1d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi John,

On 4/28/24 5:04 PM, John Brandt wrote:
>
>
> On 4/24/24 05:07, James Prestwood wrote:
>>
>> On 4/22/24 6:52 AM, James Prestwood wrote:
>>> Hi John,
>>>
>>> On 4/21/24 5:50 AM, John Brandt wrote:
>>>> This set of patches adds basic SAE support for IWD in AP mode. It has
>>>> been tested by connecting to IWD AP using wpa_supplicant. Note that 
>>>> this
>>>> does not yet correspond to WPA3, since WPA3 would also require the
>>>> support of Management Frame Protection.
>>>>
>>>> Normal client functionality has also been confirmed to still work. 
>>>> After
>>>> applying these patches it remains possible for IWD client to 
>>>> connect to
>>>> WPA3/SAE network.
>>>>
>>>> Remaining TODOs are to include better sanity-checking of received
>>>> frames.
>>>
>>> I took a quick pass and I'm impressed you took the initiative to 
>>> implement this. I do need to take a closer look from the spec side 
>>> of things but overall it looks good.
>>>
>>> Assuming we are compliant with the spec my only concern merging this 
>>> would be the TODOs. You do mention this is experimental and certain 
>>> checks are not done, but you'd be surprised at the number of people 
>>> using IWD in AP mode. The minute we merge this we're going to have 
>>> people using it, which in its current form would be insecure. I 
>>> think we first need to get the frame verification implemented as 
>>> well as MFP. But anyways, this is a good start and I'll give it a 
>>> full review when I have some time, hopefully this week.
>>>
>>> Thanks,
>>>
>>> James
>>
>> Reviewed. I also forgot to mention the CI we have showed test-sae 
>> failed after your patches, so that will need to be addressed as well. 
>> I keep getting reminded I need to also email the patch submitter.
>>
>> Thanks,
>>
>> James
>
> Thanks, I've mostly incorporated the feedback, and also added extra 
> frame checks. I can post the v2 version later this week.
>
> I'm unsure whether I'll also have the time to experiment with MFP. 
> Maybe it's possible to already add SAE support without yet mentioning 
> WPA3 for the AP mode?

MFP may be sort of automatic, it is for station mode. All IWD does is 
some minimal validation since it has an explicit profile setting to 
enable/disable/require MFP. It also checks the cipher support related to 
MFP. But I think for AP mode all you'd need to do is ensure that 
connecting stations are capable of MFP when connecting via WPA3. And set 
the proper bits in the RSNE.

Thanks,

James

>
>>>
>>>>
>>>> John Brandt (11):
>>>>    ap: ability to advertise PSK and SAE
>>>>    ap: accept PSK/SAE in auth depending on config
>>>>    sae: add function sae_set_group
>>>>    sae: refactor and add function sae_calculate_keys
>>>>    sae: make sae_process_commit callable in AP mode
>>>>    sae: verify offered group in AP mode
>>>>    sae: support reception of Confirm frame by AP
>>>>    ap: add support to handle SAE authentication
>>>>    ap: enable start of 4-way HS after SAE
>>>>    eapol: support PTK derivation with SHA256
>>>>    eapol: encrypt key data for AKM-defined ciphers
>>>>
>>>>   src/ap.c    | 135 +++++++++++++++++++++++++++++++++-------
>>>>   src/eapol.c |  58 ++++++++++++-----
>>>>   src/sae.c   | 175 
>>>> +++++++++++++++++++++++++++++++++-------------------
>>>>   3 files changed, 265 insertions(+), 103 deletions(-)
>>>>
