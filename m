Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7617F
	for <iwd@lists.linux.dev>; Mon, 29 Apr 2024 00:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714349063; cv=none; b=ddUdT130i0eVCKp8zwRXibw+mI7j5VvKfDyPHTV1InDSoKyKsDCeJ6DwC57ppu6tOJQ6mMCtCJRR/MmcnZRgGyAjPxd/StLWIlmYMVbhR9QqHIKgnN+BwF0CB14HZWtt2SGIMLBAeWMH9SLqSLPhwlzEnmSyJi+AoDPwu1xhzcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714349063; c=relaxed/simple;
	bh=cLg5myAiSuT9wR381BIpNyEiXr64EGzmhcDc+qwc05g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OrMTY5D0Lb7uy040kWoV6V+1M8yNPf36SVRdGlKPC12YDC0kraqlQJxK2bcsZ7lec0EP62I40xzOG+SpZsHd+TOY73XViClOvby6Orf+ABpo6xHL/1ePyhPR7YZeBm2lr3ha1Pauq4wYTxelLg6NZOT2Y0GrKyQpDg17q3QSq8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MRX3oWU6; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MRX3oWU6"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e4266673bbso34256505ad.2
        for <iwd@lists.linux.dev>; Sun, 28 Apr 2024 17:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714349061; x=1714953861; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zz++Lg7XB4osJohWp+DRSjpZusw7Sy3ST5e2MUJLsYA=;
        b=MRX3oWU6/8nNiAzzTaOcx+cr4y91OtXXUhJmdetPWvBhFTY2+I9nvPbFBx9YzUb/U6
         IVxFdTDXkzh8wc9IhBWWsR8lGdJK+o78Z1IRiUpkg1e6F4oERVWv2tXy/LzytXSOraZI
         UKhcGJ22zdQfcRwExptMx15OJoUOha9xqhtefoYTagoEMmhFuuL4/4NNgIc6gqiiSmUe
         o5lN4//qdlmiKP1VR3hpjbyOr+G86NwOHJ7JmBEoJp+hEpOajCByKnhJ/aVb+29miG77
         tY0hWVd9H8xsQva6HwacrqELLCfQ9eiBPCEClhoOoQL+pzuEgNpFGPuJdzBGH3FmzVo1
         UhVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714349061; x=1714953861;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zz++Lg7XB4osJohWp+DRSjpZusw7Sy3ST5e2MUJLsYA=;
        b=aFWepfGyuIoKkUVqLb+On3NkGOfEk1cs2uI/mGzGfmL7kWCDLpzMJT1m3EfzuNa6uh
         jRKvvOIETEObkcqcm1c7AHUOTg9/5a+07kcyObPIPuNVPk+YbBvu+trbP43zUdNwympb
         MJ7tRPrcy559J9wcDoYqdGU76XK409VjqJJXtXs3u/8DbxHIrZRR7iteCSEgZa7DWyae
         ZhMDe7NntKaDd1JxFUF9/ZG4CcaCBOw0/aNuSCTIQa+pa87Wa4LeAxWFCquBv2jSDs3b
         p/KlMLHNrmsOvHwYV0sdzSiLGgAWfkUgQ0QuQMZ7g45A3RlLTzsyDGPxoSbigdNZEQeJ
         DPAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdn4QmushrB/oTpEuo30Z/PEdk2yMb/hQ42jQ+nmTRDExRG4eDGHBRxv+FbEjvKzfsojiO6dggGwmSBKcrOrHxftoV
X-Gm-Message-State: AOJu0YxPf7AcIxUqum24dtAywj9jqm047tPmQ9NYOfLKW7At0q8EriZG
	qmlOBZAD0alaAr+baLUVOMiYM5NcgRb/N20lHPD9klOBfQDLZIdT
X-Google-Smtp-Source: AGHT+IFTFBHrSofFzpHElbIHQvQLSbYrU7TqSDT1QHMJ2HCP/PD2Aa7gdvy81AtaKapepeJ/x4C7dw==
X-Received: by 2002:a17:902:6b05:b0:1e9:470:87e6 with SMTP id o5-20020a1709026b0500b001e9047087e6mr8609116plk.23.1714349061245;
        Sun, 28 Apr 2024 17:04:21 -0700 (PDT)
