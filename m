Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153D916A92E
	for <iwd@lists.linux.dev>; Mon,  6 Jan 2025 15:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736177174; cv=none; b=Mel7o7lytmG79+y8ip5F1+m2h9tMcVEREwgxkmV1rj0uy7SGoIJZwHYZsJFBceVUvwmMVLPdfyGF+UTSB1V82Wdn///xVWP665z1bp7eKT+Ye7bMvLeHKZkwvzNzpuhKWJWckPdc42cOypmhA31DTUzEW7I7vKANFrVYc8z+MLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736177174; c=relaxed/simple;
	bh=O6Ox9nQwgPfXwhOpgc8e5LkUPiSfMPpWC2G7tdkDhPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tCr+mIDOVcSZiqUqhSLOx4ZU8RSMZspugIsVYdXGASJwTfvYJkaQqCSXxYfXO+Qz1RgB8d9TyxO5LkjrB8y1MfVHr//bEsHn6cp3ChhYNJXNXBGGJPIfwEXqRusRjVVRekt7WXOgf2XxjdWfdLuO3Y8DwoCShgyfEHPF+DkxiRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RAiP9Z2S; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RAiP9Z2S"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7b6f1be1daeso1360041785a.0
        for <iwd@lists.linux.dev>; Mon, 06 Jan 2025 07:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736177172; x=1736781972; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jW5fWET0UNiQFn86T+uVfVX873y1aFuCXrHKQX2qGf8=;
        b=RAiP9Z2SSjFWMdS8FIx+pHjjX2gtWFBL8MSSCDHe2EbDNfzrD5AKLe5lBlyK67FdRS
         XF4HRcwpOZRUswy+Khjbg4i6aNZrcavEQSsg7ruY1bNbky9t8+0e75GIaVqZ1gJmX4or
         T7No7Xun3EvC3WGK+4LN71DWhXwzykp6Q/DnyhvtFbx+Ef9pXPdSA89qxnXnAtuhN4zr
         oPfG0K/eJK+jzijoEFY33QGkcF17xY3XR/N+w3gMJ2wkoT6EPDmWkzx3zK6Tay8c+Qnp
         kx7QSkxC0GFuIuZ38h5Bf/KWhGb8lPpVIJT6Z/M8jc58dn8I5eWhlgxzIHTgLZ6oKcJT
         xTkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736177172; x=1736781972;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jW5fWET0UNiQFn86T+uVfVX873y1aFuCXrHKQX2qGf8=;
        b=DT4Khx4VXvztGqtdznRCqse3noMPBZafVGwN6X6X6fuSBYA9wqbNzGrEVJwP0M0Wh4
         SbSTwzzHXzTV+oRcVMxlfoa3zck5JFNF2lxg0Mj2A/GbGGJLwbeA4qtxvcF8gwtp3Y4h
         KJLgpthRTdv9QAjsQA4mDxmh0c4tFb6J+2fdS4N4kIemZssxdebOD30SOHZ2nLFWokvL
         ZQ8Ll9GWJi13jezQffUz+gpc06pbIjrawrPEQWd4eWCwgPf/jtaQVlDwZcQsrUoGnE84
         cnUTSX69Psnepu9JJtaPv3afn0UgoNPC378cmeEtIm88A20SmA0wIOqNveomodJRZNep
         eKqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwLRDxrNbFVIIWEudJFLmcImxZpYLofXEv/LpA5wYZOlqZ3aAV1sjAmsxaKyaNf83+3Cs=@lists.linux.dev
X-Gm-Message-State: AOJu0YwEvzzmfO/tYYqJNkZO8aes4iKIHPB0mPA0aOOgu6jnxsKP974+
	EmdS/386gsL7S47YmqsRefUo/vqMyv9elXp84gNFHy2/UGzLWExY
X-Gm-Gg: ASbGncuaX1SJmZzackOihNrk1g0IZG1oQBMkMD67lYOIBXBwGWpzRiIQFGuMz21otse
	oe9uvQF9rImS4NfHAnU513tUlrNvyJoSyvBbiOrzOUCUVoQEwBFPEhFZPlnSkT7tIT9iX6yUrcH
	ihJlAFRdwnPsi7+q+wY1WovLjf587YAeR7uw2FEKTRvjKGf2bPeRfCw2mWoC9yZv4VMwM57sauk
	0G4xdRYnv2SDE4aVcaGoZekqeWyPzJrRh2i9cxdreQ5rXYrPzkLY3xx7exK
X-Google-Smtp-Source: AGHT+IF/dJ9lRVxiYuurlVilOBBOJuwIt2QcURqYGzdLePb1cWMciXOktBf6KCm6Lu54XbubbvIUgw==
X-Received: by 2002:a05:620a:198e:b0:7af:cf07:905b with SMTP id af79cd13be357-7b9ba716941mr8777533585a.2.1736177171836;
        Mon, 06 Jan 2025 07:26:11 -0800 (PST)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac2df6d3sm1513370485a.46.2025.01.06.07.26.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 07:26:11 -0800 (PST)
Message-ID: <759fcc78-4ea7-4d74-8ee8-dc2704f3fed5@gmail.com>
Date: Mon, 6 Jan 2025 07:26:09 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] handshake: don't print NULL pmksa pointer
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20250106134606.115334-1-prestwoj@gmail.com>
 <9bbdd1b7-8fc4-497f-8ac8-80871df4a8dc@gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <9bbdd1b7-8fc4-497f-8ac8-80871df4a8dc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 1/6/25 7:14 AM, Denis Kenzior wrote:
> Hi James,
>
> On 1/6/25 7:46 AM, James Prestwood wrote:
>> This is undefined behavior so if no pmksa is found don't print.
>> ---
>>   src/handshake.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/src/handshake.c b/src/handshake.c
>> index f73f91d1..bee76b26 100644
>> --- a/src/handshake.c
>> +++ b/src/handshake.c
>> @@ -1272,11 +1272,11 @@ void handshake_state_cache_pmksa(struct 
>> handshake_state *s)
>>   {
>>       struct pmksa *pmksa = handshake_state_steal_pmksa(s);
>>   -    l_debug("%p", pmksa);
>> -
>
> Why is this behavior undefined? Would it not just print 0x0000...?

I had a brain fart, I was thinking for some reason it was using %s not 
%p. So yes, this is a valid input to the %p formatter.

I can alter the commit description, but I do think it still makes sense 
to move the print, or at least modify it to make it clear no PMKSA was 
cached, rather than just printing "nul" or "nil" or "0x0000".

>
>>       if (!pmksa)
>>           return;
>>   +    l_debug("%p", pmksa);
>> +
>>       if (L_WARN_ON(pmksa_cache_put(pmksa) < 0))
>>           l_free(pmksa);
>>   }
>
> Regards,
> -Denis
