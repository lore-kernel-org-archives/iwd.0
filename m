Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FF12744D
	for <iwd@lists.linux.dev>; Wed, 12 Feb 2025 15:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739375497; cv=none; b=B8c4rywthSaMbw9M6NPcKgzE0qo9EYGodK693L5TUw6B2ftuhRwEPb+a0n5mT6rc12x9PYqR4Kbubiv49HU52LpJG4q/zKuwb+++5EXKMqoPrp0YaXNxddBBV8SHjumaZkwokNtWOkgvkAY3LAdQSVxy0MMdcVltS07zGrcg7Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739375497; c=relaxed/simple;
	bh=FF/rYrHcu7KvCdb5dZ/Z3l1Gd2OaDsQk28plKx9cAH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jODCLVAPXeMlY1a2nEznbJm1xQ0m92EimILAN7sl8Vu4Z3qLgmQc6BCzo3au+ehNKGB5PKM7N4+x9J+sLdNrefgR19vNQy2/vqS6x6aoSabCKCE+EZFnT02If+8Bt0lJBGUf7FpvHe5Vf3AJP62UoURsq3Hoa3NT7IiyO+as2aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U064j22p; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U064j22p"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-47196e33b43so30435201cf.1
        for <iwd@lists.linux.dev>; Wed, 12 Feb 2025 07:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739375494; x=1739980294; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IeE1yCadDYGANVNK12Q8xU9pHxw+4M+6Yqo0q9Gzj2I=;
        b=U064j22p39nnVyNLU+gVnt3qcc1Dy8LAVJOUW3RVkb3666oEI+5yMUMds5LXRySUKF
         8ouq32Cbv7uA3H7RzUjp9Dt0OYNmEV9PuMy5nI3dG2FJUPzghU4WHF1mL43U4yA9MvPs
         LNFQgRV+rV060BeY1ONcltzkDrEi5d972O6DIlzP7l9ugLNzTIIHSrBeRZb7qzMQnAv/
         WfBZPURirdug9DanTVOBGuwfkxxtOUfhWSNTx/xC0F52Xhyd8DGPnuIdw2EFAq9hFCtg
         Zr874c8zuLhq7XAgWzlhpsZ9hcAiJMCPwXkx1VwFzKkwx5wYbtKBfLuDGBjxPWHOCCaF
         PmWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739375494; x=1739980294;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IeE1yCadDYGANVNK12Q8xU9pHxw+4M+6Yqo0q9Gzj2I=;
        b=n9NpACB22Xb9fc7zlrnAjbmvwTGhW5TFC8M99eO5LlaLGgNOXvOpMWlD++n/v7UA/T
         8SgWVbZ3nPngiWgy8RL4TRcPMzn0dtCGw0TvnDTM9nAnyIHB31xdv+QyHJqooVlWx4zP
         0ax7+F2LIrtqjhgNkSJrykGPMlTC+XE+7qdlzTAj5tu21j4a6Vyp3x3rZ2onFEBgydkf
         5TJOdAPgHrVVBdt2mkUZZSqbTG/lhFg9718MopP3O734DIjSh4bfDuyhkKwNJ7NI++/p
         beaFuwSmbgDJ2YoQSmJyn/dBzRAfvnoN6dmQXwi2xnsgpM9vO26xO6qNS/3/dA5Rwel/
         +TaA==
X-Gm-Message-State: AOJu0YwGZPYIae25BaimC7KadZZ4waH4dnyPnnJ9qCaj7bZwytHC9UN6
	rQ4+Odv7MkSsalOYslXbi11aHA9Lvv1W/pE2N26xPYxvLFyj6l4U9NqQaw==
X-Gm-Gg: ASbGnctZvsknI65+r3M+EEXmQNFeTce0oJW8QR9a8tCazZGn39oWC1DhJ2cAynwgsyZ
	fXuhL5HtrYc8nq0/OYsRe2HipjzdChyna0eLCrJMvFvhnOz1Ve7Hit5NxQKkgJ6QcKMHdhJ5Eeu
	FWk6LBr7g05q+Jo5xVylf5CBKvDAEsTr4wuE0qZOwWlki8xBMWEGwCOMW2ha6fn6iXE8ljiwYaj
	QNNGE/SBS76DdTpJCYW2+NWKtRW/eih44Yy5ibjz8NO5YsWQjm7ArQd05zEHWJ+T9WStr8Xmz55
	4ZwLb4DKZb3YvGUELyE=
