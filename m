Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503266FD6
	for <iwd@lists.linux.dev>; Thu, 16 Feb 2023 16:58:00 +0000 (UTC)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-16346330067so3253270fac.3
        for <iwd@lists.linux.dev>; Thu, 16 Feb 2023 08:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WDCuCJNbIKY3wlVZcmOGVW76QeJJ+CGhZ2fmgK7ilJc=;
        b=jsdizLD8gZi8orgkqmi/u6i/CQoM9/EZjg6O95L6jnjA8vxS2U+h0v2K8OxuTl5A9r
         4F1Oodm+8KS+yzLdeNuevuVT6I4zjWBRL6RKml/Y6HO8IbmrXN6NaIbr8FkgFrgS92bF
         ka28WW8PQrCPmpMwKewrBckB0ePNwvTHJ8Ym8noiZ5ZYbuE6yJureOvnI/ekPeMMwE6H
         HBOWDNg73BdiZHXSjlprkpZIn2EOIkP77Cb2ZSQ1vBq0sc/QDVr0BT31YQqVH8Uc482l
         lFLcCDnGdo+e7I6OrlPnfNWy/+XQJHHFMmb9agxl66p+OuV0EFYnFA6dOG2RUELISwOQ
         XdZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WDCuCJNbIKY3wlVZcmOGVW76QeJJ+CGhZ2fmgK7ilJc=;
        b=SCrLcw4Kk7lDWl1wnCIogCOU4ZlY1SWgDbo0fLIYIddYW/SMomk9s7ZM7ydvbkDu+k
         lZgk5py3BTDildGCRvYiMU6/aNLotEF3HnIGvAV074C0Sa3kWEVMdEuV45EZTKet4C7f
         8sBG/6khtZkq2NYjFaw6pziyXYeYWZ5ihdT2B3Kg7bp1K+FhgQJhKFVwYkjURPFq01rV
         mywJdJ7VuDObpC1CWapn4mVzquVVbswKLgDW/vSGgBOhwS3orhS5mXKM9Yymd7iheTvU
         sbWVfJiaTx/HHrZ3I56BCFurWGclNjgmfR52BvWrK8BOV24crsRlPEwwhbJ2wzH3dClv
         EQ3Q==
X-Gm-Message-State: AO0yUKXrCfT+EBF2OIdszbqu74LS4skbrVn9VLkLf3kP1TBFUHXolC+x
	ptxCoTmCsdHpgozeczaEsZ8=
X-Google-Smtp-Source: AK7set/5wZLEbh8bGro2PowVCPJW1hGZYM25u6BlVNBKGRptCZd9MrzPKmhPnCnSvle55SU47NU9FA==
X-Received: by 2002:a05:6870:b6a3:b0:16d:dbcc:fd7 with SMTP id cy35-20020a056870b6a300b0016ddbcc0fd7mr3689815oab.14.1676566679332;
        Thu, 16 Feb 2023 08:57:59 -0800 (PST)
Received: from [192.168.1.12] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id k5-20020a056870a4c500b0016e0779de32sm765545oal.1.2023.02.16.08.57.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 08:57:58 -0800 (PST)
Message-ID: <9d86802f-ff97-0f8f-5001-1646066eec7e@gmail.com>
Date: Thu, 16 Feb 2023 10:57:56 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: IWD does not autoconnect after S3, when moving between networks
Content-Language: en-US
To: Emil Velikov <emil.l.velikov@gmail.com>, iwd@lists.linux.dev
References: <CACvgo50v+3j1Xshc3DCgSw=R9Xth=2EbjoHUZucdO5Av2t+L5g@mail.gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <CACvgo50v+3j1Xshc3DCgSw=R9Xth=2EbjoHUZucdO5Av2t+L5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Emil,

On 2/16/23 08:44, Emil Velikov wrote:
> Greetings team,
> 
> I am seeing an off issue with iwd, where it fails to auto connect upon
> resume from S3. In particular:
> 
>   - Ensure device has saved profiles for Wifi A (eg. home) and B (eg. work)
>   - Connect to WIfi A, device is outside of Wifi B range
>   - Suspend device
>   - Go outside of Wifi A range and into Wifi B range
>   - Resume the device
>   - iwd does not autoconnect
>   - `iwctl station wlan0 show | grep Scanning` says "no"
> 
> 

You'd have to look into the iwmon log and the debug logs.  Most likely the issue 
is in the driver.  iwd is not suspend aware, so it assumes the driver will 
notify us about a disconnect when coming out of suspend.  Once disconnected, the 
normal auto-connect logic should get you reconnected.  Maybe the driver isn't 
notifying us properly?  Or only doing so part of the time?

One option might be to make iwd suspend aware and shut down the device prior to 
suspend.  This would entail (optional?) integration with systemd.

> Note: The issue is intermittent and I've been seeing it ever since I
> installed iwd in mid 2020
> 
> Are there any commits which landed recently aiming to address issues
> like this? Is there some debug option that I can toggle to provide

Nope.

> meaningful logs for the developers? Alternatively, do you have any
> pointers for code-paths I should start looking at initially?
> 

Just the usual.  See the wiki for details.

Regards,
-Denis
