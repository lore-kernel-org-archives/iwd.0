Received: from mout-b-210.mailbox.org (mout-b-210.mailbox.org [195.10.208.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5185A2D627
	for <iwd@lists.linux.dev>; Wed, 29 Jan 2025 09:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738141410; cv=none; b=jo1TSFDnhopMu8rDfU99CKtq1TH5MUAJ1K2tePcnJM+lIF13cp5csXLqJRN0ftdx38D7770QxmqQqgzaJ4tKipC++eTs0owh0+i5oFZCU9Gbbny5cWqSicQmcfViPZEc+6UuUh8xgSdliVrPpsfdt1yFFzic12kDT5uk67tdMwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738141410; c=relaxed/simple;
	bh=TB9kb6F3/naUz5l2dZ/mW9mRUCkPfIRIqlyvkTc9k7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=g6RXg+l1tgaRYk2mWk7JI0xGV3jf0JAkrXSKThj3l8LVrM/W97jUxmbJ0Hl6ACiQpO/atBHOUfpLG5yOlS8Z363BM0Evg8WbEuQev8m33lACNI1n0nEjyA/adSedJ3IvYBRUcYBvFke1cAlg6dHq+UCFMiehEz+K6dS7cTKsoJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de; spf=pass smtp.mailfrom=tavla.de; dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b=w8YuU4bN; arc=none smtp.client-ip=195.10.208.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tavla.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b="w8YuU4bN"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-210.mailbox.org (Postfix) with ESMTPS id 4YjbZG4xwWzDvVT;
	Wed, 29 Jan 2025 09:54:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tavla.de; s=MBO0001;
	t=1738140886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+ODp5kAKXPbSZIfMjb5qtitXr6lMbUlzopERGBL4SFU=;
	b=w8YuU4bN3fVXtCNwmVZaxuHO31V8CTE2yKEEJWGxLGe1fU072SAEGLKW7V4O6WRVM2ldn0
	X5WRRKxKALRN1GPVGcVKIEtLodDAVE0T/8Z8ApaEA7fxWmvhQO51na4fL2F9aZo+7F4esW
	+RowHzTKrOfoSW+7N8ewKLQdshw3vhXGIo/TceMmS4AiUJvKIxWo87H/hSNafsgzf6HXvZ
	JqJO5eRW3uDQENCictwjNtHgiBewWZkC8kSB97w1kWp2MHh1HXG92wPeilNAa3AUXfbQ7O
	4yMXNwdaXb75J3sXkTIQE4Dv94Tyf3PVWnkzZXSfMeg6FfzoiMFfVpUZVG+zsQ==
Message-ID: <e7df49cd-3db1-42c4-bb65-aaca630d685e@tavla.de>
Date: Wed, 29 Jan 2025 09:54:45 +0100
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: [RFC] netdev: avoid PMKSA for fullmac drivers
To: James Prestwood <prestwoj@gmail.com>
References: <20250128180438.65113-1-prestwoj@gmail.com>
Content-Language: en-GB, de-DE
Cc: iwd@lists.linux.dev
From: Martin Petzold <martin.petzold@tavla.de>
Organization: TAVLA Technology GmbH
In-Reply-To: <20250128180438.65113-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4YjbZG4xwWzDvVT

Dear James,

Am 28.01.25 um 19:04 schrieb James Prestwood:
> The fullmac drivers need additional support to correctly work with
> PMKSA. This can be disabled via main.conf, but to avoid extra user
> configuration avoid the use of PMKSA for fullmac drivers
> automatically.
> ---
>   src/netdev.c | 22 +++++++++++++++++++---
>   1 file changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/src/netdev.c b/src/netdev.c
> index 2a6d94fc..7af3c39a 100644
> --- a/src/netdev.c
> +++ b/src/netdev.c
> @@ -1518,7 +1518,8 @@ static void try_handshake_complete(struct netdev_handshake_state *nhs)
>   
>   		l_debug("Invoking handshake_event()");
>   
> -		handshake_state_cache_pmksa(&nhs->super);
> +		if (nhs->type != CONNECTION_TYPE_FULLMAC)
> +			handshake_state_cache_pmksa(&nhs->super);
>   
>   		if (handshake_event(&nhs->super, HANDSHAKE_EVENT_COMPLETE))
>   			return;
> @@ -2455,6 +2456,19 @@ static void netdev_driver_connected(struct netdev *netdev)
>   		eapol_register(netdev->sm);
>   }
>   
> +static bool netdev_handshake_can_use_pmksa(struct netdev_handshake_state *nhs)
> +{
> +	/*
> +	 * Do not use PMKSA if this is a fullmac driver as they need additional
> +	 * support (SET_PMKSA) in order to function properly. Until this support
> +	 * is added fullmac drivers will not utilize PMKSA.
> +	 */
> +	if (nhs->type == CONNECTION_TYPE_FULLMAC)
> +		return false;
> +
> +	return nhs->super.have_pmksa;
> +}
> +
>   static struct l_genl_msg *netdev_build_cmd_connect(struct netdev *netdev,
>   						struct handshake_state *hs,
>   						const uint8_t *prev_bssid)
> @@ -2473,7 +2487,8 @@ static struct l_genl_msg *netdev_build_cmd_connect(struct netdev *netdev,
>   	 *       0 (open) for FT Initial Mobility Domain Association over
>   	 *         PMKSA caching
>   	 */
> -	uint32_t auth_type = IE_AKM_IS_SAE(hs->akm_suite) && !hs->have_pmksa ?
> +	uint32_t auth_type = IE_AKM_IS_SAE(hs->akm_suite) &&
> +					!netdev_handshake_can_use_pmksa(nhs) ?
>   					NL80211_AUTHTYPE_SAE :
>   					NL80211_AUTHTYPE_OPEN_SYSTEM;
>   	enum mpdu_management_subtype subtype = prev_bssid ?
> @@ -4053,7 +4068,8 @@ static void netdev_connect_common(struct netdev *netdev,
>   	 * If SAE, and we have a valid PMKSA cache we can skip the entire SAE
>   	 * protocol and authenticate using the cached keys.
>   	 */
> -	if (IE_AKM_IS_SAE(hs->akm_suite) && hs->have_pmksa) {
> +	if (IE_AKM_IS_SAE(hs->akm_suite) &&
> +					netdev_handshake_can_use_pmksa(nhs)) {
>   		l_debug("Skipping SAE by using PMKSA cache");
>   		goto build_cmd_connect;
>   	}

I also still had problems with the brcmfmac driver and IWD. It was not 
finally resolved. I will try to check again with this patch.

I would really appreciate, if you could have 2-3 brcmfmac devices 
running in your testing environment.

Thanks,

Martin