X-Google-Smtp-Source: AGHT+IEVENp2pxLGLQFTo0SV3AcpcHSm5VNQbOiUQd1TJCewBrHcQmwFmDtNtckF/uikFSbavWjOug==
X-Received: by 2002:ac8:7d8a:0:b0:471:91a8:d7f4 with SMTP id d75a77b69052e-471afe4c818mr53260571cf.24.1739375493967;
        Wed, 12 Feb 2025 07:51:33 -0800 (PST)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471bc266f30sm2916371cf.66.2025.02.12.07.51.33
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 07:51:33 -0800 (PST)
Message-ID: <5638d6e8-6349-4fa8-b141-7dc51988c172@gmail.com>
Date: Wed, 12 Feb 2025 07:51:31 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wiphy: add driver quirk to disable SAE
To: iwd@lists.linux.dev
References: <20250211195855.85360-1-prestwoj@gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <20250211195855.85360-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

All,

On 2/11/25 11:58 AM, James Prestwood wrote:
> SAE/WPA3 is completely broken on brcmfmac, at least without a custom
> kernel patch which isn't included in many OS distributions. In order
> to help with this add a driver quirk so devices with brcmfmac can
> utilize WPA2 instead of WPA3 and at least connect to networks at
> this capacity until the fix is more widely distributed.

Both for my own reference and so others don't have to go digging through 
threads. The kernel patch that fixes SAE/WPA3 on brcmfmac can be found here:

https://lore.kernel.org/linux-wireless/20241215120401.238320-1-arend.vanspriel@broadcom.com/

> ---
>   src/wiphy.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/src/wiphy.c b/src/wiphy.c
> index c7df648a..46f7a6d9 100644
> --- a/src/wiphy.c
> +++ b/src/wiphy.c
> @@ -74,6 +74,7 @@ enum driver_flag {
>   	POWER_SAVE_DISABLE = 0x4,
>   	OWE_DISABLE = 0x8,
>   	MULTICAST_RX_DISABLE = 0x10,
> +	SAE_DISABLE = 0x20,
>   };
>   
>   struct driver_flag_name {
> @@ -106,7 +107,8 @@ static const struct driver_flag_name driver_flag_names[] = {
>   	{ "ForcePae",           FORCE_PAE },
>   	{ "PowerSaveDisable",   POWER_SAVE_DISABLE },
>   	{ "OweDisable",         OWE_DISABLE },
> -	{ "MulticastRxDisable", MULTICAST_RX_DISABLE }
> +	{ "MulticastRxDisable", MULTICAST_RX_DISABLE },
> +	{ "SaeDisable",         SAE_DISABLE },
>   };
>   
>   struct wiphy {
> @@ -202,6 +204,9 @@ uint16_t wiphy_get_supported_ciphers(struct wiphy *wiphy, uint16_t mask)
>   
>   static bool wiphy_can_connect_sae(struct wiphy *wiphy)
>   {
> +	if (wiphy->driver_flags & SAE_DISABLE)
> +		return false;
> +
>   	/*
>   	 * WPA3 Specification version 3, Section 2.2:
>   	 * A STA shall not enable WEP and TKIP
> @@ -1368,6 +1373,9 @@ static void wiphy_print_basic_info(struct wiphy *wiphy)
>   		if (wiphy->driver_flags & MULTICAST_RX_DISABLE)
>   			flags = l_strv_append(flags, "MulticastRxDisable");
>   
> +		if (wiphy->driver_flags & SAE_DISABLE)
> +			flags = l_strv_append(flags, "SaeDisable");
> +
>   		joined = l_strjoinv(flags, ' ');
>   
>   		l_info("\tDriver Flags: %s", joined);
