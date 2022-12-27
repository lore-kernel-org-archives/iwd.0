Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F57963AD
	for <iwd@lists.linux.dev>; Tue, 27 Dec 2022 18:10:35 +0000 (UTC)
Received: by mail-oi1-f170.google.com with SMTP id e205so13006601oif.11
        for <iwd@lists.linux.dev>; Tue, 27 Dec 2022 10:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IA6RIbmelhF7r0Wb1XNgvYqIjVMDjb/05WlSgkMbka4=;
        b=ojnDZeVFS1f7a7IrU2UKInCtY5OzZC/yHQlrtO3AuZzYWTgzNqFic0ojuGDkZoOrHs
         z17TmLp1JRKAX585SFq0oeybV/lVkL12WzeBbtLlRnWYEsYvszgCM4qQIK9VrD5/hMcP
         Vcx8jwDQZwiPIIN4mmgzqatPmR9c2yjKaRg8Crd/J9rHEmm+hKU6sac4jIZR3lnRX8hn
         Ma+3nkAlj0wubCqqGcbToV8jhLpCTgZKg68rTpgrCM3UpbAK09BztD3riRhYnOCYA8en
         Eq0YgGPGqMcZ9fQffXnetaYGYp9M+KOSk4Zl0U98VZGA+zsjbeRcsUQNudvDps/gk/Lv
         jI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IA6RIbmelhF7r0Wb1XNgvYqIjVMDjb/05WlSgkMbka4=;
        b=3uqE5xNpw4m9SsAjKaQ/UH+kzGFSz3QbqUhefGWq9dkcsNQbr3NlFXc9r2O/RUoCJq
         0Ih0csqRukxn6kGYVIifqfDvWTVtbFbF8LZoPuibtylV0aAy9XhBfLuPwn/NMHmQlAzP
         1TZzi4lkTsX7K+rVPAsqXjrGWqu4I936EP8nCPsgdU8kS8Xh3ST0hCT4VrFCoOvzsEHx
         bh5ld7QmchQSEyNBAySTsCTUJrP6gcslPNkoPvU3r8/JHBdSGIIBkS+R0oqp4eAckVoT
         Z7W+bAjGSnR+veQrp3r7QdycqvxqywPXCGCv7GfSvT+qA9lT/eL4u1lTw9m5U9SEBMaq
         yH2A==
X-Gm-Message-State: AFqh2koWeKC59tV2LPtTIdl6WmUd0sJ/fbv4W1dY5fgWmQZIDkQV1tzM
	EC19wdDtFcRmGT8qSHzmC+8=
X-Google-Smtp-Source: AMrXdXs/CziNd6AaCjkZgKp9pPxU7lVa7N9xarKt7JTtwfBWW1lY1RMBpkHU7+we5qUyxFvW/+TOuQ==
X-Received: by 2002:a05:6808:17a6:b0:361:1112:2e3a with SMTP id bg38-20020a05680817a600b0036111122e3amr14208143oib.17.1672164634438;
        Tue, 27 Dec 2022 10:10:34 -0800 (PST)
Received: from [10.0.2.15] (216.106.68.145.reverse.socket.net. [216.106.68.145])
        by smtp.googlemail.com with ESMTPSA id bk10-20020a0568081a0a00b0035c422bb303sm6119874oib.19.2022.12.27.10.10.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Dec 2022 10:10:33 -0800 (PST)
Message-ID: <f1d0679d-a6df-f274-5c95-909a9a3ed383@gmail.com>
Date: Tue, 27 Dec 2022 12:07:59 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 05/10] band: add APIs to generate a chandef from frequency
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20221220214318.2041986-1-prestwoj@gmail.com>
 <20221220214318.2041986-5-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20221220214318.2041986-5-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 12/20/22 15:43, James Prestwood wrote:
> For AP mode its convenient for IWD to choose an appropriate
> channel definition rather than require the user provide very
> low level parameters such as channel width, center1 frequency
> etc. This adds two new APIs to generate a channel definition, one
> for legacy and one for HT.
> 
> The legacy API is very simple and chooses the first matching
> operating class using 20Mhz channel widths.
> 
> The HT API is a bit more complex since it has to take into account
> 40MHz and check any channel restrictions. If an operating class is
> found that is supported/not restricted it is marked as 'best' until
> a better one is found. In this case 'better' is a larger channel
> width. Since this is HT only 20mhz and 40mhz widths are checked.

I wonder if the HT one can be implemented using the noHT one?

