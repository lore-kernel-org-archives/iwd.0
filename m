Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669F1130E5A
	for <iwd@lists.linux.dev>; Wed, 24 Jan 2024 18:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706121239; cv=none; b=AxoAiW/zmG+cbgLKbShyxoJDy6slqDrJdMi3kv3BxdWAATs7LvSyFtlXyOdAXeeSW0nG4J9RmfsGsnADJwPWDBZqXjG7CnN5Yl+Sm6240/ivclHkL/7/aM2s2ZEO051yKdQkv6rqQWwT7k18bP/xSLSXB51VM+MvISI7hEQ7W0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706121239; c=relaxed/simple;
	bh=AY3KhY6cjSWxv5hwbrjnked+Mtoua47xLZh88Yw9t3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lG4p3lJSD8wRSf9k83Cfjoje7hy9D/V4VH1aYCscNYnaIYK+En330lgm0pKKLdXUd0dVE7SWa1qD1AOy93n9WXL8FmvRdPnYOf6qwKDRekvLPDtS8qLITDmlkDAIgfJR17MGoaBBKAwjMddwID1QIeNFKUz5XN2n9VuoU764H1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XVQpDMJ+; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVQpDMJ+"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7833b6bb41bso496413685a.3
        for <iwd@lists.linux.dev>; Wed, 24 Jan 2024 10:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706121237; x=1706726037; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fq3VlIGTf+y3iXdkPONB9PwPZKX02VHUOcJFJY1RN8s=;
        b=XVQpDMJ+wv0mmc3r/XY3k0eU4dQO+/6LvXWPvskBUm6hshQ6TLabUjDTnqw8vgkkbn
         LJ2N221WIvWskFqmkJMCprwmqaSxucfUjWhSGMEHiq3rb4UWOx6CqpN8ZDqsst52D77E
         NMBPE0u/LX1rGT+WkGpMHl/ABwgkWm23aKBQsO8W6oqjku7g/REnEezS6zuqwRctn3sb
         R4E2bO1p/KxUWftONhERxRlXwBaCsvrOi+zzU4rTx/n3uB8ckWAoWT4FFYF+UtsSwnp9
         eENTXmb+G24OsA8HGVMqqm2s9DBimcMoTjIMxMwDjxrAGZLoybr7NJJ0L8U1mbvjDKI9
         SloA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706121237; x=1706726037;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fq3VlIGTf+y3iXdkPONB9PwPZKX02VHUOcJFJY1RN8s=;
        b=ShkDtFf0UtBBd2d1dA2iG0UB/t0u9xoz3XjjBh9QH/Zx6cO73Qyhhnp9HJFt6vV7o6
         Dk0MW2tTfseqKO3/B/0TovkUbhMHEpuUa/GwlyP7LTNX+ikdTlYaR+0u2QOaykjOJOkf
         1lZEHEfrkBnocYQbQe4EvQEDn4yevP/htAGQDgkWGdVKTyyEyog8TkFz5CV2kbkqTa3p
         bQ3pYcxZF7RWm9I4qqVBFtzDmODbTymBR0BjaaEbYopXAXtKO2m/f5BD0+3F9FXeTF/q
         RG+/KYqnXPFVekCurN9bB2Bijlvys+2bVkWft/kLDu6+Xpmn8p252IQGRib70h5cPh7X
         gMAw==
X-Gm-Message-State: AOJu0YyQu1ZdJ9JI45VDweTTsbGA01yCjkVFgmQrh4WBYadWPDDVOkA/
	GuTAbcmsl8szUMdmilyfFE+roRlJlZo9RUKWyuRqRLU4hacaQCxov8KFyemoOeQ=
X-Google-Smtp-Source: AGHT+IFPBzLaTFLe36hDKvBmZD7aptm9TQf9szRRAnopgqTh8SY/zOTmQYhGrSq1NneT92iuj2io2Q==
X-Received: by 2002:a05:620a:d81:b0:783:48b1:7b71 with SMTP id q1-20020a05620a0d8100b0078348b17b71mr11240480qkl.9.1706121237359;
        Wed, 24 Jan 2024 10:33:57 -0800 (PST)
Received: from [10.102.4.159] ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id x21-20020a05620a0ed500b0078322355fb7sm4281842qkm.20.2024.01.24.10.33.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 10:33:57 -0800 (PST)
Message-ID: <ac057182-4b8e-44ef-ac32-9b039d13e45f@gmail.com>
Date: Wed, 24 Jan 2024 10:33:55 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] knownnetworks: sort known frequencies by BSS rank
Content-Language: en-US
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20240124134001.20453-1-prestwoj@gmail.com>
 <20240124134001.20453-2-prestwoj@gmail.com>
 <703a48ba-41f8-4104-bb1d-6b017ae76e15@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <703a48ba-41f8-4104-bb1d-6b017ae76e15@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 1/24/24 10:10 AM, Denis Kenzior wrote:
> Hi James,
>
> On 1/24/24 07:39, James Prestwood wrote:
>> Currently a quick scan uses the entire known frequency list so
>> ordering really doesn't matter but improvements will be made here
>> to make quick scans "quicker" for large network deployments (with
>> many known frequencies).
>>
>> To prepare for this the known frequency list has been changed to
>> be sorted by BSS rank rather than most recently seen. This makes
>> a lot more sense because IWD should prefer to scan frequencies
>> that had higher ranked BSS's, not just frequencies that were scanned
>> last on the most recent scan.
>
> Interesting.  I definitely agree with the argument for treating 
> frequencies with higher-ranked candidates as preferred, but I'm not 
> sure that directly basing the frequency preference on the bss rank is 
> the right thing to do.  A client might start right under an AP, 
> ranking it quite high, but then rapidly move away where no APs exist 
> on this frequency.  So you end up always scanning the original AP's 
> frequency.  Some sort of temporal rank decay would be needed?
Yeah, I see your point...
>
> Perhaps an easier way to accomplish this would be to add known 
> frequencies in reverse bss->rank sorted order.  That way last seen 
> frequency with best ranked BSS would be first?

I'm not sure I understand, how would this be any different than just 
reversing the list I already have? Or are you saying sort by both rank 
and last seen? Essentially have the list segmented into chunks of 
frequencies found with prior scans:

[Last Scan] [N - 1] [N - 2] [ etc ]

And if a duplicate is found, move it to the front, sorted by rank?

>
> Do note however that the quick scan approach is really meant for 
> smallish networks, to cut down scanning time when moving between Home 
> / Office location for example.  It works surprisingly well, but might 
> not be appropriate for rapid roaming in a large network.
Exactly, e.g. with 50 APs (assuming you've seen them all) a "quick" scan 
takes 5 seconds.
>
>>
>> As far as the disk sync goes the ranking is not included, but
>> ordering is. This really isn't a limitation because when IWD starts
>> up there isn't any guarantee its in the same physical location so
>> old scan ranks are likely not valid anymore. The first set of scans
>> will begin replacing the frequencies loaded from disk.
>> ---
>>   src/knownnetworks.c | 16 ++++++++++++++--
>>   src/knownnetworks.h |  1 +
>>   2 files changed, 15 insertions(+), 2 deletions(-)
>>
>
> Regards,
> -Denis
>
