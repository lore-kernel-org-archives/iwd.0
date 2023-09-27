Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC8830FA0
	for <iwd@lists.linux.dev>; Wed, 27 Sep 2023 20:49:10 +0000 (UTC)
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6c09f1f4610so6027596a34.0
        for <iwd@lists.linux.dev>; Wed, 27 Sep 2023 13:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695847749; x=1696452549; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fh321gMJjLeoavJl95Ss2GB0AYJPxmTN0x7A6V4MSVs=;
        b=A6dMRmOirJVRsPzYv/cicaEEJ6WhUcwyc9Be+w2uDiyx4Wp0wCvbCQbvnhck+b8aOc
         12iC02L7WeklItQ65jjRK7G/ajF1YQTTeazRPE+R4QQBhSlJI8lRepy+UiOBoXGBbw3R
         6o4ydcI0YTdM2IpakRKRL66BOPZirbkBjtnG6gZOtUzx6TlHZTIsTugSxeqJoNScwkbg
         JO3VzkUVo4iBOzvl/ylPqb568eTuX2DyvAn+hNx7uUghFPZ4rYewgW8WRdIZ1YARLmV1
         rbCPdddFQ7ojwdjfP6s12Ce7CxUjrBSqs0S8WmnokG+zDh5PG/QnJgXFiRUUHkgZYd40
         e2rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695847749; x=1696452549;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fh321gMJjLeoavJl95Ss2GB0AYJPxmTN0x7A6V4MSVs=;
        b=jnwAPf6ICQy8C6aH2Rvvr7/WExBwm1YbZEAGu/Gz+M0EDfHV7h/+q9L3N6CAQhoV8Y
         9BgRed3hDdK4wpDQ5190A618kpG2zDMKn1ZykT6nVLDW1wo9WkbTRVVa9nnaPeoaXIp9
         ENHfHAFLB6azQ2Mg4XrFOXsNz/ne2HQ2i8uteeHZTzXiu/dWCywsV/z6vJ06kHXrKi7h
         eUo4eHjOyVkdCU2TM+Rbxm+KJgiBMtD4WBWH1ail1hsf0FXu66En5a4Hot9W3+pMD9f1
         U7CEUtXkmChQTh/ulVtifvpVq1JUFw5T/8vAVy8LEPqUZ7aM20vwMw1vqyg0mHEZ07ns
         ksrg==
X-Gm-Message-State: AOJu0Yyw04SHAeL8gExZ3XVzH16tn7r5dlPDCRzMX0XtH8Ij5sGYJJx7
	W+gJvKU/WL32VBruutw0Tuc=
X-Google-Smtp-Source: AGHT+IECfT+MbBezpoTnF0i9DCNR6fQn9XBVA+BJ0dXLbGk+1EBIMuuFrKsQtIJqNDC9usd9A8QNnw==
X-Received: by 2002:a05:6830:1651:b0:6c5:233:fc28 with SMTP id h17-20020a056830165100b006c50233fc28mr3160018otr.33.1695847749498;
        Wed, 27 Sep 2023 13:49:09 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id r195-20020a4a37cc000000b0057346742d82sm951254oor.6.2023.09.27.13.49.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 13:49:09 -0700 (PDT)
Message-ID: <5c617a95-af44-5c20-a111-77b15d3a6439@gmail.com>
Date: Wed, 27 Sep 2023 15:49:08 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 7/8] station: support user-disabled bands
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20230925185422.2242494-1-prestwoj@gmail.com>
 <20230925185422.2242494-7-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20230925185422.2242494-7-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 9/25/23 13:54, James Prestwood wrote:
> This adds support to allow users to disable entire bands, preventing
> scanning and connecting on those frequencies. If the
> [Rank].BandModifier* options are set to 0.0 it will imply those
> bands should not be used for scanning, connecting or roaming. This
> now applies to autoconnect, quick, hidden, roam, and dbus scans.
> 
> This is a station only feature meaning other modules like RRM, DPP,
> WSC or P2P may still utilize those bands. Trying to limit bands in
> those modules may sometimes conflict with the spec which is why it
> was not added there. In addition modules like DPP/WSC are only used
> in limited capacity for connecting so there is little benefit gained
> to disallowing those bands.
> ---
>   src/station.c | 134 +++++++++++++++++++++++++++++++++++++++++---------
>   1 file changed, 110 insertions(+), 24 deletions(-)
> 

