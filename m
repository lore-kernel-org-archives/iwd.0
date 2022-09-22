Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF861FA0
	for <iwd@lists.linux.dev>; Thu, 22 Sep 2022 02:25:34 +0000 (UTC)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-12b542cb1d3so11862074fac.13
        for <iwd@lists.linux.dev>; Wed, 21 Sep 2022 19:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=BbQxHVqeR+5JhUOYZ8ilnYJLJeDJUt1MBd3N5uTHHsA=;
        b=CWBf4mp8lWtAK+gwSicGdjz0X6FYWciERwNL10TbWXLn35FqrOG1KXfyn+DMixs3wG
         CCvaT+BkYawYzUmhphYf0yzYk2ZbaRxvqitB9W7zwiGhY7gfcLT0Fd+m3WAbJySEEMTv
         tVQCm71Bdtf2MT+1K7m8MCnWEavfC8r8jl9TfHHQAgIcUjnM8AVV4zl5eEX50GCmyQvz
         PIzxuRJeYE0m7jOnZ3GjRmeIOwvoW4MWbMsW5R+XYSpKxX53ihr44sEfpYKiG+9UfR23
         f1Tgp/5mRc3EOvnX3U7ujU3Q6Ec0McXHP9hXrAxrr52Dv8ymglAD3W6QcUku2ss7jKc7
         naVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=BbQxHVqeR+5JhUOYZ8ilnYJLJeDJUt1MBd3N5uTHHsA=;
        b=oy6h6Uz5h8eAx1sHcCYj2hVom8lT4LdyB/9ZctFxgmolia/ESqJgMd7QiZgQNhFN8s
         IFdm7TcfxeWh/v1Uvx9MAmiUaTxsrwY5Zj3uXb6fKasSH6TxxNwE3WFLf/cNf1M64ZPE
         vjj9RWAErDYqA0Pph65nNN0Zi38O2JjgQvfnIZ+eJH1nNWgDi6aXHfsIcGvGxzaygd6y
         AVmq9d1erZObrQw0Q6J8dDG473d87FWRMQLmccIG/dNDZNxWRDUSNcRa1zmgozwPATXv
         XbbYnhJTsuLzKQLjDF2Ca97MKnJMLE7OwLCt5S2wMpktaMJEYxmEwRvlD9LugZLjzhB4
         IfWw==
X-Gm-Message-State: ACrzQf301ObVEVLitJDDl07Sli7C/2Hh9xbzuavYjCCks9K3wCoRVxvM
	HOHAa0jnXfRUHHfHV/RQ7Bc=
X-Google-Smtp-Source: AMsMyM7gEwNod+lAOXNmLxPiJRF8gSq92qfTo0gpxVN9gl5kd5atmHnqbBG8uvlkHlhx7182efU7HQ==
X-Received: by 2002:a05:6870:8a08:b0:12b:c621:b987 with SMTP id p8-20020a0568708a0800b0012bc621b987mr6651339oaq.149.1663813533657;
        Wed, 21 Sep 2022 19:25:33 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id z204-20020a4a49d5000000b004354a4412edsm1725809ooa.29.2022.09.21.19.25.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 19:25:33 -0700 (PDT)
Message-ID: <35e1c6c9-66eb-6424-bd1b-4928c25f5694@gmail.com>
Date: Wed, 21 Sep 2022 21:25:32 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 01/15] netdev: add NETDEV_EVENT_FT_ROAMED
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20220921223158.704658-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220921223158.704658-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 9/21/22 17:31, James Prestwood wrote:
> FT is now driven (mostly) by station which removes the connect
> callback. Instead once FT is completed, keys set, etc. netdev
> will send an event to notify station.
> ---
>   src/netdev.h  | 1 +
>   src/station.c | 2 ++
>   2 files changed, 3 insertions(+)
> 

Patches 1-4 applied, thanks.

Regards,
-Denis

