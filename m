Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF41C1272DD
	for <iwd@lists.linux.dev>; Wed, 24 Jan 2024 18:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706120174; cv=none; b=MMvTcUuv3U6F8x4XqGITmjGvkV3OIW5iXqyzpAoiq1tw4W+ei4B0DQ2GcIjHqIbtpYYd11p6jjLuaM7ANKUJUokLpawcSTWREQ/FoJTMf9+SirOFcQW8lOHfRJeC1MDJBY/KhsW3xrpTr14/3XjHDcSF+UuYpjOZPOw4soyr6Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706120174; c=relaxed/simple;
	bh=AaODrCwis12n1ZxN7LXXvHSU2w6lExp5gXmqCWfWEuY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=vDCrXD9e+fc6UVNsQN0rVFsk0Hd21CUXzfkyQL7qML2IvZGvBPC3REH3s8PN2GaT06eEt9/VeGOa+UJP+BGQzZxVEEqPqlJ1+V3sMX+gz0ENLTcN49gIHAjGmUyn8PseQ9T+JLsi4HPn4B4XHt5w8PLafh9O3+4eGONslOZ8mcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nEsY6O4f; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nEsY6O4f"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-21460195d11so1390887fac.2
        for <iwd@lists.linux.dev>; Wed, 24 Jan 2024 10:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706120171; x=1706724971; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hrHtb3yUrwyP8buAGVoHbEp3gIWFBHrBaJF//AKjIjY=;
        b=nEsY6O4fyp11E4DzYwvRb4Gg8UUwBWvssZNEKFdmyo+q9far5bv0KmfMUvpWUE9eEZ
         UXToIIn0BQoapNZgsI/+Gsea5LSJsBOhyLnqtdUcodwF1XjVM9ZQ6OUS9kuLwrswaiuj
         RZRlVHaTVaYMGxkviJyjq+cw/oaEcaS7P+FjdPqTbJTeTiVm9qV5BjFWH1xdBA7FiNGt
         AQL2n48y+AlaIG1TLXjBuEV7gA46wTOaqXpPYUmUxqmUxQTQLd+xzDWM2IeWhfSUZSer
         TYWvKzb34nfIVVYUNOnp+AJJH3bTDH+Naqas8qrxwooHIYR37KryrKbZlq86B1a4FTCr
         pJTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706120171; x=1706724971;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hrHtb3yUrwyP8buAGVoHbEp3gIWFBHrBaJF//AKjIjY=;
        b=wVWcOiQfBZemi93SD6wy1YMuRchRN9rN0jPnHIDlqYlMoMPn68gxV/BR0/cywQlPFS
         p2HyDEYntPvMll9E3aLDeVW+GqNKMZJ1RxQOFKA6dWZiXFVktvIyvszy08yEhr9lmhpG
         /MPu8B+BX1wQK1e5nzL0fUUVW/Ge0+X/Vg9w/NBkeGkbP9mavBh3L08mRMp5YCvjo/pd
         UOOUAapvI2ubFDAErkM10aDWKlgBvnJBFmojhq6zDZIty85Dik02juVfgxeIYOaKV6sl
         RDLywxuvERWLcsRbkCowZ9y4IQNpDp6nfMBkn9+y404WI0wT1h9YpGg3hMmuUyYhmXxJ
         1KKw==
X-Gm-Message-State: AOJu0YwxwQM8+SGvvt8xo9wx9ahuxqMVebu+jm1twW9jkcB/okhpU23X
	O5uVJPabaeXNb7e8JASdNRnFiMtoc1qTbt3z63247jgwdAnKRtmzIuqs31Y8
X-Google-Smtp-Source: AGHT+IGUFfMNx+nb6gcvA5GQ/gESlViwQh+AmLgB46e/5RnHv/wQ+/BjG6HTBeiLEaS3gkred1wGWQ==
X-Received: by 2002:a05:6870:9a14:b0:1fa:ca5:84be with SMTP id fo20-20020a0568709a1400b001fa0ca584bemr3651417oab.51.1706120170854;
        Wed, 24 Jan 2024 10:16:10 -0800 (PST)
Received: from [172.16.49.130] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id pc8-20020a0568701ec800b00214518af626sm1792210oab.5.2024.01.24.10.16.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 10:16:10 -0800 (PST)
Message-ID: <2f497276-cf8e-46b2-adf7-baa7567f7bf8@gmail.com>
Date: Wed, 24 Jan 2024 12:16:09 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] knownnetworks: pass scan_bss to
 known_network_add_frequency
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240124134001.20453-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240124134001.20453-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 1/24/24 07:39, James Prestwood wrote:
> This prepares to store known frequencies sorted by BSS rank.
> ---
>   src/knownnetworks.c | 6 +++---
>   src/knownnetworks.h | 3 ++-
>   src/network.c       | 6 +++---
>   3 files changed, 8 insertions(+), 7 deletions(-)
> 

I'm actually fine with this patch, but small nit:

> diff --git a/src/knownnetworks.c b/src/knownnetworks.c
> index 04ce74ec..f6284fdc 100644
> --- a/src/knownnetworks.c
> +++ b/src/knownnetworks.c
> @@ -566,7 +566,7 @@ static bool known_frequency_match(const void *a, const void *b)
>    * Adds a frequency to the 'known' set of frequencies that this network
>    * operates on.  The list is sorted according to most-recently seen
>    */
> -int known_network_add_frequency(struct network_info *info, uint32_t frequency)
> +int known_network_add_frequency(struct network_info *info, struct scan_bss *bss)

const struct scan_bss ?

>   {
>   	struct known_frequency *known_freq;
>   

Regards,
-Denis

