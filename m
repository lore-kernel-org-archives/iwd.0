Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009171D516D
	for <iwd@lists.linux.dev>; Wed, 12 Feb 2025 16:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739377644; cv=none; b=NQX+XsarhLUPSK4a6r4qejRcohW4dI6l/AsAjradVDFw1s4RIhuqYPyqxKBPEn/Asb2Cu44goEuD4bXONUII+KsRltU+TwCpFq65B1ZNywSrXYojxQRLbbFCdHX02dH429BcRgAEqg8xo8fkuEbDQZ86jVgcTLf0nx4dYBuEJ5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739377644; c=relaxed/simple;
	bh=iEwga+0JC5PauPLBQYwPR6cFa/UivIV1o6CP1LiS2NU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aAljXvvnSsYujf9qleNHKPPKhxZcQ3Q0Irc1TbvUqMCMwl5izBnqLVgbM/hzRjDiv9fPc4wVhEHHRF+aVAUawl1aSiBnCEs6XhwkxEz+HKqGDDBlebMCMtrW+ME0v/CJiUKQHmnVcQXqzmidMl9XMTuVVIH7cMDiCjMVMhN5FnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hKgLOuHp; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hKgLOuHp"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c05b700b78so370473485a.2
        for <iwd@lists.linux.dev>; Wed, 12 Feb 2025 08:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739377642; x=1739982442; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vnmHvS/HFxbHqB5KUaCXmV7wZxe0DaC0jRPcb3ZwFn8=;
        b=hKgLOuHpV4B4TiqZIvkZbwuaEmtKMlA2nGBDkuEYlizoY5Ppox0In+sh5xSII/NkZ0
         zF4e5jZG8e3cQkIvXPI3oPVt0j/XFBJYVzRpnt2ZxcSqGNiNXW9qvmes2ObszRsrLDPD
         4t+sjfkIKfpNMNbLUa1uFEnwLLqE/nepgFazvGsNw1C5cNJT2/BLyPnSeOfzuPdKFuqC
         jVSke+14Du4VZhZc+yb08d4ARH13xoRXozHIBw8la/gk96bcLFalzfPG49bRv1FK554H
         LNsUvNCOhitm9FkHiUREUrMWMZ+t3hQ3Z8nXtPTOf7f4a2BfyzGZaNUTphWww3Xs7fpX
         +SQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739377642; x=1739982442;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vnmHvS/HFxbHqB5KUaCXmV7wZxe0DaC0jRPcb3ZwFn8=;
        b=rFmCN0zF2lrcYweO6R36BswtDabMFCYElkh2AKCm9MMQqucsJ41aJgZWi6wzFQyK1q
         STgSQTY/FKwfvQJCqvm7aChdTc9+LAcN6xHbiUEOb4xud3Q5tSLSmEe+cqVC9p84F9DU
         J0OXVyLBEHUVjJrAbt6peVPjUJ3PThOCk6xBQYvLhLlBJni0QuVPMRPYAvt/f1zmX2nF
         gFT0OcJj2YIp0vfLibJFQE/5LulSwHS1mlkd59p2uddPUI4k/4i65VJw8JTYQq16XNt/
         BrN71q/fJgf6awXewIErGWwtpx8oc/xVTyVGWaG4va0TSglXMrvpqWHLM/ubn46cOZzq
         PM2w==
X-Gm-Message-State: AOJu0Yzg1e8ethYJEpGAMHGxPtmRhMx4XA1hMecnpO/BGQ7omI+dbOw1
	qGk7XnoMG44ulWB8VXVqHQtWXb1U0TZu2xtxWUD5UddNam6vP7YWVKg1cw==
