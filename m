Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA34319E7E3
	for <iwd@lists.linux.dev>; Thu,  5 Sep 2024 14:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725547047; cv=none; b=bQwXtK+x8uFSLqGpNWk5ovAnHJkrUoyuINWQWC2LPfNdafepcODx410Kco/5kWsHd8kbRdjZy5kTNiHwcqZd7HZthNPImdEyHwo6PxZMTl3HFY8t5BlGBNbBijN9N3NKUGhpr/ew7Pn6aN2luWKzjXuc3P8w9zAyiyqUx4FG8DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725547047; c=relaxed/simple;
	bh=8it3SyryxSeCK4B/WQpaCrzY4x2XC4xVZhvQPzEDtUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OggjuGsj+e1kGiaA/I321ShE8PHunxcW6ZRzXW8+iDgNMyRd3Kmb/Jt2agnCME7M8pwAheplaS/bHR+Dw3O0eNSCTAxICz64GDdhC/E3ERMcMO8ElfJAWbqlSNfgkHh0pzhVGVo0EVfAVqZqb4Xf/UMGpNg/n/Pq6s3VGmd4bnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QWPbv0dI; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWPbv0dI"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-277f35c01f5so498587fac.0
        for <iwd@lists.linux.dev>; Thu, 05 Sep 2024 07:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725547044; x=1726151844; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n55iOaxcph92Xk0f6Xo6IRzNk/a9yAnUR/62hGA4l8c=;
        b=QWPbv0dIklCb2QYDJx109z9hM8NLB8mJu9EbfkDW9vAzQfX5yXHP+AqTAbJ7+iiJW/
         lc4PKJ3bEmW2CENbt/5xAi+KAoBS0K0B8akM5oQevyoKYl/V+3MrhKKMS1WYO6XB5TiU
         DsKD0xGiwJKAS5z+3ZMApKm1gD/jjT273ng/iBYT63deRCtdBt0k0x/6gjxidVK9Ay8E
         GSREtCNm2KXC70Hj18cj52+/JEOPLuKuI9elHK5c9Finw1S3IDGhXJhBIC0VPBmV4g82
         o+DWpzWTmOp/zRGORz17+vU0QISnJDQoYtBve/oi98XAxXfZBEl9VvbnkLQEKOaPLa25
         MnLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725547044; x=1726151844;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n55iOaxcph92Xk0f6Xo6IRzNk/a9yAnUR/62hGA4l8c=;
        b=RSTn8E04EFfE75aFpFF1XmQmIoBZ6ZCPs3X/sL+3byM3LFPjkh1P507FlRbMDuSHsG
         nvw1x8sb7PHsIKaEnvxlJgVqllX7o98F+3gpIv35/IWRaLe2nCW7V/1e46dPEuVCQxQ7
         X/LHFRrLHxYQqh+OqGTmqLmSeFW9OC/WWhk2KvLU1iFstMnn4ltBK1rKHiGJCfCunQDP
         JYkYQi1czXqpvPwvTCgPJtipii7ufNABVXpyj2VsS7DsA3viHjYuCMSdpXrdpW5Z5xBt
         Vr8/vJMu2Ck4wzqRr01mg2OjhPzFtCsQNdkpeNwUNJAuZ1lWwoIT4EhJ1RP8Vb12IS0W
         oj2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXFgOkgFoQlk/gXnKxmIwKgREGCBSw45ePCVliVe5FtOWQJWqnz6+eXspBqD/WzObh+90E=@lists.linux.dev
X-Gm-Message-State: AOJu0YxrhhGp7VbdLbOHBtg+jjy9UBk689/GqQIF0RNBormyyvk5qAxw
	/3tKRwg0gv3DHJwGuEbIcZ2E76YS7Vb0kUAdDw5YrqiLzEbmfxUY
X-Google-Smtp-Source: AGHT+IF9rwygpT5TzGyFj20SPJrPmfagYiUZPXsJsQMWBG7d6bWQ5a657K+yQ+exRv2ia2XpLQsNrg==
X-Received: by 2002:a05:6870:55d2:b0:278:2c82:e056 with SMTP id 586e51a60fabf-2782c82e203mr8748149fac.23.1725547043582;
        Thu, 05 Sep 2024 07:37:23 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-279dc3ce194sm903892fac.12.2024.09.05.07.37.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 07:37:22 -0700 (PDT)
Message-ID: <fb4b3b86-e659-448b-bfb9-cfba35c2b87b@gmail.com>
Date: Thu, 5 Sep 2024 09:37:21 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] scan: check scan request in get_survey_done before
 deref
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
Cc: Daniel Bond <danielbondno@gmail.com>
References: <20240905134315.374800-1-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240905134315.374800-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 9/5/24 8:43 AM, James Prestwood wrote:
> Due to the possibility of external scans the scan request pointer

Do we know why external scans are happening?  I can understand a one off because 
someone triggered iw scan, but from the bug report it sounded like it was 
crashing iwd repeatedly?

> could be NULL. Prior to surveys IWD would still get the results in
> order for periodic scans to utilize them. This behavior can be
> retained by checking both if we don't have a request or if the
> request was canceled. This check is identical to the one in
> get_scan_done.
> 
> This fixes a crash when checking if the NULL scan request has been
> canceled:
> 
> 0x00005ffa6a0376de in get_survey_done (user_data=0x5ffa783a3f90) at src/scan.c:2059
> 0x0000749646a29bbd in ?? () from /usr/lib/libell.so.0
> 0x0000749646a243cb in ?? () from /usr/lib/libell.so.0
> 0x0000749646a24655 in l_main_iterate () from /usr/lib/libell.so.0
> 0x0000749646a24ace in l_main_run () from /usr/lib/libell.so.0
> 0x0000749646a263a4 in l_main_run_with_signal () from /usr/lib/libell.so.0
> 0x00005ffa6a00d642 in main (argc=<optimized out>, argv=<optimized out>) at src/main.c:614
> 
> Reported-by: Daniel Bond <danielbondno@gmail.com>
> ---
>   src/scan.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/scan.c b/src/scan.c
> index debdeb1f..205365cd 100644
> --- a/src/scan.c
> +++ b/src/scan.c
> @@ -2056,7 +2056,7 @@ static void get_survey_done(void *user_data)
>   
>   	sc->get_survey_cmd_id = 0;
>   
> -	if (!results->sr->canceled)
> +	if (!results->sr || !results->sr->canceled)

I still don't understand why we're even bothering requesting a survey for a scan 
we didn't trigger?  In other words, we shouldn't even be in this function.

>   		get_results(results);
>   	else
>   		get_scan_done(user_data);

Regards,
-Denis
