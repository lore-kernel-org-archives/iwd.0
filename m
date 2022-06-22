Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7453A3C27
	for <iwd@lists.linux.dev>; Wed, 22 Jun 2022 23:53:39 +0000 (UTC)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-f2a4c51c45so24493323fac.9
        for <iwd@lists.linux.dev>; Wed, 22 Jun 2022 16:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=fIEK6+dumEP/jc+kJTSrVk4SUDSDsh1Ob9edQG7Wd1M=;
        b=K9kXy7Un9LlKxPxSXd13wm4qVt8TkA2fHZLvPo5aXgrzDarXYnXyqxh9FVkcpEc5io
         Yw/6Rt2FxmaGwEJJMsy6ejbf63xyp37y+1s+Vr/psEXZv4pfGAyVN0FMzQG0nCpGRDW3
         IfsjSCwVsYL6RAS8wPenjdjvvglzgHznn96P+yHHNmanaFRMI7OU2Bz7OI3TCaORCR3h
         vqupaTqFWV7olePn7edpPDq261smaYcUEBq+0j7+KfxViqokKlmaYGPc4/M+TuYR0//0
         Jk2J2qXgwzIWOpqMO7TAHUL9aUkeYuTr0yZA+y7834mJke9ZtLnGB4kxJF7haZVI5Rhi
         XRtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fIEK6+dumEP/jc+kJTSrVk4SUDSDsh1Ob9edQG7Wd1M=;
        b=r4pw1xGGoDmSxs0K1YHelzgAQeRSCgyDRpV+gzyQY0fuvHsVHz0jJIVdpWKnXw+HwB
         CVkWoIunHG6kFQdGGS4Houf8qpRUPFofoVxj0kMzVKGPlp1HzztE+gEXS3NOQ7ZDV5WK
         R4ZTF7Ikp/4jwBetFi6z0hxF+W0ZtdnLtO9mYtPUDvy4SgF35gZ/sc5APj52PkjCI0WF
         vKOEj2y+3DS1PxMZTljERj1oQINvVTesZvyQEnY5m4s6Tat0NrFmuc7xnkd4gsV3p6tl
         flgJ28qBJds8DJCqpdeB10r4il0OgrmsA3pVV22gsI94Rx6MERA4IcCbX085coLSzwEe
         z19A==
X-Gm-Message-State: AJIora9PQ0AlY+gGN6o6uLe5BlkZFSj2EcmNGJXsmdSDkbHT+I+eH9L+
	Vgcbv5QGDZloQXeNPXbXaRBYgBNegVhhGEiG
X-Google-Smtp-Source: AGRyM1uRg/Cfayv/yMo99qW8/PUtn7dfljEuE6WdKEy2/v6I+lB1HbPXS7SYWk0/x9K0aophqaXI3Q==
X-Received: by 2002:a05:6870:b4a7:b0:101:bd1f:1deb with SMTP id y39-20020a056870b4a700b00101bd1f1debmr577622oap.147.1655942018673;
        Wed, 22 Jun 2022 16:53:38 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id u6-20020a056870184600b0010173875df2sm11309777oaf.58.2022.06.22.16.53.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 16:53:38 -0700 (PDT)
Message-ID: <9a26d08b-846d-ba5e-bd74-8b954be05648@gmail.com>
Date: Wed, 22 Jun 2022 18:37:43 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 1/3] test-runner: exclude 'iwd-rtnl' from being enabled
 with --log
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20220622230219.1557695-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220622230219.1557695-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 6/22/22 18:02, James Prestwood wrote:
> Enabling this ends up dumping so much logging and, at least with namespaces,
> seems to break the logger module and cause really weird behavior, worst of
> which is that all processes start dumping to stdout.
> 
> This can still be enabled explicitly with --verbose iwd-rtnl, but is turned
> off by default when --log is used.
> ---
>   tools/utils.py | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

All applied, thanks.

Regards,
-Denis

