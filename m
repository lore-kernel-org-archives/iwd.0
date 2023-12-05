Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0236E589
	for <iwd@lists.linux.dev>; Tue,  5 Dec 2023 21:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T56LIX9G"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-58d54612d9cso4045249eaf.1
        for <iwd@lists.linux.dev>; Tue, 05 Dec 2023 13:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701812230; x=1702417030; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4JTHOsgrgRGZxLCdnhnFYA66WTooHUnUFE5noAGKksw=;
        b=T56LIX9GQZj9q+0bpOcTzMoG7kIoYiBeRfTDy/b0Ub4orszL/TbkeHDOAgj2AskgEA
         mRulfx4t9VfXP3L6SEUlkVP9/QmnttB7fwN24TWfdXtJBhTph6375PUXjv/qT7zD0koh
         NcS9pb+JGWbMBAPZlGEFqXgxAqqfinrnVDxTjcr1uMwCOYSa5Gqgi/TjISpTssej+1KD
         mdtJbw7mpmeLx8VNRblWGWyqIw+/C8EP1w2Kc6c3nK/gFjYxs1DygXRBwnSi7XjcvHli
         MG8ARh/d+FDYGClU2drGeHZll4OpHgGVdEVyiesi4BMbsAU2X9neYtgHQxivdHLymCcv
         pBQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701812230; x=1702417030;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4JTHOsgrgRGZxLCdnhnFYA66WTooHUnUFE5noAGKksw=;
        b=qmpMYfUD8SbEgXcV60mHaQtOwTrXRXSzcBRejDZc1sb+208Npth0rqRV3/2CFsQFXa
         PcrSqTRboZaYiErJZqYw8EkFzbdbcaggKlefkQTgcnzvIHBEfB+hiDLEyozi3zrbGR1e
         bxzKc7/wKLm+O4efszGOHGIMEI2hgVA84JJ88qEkb4z9yrHfQU42k/qkEs2++is6GQXD
         99vxTEQfKiZ1ZKRy9FiCYUd2sgeEWdTTrf07zC/7iZzhOiswMVXGOv9L18XFjwvWM5jY
         J5EEnkelHvSef8AaVXC5FN0ZNABeBrC6tyq4mVGAiK/IYt1JQeQMaHDavjK4UxtJO9tT
         HljA==
X-Gm-Message-State: AOJu0Yxr56T4lGgU8VpqV6lRokAEt5FHklvkGHEOcW6KyWKOlR8ENYxn
	VjyaTNxvgnPx4S4v3BUyA8vwdIH2Cq4=
X-Google-Smtp-Source: AGHT+IG0lqvC7SVyJjNBc9ATp7ytVcd31qv7JPD+uCIfh3cYJtLSQskWUmVEguezgjD29BHj29bmAg==
X-Received: by 2002:a05:6820:1519:b0:58e:1c47:76bf with SMTP id ay25-20020a056820151900b0058e1c4776bfmr6273165oob.11.1701812230088;
        Tue, 05 Dec 2023 13:37:10 -0800 (PST)
Received: from [172.16.49.130] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id f12-20020a4a580c000000b0058e2b5a4fefsm1644795oob.5.2023.12.05.13.37.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 13:37:09 -0800 (PST)
Message-ID: <9b1a1ce7-16eb-4e37-8b7b-2750d0ed66fd@gmail.com>
Date: Tue, 5 Dec 2023 15:37:08 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] netdev: hack back in disconnect event
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231205175203.1935692-1-prestwoj@gmail.com>
 <20231205175203.1935692-3-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231205175203.1935692-3-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 12/5/23 11:52, James Prestwood wrote:
> Not sure how we want to address this, but FT is special in that it
> has no connect_cb but can still trigger an associate timeout.
> Currently if FT times out associating IWD will hang indefinitely.

Do our auto tests cover this case?  I wonder why they didn't flag this earlier?

> 
> This behavior can be tested with the prior autotest patches (without
> this patch applied).
> 
> Fixes: 30c6a10f28 ("netdev: Separate connect_failed and disconnected paths")
> ---
>   src/netdev.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/src/netdev.c b/src/netdev.c
> index f2e887b4..2d1120c4 100644
> --- a/src/netdev.c
> +++ b/src/netdev.c
> @@ -3045,7 +3045,13 @@ static void netdev_associate_event(struct l_genl_msg *msg,
>   			 * out. The failed connection must be explicitly
>   			 * initiated here.
>   			 */
> -			netdev_connect_failed(netdev,
> +			if (!netdev->ap) {

if (netdev->in_ft) ?

> +				if (netdev->event_filter)
> +					netdev->event_filter(netdev,
> +						NETDEV_EVENT_DISCONNECT_BY_SME,
> +						NULL, netdev->user_data);
> +			} else
> +				netdev_connect_failed(netdev,
>   					NETDEV_RESULT_ASSOCIATION_FAILED,
>   					status_code);
>   			return;

I wonder if we should make ft_associate use netdev_reassociate?

Regards,
-Denis
