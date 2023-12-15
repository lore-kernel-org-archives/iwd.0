Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEAC4184D
	for <iwd@lists.linux.dev>; Fri, 15 Dec 2023 16:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="doHE60HU"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5910b21896eso634338eaf.0
        for <iwd@lists.linux.dev>; Fri, 15 Dec 2023 08:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702658224; x=1703263024; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1ZbRkrMfYMP59hijhLl9iNHaiLsW+7wV4PTHaquWC7E=;
        b=doHE60HUhGMFogQiT9AJy58N0Ty4Aft9eJgfX7f6qLjm/EwDsmSxgffLX3COEoxk/K
         HlITvSePv/TGvlI30pFUzIWU9kVYOjG6S3znZSHk3JxCXN8dKhnoMuKdAe++G5Zw9woH
         gcYkNmjANP7Xzrg1MSqdEqho3AcahqwsQbBQMSk6BN7irAU6bYVTW1dgSiK+SauJonFr
         gZGk47lRKTVf/3FecN9RViVbMtVjw8aWtdacN1ba4Fd83dWVaw0z0sAWvboLxfXeuKeC
         mXMGZ6B77W3E0EyxNLC/kD4J4Cu2ieff1L4yIkcqlKGtQou4u/1N8tMQGGiGWnuvkuM6
         BRcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702658224; x=1703263024;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1ZbRkrMfYMP59hijhLl9iNHaiLsW+7wV4PTHaquWC7E=;
        b=YiSPzmnDt4ftFcSd0bsmq18TMEBIkZ9xvxiWhpHIFPLxlGWd6ZycAMmjSNS0gkw4Uy
         aNDXF3Ydfz9/x3ECIY2WU6dLO68owU1aBgkI3f82e/Gr4CkqcllNmyCiPkPDIYAW7Fp2
         BeiLw8/W6i5mtlKU3MSIABVq+rZeR+N3tPT/oTjoNJGvauAuz/N2RuoUwno9ErL5TL7y
         sNtFieQbOkmHRdJssJG5ITDf0D9RMn+uDZaJLG/o6kOR2WcqLP0OZZm5hT2udiTQOt4Q
         wuxmvI/CUOKemOmX0IY+Qdooyv63xc2T/klhZ//OU7KumKtYZe+ngVkdf0D3R1mYKBoW
         5TWA==
X-Gm-Message-State: AOJu0YzrEhBkoruVHWPXQ37K13qVbRPZ2r4gfERetMRajAai/gTHXzSf
	V9DhOQGlyNfzziFNDvVnkKo=
X-Google-Smtp-Source: AGHT+IEKL8OTivyMiC4n38g1DHwHdGtncayyTQ90xVD7T3dGIcM/dcYI99c9UscXfSrk0sYyG0ERsw==
X-Received: by 2002:a4a:af02:0:b0:58d:8b93:ec8 with SMTP id w2-20020a4aaf02000000b0058d8b930ec8mr8834464oon.2.1702658224205;
        Fri, 15 Dec 2023 08:37:04 -0800 (PST)
Received: from [172.16.49.130] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id f15-20020a4ab00f000000b005919cb3b6c3sm219182oon.0.2023.12.15.08.37.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Dec 2023 08:37:03 -0800 (PST)
Message-ID: <e2b80483-8976-454f-8b7d-428bbb63ea89@gmail.com>
Date: Fri, 15 Dec 2023 10:37:02 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] knownnetworks: network: support updating known
 network settings
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231214180110.130991-1-prestwoj@gmail.com>
 <20231214180110.130991-2-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231214180110.130991-2-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 12/14/23 12:01, James Prestwood wrote:
> Currently if a known network is modified on disk the settings are not
> reloaded by network. Only disconnecting/reconnecting to the network
> would update the settings. This poses an issue to DPP since its
> creating or updating a known network after configuration then trying
> to connect. The connection itself works fine since the PSK/passphrase
> is set to the network object directly, but any additional settings
> are not updated.
> 
> To fix this add a new UPDATED known network event. This is then
> handled from within network and all settings read from disk are
> applied to the network object.

Okay, so you chose option 2...

> ---
>   src/knownnetworks.c |   4 ++
>   src/knownnetworks.h |   1 +
>   src/network.c       | 104 ++++++++++++++++++++++++++++++++++++++++++--
>   3 files changed, 106 insertions(+), 3 deletions(-)
> 

<snip>

