Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29BDBA24
	for <iwd@lists.linux.dev>; Wed, 14 Dec 2022 22:26:32 +0000 (UTC)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-1441d7d40c6so18604509fac.8
        for <iwd@lists.linux.dev>; Wed, 14 Dec 2022 14:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NrLBBKCjjKph1GudXC/b6wuS/M6YaB7WDkLXrfJHegI=;
        b=HB687up8XgFXTmUYe08xQWIzwFx95rbeO+QbSkLBTRLmc9sFKH/FeVM2V5WnWtCfkR
         mYWw1br5si+HorQLCYFbEfAF4dEYJrJ9XuJQ5plwbzKspe1qwlWyLK7UQl3TmfMhlkig
         /9m991Egf9XGMq5BCo2s1NeR2rSxqkPuDWicrIxwO8mjBDKvp34AXx1ncNcNgG7LKDwt
         dec7ga5Q3R5l/5O2TPUDmKYKxGvTywI8Zd8vNURdks66vUyJ2ZWYHDnIgEIuHWm+BH9g
         vOL54ZEP80J5LbIDISPo5ZX7hWa4qbulRCRAZ3gCLi73GZk/vDQ8m/jVbi2zRfNGu9Lm
         xWqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NrLBBKCjjKph1GudXC/b6wuS/M6YaB7WDkLXrfJHegI=;
        b=Q/u+8D82EVrnA0JeiLnYDlq4TymOQcKZiUJMZWJbzAuc48YOyYWCtJ9tfOwwB9Ux9+
         pJmf2bTnwmby7zV37cYS3s/8w1hLfCd4+H+LkX1Gknc7nH5D0NUssUiFEzFEtE97JiO2
         tseHQEJL7Cbwp7oCE05jFnc+hR/9uRYLWUqonouMakxVILPcrrYFe2Etx3LWyiWP7Vxf
         J6/K2QbiseNP/hfPEwm6P8GBUdHj/dxVXAP0SxukcphprdiS4AKA8pymRax6whuoxanK
         ZMumEV/L8/ypBaxNZ1LHgtqX7deMVP2GE8fWZPNTIgMvlxuntIt2qtIqNTzHj0IIQncO
         4CVw==
X-Gm-Message-State: ANoB5plv8WJJ7fFVYBWBcwBnac/upliM/1TIMQBtR20VhKYrOX+s8Z8f
	laFO4FUILrB1mimNrtb/rYIY18OjwRg=
X-Google-Smtp-Source: AA0mqf5jX0ncuxHoCjAzzysVIbXF4r9VFgbTqwh8pxO1wxQhEoFL5ay4zSSGVXOJonmOf+YZ/pN3ig==
X-Received: by 2002:a05:6870:d990:b0:143:e045:7082 with SMTP id gn16-20020a056870d99000b00143e0457082mr13030390oab.58.1671056791972;
        Wed, 14 Dec 2022 14:26:31 -0800 (PST)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id bc13-20020a056808170d00b003547a3401e6sm386237oib.43.2022.12.14.14.26.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 14:26:31 -0800 (PST)
Message-ID: <c451633b-3d03-830a-0de4-2267a80db67b@gmail.com>
Date: Wed, 14 Dec 2022 16:15:54 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/3] ft: gate FT-over-DS with a wiphy work item
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20221214212658.1578576-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20221214212658.1578576-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 12/14/22 15:26, James Prestwood wrote:
> Queue the FT action just like we do with FT Authenticate which makes
> it able to be used the same way, i.e. call ft_action() then queue
> the ft_associate work right away.
> 
> A timer was added to end the work item in case the target never
> responds.
> ---
>   src/ft.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++---------
>   1 file changed, 49 insertions(+), 9 deletions(-)
> 

All applied, thanks.

Regards,
-Denis

