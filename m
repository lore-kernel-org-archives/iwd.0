Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147495381
	for <iwd@lists.linux.dev>; Wed, 28 Sep 2022 21:22:43 +0000 (UTC)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-1319cf91d8aso4980230fac.5
        for <iwd@lists.linux.dev>; Wed, 28 Sep 2022 14:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=bWiE+Qn4aZbSjx9chQibE2lKe687QtQiu1wSxSRfceI=;
        b=n7IAFxqwKmd7YaqGiGQ7vpTyxPyjiNwG0KmrUu5tFm5q2OD/M6Hz00dtuUifO2aHUa
         RD0a0eMxkmZvM/Q+eOXGBlFtZTAaVqWVG8p6GRQetWMeJIL50PGrstKTJAIL9HTlMRcO
         4Esw3HVRa+AzMl8qhfvCuYFzF473tYtpqRPh4mu0/ETZ/ovJKvq6Df5We5BtAZrvmSkn
         tcloJg3b5UKeULwIruPyqI9yd/Q1H9EdO3A/VYnJZQIRHkzAHkjumWYqjBS8J/+tDwFd
         wMYr9vdQHXwb+sndXtdtlsUDBmR/0TDFrPM05QCtKVpNB3OU0sc1IhoNkDDz7B1OS53g
         sMIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=bWiE+Qn4aZbSjx9chQibE2lKe687QtQiu1wSxSRfceI=;
        b=8Iz7DzilSP4QDUz5of5XAsmcwGCqaUybQbaM6dKMUe6Dzl+YeAsWYL8k5+coGGeOw6
         f9+cS9UWlyuAwaWH9c5hgDXWkN397R+VSuz19RvczDEf1snDWsXd7EUlhmrIZoWB1SzM
         12aH3Z7mB2sFhoSlzHUMEtYiUFa0tTl+oHluYhyVufgHhuceiTnqzEXh46kvL4Hhaa+r
         V+foco45QncRz58jthLRTqjqPE5L52uSR4lIp3lcAEA0+w6aWiJ/LadX+41kGABF4/z8
         L4UiYGvKXGVMFYoydQXR3lY8bJmeRkggpLYi3eZc/lR5SxSt6wG7nvAPyfya1GiDr5hg
         CJzg==
X-Gm-Message-State: ACrzQf0c+CJ+0gnb3MUm8F//5ShL6WZf+D2IwIY70CxM/B3c/O9/z6yc
	RroTUszgBwLlJIkamkaIddWGykJclYw=
X-Google-Smtp-Source: AMsMyM6yJ+YjYLvFbuMDIoK+RUZwRDlcTfdI/myAtj1aUPk4Aidj5cDPJePEhnIY+rfFM5s8M4glHw==
X-Received: by 2002:a05:6870:e386:b0:127:bc46:769e with SMTP id x6-20020a056870e38600b00127bc46769emr6616759oad.180.1664400163129;
        Wed, 28 Sep 2022 14:22:43 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id c22-20020a056808105600b0033b31480f38sm2187983oih.34.2022.09.28.14.22.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 14:22:42 -0700 (PDT)
Message-ID: <3c60a851-efe4-0cd4-2b4f-1a5ac66fda5f@gmail.com>
Date: Wed, 28 Sep 2022 16:22:41 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] station: add two new roaming states (FT/FW)
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20220928183351.363600-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220928183351.363600-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 9/28/22 13:33, James Prestwood wrote:
> This adds two new station states to differentiate between
> reassociation (ROAMING), Fast transition (FT_ROAMING) or a firmare
> based roam (FW_ROAMING).
> ---
>   src/station.c | 33 +++++++++++++++++++++++++--------
>   src/station.h |  4 +++-
>   src/wsc.c     |  2 ++
>   3 files changed, 30 insertions(+), 9 deletions(-)
> 

Both applied, thanks.

Regards,
-Denis