X-Gm-Gg: ASbGncuUmLimauRSvewrK6OR4YSw3OELVqASlgJcA/1s0r7HVAsuobMJOZvP//Y6ZqP
	EszGKp89XGb+TWJIz/2J2jKMA95+53ZD38nrD6FuqFkji49q2DhV3GrzinX2AUKXSGZRA8tWCH0
	7FsuZ2WRJoU4FvZcUmf44J8VyQqAaa/aQxCQLE1F4NDDVWa4EkXKI5+PDDFP7YboWu3nU8WTT82
	k6HwBZJnxMFKHkh4wwk+z03sgr1NmOCT42SHvnFenbwfAZ/yf0LakC9DF8Bi7L3D/zvygCBiQZ3
	1cS9qufErfQWnvyT1II=
X-Google-Smtp-Source: AGHT+IFspA34aksGqe8tVApNiuV2dqfYs/4CG1VxglrFKvArbIa0ujBg1qqtnr+NuP14Lgw3gejGmw==
X-Received: by 2002:ad4:5d66:0:b0:6d4:215d:91b9 with SMTP id 6a1803df08f44-6e46ed7e57fmr54340196d6.11.1739377641694;
        Wed, 12 Feb 2025 08:27:21 -0800 (PST)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e43baacb52sm80823416d6.89.2025.02.12.08.27.20
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 08:27:21 -0800 (PST)
Message-ID: <a50a50d6-100b-45f3-972e-3f3aa63c5ee8@gmail.com>
Date: Wed, 12 Feb 2025 08:27:19 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] netdev: implement PMKSA for fullmac drivers
To: iwd@lists.linux.dev
References: <20250212162401.130792-1-prestwoj@gmail.com>
 <20250212162401.130792-4-prestwoj@gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <20250212162401.130792-4-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2/12/25 8:24 AM, James Prestwood wrote:
