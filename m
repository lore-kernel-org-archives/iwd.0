Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD09712BE98
	for <iwd@lists.linux.dev>; Wed, 24 Jan 2024 18:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706122510; cv=none; b=PonBPVcyBxrkbN86O1wxEFnXSLkW81BKuY/sK2AaMkNwH8pQeJ4EBHeNqBbr8N5jUbYiMHC5xkDNZaJOrSsVjCNOjCxYAH4gY0Z+LWi2CEVbK0mXmFkjyVyTn0JXGSVVYpkSeDjZLkHPI1M3VjnXoVFYJp260lN7VtAkaDXJbuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706122510; c=relaxed/simple;
	bh=rKn59L21zc12KQQICKcCVev88KG/QqhdnLRwNIOu2lQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QKtSIGLwhC/BQFSzYc0sBJflzllm56au8pse4aaKJyZri/VeAP1xRY+stMqoolDXEXtawfCfFX2DzSXJ9qwZ8VWcHTpWGWvSuiFrt6ezT9jIULDSH33eU4glh7dDGntcvntV26tT3UJcBG/K5SETQmAJnwRXiC5n2ITjQ1qlKRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dM9uG6QN; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dM9uG6QN"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-42a0454899dso47350861cf.0
        for <iwd@lists.linux.dev>; Wed, 24 Jan 2024 10:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706122508; x=1706727308; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bzpkRmyEEbrUvq6Q7V2nCzRKqrj4SDBGIr9Of7mnfc4=;
        b=dM9uG6QNfI+jHYyDHCDSiCaXaUsu7BH700wWv/Z9IXINoGEuzM9WwRYUMDdr3Duf+1
         7UHa+B6v93BNfB3+/Qx8L/qrDKqnEmEmIzfs/NEJBj3r6ItGBb7hUZnwPsVjObQgpR+b
         9Yc0juXVsCl3AXmAFEnd/huJASy9FFtJRqde09uOeBarJ+Am3C4lR16Yb5MEqtYbNgT0
         gwuewfilV4G4Poo2YMxIi4KlWVDzl0uRegpbdPMbk9JuGKOyL8uzsFHosyNYnKY+/Rqb
         7ShKN9RqT1V1YoPUFhhioA8st4KrNnY5Ec20vmIaKoKiAQCEOgpV/eASriggVcTjl+C/
         s4dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706122508; x=1706727308;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bzpkRmyEEbrUvq6Q7V2nCzRKqrj4SDBGIr9Of7mnfc4=;
        b=hCaM3lyTP9fhxCZx6CIh8MttLf55cH/VjK1emi7qly+BbPsZTxY6Il6dem/BZq2k27
         CzeAJ563+vCHCJ2ven9V7iFtzTB47Go/AtocODmi0SeukoCVS1B0/vl4MOwQKX6uIWyp
         Jx73uB/LYludg66jCS6mrTqOKMyegglh7fvPR/E1JafeByZ+MrC//hyKC5vPq2vW69ap
         +bJsbnaGAPeSur/budjudBJR7cODaAJgPyzCFOKrpALR30ctB8ykxO++KBcvgNzeOhJt
         MLaPELLNkGR0Lx2cuQq6dRPWgrpSOFr9kP/I7+E/ZgQl9OgYKQH0S2RVdJ6duErnthq/
         xFHA==
X-Gm-Message-State: AOJu0YwyBR8W8dW1GSmTtubLmYp0LTs3aiFhmwmWKsYH+5EU9ubcq/sz
	eVNCvT8tAR5wkkzLeiJqV1EOSIZFstubeG1lC3n8Q8G/AOmDgmZj
X-Google-Smtp-Source: AGHT+IHUJUjgEmuol7N7FsqWU1XQOyTu2JOnuHKV60eFo0CZ42nQ6VQQWL0Oc7UIGi7R9lJXuZ8lJQ==
X-Received: by 2002:a05:622a:30f:b0:42a:600c:2d7e with SMTP id q15-20020a05622a030f00b0042a600c2d7emr1189821qtw.51.1706122507729;
        Wed, 24 Jan 2024 10:55:07 -0800 (PST)
Received: from [10.102.4.159] ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id cm24-20020a05622a251800b004181138e0c0sm4603546qtb.31.2024.01.24.10.55.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 10:55:07 -0800 (PST)
Message-ID: <edaa845f-5e5a-47c4-90da-820c294637e4@gmail.com>
Date: Wed, 24 Jan 2024 10:55:05 -0800
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
 <ac057182-4b8e-44ef-ac32-9b039d13e45f@gmail.com>
 <8015796a-e94f-44bc-a01d-0339b1a156a2@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <8015796a-e94f-44bc-a01d-0339b1a156a2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 1/24/24 10:44 AM, Denis Kenzior wrote:
> Hi James,
>
>>> Perhaps an easier way to accomplish this would be to add known 
>>> frequencies in reverse bss->rank sorted order.  That way last seen 
>>> frequency with best ranked BSS would be first?
>>
>> I'm not sure I understand, how would this be any different than just 
>> reversing
>
> Well, right now we maintain the least recently seen frequency list in 
> a very simple way:
>
> - When scan results become available
>     - Walk the result list (which is sorted by bss_rank?)
>     - Add each result's frequency to the frequency cache
>         - Remove any matching entry in the cache
>         - Add it to head
>
> Since the result list is sorted, the top entry in the frequency cache 
> is the least ranked.  This doesn't matter for small networks since 
> there would only be a couple results.
>
> What we should do is to add the frequencies to the frequency cache in 
> reverse order.  That way the highest ranked bss is at the top of the 
> frequency cache.

Oh I see, I didn't realize the list was already sorted since its coming 
from network->bss_list. But wouldn't we have the same problem here? Old 
frequencies with a high rank would remain at the front unless they were 
seen by a recent scan. So if you saw a really high ranked AP once then 
never again it would always stay at the front.

Another thing I didn't consider is multiple BSS's on the same frequency :)

Maybe introducing a last seen time would help, though that adds even 
more complication.

>
> Hope that made sense.
>  Regards,
> -Denis
>
