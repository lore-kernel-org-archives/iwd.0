Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603F63D74
	for <iwd@lists.linux.dev>; Sun, 18 Jun 2023 19:07:38 +0000 (UTC)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-1a98a7fdf3bso1883403fac.1
        for <iwd@lists.linux.dev>; Sun, 18 Jun 2023 12:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687115257; x=1689707257;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1i09HRK3SORuFee+yKvEcCVqnT5RygrXkWaf32eLtBQ=;
        b=Aj2f2k+VfdEoqH8Bpi0DIE4bL9UPOdj128oFtlCH7kE9lYWnNLKppN4+6esGmgTgRg
         8MtJpsDxFW3pvPIp1niDlx0ycCbhIpAdU4ePh2WbbbwnO+pGWDNAU6DRkfJKU+N4RI32
         fhIh9ovledRklC/W62nmN79lJaB5dFUEV6YVQJJMpUoWuYNUD2H+P5T+3fa7o12blUge
         hxWVslZqw9q0/Qeppokv1RUB96U676d6A6cxMQ4t+tpvBS3Job4VVTlPuuaLJP5Ro5OP
         V49rDYeJQEXE0dID9Hbuy6hX0BquEujk1Z2KhfcSNjJBs+hOGM8opCrMofTNW8LT3mxX
         4z8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687115257; x=1689707257;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1i09HRK3SORuFee+yKvEcCVqnT5RygrXkWaf32eLtBQ=;
        b=i/0JpUCODMi7fVeKTm3r1RN1rh1SJRC3I376xpPvTzJhZHNG16SYXzIAgkzqpYYzuf
         RsP+JOH1+SVJwh5PITw70YWp1ydGQ0d4atnDc6zbOhAUSB52TmjdgoQqQyFaNih8Dyc6
         tEYS4aJHxUwKbjbKQ5GRGLkXWMUDVWq9mfetjDws+Qry2t19Em7QRddeo2n6pamAD3Zg
         63hPDyMLuAenv9N1Nd4kfY7SBaI3pNjrfqVL1ifIOdeV8bAn6VIM7WSHoNnvkg0eXw8i
         jj8YoFbyrSidqqbhTvb0lICCWq4xX8mNqASbnZt3qeFt9C5fTOBxRfJg7vH+5Y5MSNtK
         wuEw==
X-Gm-Message-State: AC+VfDxDA1U98yWuw1prAueMlHaEO04hIlFF9zwHKzloCjLOWU10rXkJ
	ptpeCLeo64h3kiDVIw4Mfp4=
X-Google-Smtp-Source: ACHHUZ4B8n+r73bz0rZMGxogMTA5s1pSmWSfaL0WCxHwsiUvmRQ7bXMalEdIKhojNlQAUAne0dIKlQ==
X-Received: by 2002:a05:6870:6186:b0:1a9:f6ba:138a with SMTP id a6-20020a056870618600b001a9f6ba138amr1911072oah.0.1687115257299;
        Sun, 18 Jun 2023 12:07:37 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id s10-20020a05683004ca00b006add66c7d73sm8900526otd.27.2023.06.18.12.07.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Jun 2023 12:07:36 -0700 (PDT)
Message-ID: <746fada3-377e-8d26-fef9-2b635d208ac0@gmail.com>
Date: Sun, 18 Jun 2023 14:03:02 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/7] wiphy: allow for user-defined driver flags
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20230615192415.1718516-1-prestwoj@gmail.com>
 <20230615192415.1718516-2-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20230615192415.1718516-2-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 6/15/23 14:24, James Prestwood wrote:
> The driver_infos list in wiphy.c is hard coded and, naturally,
> not configurable from a user perspective. As drivers are updated
> or added users may be left with their system being broken until the
> driver is added, IWD released, and packaged.
> 
> This adds the ability to define driver flags inside main.conf under
> the "DriverFlags" group. Keys in this group correspond to values in

So I renamed this to "DriverQuirks" instead to be a little more future-proof.

> enum driver_flag and values are a list of glob matches for specific
> drivers:
> 
> [DriverFlags]
> DefaultInterface=rtl81*,rtl87*,rtl88*,rtw_*,brcmfmac,bcmsdh_sdmmc
> ForcePae=buggy_pae_*
> ---
>   src/wiphy.c | 31 +++++++++++++++++++++++++++++++
>   1 file changed, 31 insertions(+)
> 

Patch 1-3 applied, thanks.

Regards,
-Denis
