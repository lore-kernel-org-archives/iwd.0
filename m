Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDE0BA24
	for <iwd@lists.linux.dev>; Wed, 14 Dec 2022 22:18:25 +0000 (UTC)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-14455716674so18603953fac.7
        for <iwd@lists.linux.dev>; Wed, 14 Dec 2022 14:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c2UGpNayb5uzJn5Ey4UN496KFxPVmTxoQMKxdxacFyE=;
        b=jGaiQq1+IWjwhUWutqJgbqLXRfaZgkjmNMWM/4uoyT2kLm5lNW8VURvbni9GK8fAuK
         izzA+0CVEQ/T8wZKvsXCqyFDiAidnLz+3Ou7cPXYXi1ax1j3Ovo/+zV+XIpa0oXybASd
         +rEJa5h4GVXYN7idrUrgjV5sY7WgEEsMRJf7CKPkOuTD9L9AYFCfZlg0961bEA13natf
         KRdMP2FV9Myacv0nRZ0ZpcCyTkGM5GDpJuFrsTJl/e6Whe8Aubw/j1rjAWa9JQhjVCm6
         GW5e/7ai0DdFBHIJVeWuhb6kkwcoTquXX3Wj4rWy1ScHcruViTz/ihRM8YmqcX49TlHb
         BCpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c2UGpNayb5uzJn5Ey4UN496KFxPVmTxoQMKxdxacFyE=;
        b=xayyGfjh9xMMalkiXrWhiyqm94nlVyF5J1T+szYIWgZZ8F/rwiR9fnEWLtCsu1nyMg
         NZJeVhzw/yunZwLjR5bpGf/avFPY47QX+iNmIuPYE3c+rwo8ZHkOBsZSCZt71p4NvE1e
         ZXIncPeGRh+q7qVkki8uAFIa/hPMneW5zVVsrcPxB9zvm1S6ryXy7c9DJu99NJWFAfse
         QuIRjQYKkIj4EigcyVHbwW8V99D2wChw5GSFXY7HTFPA+TxJQbz3R+yB4S3gICWko87Q
         1yGCdIqBf7/7oMo8weeAJaiRdkisybchk+/PlzimmDPBnYA2+bU5XtdHfIYC9SdP4WkS
         YBOA==
X-Gm-Message-State: ANoB5pnnOyMwN7l4A7U6ICB8n43UCYNkN4PIaBIPoRapI3R3JWpQWKxN
	TimtW8m3TDzfOY09INEWLH7yQWkc3go=
X-Google-Smtp-Source: AA0mqf4A7ciLZDV+nNfbQXocxaLwnXf1rH58CTSNxQNElS7L9v5W8rZk0dX9BYV844VYrfBGzVllMg==
X-Received: by 2002:a05:6871:4218:b0:148:b4a:5285 with SMTP id li24-20020a056871421800b001480b4a5285mr13581818oab.12.1671056304460;
        Wed, 14 Dec 2022 14:18:24 -0800 (PST)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id q10-20020a9d4b0a000000b0066f09567827sm2829914otf.78.2022.12.14.14.18.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 14:18:23 -0800 (PST)
Message-ID: <b000a05e-05f0-3c51-9a85-5294747519f8@gmail.com>
Date: Wed, 14 Dec 2022 16:11:46 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 3/7] wiphy: parse/store frequency info in band object
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20221213203624.1423277-1-prestwoj@gmail.com>
 <20221213203624.1423277-3-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20221213203624.1423277-3-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 12/13/22 14:36, James Prestwood wrote:
> As additional frequency info is needed it doesn't make sense to
> store a full list of frequencies for every attribute (i.e.
> supported, disabled, no-IR, etc).
> 
> This changes nl80211_parse_supported_frequencies to take a uint16_t
> array where each index corresponds to a channel, and each value
> can be filled with flag bits to signal any limitations on that
> frequency.
> 
> wiphy.c then had to be updated to use this rather than the existing
> scan_freq_set lists. This, as-is, will break anything using
> wiphy_get_disabled_freqs().
> ---
>   src/nl80211util.c |  19 +++++----
>   src/nl80211util.h |   3 +-
>   src/wiphy.c       | 105 ++++++++++++++++++++++++++++++++++++++++++----
>   3 files changed, 109 insertions(+), 18 deletions(-)
> 
> diff --git a/src/nl80211util.c b/src/nl80211util.c
> index da36d936..a2cd882d 100644
> --- a/src/nl80211util.c
> +++ b/src/nl80211util.c
> @@ -501,20 +501,20 @@ int nl80211_parse_chandef(struct l_genl_msg *msg, struct band_chandef *out)
>   }
>   
>   int nl80211_parse_supported_frequencies(struct l_genl_attr *band_freqs,
> -					struct scan_freq_set *supported_list,
> -					struct scan_freq_set *disabled_list)
> +					uint16_t *list, size_t num_channels)

Hmm, I wonder if you can simply build the supported_list at this time as well?