<snip>

> @@ -1326,6 +1329,20 @@ static bool station_needs_hidden_network_scan(struct station *station)
>   	return !l_queue_isempty(station->hidden_bss_list_sorted);
>   }
>   
> +static struct scan_freq_set *station_get_allowed_freqs(struct station *station)
> +{
> +	uint32_t band_mask = 0;
> +
> +	if (!band_2_4ghz_disabled)
> +		band_mask |= BAND_FREQ_2_4_GHZ;
> +	if (!band_5ghz_disabled)
> +		band_mask |= BAND_FREQ_5_GHZ;
> +	if (!band_6ghz_disabled)
> +		band_mask |= BAND_FREQ_6_GHZ;

You might as well compute the band_mask in station_init directly.

> +
> +	return wiphy_get_allowed_freqs(station->wiphy, band_mask);

Same question here as the previous patch, should this be supported instead of 
allowed?

> +}
> +
>   static uint32_t station_scan_trigger(struct station *station,
>   					struct scan_freq_set *freqs,
>   					scan_trigger_func_t triggered,
> @@ -1411,6 +1428,7 @@ static void station_quick_scan_destroy(void *userdata)
>   static int station_quick_scan_trigger(struct station *station)
>   {
>   	_auto_(scan_freq_set_free) struct scan_freq_set *known_freq_set = NULL;
> +	_auto_(scan_freq_set_free) struct scan_freq_set *allowed = NULL;
>   	bool known_6ghz;
>   
>   	if (wiphy_regdom_is_updating(station->wiphy)) {
> @@ -1440,9 +1458,14 @@ static int station_quick_scan_trigger(struct station *station)
>   			known_6ghz)
>   		return -ENOTSUP;
>   
> -	if (!wiphy_constrain_freq_set(station->wiphy, known_freq_set)) {
> +	allowed = station_get_allowed_freqs(station);
> +	if (L_WARN_ON(!allowed))
> +		return -ENOTSUP;
> +
> +	scan_freq_set_constrain(known_freq_set, allowed);

This looks fine, but does bring up the question.  If we're now enabling 6G 
frequencies to be put into scan requests (even if they're not allowed now, in 
hope that regdom allows them after the split scan) should this logic be using 
supported frequencies and not allowed ones?

> +
> +	if (scan_freq_set_isempty(known_freq_set))
>   		return -ENOTSUP;
> -	}
>   
>   	station->quick_scan_id = station_scan_trigger(station,
>   						known_freq_set,
> @@ -2656,6 +2679,11 @@ static int station_roam_scan(struct station *station,
>   				struct scan_freq_set *freq_set)
>   {
>   	struct scan_parameters params = { .freqs = freq_set, .flush = true };
> +	_auto_(scan_freq_set_free) struct scan_freq_set *allowed =
> +					station_get_allowed_freqs(station);
> +
> +	if (L_WARN_ON(!allowed))
> +		return -ENOTSUP;
>   
>   	l_debug("ifindex: %u", netdev_get_ifindex(station->netdev));
>   
> @@ -2666,8 +2694,14 @@ static int station_roam_scan(struct station *station,
>   		params.ssid_len = strlen(ssid);
>   	}
>   
> -	if (!freq_set)
> +	if (!freq_set) {
>   		station->roam_scan_full = true;
> +		params.freqs = allowed;
> +	} else
> +		scan_freq_set_constrain(freq_set, allowed);
> +

Same as above?

> +	if (L_WARN_ON(scan_freq_set_isempty(params.freqs)))
> +		return -ENOTSUP;
>   
>   	station->roam_scan_id =
>   		scan_active_full(netdev_get_wdev_id(station->netdev), &params,

<snip>

> @@ -4268,38 +4308,77 @@ int station_hide_network(struct station *station, struct network *network)
>   	return 0;
>   }
>   
> -static void station_add_one_freq(uint32_t freq, void *user_data)
> +static void station_add_6ghz_freq(uint32_t freq, void *user_data)
>   {
> -	struct station *station = user_data;
> +	struct scan_freq_set *set = user_data;
>   
> -	if (freq > 3000)
> -		scan_freq_set_add(station->scan_freqs_order[1], freq);
> -	else if (!scan_freq_set_contains(station->scan_freqs_order[0], freq))
> -		scan_freq_set_add(station->scan_freqs_order[2], freq);
> +	if (freq > 5935)
> +		scan_freq_set_add(set, freq);
> +}
> +
> +static void station_add_5ghz_freq(uint32_t freq, void *user_data)
> +{
> +	struct scan_freq_set *set = user_data;
> +
> +	if (freq > 3000 && freq < 5935)
> +		scan_freq_set_add(set, freq);
> +}
> +
> +static void station_add_2_4ghz_freq(uint32_t freq, void *user_data)
> +{
> +	struct scan_freq_set *set = user_data;
> +
> +	/* exclude social channels added in initial scan request */
> +	if (freq < 3000 && freq != 2412 && freq != 2437 && freq != 2462)
> +		scan_freq_set_add(set, freq);
>   }
>   
>   static void station_fill_scan_freq_subsets(struct station *station)
>   {
> -	const struct scan_freq_set *supported =
> -		wiphy_get_supported_freqs(station->wiphy);
> +	_auto_(scan_freq_set_free) struct scan_freq_set *allowed =
> +					station_get_allowed_freqs(station);
> +	unsigned int subset_idx = 0;
>   
> +	if (L_WARN_ON(!allowed))
> +		return;
>   	/*
>   	 * Scan the 2.4GHz "social channels" first, 5GHz second, if supported,
>   	 * all other 2.4GHz channels last.  To be refined as needed.
>   	 */
> -	station->scan_freqs_order[0] = scan_freq_set_new();
> -	scan_freq_set_add(station->scan_freqs_order[0], 2412);
> -	scan_freq_set_add(station->scan_freqs_order[0], 2437);
> -	scan_freq_set_add(station->scan_freqs_order[0], 2462);
> -
> -	station->scan_freqs_order[1] = scan_freq_set_new();
> -	station->scan_freqs_order[2] = scan_freq_set_new();
> -	scan_freq_set_foreach(supported, station_add_one_freq, station);
> -
> -	if (scan_freq_set_isempty(station->scan_freqs_order[1])) {
> -		scan_freq_set_free(station->scan_freqs_order[1]);
> -		station->scan_freqs_order[1] = station->scan_freqs_order[2];
> -		station->scan_freqs_order[2] = NULL;
> +	if (!band_2_4ghz_disabled) {
> +		station->scan_freqs_order[subset_idx] = scan_freq_set_new();
> +		scan_freq_set_add(station->scan_freqs_order[subset_idx], 2412);
> +		scan_freq_set_add(station->scan_freqs_order[subset_idx], 2437);
> +		scan_freq_set_add(station->scan_freqs_order[subset_idx], 2462);
> +		subset_idx++;
> +	}
> +
> +	/*
> +	 * TODO: It may might sense to split up 5 and 6ghz into separate subsets
> +	 *       since the channel set is so large.
> +	 */
> +	if (!band_5ghz_disabled || !band_6ghz_disabled) {
> +		struct scan_freq_set *set = scan_freq_set_new();
> +
> +		if (!band_5ghz_disabled)
> +			scan_freq_set_foreach(allowed,
> +						station_add_5ghz_freq, set);
> +		if (!band_6ghz_disabled)
> +			scan_freq_set_foreach(allowed,
> +						station_add_6ghz_freq, set);

Is there a better way to generate 5G/6G freqs than scan_freq_set_foreach?  Isn't 
this wiphy_get_allowed_freqs() with a relevant band_mask?

> +
> +		/* 5/6ghz didn't add any frequencies */
> +		if (scan_freq_set_isempty(set)) {
> +			scan_freq_set_free(set);
> +		} else
> +			station->scan_freqs_order[subset_idx++] = set;
> +	}
> +
> +	/* Add remaining 2.4ghz channels to subset */
> +	if (!band_2_4ghz_disabled) {
> +		station->scan_freqs_order[subset_idx] = scan_freq_set_new();
> +		scan_freq_set_foreach(allowed, station_add_2_4ghz_freq,
> +					station->scan_freqs_order[subset_idx]);
>   	}
>   }
>   

Regards,
-Denis