> diff --git a/src/network.c b/src/network.c
> index 41c5460b..bd3671ca 100644
> --- a/src/network.c
> +++ b/src/network.c
> @@ -730,6 +730,73 @@ static void network_settings_save(struct network *network,
>   		network_settings_save_sae_pt_ecc(settings, network->sae_pt_20);
>   }
>   
> +static bool network_settings_update(struct network *network,
> +					struct l_settings *new)
> +{
> +	bool have_transition_disable;
> +	uint8_t transition_disable = 0;
> +	unsigned int i;
> +	size_t psk_len;
> +	_auto_(l_strv_free) char **list = NULL;
> +	_auto_(l_free) uint8_t *psk = NULL;
> +	_auto_(l_free) char *passphrase = NULL;
> +
> +	if (l_settings_get_bool(new, NET_TRANSITION_DISABLE,
> +				&have_transition_disable) &&
> +				have_transition_disable) {
> +		list = l_settings_get_string_list(new,
> +					NET_TRANSITION_DISABLE_MODES, ' ');
> +
> +		for (i = 0; list[i]; i++) {
> +			if (!strcmp(list[i], "personal"))
> +				set_bit(&transition_disable, 0);
> +			else if (!strcmp(list[i], "enterprise"))
> +				set_bit(&transition_disable, 1);
> +			else if (!strcmp(list[i], "open"))
> +				set_bit(&transition_disable, 2);
> +		}
> +
> +		have_transition_disable = true;
> +	} else
> +		have_transition_disable = false;
> +
> +	if (network->security != SECURITY_PSK)
> +		goto apply;
> +
> +	psk = l_settings_get_bytes(network->settings, "Security",
> +					"PreSharedKey", &psk_len);
> +	if (psk && psk_len != 32) {
> +		l_warn("updated [Security].PreSharedKey value is invalid!");
> +		return false;
> +	}

I'm not sure you really want to yank the PSK or Passphrase actually.  These are 
obtained via the Agent and should take precedence.

> +
> +	passphrase = l_settings_get_string(network->settings,
> +						"Security", "Passphrase");
> +	if (passphrase && !crypto_passphrase_is_valid(passphrase)) {
> +		l_warn("updated [Security].Passphrase value is invalid!");
> +		return false;
> +	}
> +
> +apply:
> +	network_settings_close(network);
> +	network->settings = new;
> +
> +	network->have_transition_disable = have_transition_disable;
> +	network->transition_disable = transition_disable;
> +
> +	if (psk)
> +		network->psk = l_steal_ptr(psk);
> +
> +	if (passphrase) {
> +		network->passphrase = l_strdup(passphrase);
> +
> +		network_settings_load_pt_ecc(network, 19, &network->sae_pt_19);
> +		network_settings_load_pt_ecc(network, 20, &network->sae_pt_20);
> +	}

I suspect you're better off copying all the settings (with the exception of 
Security) over to the open settings object instead,

> +
> +	return true;
> +}
> +
>   void network_sync_settings(struct network *network)
>   {
>   	struct network_info *info = network->info;
> @@ -1966,17 +2033,32 @@ static void network_update_hotspot(struct network *network, void *user_data)
>   	match_hotspot_network(info, network);
>   }
>   
> -static void match_known_network(struct station *station, void *user_data)
> +static void match_known_network(struct station *station, void *user_data,
> +				bool new)
>   {
>   	struct network_info *info = user_data;
>   	struct network *network;
>   
>   	if (!info->is_hotspot) {
> +		struct l_settings *settings;
>   		network = station_network_find(station, info->ssid, info->type);
>   		if (!network)
>   			return;
>   
> -		network_set_info(network, info);
> +		/* New networks should load settings upon connecting */
> +		if (new) {
> +			network_set_info(network, info);
> +			return;
> +		}

Don't you want to update the settings even for the EVENT_ADDED case?  Something 
like this might happen for example:

- User issues Network.Connect() for an unknown network
- At the same time, the network file is written to /var/lib/iwd

Connect proceeds to win the race, with the EVENT_ADDED event coming in shortly 
after.  Don't you want any additional settings (say DHCP hostname or whatever) 
to be used when the network succeeds in associating?

> +
> +		settings = network_info_open_settings(info);
> +
> +		if (!settings || !network_settings_update(network, settings)) {
> +			l_warn("Failed to apply new/updated settings (%s)",
> +					info->ssid);
> +			l_settings_free(settings);
> +		}
> +
>   		return;
>   	}
>   

<snip>

> +	case KNOWN_NETWORKS_EVENT_UPDATED:
> +		station_foreach(update_known_network, (void *) info);
> +
> +		/* Syncs frequencies of updated known network */
> +		known_network_frequency_sync((struct network_info *)info);
> +		break;

Hmm, why do this on the update?

>   	case KNOWN_NETWORKS_EVENT_REMOVED:
>   		station_foreach(emit_known_network_removed, (void *) info);
>   		break;

Regards,
-Denis
