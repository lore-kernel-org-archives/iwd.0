Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7392A18631
	for <iwd@lists.linux.dev>; Fri, 29 Sep 2023 15:26:29 +0000 (UTC)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-1dcdfeb7e44so6273157fac.0
        for <iwd@lists.linux.dev>; Fri, 29 Sep 2023 08:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696001188; x=1696605988; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZfAg4mEbJFqZCZMzBF0BxeV8+dCMc4T7YGpQgTbkxjE=;
        b=i6myJVVVUAQoOm/KSrSqk65QOsRV7kz3dvja6sflGAAVmqpAftK2pvH5XwjeV3zm1O
         BF+WtynvWQNg1ztEMH/p30IZ7kK2pJ5C+eE/qn4T5/04cnP8Xs8ujTG51nc4a+UHHo2y
         zfIM1I7nf+x4lwe8lbIOUrNrknpI+JvPryBUFs/6hXr61hgNEbLETP5ZihabQZM69m0L
         Nff0b7mGP1Gty4c6QOq5ZwGCs9Cz/izJhFhP+YSHFR/rOrS1FOy6sVwQtW8deivCrvpZ
         sxwnN6etNuelehb0ycMpKHWzfV8TaH/OhelzgzYCAAH2BAhE9km1uNTa7Np1/SaC+wle
         fNkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696001188; x=1696605988;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZfAg4mEbJFqZCZMzBF0BxeV8+dCMc4T7YGpQgTbkxjE=;
        b=s5DeA+wMzuKbmRh7pAV4u2AYFe2643yFJ0LM1k5aMRkwd6XmBo3IXVDFK6sjUFGTIB
         5jrTq7X8CzmVaLOleHlcKr2rJmnQuWHuw0jilylodXOv608EQmho9irmlmKG5N0QfXOW
         CQlHaV2xBhzo18MSpJPmONBDCmj2RfpxhOdu4Eseh56MawmgRgRkivnUqYwVCYP3ID3S
         YBy/UAWMSt+8X6eXu4qcS2WNwsZ7U6Rvkm5nUH33+dQEDU1xsMe0kpgAK0KZ4PRGtCr/
         2IpP4Ho+QgM1fFtG+CYV1Xp5k/bKNmrVjYt3K5OWXLhRLHuanKhSiHQwikLROv8DetwO
         n+2w==
X-Gm-Message-State: AOJu0YyDdsODnv8EKFCgRYaEM0ZMWWnWei8k/7sQuhXoUV6Erq2fm4tI
	beKXuF5hGz/2ecZqiQtHYY0=
X-Google-Smtp-Source: AGHT+IFtAgiCnxSx6cIid3ZjjVC3Gscm4NrE9SVrNW5lWTqP3f6hw30F3qpNTqQTGgryeXQPJKS0yA==
X-Received: by 2002:a05:6870:9a20:b0:1d0:e372:6c2d with SMTP id fo32-20020a0568709a2000b001d0e3726c2dmr5126145oab.0.1696001188319;
        Fri, 29 Sep 2023 08:26:28 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id bb2-20020a056871b20200b001d4d7238a78sm3895135oac.54.2023.09.29.08.26.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Sep 2023 08:26:27 -0700 (PDT)
Message-ID: <71493368-4cd9-aac4-c2cc-e8b712af223f@gmail.com>
Date: Fri, 29 Sep 2023 10:26:26 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/4] scan: allow splitting of scans with defined
 frequencies
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20230928124128.3793788-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20230928124128.3793788-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 9/28/23 07:41, James Prestwood wrote:
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
>   src/scan.c | 56 +++++++++++++++++++++---------------------------------
>   1 file changed, 22 insertions(+), 34 deletions(-)
> 
> v2:
>   * Use _auto_ for allowed frequencies in scan_cmds_add()
> 

I went ahead and applied, but a quick comment:

