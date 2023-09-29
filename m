Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757B51A71F
	for <iwd@lists.linux.dev>; Fri, 29 Sep 2023 15:37:16 +0000 (UTC)
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6c4e30a3604so5901783a34.2
        for <iwd@lists.linux.dev>; Fri, 29 Sep 2023 08:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696001835; x=1696606635; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aye7kLn9ARfMv7LnI60YX9PX/0CO5EnpkZVyUq2BgS8=;
        b=TVLl6voErR0xl3tRQSale8xK0fokoNeEwBi1kPswsBzd6c3vvhcHMMtk6sIwYIJgOd
         aGD2Ki2SSP/P7nkC/g25o79ZMZOn2IKO38fjfTywvXezUWFv8O7Dp4UvV/Cq/8y2MRRq
         oJyImMtO+vqRJcJ3da+CNKAaRrr396wy/ZmD9aT5OfKOveBWV2WIIUCLBMRg2C30CRMI
         oOm9vPPeI6WUGyB9l2QBgUWAFeYWJaj9yEtGBoWnf6LItL3F9kbPXgbJX6Qmg4thqtka
         2Hisq/hGzfeZSRfF1YwWeY9285fd01thAgDCRv79waG2pLyvcIQDFKBeg+6gyC29F4aB
         /AzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696001835; x=1696606635;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aye7kLn9ARfMv7LnI60YX9PX/0CO5EnpkZVyUq2BgS8=;
        b=cl/6XpbaZvwFF+0TtCU7LvqL/Q4xkOrVT+69YSk+YGQxqbX47VhteqGp27EnqT/8KP
         Vp6jo1LCpbLplfKipxCONShr/8JWZsTWtDZGOZPayynYcJVhDGgvvq0Yn7UmYWn3blSx
         g28QEKhayhKU8pyC25J3YExE103d/FtLmp1i/hZ5dRo5NOdXw5CyNxz73DbtbxGkPcVO
         asQ/a03HJLEbog3IdAnYCaF7s4ILC+m5Gs+byZRKD8RKPINW2GPORRxXeGVNNfk/RskZ
         Ku56um8ck/fZondbjKmLYUzhvN3AncqwUzGvGgYsIFsdZgmnlYAS+MP/L4Wmb5aZwJWY
         DkBg==
X-Gm-Message-State: AOJu0YzozrIKbRkVAEpg6huwQNDybzmFNS4sWBeAXuiyfNFrHiHLAdMe
	OM1ITPIcK/pBe0JQl0aTL0KD/mlGx/Q=
X-Google-Smtp-Source: AGHT+IE2vHQs7NsT1FlEm8uKDCmAgxk/3aWrEx3xPePCBn5TS3ZIQ6OTSxkZh8hNEvcZw3Yp+eLybQ==
X-Received: by 2002:a05:6830:8e:b0:6bf:df:66d5 with SMTP id a14-20020a056830008e00b006bf00df66d5mr4521011oto.35.1696001835473;
        Fri, 29 Sep 2023 08:37:15 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id f128-20020a4a5886000000b0057bb326cad4sm2239119oob.33.2023.09.29.08.37.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Sep 2023 08:37:14 -0700 (PDT)
Message-ID: <0e6036b3-09a1-ef34-85e3-dcd86a041b1e@gmail.com>
Date: Fri, 29 Sep 2023 10:37:13 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 3/4] station: support user-disabled bands
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20230928124128.3793788-1-prestwoj@gmail.com>
 <20230928124128.3793788-3-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20230928124128.3793788-3-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 9/28/23 07:41, James Prestwood wrote:
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
>   src/station.c | 120 ++++++++++++++++++++++++++++++++++++++++----------
>   1 file changed, 97 insertions(+), 23 deletions(-)
> 
> v2:
>   * Compute an allowed band mask in station_init rather than separate bools
>   * Let all scan paths include frequencies which may be disabled but
>     supported. This opens up the potential for 6ghz to be unlocked, and if
>     a frequency is disabled the kernel filters it anyways.
>   * Optimized the dbus scan subset creation. Clone the 5/6ghz sets based
>     on supported freqs rather than foreach.
>   * Added a warning after computing the subsets if none were created
> 

I went ahead and applied this and 4/4.  Couple of comments:

>   
> +static struct scan_freq_set *station_get_allowed_freqs(struct station *station)
> +{
> +	const struct scan_freq_set *supported =
> +				wiphy_get_supported_freqs(station->wiphy);
> +	struct scan_freq_set *allowed = scan_freq_set_clone(supported,
> +							allowed_bands);
> +
> +	if (scan_freq_set_isempty(allowed)) {
> +		scan_freq_set_free(allowed);
> +		allowed = NULL;
> +	}
> +
> +	return allowed;
> +}
> +

This is almost identical to the function in scan.c.  Maybe consider using a 
shared implementation?

> @@ -1440,9 +1457,14 @@ static int station_quick_scan_trigger(struct station *station)
>   			known_6ghz)
>   		return -ENOTSUP;
>   
> -	if (!wiphy_constrain_freq_set(station->wiphy, known_freq_set)) {
> +	allowed = station_get_allowed_freqs(station);
> +	if (L_WARN_ON(!allowed))
> +		return -ENOTSUP;

You have a lot of this handling sprinkled about.  I think this is fine, since 
someone can still disable the single band their hardware supports or something. 
But maybe its worth checking the really bizarre cases and fail initialization early?

Somewhere in station_init or scan_init?  Sanitize that at least a single band is 
enabled, or at least one of 2.4/5G if 6G is also enabled?

Regards,
-Denis

