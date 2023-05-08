Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B341361
	for <iwd@lists.linux.dev>; Mon,  8 May 2023 13:49:38 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-24e2bbec3d5so3233710a91.3
        for <iwd@lists.linux.dev>; Mon, 08 May 2023 06:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683553778; x=1686145778;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+qxasU3SNKYjPJb7hc73gmxmIM5M/FxuRxL1Y2u8Zgw=;
        b=X8Gk/XUoFZznVJ7YT7ojbjt8eGFn50I4F+CkcauE9T2pPV9qcyaWbt7cnSLwUHpUZe
         ZxeclnphI67wWiAzKp6UHKdyhs5iENPj0RSU6SaIZV5jFD20Bkc6gm3KjS742bQbkidu
         /u+15KgBP4bzvYHtKKnMMqKtGCbDwK6g2coO9xwhvsClvjHCvDeLI5CuEeBza1XCfZMu
         WlLXU4NNekMNEOIWD7cxrZW4Cz0HHZRSxraFxTTfXiWeBQ42aIfCM2fEiQeK591S+Z7L
         P49j+Sk4fj8acaxR1EImMHkfxsahSEzvNRR9Zt/DSIsj5nfWOASvGR8oKrj15VoX08NA
         ZjVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683553778; x=1686145778;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+qxasU3SNKYjPJb7hc73gmxmIM5M/FxuRxL1Y2u8Zgw=;
        b=SUBmyoqfjHkk1E5kpPStKPOqOtsrgmIK6w754EosVNTOpwmlGrosCEmEfT/1bWebbI
         Bpqe2rUfTpZim1yBzBGOFb5f689dJNbgk283lZPCV085yDhz2nC8ciSTzlhvlwrS4HzP
         s6bfcEUHPZMKfei3bk5IrJer2KZ+4A7cu1nHHnfZt1hnYM+5DDpNaTnOtyfeH51O2FMz
         EtzZyf1jcNjM8ScmPX6UQdqYxchx7YPQZF5+nuaEXM4BHxUUuRGbD5Te+C2nByWa4Pil
         C7zzx8ikhCsOmMgqywAhS6I6IhyEg1WeG5I6V/neCtUbZGM1DvQMVpeOfyToi1Y1kWfR
         S3pw==
X-Gm-Message-State: AC+VfDyfm5fcMpc4TZerHHVxv+VYei0YftfOaQGlR3INbUhh2Zq+cFji
	qJdtQo+smpeaW8mTIOAP2z+4Gm7PvZJxPA==
X-Google-Smtp-Source: ACHHUZ5SSqTzYokbfKNrVbH96ID9/9ChlcZP46amZNMX+UhbmOt+Ajb7MnnkMehM79yj+DPnAgBHMg==
X-Received: by 2002:a17:90a:8807:b0:249:842d:312f with SMTP id s7-20020a17090a880700b00249842d312fmr10695321pjn.4.1683553777943;
        Mon, 08 May 2023 06:49:37 -0700 (PDT)
Received: from [192.168.254.76] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id gl20-20020a17090b121400b0024749e7321bsm2389928pjb.6.2023.05.08.06.49.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 06:49:37 -0700 (PDT)
Message-ID: <18798950-0bd5-e09a-3192-df0647a4ce71@gmail.com>
Date: Mon, 8 May 2023 06:49:34 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] station: fix potential NULL access with forced roam
Content-Language: en-US
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20230502185955.436081-1-prestwoj@gmail.com>
 <94a9b440-eaaa-409c-7a6f-8bdf9d6bc976@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <94a9b440-eaaa-409c-7a6f-8bdf9d6bc976@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 5/7/23 4:10 PM, Denis Kenzior wrote:
> Hi James,
> 
> On 5/2/23 13:59, James Prestwood wrote:
>> If forcing a roam using developer mode IWD could become
>> unconnected during the scan and result in a segfault when
>> the network_get_security() is called.
>> ---
>>   src/station.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
> 
> Do you have a backtrace?
> 
>> diff --git a/src/station.c b/src/station.c
>> index be571083..9104ebf6 100644
>> --- a/src/station.c
>> +++ b/src/station.c
>> @@ -2482,7 +2482,7 @@ static bool station_roam_scan_notify(int err, 
>> struct l_queue *bss_list,
> 
> This seems suspicious.  Forced roam should be going via 
> station_force_roam_scan_notify(), not via this callback.

Yes true. I did see this crash here but maybe it was related to local 
changes. I was roaming back and forth but your right, a forced roam 
shouldn't ever hit this callback.

I'll get back to you on this.

> 
>>       uint16_t mdid;
>>       enum security orig_security, security;
>> -    if (err) {
>> +    if (err || !network) {
>>           station_roam_failed(station);
>>           return false;
>>       }
> 
> And even then, isn't station->roam_scan_id canceled, so the callback 
> shouldn't even be called in the first place?
> 
> Regards,
> -Denis
