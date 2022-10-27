Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D302568
	for <iwd@lists.linux.dev>; Thu, 27 Oct 2022 14:41:13 +0000 (UTC)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-13ba9a4430cso2252098fac.11
        for <iwd@lists.linux.dev>; Thu, 27 Oct 2022 07:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JtHP8m7yuxDwbmjhSpjEdrs1VaEMRkaXAq9NdiznNgI=;
        b=oWmjd8bPjFj6Ah40lMoFvR8ogcgUQPcRkBiWUuFgFrJ382kpN4vgnTlMYnQmJIVp7V
         bumhVL58sHZ3y/T25Dvv4kXf8b6UUmxQVeKgYAuDyL2ExKALMvB6KgxxWdJhNGI9ba9H
         8J/jDhD4xTO1YCWu9g2J5EY5/6rv5supDPaCgHQO4n+Op/ZpvBLYJjr7yFvzE11+q50m
         hYR0ANqwGKETxRB0bsjNAMlJYG9tx0AU1yv2uwvNsV+22qf5GLf5tPgBx32zmB7Ca0i5
         vbRF/gu1wsWjcijwgSL7lH+zTJ3Xi9DCZjLkw8VlTxxPMpwPCod8/dZ6+olV+oh0sAsu
         5sjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JtHP8m7yuxDwbmjhSpjEdrs1VaEMRkaXAq9NdiznNgI=;
        b=rHnsdpSmNwWSu4O/YYEAjOrR+XenoZBI7Kf4NXImH/K0T8oCYiWeRBHpzO4z2MBEHZ
         UrjBRX8aNYBr9aaHTH5VPIbdlgu+XvyHUZkHl6yM9IOzpF/5B8fD0ugxDG/IfDmZj0W9
         b9jUYnKjfBY7o0DnlUTSM8AeR/Hw/QTM6c4k3YsTx/J8baCAtW8gvsg3oT294ZsFNOi8
         pVcfvtF2chXHOh18vvzMW17ZTnFUsAWmogQNSIDXBE7RAUYjoSIOK+uQ29UlyMUMPQmx
         UKBSHLHTzIGXwNnF143m9KXw6Rc/w25MLVEwyLragjDGadotjBCWBuy1W366zSSSB2Pw
         qQGw==
X-Gm-Message-State: ACrzQf33Ks4yRq8YtSOtJUO6JrX1S/ZiQq4X9ktKum7f8/EsnPek9LyK
	vGXhFAbZh3fITP52LAl7KeAiybwT2QM=
X-Google-Smtp-Source: AMsMyM7WTda745K7FC5mXhWW7jcNE0R4JdPyQ45NrM1v/iwjn7siRtQNo+iMvMc8HB1cnxdVJQZOFQ==
X-Received: by 2002:a05:6870:312a:b0:132:9c83:353b with SMTP id v42-20020a056870312a00b001329c83353bmr5546785oaa.65.1666881673107;
        Thu, 27 Oct 2022 07:41:13 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id g2-20020a9d6c42000000b0066aba96addbsm548791otq.81.2022.10.27.07.41.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 07:41:12 -0700 (PDT)
Message-ID: <136bef49-cf40-7078-9d59-e2bc2da21c2c@gmail.com>
Date: Thu, 27 Oct 2022 09:41:09 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] hwsim: add additional ciphers to disable list
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20221026215350.506918-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20221026215350.506918-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 10/26/22 16:53, James Prestwood wrote:
> Allows these ciphers to be disabled when creating radios.
> ---
>   tools/hwsim.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 

Both applied, thanks.

Regards,
-Denis