> Supporting PMKSA on fullmac drivers requires that we set the PMKSA
> into the kernel as well as remove it. Since station has a removal
> path netdev_remove_pmksa needed to be added which station will
> call. This will handle both removing IWD's PMKSA cache as well as
> in the kernels.
>
> On addition its similar, we add to both IWDs cache and the kernels.
> ---
>   src/netdev.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>   src/netdev.h |  2 ++
>   2 files changed, 70 insertions(+)
>
> diff --git a/src/netdev.c b/src/netdev.c
> index 06282c2a..42fb6a4b 100644
> --- a/src/netdev.c
> +++ b/src/netdev.c
> @@ -1498,6 +1498,52 @@ static void netdev_setting_keys_failed(struct netdev_handshake_state *nhs,
>   	handshake_event(&nhs->super, HANDSHAKE_EVENT_SETTING_KEYS_FAILED, &err);
>   }
>   
> +static void netdev_set_pmksa(struct handshake_state *hs)
> +{
> +	struct l_genl_msg *msg;
> +	uint32_t expiration = (uint32_t)hs->expiration;
> +
> +	if (!hs->have_pmkid)
> +		return;
> +
> +	msg = l_genl_msg_new(NL80211_CMD_SET_PMKSA);
> +
> +	l_genl_msg_append_attr(msg, NL80211_ATTR_IFINDEX, 4, &hs->ifindex);
> +	l_genl_msg_append_attr(msg, NL80211_ATTR_PMKID, 16, hs->pmkid);
> +	l_genl_msg_append_attr(msg, NL80211_ATTR_MAC, ETH_ALEN, hs->aa);
> +	l_genl_msg_append_attr(msg, NL80211_ATTR_SSID, hs->ssid_len, hs->ssid);
> +	l_genl_msg_append_attr(msg, NL80211_ATTR_PMK_LIFETIME, 4, &expiration);
> +	l_genl_msg_append_attr(msg, NL80211_ATTR_PMK, hs->pmk_len, hs->pmk);
> +
> +	if (!l_genl_family_send(nl80211, msg, NULL, NULL, NULL))
> +		l_error("error sending SET_PMKSA");
> +}
> +
> +void netdev_remove_pmksa(struct netdev *netdev)
> +{
> +	struct l_genl_msg *msg;
> +	struct handshake_state *hs = netdev->handshake;
> +	struct netdev_handshake_state *nhs = l_container_of(hs,
> +					struct netdev_handshake_state, super);
> +
> +	handshake_state_remove_pmksa(netdev->handshake);
> +
> +	if (nhs->type != CONNECTION_TYPE_FULLMAC)
> +		return;
> +
> +	/* Fullmac cards need to set/remove the PMKSA within the kernel */
> +
> +	msg = l_genl_msg_new(NL80211_CMD_DEL_PMKSA);
> +
> +	l_genl_msg_append_attr(msg, NL80211_ATTR_IFINDEX, 4, &netdev->index);
> +	l_genl_msg_append_attr(msg, NL80211_ATTR_PMKID, 16, hs->pmkid);
> +	l_genl_msg_append_attr(msg, NL80211_ATTR_MAC, ETH_ALEN, hs->aa);
> +	l_genl_msg_append_attr(msg, NL80211_ATTR_SSID, hs->ssid_len, hs->ssid);
> +
> +	if (!l_genl_family_send(nl80211, msg, NULL, NULL, NULL))
> +		l_error("error sending DEL_PMKSA");
> +}
> +
>   static void try_handshake_complete(struct netdev_handshake_state *nhs)
>   {
>   	l_debug("ptk_installed: %u, gtk_installed: %u, igtk_installed: %u",
> @@ -1518,6 +1564,9 @@ static void try_handshake_complete(struct netdev_handshake_state *nhs)
>   
>   		l_debug("Invoking handshake_event()");
>   
> +		if (nhs->type == CONNECTION_TYPE_FULLMAC)
> +			netdev_set_pmksa(&nhs->super);
> +
>   		handshake_state_cache_pmksa(&nhs->super);
>   
>   		if (handshake_event(&nhs->super, HANDSHAKE_EVENT_COMPLETE))
> @@ -6469,6 +6518,23 @@ static void netdev_get_link(struct netdev *netdev)
>   	L_WARN_ON(netdev->get_link_cmd_id == 0);
>   }
>   
> +static void netdev_flush_pmksa(struct netdev *netdev)
> +{
> +	struct l_genl_msg *msg = l_genl_msg_new(NL80211_CMD_FLUSH_PMKSA);
Just noticed this is leaking memory. I'll fix after reviews.
> +
> +	/*
> +	 * We only utilize the kernel's PMKSA cache for fullmac cards, so no
> +	 * need to flush if this is a softmac
> +	 */
> +	if (wiphy_supports_cmds_auth_assoc(netdev->wiphy))
> +		return;
> +
> +	l_genl_msg_append_attr(msg, NL80211_ATTR_IFINDEX, 4, &netdev->index);
> +
> +	if (!l_genl_family_send(nl80211, msg, NULL, NULL, NULL))
> +		l_error("Failed to flush PMKSA");
> +}
> +
>   struct netdev *netdev_create_from_genl(struct l_genl_msg *msg,
>   					const uint8_t *set_mac)
>   {
> @@ -6544,6 +6610,8 @@ struct netdev *netdev_create_from_genl(struct l_genl_msg *msg,
>   
>   	netdev_get_link(netdev);
>   
> +	netdev_flush_pmksa(netdev);
> +
>   	return netdev;
>   }
>   
> diff --git a/src/netdev.h b/src/netdev.h
> index 6299934e..0c7d7550 100644
> --- a/src/netdev.h
> +++ b/src/netdev.h
> @@ -218,6 +218,8 @@ int netdev_get_all_stations(struct netdev *netdev, netdev_get_station_cb_t cb,
>   
>   void netdev_handshake_failed(struct handshake_state *hs, uint16_t reason_code);
>   
> +void netdev_remove_pmksa(struct netdev *netdev);
> +
>   struct netdev *netdev_find(int ifindex);
>   
>   uint32_t netdev_watch_add(netdev_watch_func_t func,