>   {
>   	uint16_t type, len;
>   	const void *data;
>   	struct l_genl_attr attr;
>   	struct l_genl_attr nested;
> +	uint8_t channel;
>   
>   	if (!l_genl_attr_recurse(band_freqs, &nested))
>   		return -EBADMSG;
>   
>   	while (l_genl_attr_next(&nested, NULL, NULL, NULL)) {
>   		uint32_t freq = 0;
> -		bool disabled = false;
> +		uint16_t flags = BAND_FREQ_ATTR_SUPPORTED;

That way you could probably not even need this flag.  Also I would use a packed 
bitfield struct for this instead of uint16_t.

>   
>   		if (!l_genl_attr_recurse(&nested, &attr))
>   			continue;
> @@ -525,7 +525,10 @@ int nl80211_parse_supported_frequencies(struct l_genl_attr *band_freqs,
>   				freq = *((uint32_t *) data);
>   				break;
>   			case NL80211_FREQUENCY_ATTR_DISABLED:
> -				disabled = true;
> +				flags |= BAND_FREQ_ATTR_DISABLED;
> +				break;
> +			case NL80211_FREQUENCY_ATTR_NO_IR:
> +				flags |= BAND_FREQ_ATTR_NO_IR;
>   				break;
>   			}
>   		}
> @@ -533,11 +536,11 @@ int nl80211_parse_supported_frequencies(struct l_genl_attr *band_freqs,
>   		if (!freq)
>   			continue;
>   
> -		if (supported_list)
> -			scan_freq_set_add(supported_list, freq);
> +		channel = band_freq_to_channel(freq, NULL);
> +		if (!channel || channel > num_channels)
> +			continue;

Hmm, this probably deserves a WARN_ON then.

>   
> -		if (disabled && disabled_list)
> -			scan_freq_set_add(disabled_list, freq);
> +		list[channel] = flags;
>   	}
>   
>   	return 0;

<snip>

> @@ -952,7 +977,7 @@ int wiphy_estimate_data_rate(struct wiphy *wiphy,
>   
>   bool wiphy_regdom_is_updating(struct wiphy *wiphy)
>   {
> -	return wiphy->pending_freqs != NULL;
> +	return wiphy->dump_id || (!wiphy->self_managed && wiphy_dump_id);
>   }
>   

Maybe this belongs in a separate patch?

> @@ -1980,7 +2011,28 @@ static void wiphy_dump_callback(struct l_genl_msg *msg,
>   	if (L_WARN_ON(!wiphy))
>   		return;
>   
> -	while (l_genl_attr_next(&bands, NULL, NULL, NULL)) {
> +	/* Unregistered means the wiphy is blacklisted, don't bother parsing */
> +	if (!wiphy->registered)
> +		return;

Probably should be a separate commit as well.

> +
> +	while (l_genl_attr_next(&bands, &type, NULL, NULL)) {
> +		switch (type) {
> +		case NL80211_BAND_2GHZ:
> +			band = wiphy->band_2g;
> +			break;
> +		case NL80211_BAND_5GHZ:
> +			band = wiphy->band_5g;
> +			break;
> +		case NL80211_BAND_6GHZ:
> +			band = wiphy->band_6g;
> +			break;
> +		default:
> +			continue;
> +		}
> +
> +		if (L_WARN_ON(!band))
> +			continue;
> +
>   		if (!l_genl_attr_recurse(&bands, &attr))
>   			return;
>   
> @@ -1988,8 +2040,14 @@ static void wiphy_dump_callback(struct l_genl_msg *msg,
>   			if (type != NL80211_BAND_ATTR_FREQS)
>   				continue;
>   
> -			nl80211_parse_supported_frequencies(&attr, NULL,
> -							wiphy->pending_freqs);
> +			/*
> +			 * Just write over the old list for each frequency. In
> +			 * theory no new frequencies should be added so there
> +			 * should never be any stale values.
> +			 */
> +			nl80211_parse_supported_frequencies(&attr,
> +							band->frequencies,
> +							band->freqs_len);
>   		}
>   	}
>   }
> @@ -2178,6 +2236,36 @@ static void wiphy_get_reg_domain(struct wiphy *wiphy)
>   	}
>   }
>   
> +static void setup_supported_freqs(struct wiphy *wiphy)
> +{
> +	struct band *bands[3] = { wiphy->band_2g,
> +					wiphy->band_5g, wiphy->band_6g };
> +	unsigned int b;
> +	unsigned int i;
> +
> +	wiphy->supported_freqs = scan_freq_set_new();
> +
> +	for (b = 0; b < L_ARRAY_SIZE(bands); b++) {
> +		struct band *band = bands[b];
> +
> +		if (!band)
> +			continue;
> +
> +		for (i = 0; i < band->freqs_len; i++) {
> +			uint32_t freq;
> +
> +			if (!(band->frequencies[i] & BAND_FREQ_ATTR_SUPPORTED))
> +				continue;
> +
> +			freq = band_channel_to_freq(i, band->freq);
> +			if (!freq)
> +				continue;
> +
> +			scan_freq_set_add(wiphy->supported_freqs, freq);
> +		}
> +	}

If you mark the supported frequencies during 
nl80211_parse_supported_frequencies(), then this wouldn't be needed, right?

> +}
> +
>   void wiphy_create_complete(struct wiphy *wiphy)
>   {
>   	wiphy_register(wiphy);
> @@ -2193,6 +2281,7 @@ void wiphy_create_complete(struct wiphy *wiphy)
>   	wiphy_set_station_capability_bits(wiphy);
>   	wiphy_setup_rm_enabled_capabilities(wiphy);
>   	wiphy_get_reg_domain(wiphy);
> +	setup_supported_freqs(wiphy);

Or this

>   
>   	wiphy_print_basic_info(wiphy);
>   }

Regards,
-Denis