> ---
>   src/band.c | 159 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>   src/band.h |   4 ++
>   2 files changed, 163 insertions(+)
> 
> diff --git a/src/band.c b/src/band.c
> index d89b2a90..b1e319d7 100644
> --- a/src/band.c
> +++ b/src/band.c
> @@ -1194,6 +1194,165 @@ int oci_from_chandef(const struct band_chandef *own, uint8_t oci[static 3])
>   	return -ENOENT;
>   }
>   
> +static bool freq_in_oper_class(uint32_t freq,
> +				const struct operating_class_info *info,
> +				enum band_freq *out_band)
> +{
> +	uint8_t channel;
> +	enum band_freq band;
> +
> +	channel = band_freq_to_channel(freq, &band);
> +	if (!channel)
> +		return false;

You already call band_freq_to_channel right at the top of band_freq_to_chandef 
(but not band_freq_to_ht_chandef?).  Not really a big deal, but why continue 
calling it inside this function which is being called in a loop?  You already 
know the channel and the band...

> +
> +	switch (band) {
> +	case BAND_FREQ_2_4_GHZ:
> +		if (info->starting_frequency > 5000)
> +			return false;
> +		break;
> +	case BAND_FREQ_5_GHZ:
> +		if (info->starting_frequency < 5000 ||
> +				info->starting_frequency > 5950)
> +			return false;
> +		break;
> +	case BAND_FREQ_6_GHZ:
> +		if (info->starting_frequency < 5900)
> +			return false;
> +		break;
> +	}

So you don't trust band_freq_to_channel?

Also, I'd really like to isolate 'magic frequency numbers' use as much as 
possible.  Ideally contain this in band_freq_to_channel and band_channel_to_freq 
only.  And even then maybe we should look into whether we can rework 
band_channel_to_freq to use the e4 table.

If there's a chance that band_freq_to_channel can produce a channel/band 
combination that isn't in e4, then perhaps we should simply add a 'band' member 
to 'struct operating_class_info'.  That way this could be sanity checked directly.

> +
> +	if (e4_channel_to_frequency(info, channel) < 0)
> +		return false;
> +
> +	if (out_band)
> +		*out_band = band;
> +
> +	return true;
> +}
> +
> +/* Find a legacy chandef for the frequency */
> +int band_freq_to_chandef(uint32_t freq, const struct band_freq_attrs *attr,
> +				struct band_chandef *chandef)
> +{
> +	enum band_freq band;
> +	uint8_t channel;
> +	unsigned int i;
> +	const struct operating_class_info *best = NULL;
> +
> +	channel = band_freq_to_channel(freq, &band);
> +	if (!channel)
> +		return -EINVAL;
> +
> +	if (attr->disabled || !attr->supported)
> +		return -EINVAL;
> +
> +	for (i = 0; i < L_ARRAY_SIZE(e4_operating_classes); i++) {
> +		const struct operating_class_info *info =
> +						&e4_operating_classes[i];
> +
> +		if (!freq_in_oper_class(freq, info, NULL))
> +			continue;
> +
> +		if (info->channel_spacing != 20)
> +			continue;

nit, but you might want to check this first.

> +
> +		best = info;
> +		break;
> +	}
> +
> +	if (!best)
> +		return -ENOENT;
> +
> +	chandef->frequency = freq;
> +	chandef->channel_width = BAND_CHANDEF_WIDTH_20NOHT;
> +
> +	return 0;
> +}
> +
> +/* Find an HT chandef for the frequency */
> +int band_freq_to_ht_chandef(uint32_t freq, const struct band_freq_attrs *attr,
> +				struct band_chandef *chandef)
> +{
> +	enum band_freq band;
> +	enum band_chandef_width width;
> +	unsigned int i;
> +	const struct operating_class_info *best = NULL;
> +
> +	if (attr->disabled || !attr->supported)
> +		return -EINVAL;
> +
> +	for (i = 0; i < L_ARRAY_SIZE(e4_operating_classes); i++) {
> +		const struct operating_class_info *info =
> +						&e4_operating_classes[i];
> +		enum band_chandef_width w;
> +
> +		if (!freq_in_oper_class(freq, info, &band))
> +			continue;
> +
> +		/* Any restrictions for this channel width? */
> +		switch (info->channel_spacing) {
> +		case 20:
> +			w = BAND_CHANDEF_WIDTH_20;
> +			break;
> +		case 40:
> +			w = BAND_CHANDEF_WIDTH_40;
> +
> +			/* 6GHz remove the upper/lower 40mhz channel concept */
> +			if (band == BAND_FREQ_6_GHZ)
> +				break;
> +
> +			if (info->flags & PRIMARY_CHANNEL_UPPER &&
> +						attr->no_ht40_plus)
> +				continue;
> +
> +			if (info->flags & PRIMARY_CHANNEL_LOWER &&
> +						attr->no_ht40_minus)
> +				continue;
> +
> +			break;
> +		default:
> +			continue;
> +		}
> +
> +		if (!best || best->channel_spacing < info->channel_spacing) {
> +			best = info;
> +			width = w;
> +		}
> +	}
> + > +	if (!best)
> +		return -ENOENT;

So why not limit the above loop to 40 mhz channel spacing, and if nothing is 
found, do something like

if (!best)
	return band_freq_to_chandef();

Or alternatively, pass in a parameter for maximum desired width.

> +
> +	chandef->frequency = freq;
> +	chandef->channel_width = width;
> +
> +	/*
> +	 * Choose a secondary channel frequency:
> +	 * - 20mhz no secondary
> +	 * - 40mhz we can base the selection off the channel flags, either
> +	 *   higher or lower.
> +	 */
> +	switch (width) {
> +	case BAND_CHANDEF_WIDTH_20:
> +		return 0;
> +	case BAND_CHANDEF_WIDTH_40:
> +		if (band == BAND_FREQ_6_GHZ)
> +			return 0;
> +
> +		if (best->flags & PRIMARY_CHANNEL_UPPER)
> +			chandef->center1_frequency = freq - 10;
> +		else
> +			chandef->center1_frequency = freq + 10;
> +
> +		return 0;
> +	default:
> +		/* Should never happen */
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>   uint8_t band_freq_to_channel(uint32_t freq, enum band_freq *out_band)
>   {
>   	uint32_t channel = 0;

Regards,
-Denis
