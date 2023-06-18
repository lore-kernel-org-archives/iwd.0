Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDC13D74
	for <iwd@lists.linux.dev>; Sun, 18 Jun 2023 19:14:37 +0000 (UTC)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-1a98a7fdf3bso1886295fac.1
        for <iwd@lists.linux.dev>; Sun, 18 Jun 2023 12:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687115676; x=1689707676;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hNkilYMKH7NhB/sJLRVUc96nBdFZnXIFe5moKccCYC4=;
        b=cAuiTltWrOJxmJ5iv3eoo3qoSMYHCQoCDhBuUD+K4z/RoyOLdLzSR5FUeuIprwTBtj
         Nfv9i9shv99hZAdriE5Bw8/AUm9c0N09fTzs63t1ztAdVVo06owZTBB8aNnKpw2Ltg/n
         RqmsfcQyL9J7y5kBvtARC/OXtst1bYZwQKMp8Ttamnh/Lr8mrsQ/kUyxzHsjZnMQYa9U
         DToaT+eXK8a20dBJoIGONjNOsBHGXRUv5aatiec3WGeNXhIqjVr2yu4TSapHZIkyAFau
         xSBXxpBtgsluhXN26aickeKSrcBYQKvnudLRWY+BzpWbbaJAOJ2mhnPRvNz8c80ofxy2
         fsuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687115676; x=1689707676;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hNkilYMKH7NhB/sJLRVUc96nBdFZnXIFe5moKccCYC4=;
        b=C2L7ubtBeP5XfV2Vx23ssS0vwwyIS1Fvg58Z009LNBJedfg7VGfI9J/p7fHpaldeBy
         VEC/tJ+FGbD2uNkmUrvmYou1uq4OiUK4xxcTCr9sQi+q0ZXdUV5YvxqsQ5wdqlWqW3Hl
         2XSg76QpLg3ddF/t4Te9V7LYVUXhK27cI+vLLnHYwkRH8dxfqNh4jL7yc//eMqpHT61a
         CcYwhuonOq/kTURBQOSzEluDExIb8cjutMnzo9A4vI3Ad6IscvwwgMk+oBFWpGiBMDTM
         eBqTeAydcHbOWtCE8nbDJub5PQI0n/jpSqpHAz8jOygP7ERXpWewXUNmdqpd9Lu7WUWi
         3w2g==
X-Gm-Message-State: AC+VfDzHqVG0iqJVJONW4QL7wFbZoFtmrBGhaDWbyww0kWibiqAqNAAh
	lCmfiv09Hrrh8cmvdLoTPwlavn7BzHc=
X-Google-Smtp-Source: ACHHUZ4OV5FnhRqbcvoVxYc8c2mUAymjUxVaNWcYQ/8b8eU5LRJMmCRT+1U4c51MoNCcu3jkX6ZVoQ==
X-Received: by 2002:a05:6870:c787:b0:1a6:8fdd:9902 with SMTP id dy7-20020a056870c78700b001a68fdd9902mr2853361oab.19.1687115676434;
        Sun, 18 Jun 2023 12:14:36 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id u22-20020a056830119600b006b457eaf174sm1876656otq.0.2023.06.18.12.14.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Jun 2023 12:14:35 -0700 (PDT)
Message-ID: <a3621173-3b82-2954-2454-a3039dd985ef@gmail.com>
Date: Sun, 18 Jun 2023 14:07:09 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 4/7] wiphy: add [DriverFlags].PowerSaveDisable flag
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20230615192415.1718516-1-prestwoj@gmail.com>
 <20230615192415.1718516-4-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20230615192415.1718516-4-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 6/15/23 14:24, James Prestwood wrote:
> Certain drivers do not handle power save very well resulting in
> missed frames, firmware crashes, or other bad behavior. Its easy
> enough to disable power save via iw, iwconfig, etc but since IWD
> removes and creates the interface on startup it blows away any
> previous power save setting. The setting must be done *after* IWD
> creates the interface which can be done, but needs to be via some
> external daemon monitoring IWD's state. For minimal systems,
> e.g. without NetworkManager, it becomes difficult and annoying to
> persistently disable power save.
> 
> For this reason a new driver flag POWER_SAVE_DISABLE is being
> added. This can then be referenced when creating the interfaces
> and if set, disable power save.
> ---
>   src/wiphy.c | 13 +++++++++++++
>   src/wiphy.h |  1 +
>   2 files changed, 14 insertions(+)
> 

<snip>

> @@ -723,6 +725,17 @@ bool wiphy_control_port_enabled(struct wiphy *wiphy)
>   	return enabled;
>   }
>   
> +bool wiphy_disable_power_save(struct wiphy *wiphy)

I named this wiphy_power_save_disabled to be consistent with 
wiphy_control_port_enabled()...

I went ahead and applied this, but I think we have to fix the behavior of this 
and wiphy_control_port_enabled().  Namely:

> +{
> +	if (wiphy->driver_flags & POWER_SAVE_DISABLE) {
> +		l_info("Disabling power save due to driver quirks: %s",
> +				wiphy_get_driver(wiphy));

We shouldn't really use l_info here.  This method is meant more as a getter and 
might have other users in the future.  Same case with 
wiphy_control_port_enabled(), but that one is a little bit more complex to fix.

Patches 4, 6 and 7 applied.

Regards,
-Denis
