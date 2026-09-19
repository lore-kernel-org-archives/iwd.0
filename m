Received: from mail.horus.com (mail.horus.com [78.46.148.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7B310F0
	for <iwd@lists.linux.dev>; Sat, 19 Sep 2026 14:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.148.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789826545; cv=none; b=BwmksN7PZeQmalk4wIPlMdUnNbRsOlk5Ks747UMswAq4LChRgNQADhY5eHakuDpu2Qh+1DW/OlT8X0D/wMFta1AXN0YGczg55CPkIyeDhoukhVTBF1AZ1Te9L9oJKqeE2TEgBBBzpaEpq1SFLEyVJtUvXvsv3tvuzmMVPmbVK2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789826545; c=relaxed/simple;
	bh=RUPXFkBpEnA57/b3cdFbnWzhkePsfuhXnFTET11D170=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IexT4KPfO9mUpCVG5LUXQvGbaCMqARkb1UXeMwLhleco88bDxdw4sCKVvNJe7cvAdU4faK/RTODSOtIG/erx4T0p44t21ttwYKyblsYUFvTTUpwqBKfFRoehtvY0AAnNnZXDiYIlL6K9pb3JWTk5FZGlVr0cHsoL+J+c5NHmAMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=horus.com; spf=pass smtp.mailfrom=horus.com; dkim=pass (1024-bit key) header.d=horus.com header.i=@horus.com header.b=YwrjUf8d; arc=none smtp.client-ip=78.46.148.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=horus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=horus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=horus.com header.i=@horus.com header.b="YwrjUf8d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=horus.com;
	s=20180324; t=1789826123;
	bh=Z8gWXLNTcuXAMC19a9AYOUXKvRRKHCDGwHnOGOTu8ZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YwrjUf8d7Vydd6GFXWVqJjafzqJVuHZalvCBFlJ0FQAgAZSXFBRQtQ1SKIf0KzNAR
	 rXZ/cbkrFt7mezX0MSojz7T968HZn4+RIvE0FGLgf0RrXy9+sWz9wxa6XDosxJ8I9U
	 nqHPC7nsKPTl8lxX7AepNrMg7AlBLz7oNOUdrNto=
Received: from [192.168.1.22] (188-22-145-194.adsl.highway.telekom.at [188.22.145.194])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.horus.com (Postfix) with ESMTPSA id 037E56404F;
	Sat, 19 Sep 2026 15:55:22 +0200 (CEST)
Received: by camel4.lan (Postfix, from userid 1000)
	id 02D5F580298; Sat, 19 Sep 2026 15:55:21 +0200 (CEST)
Date: Sat, 19 Sep 2026 15:55:21 +0200
From: Matthias Reichl <hias@horus.com>
To: Jeremy Blum <jeremy@jeremyblum.com>
Cc: iwd@lists.linux.dev, denkenz@gmail.com, prestwoj@gmail.com,
	marcel@holtmann.org
Subject: Re: [PATCH] netdev: use SAE PWE both for fullmac external auth
Message-ID: <aq6USbwGZT9CjoKf@camel4.lan>
References: <20260403175038.4533-1-jeremy@jeremyblum.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403175038.4533-1-jeremy@jeremyblum.com>

On Fri, Apr 03, 2026 at 10:50:38AM -0700, Jeremy Blum wrote:
> For fullmac external SAE, iwd currently forces Hunt-and-Peck and does
> not include NL80211_ATTR_SAE_PWE in the connect request.
> 
> This prevents successful association with H2E-capable APs on at least
> some fullmac drivers, since userspace is effectively constraining SAE
> to Hunt-and-Peck while not advertising the intended SAE PWE policy to
> nl80211.
> 
> For fullmac SAE connections without PMKSA reuse, request
> NL80211_SAE_PWE_BOTH and stop forcing Hunt-and-Peck on the SAE state
> machine. This keeps the fullmac external-auth path aligned with the
> actual SAE policy instead of hard-wiring HnP.
> 
> Tested on a CYW43455/brcmfmac fullmac device using firmware 7.45.286,
> where this change fixes WPA3 association and traffic on H2E-capable APs.
> 
> Signed-off-by: Jeremy Blum <jeremy@jeremyblum.com>

Tested-by: Matthias Reichl <hias@horus.com>

Thanks for the patch, it works fine on a Raspberry Pi 5 using a 43455
with firmware 7.45.265, the downstream RPi 6.18.52 kernel and iwd 3.12
plus this patch.

Without it hostapd on my Asus AX4200 router running OpenWRT 25.12.5
would reject association with a "SAE: xx:xx:xx:xx:xx:xx indicates
support for SAE H2E, but did not use it" message.

With this patch iwd connected fine both to a WPA3 SAE only network
and a mixed WPA2/WPA3 PSK/SAE network.

so long,

Hias

> ---
>  src/netdev.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/src/netdev.c b/src/netdev.c
> index e639a1f8..94520b5c 100644
> --- a/src/netdev.c
> +++ b/src/netdev.c
> @@ -2600,6 +2600,11 @@ static struct l_genl_msg *netdev_build_cmd_connect(struct netdev *netdev,
>  	uint32_t auth_type = IE_AKM_IS_SAE(hs->akm_suite) && !hs->have_pmksa ?
>  					NL80211_AUTHTYPE_SAE :
>  					NL80211_AUTHTYPE_OPEN_SYSTEM;
> +	uint8_t sae_pwe = nhs->type == CONNECTION_TYPE_FULLMAC &&
> +				IE_AKM_IS_SAE(hs->akm_suite) &&
> +				!hs->have_pmksa ?
> +				NL80211_SAE_PWE_BOTH :
> +				NL80211_SAE_PWE_UNSPECIFIED;
>  	enum mpdu_management_subtype subtype = prev_bssid ?
>  				MPDU_MANAGEMENT_SUBTYPE_REASSOCIATION_REQUEST :
>  				MPDU_MANAGEMENT_SUBTYPE_ASSOCIATION_REQUEST;
> @@ -2618,6 +2623,8 @@ static struct l_genl_msg *netdev_build_cmd_connect(struct netdev *netdev,
>  	l_genl_msg_append_attr(msg, NL80211_ATTR_MAC, ETH_ALEN, hs->aa);
>  	l_genl_msg_append_attr(msg, NL80211_ATTR_SSID, hs->ssid_len, hs->ssid);
>  	l_genl_msg_append_attr(msg, NL80211_ATTR_AUTH_TYPE, 4, &auth_type);
> +	if (sae_pwe != NL80211_SAE_PWE_UNSPECIFIED)
> +		l_genl_msg_append_attr(msg, NL80211_ATTR_SAE_PWE, 1, &sae_pwe);
>  
>  	switch (nhs->type) {
>  	case CONNECTION_TYPE_SOFTMAC:
> @@ -4218,7 +4225,6 @@ static void netdev_connect_common(struct netdev *netdev,
>  					netdev_external_auth_sae_tx_associate,
>  					netdev);
>  		sae_sm_force_default_group(netdev->ap);
> -		sae_sm_force_hunt_and_peck(netdev->ap);
>  	}
>  
>  	if (sae_sm_is_h2e(netdev->ap)) {
> 
> base-commit: d003d0e593323b3de427f01284ede81ba61e9dcc
> -- 
> 2.50.1 (Apple Git-155)
> 
