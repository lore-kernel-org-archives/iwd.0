Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2ADB1A586
	for <iwd@lists.linux.dev>; Wed, 27 Sep 2023 19:52:11 +0000 (UTC)
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-57ba5f05395so4682561eaf.1
        for <iwd@lists.linux.dev>; Wed, 27 Sep 2023 12:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695844331; x=1696449131; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0v7VSvH6qoot2+0rrosZyyY5GPrJDgAp7WMwn35W5dk=;
        b=FfPoxqdSIX091O1oxfNtUCXmIvVI1uWcgxrYmXGwPpUSuQX52hs8m1GJRFkCM3tIg9
         QSrTmTkJC/+sKNEcoZ9e63i991NMlV52G15CbZ/ALma3JMxPhdVBtVM6avIz1H+e9RPC
         u+B4sOQWKPf9+KWzc4KcYjnO42D8wzYQXvjR6fL8qSYNGiu8LEWszPm+Lmd4w1D+cAEg
         C1QGh9nj3xmUT2WkJ5blOpIQjP0CwcjvH/5Q49ksspKPfoXVzjf//Q6n4RmHqB5KDxDx
         /Ej9TCIAfn6M4IctDD4VQVa7a2rvJxOux2u0J5OyQLmR1vb+z7yowbNahM+j0ZyIsItr
         kw5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695844331; x=1696449131;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0v7VSvH6qoot2+0rrosZyyY5GPrJDgAp7WMwn35W5dk=;
        b=FUWZPuF/bVkENEndWqhy2v2sCq0so6TijeY21efREfIr+WLKMnIBaC/+B/ylFwBa/d
         tz3zwsUh1wfRUvgsDdJMSAuThE96gwHFM21/DQrlvzwe0ZKc8T0xs2RnDlpqKNFIUQBx
         dYKhNRdByiZcAnnRS73/A54vpF/s2D3AxQp2g/fr6YrmrepXSIb9TVYeL8U8zTgVLXac
         G26qvSOFZSgwK0NBZ40ieFm+TFwO2KATeOQUX/iqthOLxD75vxCJGTnNtRTfrWlMYRdN
         swwR7WWCheCFGjY6ztyzBitYCz44aUH/rHAHB5GEeEITbfYwUf6Sv8+MLNxuhRp/Z0Nl
         oUcg==
X-Gm-Message-State: AOJu0YzTlgpcztYI18QSF8taaZ6/WieQEhgoNDGsEv2CjSykiOl+cffk
	JJD9QTa/1EFQiuyCbiaqvWKNKM/wi+0=
X-Google-Smtp-Source: AGHT+IF9+Q86Fa7dsiNOR+m8e/VgR7HBWtIeIklnzX1x2GbGqABt8KP/jH2hJXObhyxF2/iWYxhfPA==
X-Received: by 2002:a4a:3019:0:b0:57b:92f2:1f64 with SMTP id q25-20020a4a3019000000b0057b92f21f64mr3091097oof.8.1695844330742;
        Wed, 27 Sep 2023 12:52:10 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id e201-20020a4a55d2000000b0057df0bcab46sm341986oob.45.2023.09.27.12.52.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 12:52:10 -0700 (PDT)
Message-ID: <58f3da34-a15c-bb91-92ad-a4e8a643ea9e@gmail.com>
Date: Wed, 27 Sep 2023 14:52:09 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5/8] scan: allow splitting of scans with defined
 frequencies
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20230925185422.2242494-1-prestwoj@gmail.com>
 <20230925185422.2242494-5-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20230925185422.2242494-5-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 9/25/23 13:54, James Prestwood wrote:
> Currently the only way a scan can be split is if the request does
> not specify any frequencies, implying the request should scan the
> entire spectrum. This allows the scan logic to issue an extra
> request if 6GHz becomes available during the 2.4 or 5GHz scans.
> This restriction was somewhat arbitrary and done to let periodic
> scans pick up 6GHz APs through a single scan request.
> 
> But now with the addition of allowing user-disabled bands
> periodic scans will need to specify a frequency list in case a
> given band has been disabled. This will break the scan splitting
> code which is why this prep work is being done.
> 
> The main difference now is the original scan frequencies are
> tracked with the scan request. The reason for this is so if a
> request comes in with a limited set of 6GHz frequences IWD won't
> end up scanning the full 6GHz spectrum later on.
> ---
>   src/scan.c | 53 ++++++++++++++++++++++-------------------------------
>   1 file changed, 22 insertions(+), 31 deletions(-)
> 

Looks good, mostly just nits:

> @@ -582,22 +571,29 @@ static void scan_cmds_add(struct scan_request *sr, struct scan_context *sc,
>   				bool passive,
>   				const struct scan_parameters *params)
>   {
> +	uint32_t bands = BAND_FREQ_2_4_GHZ | BAND_FREQ_5_GHZ | BAND_FREQ_6_GHZ;
>   	unsigned int i;
>   	struct scan_freq_set *subsets[2] = { 0 };
> -	struct scan_freq_set *allowed = scan_get_allowed_freqs(sc);
> +	struct scan_freq_set *allowed = wiphy_get_allowed_freqs(sc->wiphy,
> +								bands);

Maybe use _auto_ here?

>   	const struct scan_freq_set *supported =
>   					wiphy_get_supported_freqs(sc->wiphy);
>   
>   	/*
> -	 * If 6GHz is not possible, or already allowed, or the frequencies are
> -	 * explicit don't break up the request.
> +	 * No frequencies, just include the entire supported list and let the
> +	 * kernel filter out any disabled frequencies
>   	 */
> +	if (!params->freqs)
> +		sr->scan_freqs = scan_freq_set_clone(supported, bands);

Maybe l_steal_ptr(&allowed)?  You went through the trouble of calculating it 
already?

> +	else
> +		sr->scan_freqs = scan_freq_set_clone(params->freqs, bands);
> +
> +	/* If 6GHz is not possible or already allowed don't split the request */
>   	if (!(scan_freq_set_get_bands(supported) & BAND_FREQ_6_GHZ) ||
> -			(scan_freq_set_get_bands(allowed) & BAND_FREQ_6_GHZ) ||
> -			params->freqs) {
> +			(scan_freq_set_get_bands(allowed) & BAND_FREQ_6_GHZ)) {
>   		scan_freq_set_free(allowed);
>   		scan_build_next_cmd(sr->cmds, sc, passive,
> -						params, params->freqs);
> +						params, sr->scan_freqs);
>   		return;
>   	}
>   

Regards,
-Denis

