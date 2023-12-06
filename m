Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3175548CE1
	for <iwd@lists.linux.dev>; Wed,  6 Dec 2023 16:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bTS5w/tG"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3b83fc26e4cso4080265b6e.2
        for <iwd@lists.linux.dev>; Wed, 06 Dec 2023 08:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701880685; x=1702485485; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IqpZHU378XK7uL2dlxSPac4x2xutJaG+hHiOjeBYL+U=;
        b=bTS5w/tGiqf037oWpORKZCbOJ6X4BVh0H2Mbw+vdjGplHnf3FJCGpBW+51XEB8u4G2
         tEhVxOTkFr1vuyqnO+AKiS7IJau1buCB4lz6xPbEt+9vS5TFYDEXKw1X1ZCDQOWpzJ8N
         7rCM+9FyrFoLOi/ChKZ7QpcAVyzLWSa5uQIDxgSIWalVLd3JK4IB6ctQATBaYnXQi8Wu
         yDIsnReQD34B/Bo8bEQXZXk25mzCTFpvjXGdprPwDbw+JuVvHv2RiexaOjWjYs4bjNug
         qj5JrZEs1Y1YXvrbRbzMk4fzEYGZ0Nwr1bSxlcoACduKCmMqlqqLFiH4SlBVWchdmAZc
         rTfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701880685; x=1702485485;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IqpZHU378XK7uL2dlxSPac4x2xutJaG+hHiOjeBYL+U=;
        b=lH8oJDH1Ln368hlKdXdEyEunrZ8CQtCPw538o9dJ974SyAwWtc2ijTxxEDW/AWRWlf
         N6lpJvK976Gt2xJyANBZWf/O9lFYcx13Uanadin24woSyuBuN7iQtkmfZldiyXmcEpch
         3bm6dt2fahAQdGlFvewJhspNvmEMg4WBB8gecRcr6UiaGjTpVu1MSMEo5/hwTJSk3EgG
         p2k4+BOTeHIQIcfbKGOfn6UkqXDE/HPrny2b+1G1hPCsQ6UH1pdoGPYOU4503rWTYpkL
         iGBiPn62VxfZxiO5zCqWNjj6lN9NjDwsbzaCBw1hjwygOi+SfMS9Jy/qWtuUBRTc6y+r
         JgsA==
X-Gm-Message-State: AOJu0YwdUF67QivJH4Qlwa6CCL6fHf2fzexbRPMRWwtwXDQCtrstM5rM
	Q4tZ73+ADhlBhr5BqXyz5wNF06SU8dU=
X-Google-Smtp-Source: AGHT+IEEBYgxf+Hyl8hQzXACmtrb8xZbzqtfdp4pk+F5udT9GXdmRqXU5yWxLEDzJSdBxFYMcsRlvg==
X-Received: by 2002:a05:6808:214:b0:3b9:da57:6d90 with SMTP id l20-20020a056808021400b003b9da576d90mr76115oie.111.1701880685304;
        Wed, 06 Dec 2023 08:38:05 -0800 (PST)
Received: from [172.16.49.130] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id bh1-20020a056808180100b003b897b71e11sm45333oib.56.2023.12.06.08.38.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 08:38:05 -0800 (PST)
Message-ID: <91f80f30-b4aa-41a9-b134-b3632b4ea7ed@gmail.com>
Date: Wed, 6 Dec 2023 10:38:04 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/9] ft: add ft_handshake_setup
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231206150708.2080336-1-prestwoj@gmail.com>
 <20231206150708.2080336-6-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231206150708.2080336-6-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 12/6/23 09:07, James Prestwood wrote:
> This will be called from station after FT-authentication has
> finished. It sets up the handshake object to perform reassociation.
> 
> This is essentially a copy-paste of ft_associate without sending
> the actual frame.
> ---
>   src/ft.c | 32 ++++++++++++++++++++++++++++++++
>   src/ft.h |  2 ++
>   2 files changed, 34 insertions(+)
> 
> diff --git a/src/ft.c b/src/ft.c
> index 358a4594..738e08c3 100644
> --- a/src/ft.c
> +++ b/src/ft.c
> @@ -1276,6 +1276,38 @@ int ft_associate(uint32_t ifindex, const uint8_t *addr)
>   	return ret;
>   }
>   
> +int ft_handshake_setup(uint32_t ifindex, const uint8_t *target)
> +{
> +	struct netdev *netdev = netdev_find(ifindex);
> +	struct handshake_state *hs = netdev_get_handshake(netdev);
> +	struct ft_info *info;
> +
> +	info = ft_info_find(ifindex, target);
> +	if (!info)
> +		return -ENOENT;
> +
> +	/*
> +	 * Either failed or no response. This may have been an FT-over-DS
> +	 * attempt so clear out the entry so FT-over-Air can try again.
> +	 */
> +	if (info->status != 0) {
> +		int status = info->status;
> +
> +		l_queue_remove(info_list, info);
> +		ft_info_destroy(info);
> +
> +		return status;
> +	}
> +
> +	if (L_WARN_ON(!ft_prepare_handshake(info, hs)))
> +		return -EINVAL;

It isn't quite clear how this case should be handled?  Would you still remove it 
from the queue and destroy this info object? Or destroy all authentications for 
the ifindex?

> +
> +	/* After this no previous auths will be valid */
> +	ft_clear_authentications(ifindex);
> +
> +	return 0;
> +}
> +
>   static bool remove_ifindex(void *data, void *user_data)
>   {
>   	struct ft_info *info = data;

Regards,
-Denis

