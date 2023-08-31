Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17DBEA1
	for <iwd@lists.linux.dev>; Thu, 31 Aug 2023 02:34:46 +0000 (UTC)
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3a86a0355dfso175258b6e.0
        for <iwd@lists.linux.dev>; Wed, 30 Aug 2023 19:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693449285; x=1694054085; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vbndBQX/36CddgSEcDBENVrjW2xJdcYejJeC/oI6vgw=;
        b=RgMTeQ7pBNXNl/gGZHP4Clqa5s/LaxJxaGjy50Vec9L5in2vmHFl0OZyiYmc76iGb4
         C4BwqfOLrN+gmB0eHDjBP2Mg8u1tYkB+GDur7z5zBYhOEeE/+xInNrqgiTmB4CHBG0Gj
         uzweXoAlI4pbEgc9DWliP2ROYLIrT9Sbr6rDaw7aXxXyPF8L73mmNcYoBhKffhYmiR5Z
         yrzt/RXEFwejs8ButTCGdG2YitlzyPxmGWD7CZvd9dSB+IEs9Re00JomnBFPZEb8gegI
         wl8hdY4Eet0ytgAoEhfsGQHEj7wRP1C+c7zRmvw1MbOuLVlZbEdEz587MZkkIj9fttC9
         OGvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693449285; x=1694054085;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vbndBQX/36CddgSEcDBENVrjW2xJdcYejJeC/oI6vgw=;
        b=Z41Ie9+7wen7FDiI/VRxpmXYbGcXOtWiEMZ7gYNcrlPu+Jbb1fpPwGDao/wMGwIDKe
         ak8pbLqczZn/HcWi7T9y+9rsGDcs3lP66WXpe54+u7RC8wDcgpX4iA1WSMFXTagunosu
         cIo0Nvx0NTrhDCeWQG/c3geEX6Erqu7H0m03nWNOsePQAiR7hB9Rk+/9cUV1hefDdrqU
         SKRgurvP9a/bXAImhxkUKVKN61Kg1thI2qv9fEZX9HXvIVIHGBSrKRO4FwZC8jKKQQqg
         NOq9VKhSVR8krhVVQjtOqV2KtXLstF2Y9qIAAvdhbA/KrBC5UgT8tMrxDt7nq3a7TTB0
         vDjA==
X-Gm-Message-State: AOJu0Yyn2KKojATfbF1NZajQk0Jn0OHEtnWSPok1GR4+/lWYKh7E5nF6
	wvfp+YleuABMKQV/Y27KAEY=
X-Google-Smtp-Source: AGHT+IGSLMKE3b3+mPHkbn13nc5dhO+ovF7tE2I+25I/bNkpezcUoadH1z8Rkwwpy3ukPpcpaGtWNg==
X-Received: by 2002:a05:6808:1923:b0:3a4:6a:6363 with SMTP id bf35-20020a056808192300b003a4006a6363mr5348236oib.14.1693449285508;
        Wed, 30 Aug 2023 19:34:45 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id o20-20020a0568080bd400b003a74933a1e2sm243947oik.46.2023.08.30.19.34.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 19:34:44 -0700 (PDT)
Message-ID: <14b92465-07b9-7f76-556f-0bd79dc2a6f7@gmail.com>
Date: Wed, 30 Aug 2023 21:34:43 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/3] station: fall back to reassociation under certain
 FT failures
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20230829145116.279949-1-prestwoj@gmail.com>
 <20230829145116.279949-2-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20230829145116.279949-2-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 8/29/23 09:51, James Prestwood wrote:
> The auth/action status is now tracked in ft.c. If an AP rejects the
> FT attempt with "Invalid PMKID" we can now assume this AP is either
> mis-configured for FT or is lagging behind getting the proper keys
> from neighboring APs (e.g. was just rebooted).
> 
> If we see this condition IWD can now fall back to reassociation in
> an attempt to still roam to the best candidate. The fallback decision
> is still rank based: if a BSS fails FT it is marked as such, its
> ranking is re-computed removing the FT factor and it is inserted back
> into the queue.
> 
> The motivation behind this isn't necessarily to always force a roam,
> but instead to handle two cases where IWD can either make a bad roam
> decision or get 'stuck' and never roam:
> 
>    1. If there is one good roam candidate and other bad ones. For
>       example say BSS A is experiencing this FT key pull issue:
>           Current BSS: -85dbm
>           BSS A:       -55dbm
>           BSS B:       -80dbm
>       The current logic would fail A, and roam to B. In this case
>       reassociation would have likely succeeded so it makes more sense
>       to reassociate to A as a fallback.
> 
>    2. If there is only one candidate, but its failing FT. IWD will
>       never try anything other than FT and repeatedly fail.
> 
> Both of the above have been seen on real network deployments and
> result in either poor performance (1) or eventually lead to a full
> disconnect due to never roaming (2).
> ---
>   src/station.c | 124 ++++++++++++++++++++++++++++++++------------------
>   1 file changed, 80 insertions(+), 44 deletions(-)
> 
> v2:
>   * Rather than always falling back to reassociate recompute the
>     rank and insert into the queue. This allows IWD to try similarly
>     ranked BSS's with FT before falling back to reassociation.
> 