Received: from [10.5.0.2] ([192.145.118.237])
        by smtp.gmail.com with ESMTPSA id u10-20020a170903124a00b001e3d38c9e70sm18938097plh.125.2024.04.28.17.04.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Apr 2024 17:04:21 -0700 (PDT)
Message-ID: <32416c35-4279-4e3a-9633-89cb71c7ce1d@gmail.com>
Date: Sun, 28 Apr 2024 17:04:18 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] Basic SAE support for AP mode
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240421125050.6649-1-brandtwjohn@gmail.com>
 <13851d8a-e91d-47e8-b9c1-0b1e7369edba@gmail.com>
 <fd8371c5-38a4-4302-ba1b-fa4577c5492e@gmail.com>
Content-Language: en-US
From: John Brandt <brandtwjohn@gmail.com>
In-Reply-To: <fd8371c5-38a4-4302-ba1b-fa4577c5492e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/24/24 05:07, James Prestwood wrote:
> 
> On 4/22/24 6:52 AM, James Prestwood wrote:
>> Hi John,
>>
>> On 4/21/24 5:50 AM, John Brandt wrote:
>>> This set of patches adds basic SAE support for IWD in AP mode. It has
>>> been tested by connecting to IWD AP using wpa_supplicant. Note that this
>>> does not yet correspond to WPA3, since WPA3 would also require the
>>> support of Management Frame Protection.
>>>
>>> Normal client functionality has also been confirmed to still work. After
>>> applying these patches it remains possible for IWD client to connect to
>>> WPA3/SAE network.
>>>
>>> Remaining TODOs are to include better sanity-checking of received
>>> frames.
>>
>> I took a quick pass and I'm impressed you took the initiative to 
>> implement this. I do need to take a closer look from the spec side of 
>> things but overall it looks good.
>>
>> Assuming we are compliant with the spec my only concern merging this 
>> would be the TODOs. You do mention this is experimental and certain 
>> checks are not done, but you'd be surprised at the number of people 
>> using IWD in AP mode. The minute we merge this we're going to have 
>> people using it, which in its current form would be insecure. I think 
>> we first need to get the frame verification implemented as well as 
>> MFP. But anyways, this is a good start and I'll give it a full review 
>> when I have some time, hopefully this week.
>>
>> Thanks,
>>
>> James
> 
> Reviewed. I also forgot to mention the CI we have showed test-sae failed 
> after your patches, so that will need to be addressed as well. I keep 
> getting reminded I need to also email the patch submitter.
> 
> Thanks,
> 
> James

Thanks, I've mostly incorporated the feedback, and also added extra 
frame checks. I can post the v2 version later this week.

I'm unsure whether I'll also have the time to experiment with MFP. Maybe 
it's possible to already add SAE support without yet mentioning WPA3 for 
the AP mode?

>>
>>>
>>> John Brandt (11):
>>>    ap: ability to advertise PSK and SAE
>>>    ap: accept PSK/SAE in auth depending on config
>>>    sae: add function sae_set_group
>>>    sae: refactor and add function sae_calculate_keys
>>>    sae: make sae_process_commit callable in AP mode
>>>    sae: verify offered group in AP mode
>>>    sae: support reception of Confirm frame by AP
>>>    ap: add support to handle SAE authentication
>>>    ap: enable start of 4-way HS after SAE
>>>    eapol: support PTK derivation with SHA256
>>>    eapol: encrypt key data for AKM-defined ciphers
>>>
>>>   src/ap.c    | 135 +++++++++++++++++++++++++++++++++-------
>>>   src/eapol.c |  58 ++++++++++++-----
>>>   src/sae.c   | 175 +++++++++++++++++++++++++++++++++-------------------
>>>   3 files changed, 265 insertions(+), 103 deletions(-)
>>>
