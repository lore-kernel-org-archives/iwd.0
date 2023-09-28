Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27729746A
	for <iwd@lists.linux.dev>; Thu, 28 Sep 2023 11:37:54 +0000 (UTC)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-690ce3c55f1so10000913b3a.0
        for <iwd@lists.linux.dev>; Thu, 28 Sep 2023 04:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695901074; x=1696505874; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3/RrWEFC9MooAeItwLWhjyR8CEph4i70WqgrnQ1OFqg=;
        b=F/XG5KiSByHoSWpGiKLeBovzHDdiOJa/9BQPPNgGRg90GCDw89NXrRWmsfNooJn13y
         7/RDJRIlDoS+gy2mBB6R3lEZ2DzAr4f0rci6tBCcLnmZZKlQDtycfflPE4H4BYGVEJEh
         RUFPST7GRNh9Jr60dOWX/LF+TrJe68apgJYV7AP8ozoyrEHAFLM4vJT0cIFp+TZVqSG3
         d543t5bObjSP6sTJogRopSBHlvSq3kKwDTr9LNfAmYIZS1zSNRT9rCwORnG2pFMLIazq
         3f8zC7IZPoNnWkc4EeqoRLODM0XOQL5zQ3vgxQVw7ps26LWWYtY1yCRUvae72TY2bMdl
         ljAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695901074; x=1696505874;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3/RrWEFC9MooAeItwLWhjyR8CEph4i70WqgrnQ1OFqg=;
        b=iGieR2w2AjVFAhPWo16ff/87MDBice53yRSU7a6m51qqYlmckFemJiDmZuJ2y+EZIw
         JGMLeUTF/UXf0dnl1Kgbb4cTlOUWyjaR/g4xmFR962aFJvDzFpJ6BuZHECQaRX9rFVKI
         dL5J+NAL8rDGTK+6I7sn3LcR3MxhWp0z4OYcPYRE1aFeWgtuUQzz5vMaPhfLsPPrdE8M
         Myevd+0obs43wat59lAEX/NVnkFtFvVYAjnFPJfjCZzaB8HcdrySekxj5FMqqvyP9RLF
         CQiaJlPXXA/SLN48YjWykgeuQiY86jbFU0dMWKa7R65D+RNXyI9+mSNM+zQ8KVznXDAv
         IIcg==
X-Gm-Message-State: AOJu0YzTkR8hmsA6hLtaJAfg8dTKZfMSbJc64Pw8OtgQL0B1WjyiDQ+2
	8LaBfoU1eI8brpQ/v884q3Q=
X-Google-Smtp-Source: AGHT+IEhs62Nvaca9RPaYrlyOH1+MoWsd9hX+0rs4lIw2pxbDm0aS+NC/ai72cvZyxoj6jMKhu4Mdg==
X-Received: by 2002:a05:6a00:2442:b0:68e:2b6b:2723 with SMTP id d2-20020a056a00244200b0068e2b6b2723mr758004pfj.29.1695901074245;
        Thu, 28 Sep 2023 04:37:54 -0700 (PDT)
Received: from [192.168.254.82] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id m26-20020aa78a1a000000b0068fd026b496sm13131276pfa.46.2023.09.28.04.37.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 04:37:54 -0700 (PDT)
Message-ID: <d3a70b97-7848-4071-b956-f0e858b0420e@gmail.com>
Date: Thu, 28 Sep 2023 04:37:52 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] scan: allow splitting of scans with defined
 frequencies
Content-Language: en-US
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20230925185422.2242494-1-prestwoj@gmail.com>
 <20230925185422.2242494-5-prestwoj@gmail.com>
 <58f3da34-a15c-bb91-92ad-a4e8a643ea9e@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <58f3da34-a15c-bb91-92ad-a4e8a643ea9e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 9/27/23 12:52 PM, Denis Kenzior wrote:
> Hi James,
> 
> On 9/25/23 13:54, James Prestwood wrote:
>> Currently the only way a scan can be split is if the request does
>> not specify any frequencies, implying the request should scan the
>> entire spectrum. This allows the scan logic to issue an extra
>> request if 6GHz becomes available during the 2.4 or 5GHz scans.
>> This restriction was somewhat arbitrary and done to let periodic
>> scans pick up 6GHz APs through a single scan request.
>>
>> But now with the addition of allowing user-disabled bands
>> periodic scans will need to specify a frequency list in case a
>> given band has been disabled. This will break the scan splitting
>> code which is why this prep work is being done.
>>
>> The main difference now is the original scan frequencies are
>> tracked with the scan request. The reason for this is so if a
>> request comes in with a limited set of 6GHz frequences IWD won't
>> end up scanning the full 6GHz spectrum later on.
>> ---
>>   src/scan.c | 53 ++++++++++++++++++++++-------------------------------
>>   1 file changed, 22 insertions(+), 31 deletions(-)
>>
> 
> Looks good, mostly just nits:
> 
>> @@ -582,22 +571,29 @@ static void scan_cmds_add(struct scan_request 
>> *sr, struct scan_context *sc,
>>                   bool passive,
>>                   const struct scan_parameters *params)
>>   {
>> +    uint32_t bands = BAND_FREQ_2_4_GHZ | BAND_FREQ_5_GHZ | 
>> BAND_FREQ_6_GHZ;
>>       unsigned int i;
>>       struct scan_freq_set *subsets[2] = { 0 };
>> -    struct scan_freq_set *allowed = scan_get_allowed_freqs(sc);
>> +    struct scan_freq_set *allowed = wiphy_get_allowed_freqs(sc->wiphy,
>> +                                bands);
> 
> Maybe use _auto_ here?
> 
>>       const struct scan_freq_set *supported =
>>                       wiphy_get_supported_freqs(sc->wiphy);
>>       /*
>> -     * If 6GHz is not possible, or already allowed, or the 
>> frequencies are
>> -     * explicit don't break up the request.
>> +     * No frequencies, just include the entire supported list and let 
>> the
>> +     * kernel filter out any disabled frequencies
>>        */
>> +    if (!params->freqs)
>> +        sr->scan_freqs = scan_freq_set_clone(supported, bands);
> 
> Maybe l_steal_ptr(&allowed)?  You went through the trouble of 
> calculating it already?

In this case "allowed" is only used to check if 6Ghz is already 
supported so we know whether or not to split, not define the frequencies 
to scan. (I'll make it _auto_ though).

> 
>> +    else
>> +        sr->scan_freqs = scan_freq_set_clone(params->freqs, bands);
>> +
>> +    /* If 6GHz is not possible or already allowed don't split the 
>> request */
>>       if (!(scan_freq_set_get_bands(supported) & BAND_FREQ_6_GHZ) ||
>> -            (scan_freq_set_get_bands(allowed) & BAND_FREQ_6_GHZ) ||
>> -            params->freqs) {
>> +            (scan_freq_set_get_bands(allowed) & BAND_FREQ_6_GHZ)) {
>>           scan_freq_set_free(allowed);
>>           scan_build_next_cmd(sr->cmds, sc, passive,
>> -                        params, params->freqs);
>> +                        params, sr->scan_freqs);
>>           return;
>>       }
> 
> Regards,
> -Denis
> 
