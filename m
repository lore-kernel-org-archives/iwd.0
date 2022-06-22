Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301AB3C27
	for <iwd@lists.linux.dev>; Wed, 22 Jun 2022 23:58:18 +0000 (UTC)
Received: by mail-ot1-f50.google.com with SMTP id t26-20020a9d775a000000b006168f7563daso1591650otl.2
        for <iwd@lists.linux.dev>; Wed, 22 Jun 2022 16:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=Odk5/IeOAuIEGyLp/vyGvV/OO0olg00Z6SmvzCzPkVc=;
        b=Yy6ju90iejAPotJon2mH+V8HEOTpEuk0fMWpLV8ZB7XIz9bNhL8wDXL+yjJIh7inW7
         a+UZZLtbSG35yW8aycjsKQcVX9BnnVzqmxbL4eOiHAPcDR1y7CmcOzBIf962dBVv7P5A
         rDsOQ2Joi1OMpE+klUsYEj3krQc2ldZoRhygsdwKikRwp0S2uZUeuQWuTMJ9rrzbff6B
         jBNO+88bm/KqcHcAJU7ms9qnWZL7lpiKUndomGGq2+CfFem/WiEjt0FjMYpcYFUTXes2
         KICLXWdX189RSs6UUPniUWgMmg3+RtzGDLIq0ty1bUTu0mT9OHLMzoY886WbI9/kune3
         CTRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Odk5/IeOAuIEGyLp/vyGvV/OO0olg00Z6SmvzCzPkVc=;
        b=fcLc63LpMhI0drOAXttZxEbwMcYnaBOpipHV/eb75WLXP3S9e7BtTDwaa6pZAFz9Ca
         2aY63cBJiLOaQJyDfXakiI4xSMK7wpJuFCngh/MweSyKwSJ04cAriyEkoRiJokd4pWCW
         KPztnHaN0jRqXQwHjgLR/Qg2ZPMdaQOO7tABlQaJk2An93OEbkEzvEh6IujGwifKX7Fd
         vfrW9ElbP1WPIRdAtCVThyiUOL8QWhRJp5bHLIDMuNii14WAwk8HqRGNxDSkTp+sqZvY
         7BeG8TXJcqu1yHIDotcATgBLWh3KaKZosFXMw3n6W7HhB7dBzgrsTLP5Dn+C29WQms6c
         Mt8g==
X-Gm-Message-State: AJIora+UEphPFG5jL34c8gfzYsdrUCCsBG9qkVXZLo0CD8Y1DxQu4WTx
	WHUP6X9EzcYd0Kjnhurfvfs4WfoFHeb/M+LM
X-Google-Smtp-Source: AGRyM1v5iTebA+A6fUEuS0pbmAsM6htyq9ws5ZULP6oV/6s1pRUdOZiv0u8qHBTkczBAmJ1uIJtF0A==
X-Received: by 2002:a05:6830:b85:b0:60c:ee1:99ec with SMTP id a5-20020a0568300b8500b0060c0ee199ecmr2609349otv.180.1655942297350;
        Wed, 22 Jun 2022 16:58:17 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id p3-20020a4a8143000000b0035eb4e5a6cbsm12521586oog.33.2022.06.22.16.58.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 16:58:17 -0700 (PDT)
Message-ID: <0cfcd79c-9907-6ecc-de54-94c9ff2eee96@gmail.com>
Date: Wed, 22 Jun 2022 18:42:06 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] test-runner: fix result/monitor options
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20220622235116.1562570-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220622235116.1562570-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 6/22/22 18:51, James Prestwood wrote:
> An earlier commit fixed several options but ended up breaking others. The
> result_parent/monitor_parent options are hidden from the user and only meant
> to be passed to the kernel but they relied on the fact that the underscore
> was present, not a dash. This updates the argument to use a dash:
> 
> --result-parent
> --monitor-parent
> 
> Fixes: 00e41eb0ff ("test-runner: Fix parsing for some arguments")
> ---
>   tools/runner.py | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 

Applied, thanks.

Regards,
-Denis

