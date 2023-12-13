Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D228534B
	for <iwd@lists.linux.dev>; Wed, 13 Dec 2023 16:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cY+4wGZ/"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3ba2dd905f9so47187b6e.2
        for <iwd@lists.linux.dev>; Wed, 13 Dec 2023 08:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702483542; x=1703088342; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wb7E/Qb7q/usnq6toa4ToTkN8FgPA0RWMMbzfcVbnjI=;
        b=cY+4wGZ/n9rE7N3Yp2QTQYNb4q+v1vFG0IyOLnpnMThkj8ZpmHOyCSmvOlt+acWxsQ
         vad7c5kOBLpTUMFTd+V4GEqOxxRmwcPXCsKQk8rvOXGT6Z1WzoHLTTkpG+VR8tl8rOGx
         YTmOOnswPU47BR22set1VsFbVVvC8DWKDl4pzVJZYJZFWrdiHU96jJlvR3vyP9f9sjgZ
         U8JM9S8Xodh5rmbEyu79zkICKT16kQETk0pbKzxefy3yfBW5LiVkZGExFb5STumiyJH9
         T/eit1Nuav9ApKIz2wNmDOum9AsOMK6ilFoKem7iClzJ2QQi2T0UMkBqmqUps9zqknpl
         0W/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702483542; x=1703088342;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wb7E/Qb7q/usnq6toa4ToTkN8FgPA0RWMMbzfcVbnjI=;
        b=qrs21WyyWNEpwu51fHM3yXlSvnpZ/bRDnZmU03xlONPLiJki5kVAZrOMl8buipJl4I
         DUz3oV60DEpE7t+Hmx2Y9vwuVK83J32IYz1eAcbBmRTyJn04ImahKX8DjsDMP2DVqZSq
         LQ03WgEg35if3lJ776aSi7/M6fSGOt2ggNfhGxrq35qoIN+vrGuwjRDH5UJoW+XyDOXU
         LYDNZgnF9pqrpt7gIoyhnjUOPaUvQIbfXm0Cjr44URny9JSwcRdCxsoecRGi1UCwuAJZ
         TyJq4/BoqeXRAAYvAd3iHcWzYpjdeePYs0LzlTGBHm04vUFcaFSNWTLu1v1Fsi1RuDj8
         1hyQ==
X-Gm-Message-State: AOJu0Yz2214eqcJh+n1TCt6l5L6nDXPBxEru/7Wbi0I0WCFbx+Bu9a80
	vVMAKxoJnKPDrUDiO5RZMCkXoBWtSY4=
X-Google-Smtp-Source: AGHT+IEqRJsyMQ1GVCv9oX5kO7b4fs+Og8IAPXkQnckew7uevIbvwD390DaCIL46r4SCUVq5IT8PZA==
X-Received: by 2002:a05:6808:3a09:b0:3b9:f1f4:ab51 with SMTP id gr9-20020a0568083a0900b003b9f1f4ab51mr11466275oib.0.1702483541689;
        Wed, 13 Dec 2023 08:05:41 -0800 (PST)
Received: from [172.16.49.130] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id e9-20020a05680809a900b003b8b1a4fbf9sm3009191oig.31.2023.12.13.08.05.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 08:05:40 -0800 (PST)
Message-ID: <04898517-9cc0-4dc7-8e65-7f4b2335e3fb@gmail.com>
Date: Wed, 13 Dec 2023 10:05:39 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] network: add support for SAE password identifiers
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231207140049.2614514-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231207140049.2614514-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 12/7/23 08:00, James Prestwood wrote:
> Adds a new network profile setting [Security].PasswordIdentifier.
> When set (and the BSS enables SAE password identifiers) the network
> and handshake object will read this and use it for the SAE
> exchange.
> 
> Loading the PSK will fail if:
>   - there is no password identifier set and the BSS sets the
>     "exclusive" bit.
>   - there is a password identifier set and the BSS does not set
>     the "in-use" bit.
> ---
>   src/network.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 48 insertions(+), 1 deletion(-)
> 
> v3:
>   * fix outdated commit description
> 
> diff --git a/src/network.c b/src/network.c
> index 79f964b2..70a5434b 100644
> --- a/src/network.c
> +++ b/src/network.c

<snip>

> @@ -641,6 +657,31 @@ static int network_load_psk(struct network *network, struct scan_bss *bss)
>   		psk_len = 0;
>   	}
>   
> +	if (is_sae) {
> +		/*
> +		 * Fail if:
> +		 *   - the BSS exclusively uses password IDs and the profile
> +		 *     does not have one set.
> +		 *   - the BSS does not use password IDs and the profile has
> +		 *     one set.
> +		 *
> +		 * In theory you could have a network with a mix of BSS's that
> +		 * use IDs and those that don't, but this is a strange
> +		 * configuration (arguably broken).
> +		 */
> +		if (bss->sae_pw_id_exclusive && !password_id) {
> +			l_error("[Security].PasswordIdentifier is not set but "
> +				"BSS requires SAE password identifiers");
> +			return -ENOKEY;
> +		}
> +
> +		if (!bss->sae_pw_id_used && password_id) {
> +			l_debug("[Security].PasswordIdentifier set but BSS "
> +				"does not not use password identifiers");
> +			return -ENOKEY;
> +		}

So I thought the plan was to check this at handshake build time, not here?

> +	}
> +
>   	/* PSK can be generated from the passphrase but not the other way */
>   	if (!psk || is_sae) {
>   		if (!passphrase)

Regards,
-Denis