<snip>

> diff --git a/src/station.c b/src/station.c
> index 2473de2a..59191baa 100644
> --- a/src/station.c
> +++ b/src/station.c
> @@ -73,6 +73,7 @@ static bool supports_arp_evict_nocarrier;
>   static bool supports_ndisc_evict_nocarrier;
>   static struct watchlist event_watches;
>   static uint32_t known_networks_watch;
> +static const double RANK_FT_FACTOR = 1.3;
>   
>   struct station {
>   	enum station_state state;
> @@ -147,15 +148,49 @@ struct roam_bss {
>   	uint8_t addr[6];
>   	uint16_t rank;

I'd store the original (non-FT factored rank here).  This lets you get rid of 
the double division which I think might be expensive on some platforms.

>   	int32_t signal_strength;
> +	bool reassoc: 1;

I'd name this something like ft_failed.

>   };
>   
> -static struct roam_bss *roam_bss_from_scan_bss(const struct scan_bss *bss)

<snip>

> +static struct roam_bss *roam_bss_from_scan_bss(struct handshake_state *hs,
> +						const struct scan_bss *bss)
>   {
>   	struct roam_bss *rbss = l_new(struct roam_bss, 1);
>   
>   	memcpy(rbss->addr, bss->addr, 6);
>   	rbss->rank = bss->rank;
>   	rbss->signal_strength = bss->signal_strength;
> +	rbss->reassoc = !station_can_fast_transition(hs, bss);

Why would you do this for every candidate up-front?  If the first one succeeds, 
no need to do this for the rest.  Also, strictly speaking the scan results might 
have changed in the meantime.  You should be checking this against the fresh bss 
obtained in station_transition_start.

>   
>   	return rbss;
>   }

<snip>

> @@ -2264,19 +2272,43 @@ static void station_transition_start(struct station *station);
>   static bool station_ft_work_ready(struct wiphy_radio_work_item *item)
>   {
>   	struct station *station = l_container_of(item, struct station, ft_work);
> -	struct roam_bss *rbss = l_queue_pop_head(station->roam_bss_list);
> -	struct scan_bss *bss = network_bss_find_by_addr(
> -					station->connected_network, rbss->addr);
> +	_auto_(l_free) struct roam_bss *rbss = l_queue_pop_head(
> +							station->roam_bss_list);
> +	struct scan_bss *bss;
>   	int ret;
>   
> -	l_free(rbss);
> -
>   	/* Very unlikely, but the BSS could have gone away */
> +	bss = network_bss_find_by_addr(station->connected_network, rbss->addr);
>   	if (!bss)
>   		goto try_next;
>   
>   	ret = ft_associate(netdev_get_ifindex(station->netdev), bss->addr);
> -	if (ret == -ENOENT) {

Okay, but it feels like the resulting if statement is starting to become messy 
after these changes.  Maybe using a switch/case would be better?

> +	if (ret > 0) {
> +		if (ret != MMPDU_STATUS_CODE_INVALID_PMKID) {
> +			station_debug_event(station, "ft-roam-failed");
> +			goto try_next;
> +		}
> +
> +		/*
> +		 * Re-insert removing FT from the ranking. If the BSS is still
> +		 * the best reassociation will be used, otherwise we'll try
> +		 * more FT candidates that are better ranked
> +		 */
> +		rbss->rank /= RANK_FT_FACTOR;
> +		rbss->reassoc = true;

Here's where saving the original rank would be better.  You can simply assign 
the original rank to the current one and avoid the division.

> +
> +		l_debug("Re-inserting BSS "MAC" forcing reassociation, rank: %u",
> +					MAC_STR(rbss->addr), rbss->rank);
> +
> +		l_queue_insert(station->roam_bss_list, rbss,
> +				roam_bss_rank_compare, NULL);
> +
> +		station_debug_event(station, "ft-fallback-to-reassoc");
> +
> +		station_transition_start(station);
> +		l_steal_ptr(rbss);
> +		return true;
> +	} else if (ret == -ENOENT) {
>   		station_debug_event(station, "ft-roam-failed");
>   try_next:
>   		station_transition_start(station);

<snip>

> @@ -2490,7 +2526,6 @@ static bool station_roam_scan_notify(int err, struct l_queue *bss_list,
>   	struct scan_bss *current_bss = station->connected_bss;
>   	struct scan_bss *bss;
>   	double cur_bss_rank = 0.0;
> -	static const double RANK_FT_FACTOR = 1.3;

You probably don't need to move this if you save the original rank.

>   	uint16_t mdid;
>   	enum security orig_security, security;
>   

<snip>

Regards,
-Denis
