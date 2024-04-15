Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC0674420
	for <iwd@lists.linux.dev>; Mon, 15 Apr 2024 14:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713189946; cv=none; b=Ro1vrb12ZqYgd6fRVaKYvfVSqCvnJxzfUP4pUBHbk3k7ecNU+H4teVQfNKbBAefOY0SE8b5dEy25m1r/Dj+jHbTcAiOEW97I4TdXIEEEPvbX5lIDZz21/7kG0RuM8QJljr5Xxb2UFJ53mZHeQ2kDS8Umr1CibJgqS6VBHamrIso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713189946; c=relaxed/simple;
	bh=wSGj5GbKaUQU2/DCapHOtQUItaa9AOS882EgPCywWuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ki9q7bS5gkSEjcbPTfsyq2S98nyD2t1ksC0J67QKVkPPXHhNQkDZrt0TDazIJlv+I0SsSc6w/jsPseTDMb1RJ6GA5GMLwfuYi+S4iXdH8RyOBXawhm1PJh6z+Byzg6DyRhh57jOm3qPCVfPQFQWkMFtbzN/1MvSHOQ4jENJOEgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MVllc1QH; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVllc1QH"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4367e9f6b38so13151121cf.1
        for <iwd@lists.linux.dev>; Mon, 15 Apr 2024 07:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713189943; x=1713794743; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RCEODbFOhJFeI4dlt9VtZsMGeZaKxeyQTSOhUUU5j+4=;
        b=MVllc1QHc9ak1nSQ97NAadR/ZyM7Kjty6+X88iIhOyIIlMkI2n+L1jzKqFyaJMBaBJ
         4nAtroTQ73nu+8CBUhYspEwt1TZLd3g7HFbjDh199cSbbH8A+EM9owJMH/fGoiI3dZTM
         Rz5gHWOumwV2aCcI0TsCF1yei0wlY5rYWAH28iFWu8JQYV/zmlFzi4AK32Qw3JtZiln1
         v8nMebgXb7VtM8dE/SWvdhJkuUyc7F2nuN65mX2uSN0pAMSEQEQ19R1Gyl4QFKnxxf5z
         eVBSbUd+8TkGEakRmcSvuTtwVATVgfM4MMxeTt1biJtJvftEC+UzjKN0m67PV4PQARzE
         SFqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713189943; x=1713794743;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RCEODbFOhJFeI4dlt9VtZsMGeZaKxeyQTSOhUUU5j+4=;
        b=kMv3QVHf4F9Yv/7LC+wUGCA3b2wu7ZhG3AOQCYu+WcvitmEISvarus1/SRb9aiQ0BF
         2u2pS6ZyuhJ/0KaBq/ojRGhmjmy7imo89LtvTVWNFzLUce37ceZLl9ncgsSmEcZjTdKI
         aeLKLLVqQ8kgLAnnQwP7qxlaDPCvJwuzFmFRbSZyGJIGM31rd3UASdeSGgl6k58afyWL
         SgjInOlmcmaDwkBUCV0q6jUf5b/V1QdoZAz/c10Gg83e2Mjk8Sn+e74WWLpAsvUS89j3
         G2saKbag3LOPRropkLdeJ3g/6Vo76hvTJj6QUUHkd4IRLPKAz29FHFquczfyQbmrGj1F
         pBAA==
X-Forwarded-Encrypted: i=1; AJvYcCUD0LnWDk7I/cxl+0+Fltb3rErECUnOBOVWf/QSDA6Li0AUeA9HYvjN7NQAJQdMkWOutV4xqJCfwR5gGPhthTGsn5l5
X-Gm-Message-State: AOJu0YxJWEtW4u9xYEUvSulK3yF7QnSusxherK+A1MI2bTzQMWT22NH9
	zzE9qqFXBYdq24n7qB2BucP7od1LUMsWSlBBP/AWds+mKUM5s6oJ
X-Google-Smtp-Source: AGHT+IESjqop4/h+6CxUrzxATC8EcQ270J8cMmX2ESYoA4qMC/bvvISP/W4MKZOne8dg9r/nf9lSkA==
X-Received: by 2002:ac8:5dcf:0:b0:432:e325:2c27 with SMTP id e15-20020ac85dcf000000b00432e3252c27mr10759978qtx.52.1713189943513;
        Mon, 15 Apr 2024 07:05:43 -0700 (PDT)
Received: from [10.102.4.159] ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id ol9-20020ac84149000000b0043721c4654csm562444qtb.30.2024.04.15.07.05.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 07:05:43 -0700 (PDT)
Message-ID: <9f58f2a9-d2ba-4613-8613-9e44c1122e29@gmail.com>
Date: Mon, 15 Apr 2024 07:05:41 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] dpp-common: add TX/RX handlers to dpp_sm
Content-Language: en-US
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20240327151957.1446149-1-prestwoj@gmail.com>
 <20240327151957.1446149-6-prestwoj@gmail.com>
 <ae336a48-1606-47c4-a83e-59dc2560c1e6@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <ae336a48-1606-47c4-a83e-59dc2560c1e6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 4/2/24 8:27 AM, Denis Kenzior wrote:
> Hi James,
>
> On 3/27/24 10:19, James Prestwood wrote:
>> This copies the bulk of the protocol handling from dpp.c into
>> dpp-common.c. There are no logical changes but some adaptations
>> needed to be made in order to isolate the encapsulating protocol
>> from the common protocol.
>>
>>   - The DPP header is now reduced to not include the mmpdu header
>>     or catagory byte.
>>   - A channel switch must now notify the encapsulating protocol
>>     since DPP common has no concept of frequency/channels
>>   - When a peer is accepted its up to the encapsulating protocol
>>     to filter frames only from this peer for the remainder of the
>>     protocol. With PKEX the peer/own MACs actually do need to be
>>     communicated to dpp-common due to some of the key generation.
>>   - When a PKEX key is not set into the SM its up to the
>>     encapsulating protocol to provide the key after a
>>     PKEX_KEY_REQUESTED event. Once the key is obtained the SM
>>     can resume the PKEX protocol.
>>
>
> There's a lot going on here, I think you're going to need to come up 
> with a different strategy and break this patch up into digestible chunks.
>
Sure, I tried, but its just a nasty build breaking change :)

I can try and make some of the improvements ahead of time, add frame 
handlers separately (auth/pkex/config/etc), then add the different events.

Thanks,

James