> @@ -582,22 +571,28 @@ static void scan_cmds_add(struct scan_request *sr, struct scan_context *sc,
>   				bool passive,
>   				const struct scan_parameters *params)
>   {
> +	uint32_t bands = BAND_FREQ_2_4_GHZ | BAND_FREQ_5_GHZ | BAND_FREQ_6_GHZ;
>   	unsigned int i;
>   	struct scan_freq_set *subsets[2] = { 0 };
> -	struct scan_freq_set *allowed = scan_get_allowed_freqs(sc);
> +	_auto_(scan_freq_set_free) struct scan_freq_set *allowed =
> +				wiphy_get_allowed_freqs(sc->wiphy, bands);
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
> +	else
> +		sr->scan_freqs = scan_freq_set_clone(params->freqs, bands);
> +
> +	/* If 6GHz is not possible or already allowed don't split the request */
>   	if (!(scan_freq_set_get_bands(supported) & BAND_FREQ_6_GHZ) ||
> -			(scan_freq_set_get_bands(allowed) & BAND_FREQ_6_GHZ) ||
> -			params->freqs) {
> -		scan_freq_set_free(allowed);
> +			(scan_freq_set_get_bands(allowed) & BAND_FREQ_6_GHZ)) {

You're using allowed here for the sole purpose of checking whether 6G was 
allowed by the regdom.  This is sort of an expensive operation and we should 
really just have a getter for this.  Would make the code easier to understand as 
well.

Maybe consider using something like wiphy_band_is_disabled() instead?

>   		scan_build_next_cmd(sr->cmds, sc, passive,
> -						params, params->freqs);
> +						params, sr->scan_freqs);
>   		return;
>   	}
>   
> @@ -613,10 +608,8 @@ static void scan_cmds_add(struct scan_request *sr, struct scan_context *sc,
>   	 * extra 6GHz-only passive scan can be appended to this request
>   	 * at that time.
>   	 */
> -	subsets[0] = scan_freq_set_clone(allowed, BAND_FREQ_2_4_GHZ);
> -	subsets[1] = scan_freq_set_clone(allowed, BAND_FREQ_5_GHZ);
> -
> -	scan_freq_set_free(allowed);
> +	subsets[0] = scan_freq_set_clone(sr->scan_freqs, BAND_FREQ_2_4_GHZ);
> +	subsets[1] = scan_freq_set_clone(sr->scan_freqs, BAND_FREQ_5_GHZ);
>   
>   	for(i = 0; i < L_ARRAY_SIZE(subsets); i++) {
>   		if (!scan_freq_set_isempty(subsets[i]))
> @@ -1918,9 +1911,8 @@ static void scan_wiphy_watch(struct wiphy *wiphy,
>   	struct scan_request *sr = NULL;
>   	struct l_genl_msg *msg = NULL;
>   	struct scan_parameters params = { 0 };
> -	struct scan_freq_set *freqs_6ghz;
>   	struct scan_freq_set *allowed;
> -	bool allow_6g;
> +	_auto_(scan_freq_set_free) struct scan_freq_set *freqs_6ghz = NULL;
>   
>   	/* Only care about completed regulatory dumps */
>   	if (event != WIPHY_STATE_WATCH_EVENT_REGDOM_DONE)
> @@ -1934,14 +1926,14 @@ static void scan_wiphy_watch(struct wiphy *wiphy,
>   	if (!sr)
>   		return;
>   
> -	allowed = scan_get_allowed_freqs(sc);
> -	allow_6g = scan_freq_set_get_bands(allowed) & BAND_FREQ_6_GHZ;
> +	allowed = wiphy_get_allowed_freqs(sc->wiphy, BAND_FREQ_6_GHZ);
> +	freqs_6ghz = scan_freq_set_clone(sr->scan_freqs, BAND_FREQ_6_GHZ);

Same situation here, you're not really using allowed / freqs_6ghz for anything.

>   
>   	/*
>   	 * This update did not allow 6GHz, or the original request was
>   	 * not expecting 6GHz. The periodic scan should now be ended.
>   	 */
> -	if (!allow_6g || !sr->split) {
> +	if (!allowed || scan_freq_set_isempty(freqs_6ghz) || !sr->split) {
>   		scan_get_results(sc, sr, sr->freqs_scanned);
>   		goto free_allowed;
>   	}

Regards,
-Denis

