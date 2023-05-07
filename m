Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4681C33D4
	for <iwd@lists.linux.dev>; Sun,  7 May 2023 23:14:28 +0000 (UTC)
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6aaf9092c52so308008a34.1
        for <iwd@lists.linux.dev>; Sun, 07 May 2023 16:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683501267; x=1686093267;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cQbddrxwXUHKH3WOaH6fbD/alODVymUyIvqL3qFqPbU=;
        b=En0VmXHHu+CcDHsEefOG6izSaPmdbuCvCaHPonPOrR2jOH+ceXAA7tJvLZloSAn1oM
         NL1IX1obgW96dnWugNNCN/I12Uqzy/itMd9MLQPkL0aDsGobnq8Tg5mjOd9HYlh665Ur
         iW2sDlQP5/511ESbYoCkL7uoHluHymelKuIEBtDnfgAvJuj91LhVjgCbr9mvZZBCdpZj
         xq8/a4unS24wM7H8gk1DRKWHoN5AzjYJFG4rhpFEXxpdkBzuQ06FqAfYPWDjaOVH1ege
         TGrCdcLM3+VnXDlHUn2R+KF8z5m2IwIwsZSyS0aQHCK9AIKxSDbJ77cTB1uNGCHl/gUB
         sUDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683501267; x=1686093267;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cQbddrxwXUHKH3WOaH6fbD/alODVymUyIvqL3qFqPbU=;
        b=HTRhZ9IZDDm6va10NYwOuCYL040DfLmS9EukRW+T4blnnvZ0vS8Ljq/gy3IQbwcFZY
         mAzJrQ1l0tUpQOaMxfqPK4Bfjq1b00M8KpzBop1OXsatEz1YxHBc3+77w9dk93r68C30
         8EzvjrS/T9ELF+Mh584O6+Z981x1qsji4zI1m9f5p5Bmm57XkKwx9uZPghtwQPN+Cn5Y
         PVFL3qVMX41XIQWhQ5V2SDeVonjmP6iH3Y0bs5GNU2mVs63py31M8Ma96bcOkPvwFelv
         QF5GoenEj5/zAbRlEH8xaTs60/kmA5+VPk3qQdW5n+eC5JCQQmxs0aA+AEoobLYmU16p
         MFxA==
X-Gm-Message-State: AC+VfDxEXFKMM/y8HIsfGrcoEZJaX7KLGKLJ/kxTqVODlw90+b0Poy1V
	rPRr0aev6II2i4TigGku5gQXghnBqoQ=
X-Google-Smtp-Source: ACHHUZ7WV3SUf3ePZ0zxeSkYVWNdSyHlNRtuGFO3wYZqVBmvgtsGiazAUdbX7jLoprQ26y6y6tvO3g==
X-Received: by 2002:a05:6870:9183:b0:192:9df1:8587 with SMTP id b3-20020a056870918300b001929df18587mr2912806oaf.8.1683501267266;
        Sun, 07 May 2023 16:14:27 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id g25-20020a4ad319000000b00549f2828585sm3491006oos.33.2023.05.07.16.14.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 May 2023 16:14:26 -0700 (PDT)
Message-ID: <94a9b440-eaaa-409c-7a6f-8bdf9d6bc976@gmail.com>
Date: Sun, 7 May 2023 18:10:03 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] station: fix potential NULL access with forced roam
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20230502185955.436081-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20230502185955.436081-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 5/2/23 13:59, James Prestwood wrote:
> If forcing a roam using developer mode IWD could become
> unconnected during the scan and result in a segfault when
> the network_get_security() is called.
> ---
>   src/station.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Do you have a backtrace?

> diff --git a/src/station.c b/src/station.c
> index be571083..9104ebf6 100644
> --- a/src/station.c
> +++ b/src/station.c
> @@ -2482,7 +2482,7 @@ static bool station_roam_scan_notify(int err, struct l_queue *bss_list,

This seems suspicious.  Forced roam should be going via 
station_force_roam_scan_notify(), not via this callback.

>   	uint16_t mdid;
>   	enum security orig_security, security;
>   
> -	if (err) {
> +	if (err || !network) {
>   		station_roam_failed(station);
>   		return false;
>   	}

And even then, isn't station->roam_scan_id canceled, so the callback shouldn't 
even be called in the first place?

Regards,
-Denis
