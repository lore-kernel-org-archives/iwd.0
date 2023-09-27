Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091FC48EBE
	for <iwd@lists.linux.dev>; Wed, 27 Sep 2023 20:29:51 +0000 (UTC)
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-57b9231e91dso5372854eaf.2
        for <iwd@lists.linux.dev>; Wed, 27 Sep 2023 13:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695846591; x=1696451391; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3MsSFNnFPZNJy1mmYNqIsCvAqk5BTb/ZJKxggz/KdMc=;
        b=nrR6X/zmlgDCYfT3mnjadwkG4e/ekQ8smnv/jgRb6CbvgtAwZ3bjgkdAZdygaH0Vmy
         bj5D6GCkbtaYKV/wWzZiA76CjfMlYKwTUUS4FHmE3RuwX81XuiL3DItrMJ4ZBZdqxk08
         Jd5o4eEFxq+64QHUXAQQ21iUy85IVo65l6kdtmdNxlGTqZu2WbOKQ9NjupHcxcB+4c69
         b+57hnjoqqT5Y+t3bBIx3lVHxX+H7nLAv0TXBwghUOTQ38uxkidoyYZFSBHe3ervPfRi
         SFFdtMlaJiYhCSJWJMltWSEm1C0I5fIEGYpDOx0j6EPu42H80AnobErtQV40MOh5y5mP
         FYIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695846591; x=1696451391;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3MsSFNnFPZNJy1mmYNqIsCvAqk5BTb/ZJKxggz/KdMc=;
        b=vAnNh34UNJ3JNFpIlSKLsZU/W0UfurVPg5CVrOZN84hTFK5jhsR4M2PgFdbBaHrjbe
         gGbrCxw0csO44pa15ktDDEvAuyYZsqVxaAWsb9CbKO5xZ6a/pybl5A8t+JbdYBq0aNEN
         iDECN/cnezkZMCZOl5ktsDc3G9Y8uNzqCWBc7nu0jvgIByfKHCIJgEPXK/FWX3ynlOYo
         WOEYJ1q7QS0bNqj5GZTzZQh7e+rwMVCdjAyai+kwYPETE2aPfhxSYLhKfQCnlMXmuJhM
         hWOVwipfQpRiFpPCQ43bux0DbEYY3Sli30rWGy+ymAwGaXviN1d+3DSURNGDwM3v5sJA
         e82Q==
X-Gm-Message-State: AOJu0YwC4dlPZDJO7R9wJfZPbYZ3Dro0no4mXfSw9uqQcdxiAbBAElSe
	CnZeQpfE6TJLmur2/koak/M=
X-Google-Smtp-Source: AGHT+IEJ+FFdSvc/sMPQ49XbZSmuq24kEPY7pnViqsS4+I9LAFN7M8nZJO+VXfG3PNEyYrAHl/JWvQ==
X-Received: by 2002:a4a:345b:0:b0:57b:3424:147f with SMTP id n27-20020a4a345b000000b0057b3424147fmr3418917oof.9.1695846590926;
        Wed, 27 Sep 2023 13:29:50 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id r123-20020a4a4e81000000b0057aef3cab33sm2931219ooa.21.2023.09.27.13.29.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 13:29:50 -0700 (PDT)
Message-ID: <0e53f804-594a-fba3-9552-0f6be0ae4128@gmail.com>
Date: Wed, 27 Sep 2023 15:29:49 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 6/8] scan: filter user-disabled bands for periodic scans.
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20230925185422.2242494-1-prestwoj@gmail.com>
 <20230925185422.2242494-6-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20230925185422.2242494-6-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 9/25/23 13:54, James Prestwood wrote:
> To support user-disabled bands periodic scans need to specify a
> frequency list filtered by any bands that are disabled. This was
> needed in scan.c since periodic scans don't provide a frequency
> list in the scan request.
> 
> If no bands are disabled the allowed freqs API should still
> result in the same scan behavior as if a frequency list is left
> out i.e. IWD just filters the frequencies as opposed to the kernel.
> ---
>   src/scan.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 46 insertions(+)
> 
> diff --git a/src/scan.c b/src/scan.c
> index 9b1cc30a..84cf0f38 100644
> --- a/src/scan.c
> +++ b/src/scan.c
> @@ -990,9 +990,53 @@ static void scan_periodic_destroy(void *user_data)
>   	sc->sp.id = 0;
>   }
>   
> +static struct scan_freq_set *scan_periodic_get_freqs(struct scan_context *sc)
> +{
> +	struct scan_freq_set *allowed;
> +	struct scan_freq_set *band_6g;
> +	const struct scan_freq_set *supported =
> +					wiphy_get_supported_freqs(sc->wiphy);
> +	uint32_t band_mask = 0;
> +
> +	if (RANK_2G_FACTOR)
> +		band_mask |= BAND_FREQ_2_4_GHZ;
> +	if (RANK_5G_FACTOR)
> +		band_mask |= BAND_FREQ_5_GHZ;
> +

If we're letting the kernel filter allowed frequencies, should this be just a 
clone of supported_freqs with band_mask set appropriately?  Might make the logic 
here a bit simpler.

> +	allowed = wiphy_get_allowed_freqs(sc->wiphy, band_mask);
> +	if (!RANK_6G_FACTOR)
> +		return allowed;
> +
> +	/* 2.4 and 5Ghz are disabled, this is not a workable configuration */
> +	if (!allowed)
> +		return NULL;
> +
> +	/*
> +	 * 6GHz is special because initially its disabled until the regdom is
> +	 * established so (unless user disabled) we should always include those
> +	 * frequencies for periodic scans.
> +	 */
> +	band_6g = scan_freq_set_clone(supported, BAND_FREQ_6_GHZ);
> +	scan_freq_set_merge(allowed, band_6g);
> +	scan_freq_set_free(band_6g);
> +
> +	return allowed;
> +}
> +

Regards,
-Denis

