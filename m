Received: from mout-b-112.mailbox.org (mout-b-112.mailbox.org [195.10.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6A41F80D7
	for <iwd@lists.linux.dev>; Fri, 25 Oct 2024 11:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729854900; cv=none; b=qCZ6jJob/Obzb8ZScJVAV6aUPSkLj3vTD8nuqbodAI0wKG5wBXIlsVrNXwSfJXRvci7MDI1MwOqXTKUzXg3Cm31FGYfLIrJJvzBnQtPhHScr1+8D44A8U7tAY7qR9BH7Xq0iZAo8e7+LJc76o7UvyDOhKFFKrmNeSsn8F8ARUaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729854900; c=relaxed/simple;
	bh=09x/7nYHMh7P9uF4bpZ/hx8x7o1Tj+eXUMZ8cADqu90=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=S8yafudEDGgGz1x/kaXp2K5yTJgI++1aajTmv6OH2Smwrxm1Qdr6mpUSLPYSZBcpq4L9zrwclwrIuDR5+rRrx4yw3p8nAaAvrIbOjncKzW2/6oO6qLgj7WcKOVh6dg2tFCekn5dryquulO3vwSp92W9Anl+EjCkvsvrTpAJ93tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de; spf=pass smtp.mailfrom=tavla.de; dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b=jCz3j7JX; arc=none smtp.client-ip=195.10.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tavla.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b="jCz3j7JX"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-112.mailbox.org (Postfix) with ESMTPS id 4XZgDD6WFwzDtFd;
	Fri, 25 Oct 2024 13:14:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tavla.de; s=MBO0001;
	t=1729854892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XsF1b8MGmBdAHbm6+43M3ggMBWo/fpPyDL9lhYxtvQg=;
	b=jCz3j7JX9vUboO6lOHRhu8khPUkmznZDaSUzgQO543An81axX7QbNKRvFFQQw+P6gxJFbQ
	8qCeXTPj+bzlAqryDUCl1S83r6wbSwcnxncZ7JQDeYEgcJ9lwon6VURqn4pFmlLNOOeqCE
	zt9vzZHeN3yLs1BWfVE0SsoLCNU47zaNDzirr73WHtjqIWrAVwwf1JUUTtTUFWB2g7wBKe
	GdM4arhp4/B1pEJ8Jsg6aqASUG+J5QV5NlCNVrlKGhV53saWZePAoiTkwAfHIMYYZAP71E
	BG1Oz25XgxXdZmoIVBI7Fm9EDGGaLYFAUT8rwVm7XmfwgYptASx7shEPZK1M6Q==
Message-ID: <91657cac-4009-42a0-89b4-865e443a671b@tavla.de>
Date: Fri, 25 Oct 2024 13:14:51 +0200
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: [PATCH] station: check support for all sysfs settings
To: James Prestwood <prestwoj@gmail.com>
References: <20241024131628.152607-1-prestwoj@gmail.com>
Content-Language: en-GB, de-DE
Cc: iwd@lists.linux.dev
From: Martin Petzold <martin.petzold@tavla.de>
Organization: TAVLA Technology GmbH
In-Reply-To: <20241024131628.152607-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4XZgDD6WFwzDtFd

Hi James,

Am 24.10.24 um 15:16 schrieb James Prestwood:
> If IPv6 is disabled or not supported at the kernel level writing the
> sysfs settings will fail. A few of them had a support check but this
> patch adds a supported bool to the remainder so we done get errors
> like:
I have IPv6 disabled. What is the impact of this issue without the 
patches? Connection losses?
> Unable to write drop_unsolicited_na to /proc/sys/net/ipv6/conf/wlan0/drop_unsolicited_na
> ---
>   src/station.c | 36 ++++++++++++++++++++++++++++--------
>   1 file changed, 28 insertions(+), 8 deletions(-)
>
> diff --git a/src/station.c b/src/station.c
> index cef6c66a..34537b26 100644
> --- a/src/station.c
> +++ b/src/station.c
> @@ -74,6 +74,10 @@ static uint32_t roam_retry_interval;
>   static bool anqp_disabled;
>   static bool supports_arp_evict_nocarrier;
>   static bool supports_ndisc_evict_nocarrier;
> +static bool supports_drop_gratuitous_arp;
> +static bool supports_drop_unsolicited_na;
> +static bool supports_ipv4_drop_unicast_in_l2_multicast;
> +static bool supports_ipv6_drop_unicast_in_l2_multicast;
>   static struct watchlist event_watches;
>   static uint32_t known_networks_watch;
>   static uint32_t allowed_bands;
> @@ -1641,10 +1645,13 @@ static void station_set_drop_neighbor_discovery(struct station *station,
>   {
>   	char *v = value ? "1" : "0";
>   
> -	sysfs_write_ipv4_setting(netdev_get_name(station->netdev),
> -				"drop_gratuitous_arp", v);
> -	sysfs_write_ipv6_setting(netdev_get_name(station->netdev),
> -				"drop_unsolicited_na", v);
> +	if (supports_drop_gratuitous_arp)
> +		sysfs_write_ipv4_setting(netdev_get_name(station->netdev),
> +					"drop_gratuitous_arp", v);
> +
> +	if (supports_drop_unsolicited_na)
> +		sysfs_write_ipv6_setting(netdev_get_name(station->netdev),
> +					"drop_unsolicited_na", v);
>   }
>   
>   static void station_set_drop_unicast_l2_multicast(struct station *station,
> @@ -1652,10 +1659,13 @@ static void station_set_drop_unicast_l2_multicast(struct station *station,
>   {
>   	char *v = value ? "1" : "0";
>   
> -	sysfs_write_ipv4_setting(netdev_get_name(station->netdev),
> -				"drop_unicast_in_l2_multicast", v);
> -	sysfs_write_ipv6_setting(netdev_get_name(station->netdev),
> -				"drop_unicast_in_l2_multicast", v);
> +	if (supports_ipv4_drop_unicast_in_l2_multicast)
> +		sysfs_write_ipv4_setting(netdev_get_name(station->netdev),
> +					"drop_unicast_in_l2_multicast", v);
> +
> +	if (supports_ipv6_drop_unicast_in_l2_multicast)
> +		sysfs_write_ipv6_setting(netdev_get_name(station->netdev),
> +					"drop_unicast_in_l2_multicast", v);
>   }
>   
>   static void station_signal_agent_notify(struct station *station);
> @@ -5813,6 +5823,16 @@ static int station_init(void)
>   						"arp_evict_nocarrier");
>   	supports_ndisc_evict_nocarrier = sysfs_supports_ipv6_setting("all",
>   						"ndisc_evict_nocarrier");
> +	supports_drop_gratuitous_arp = sysfs_supports_ipv4_setting("all",
> +						"drop_gratuitous_arp");
> +	supports_drop_unsolicited_na = sysfs_supports_ipv6_setting("all",
> +						"drop_unsolicited_na");
> +	supports_ipv4_drop_unicast_in_l2_multicast =
> +					sysfs_supports_ipv4_setting("all",
> +					"drop_unicast_in_l2_multicast");
> +	supports_ipv6_drop_unicast_in_l2_multicast =
> +					sysfs_supports_ipv6_setting("all",
> +					"drop_unicast_in_l2_multicast");
>   
>   	watchlist_init(&event_watches, NULL);
>   

