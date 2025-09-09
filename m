Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7812D1F4A
	for <iwd@lists.linux.dev>; Tue,  9 Sep 2025 13:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757424321; cv=none; b=SIhRKMpAmzz/8qykpaYFmVY5b3egi904F03eFemMng3zXDDEc4jjPyKhEIOhGOEEcPWVwbEpbkq+sVbxHLeYrrC9Fc8ZaVM3NFvknag0p/Q+Z/iQ3BYTfcA2KE8VYANMruLchoGRCy45pvvZfjdzZkOkgVt2squo+8rAcJE9sZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757424321; c=relaxed/simple;
	bh=Eb0ZftgDTITXj5UxBN6HrVm1mf9JsDNdJUHWISg08ss=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=npi4EMIKCU5VUC115Bq9Yek1eO3GpS3I3Uq+8Z5sPnRSceXoEPKboLlaqq7OwaomjZHap5Cdvky9UCNVFCX7efLA/9voFCZ+d7i3D+rCMlTSf/hyK1eNBYBvRKYhAMEaCK6hZMJ1YfJBlaxKCOyG8BXK9LPLEymqx+bRiIdmTm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=evkoh7Xo; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evkoh7Xo"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-25634c5ebdeso24191195ad.0
        for <iwd@lists.linux.dev>; Tue, 09 Sep 2025 06:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757424319; x=1758029119; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cPicWPXXfIAeVxK5nccASGmJB+pz1p+t2S1pPnNwcCg=;
        b=evkoh7Xonwwp+WFvwLY1TSGh6uC+mb8cciwiy0cbn+A6pv/UBo2U5YXPYBe7bXjYYI
         ph+1exRMviCXK9lLajghQNmlH8p8TKN72r5wbsPURIy5doA9/taM+P9CejNIiv0bGX5I
         d8l2kNfkNOZCsdWIg//6IsAgBXY05qNENI01DFq2k0pZJuk89evTpG4uez3WOI606pJ1
         xWROsFVyvRiKA0TxG5kMlO/LUs2TB9WEgW51UonBDaQIFZBtMF/fD/A3kWxDRh6oi/v+
         9tsKuy0fbRM9GFm8j2qzogxnIso8g9AmdmrxOCeusbU6Y+bllOg3E9dEo8VJbAznTxAB
         MVww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757424319; x=1758029119;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cPicWPXXfIAeVxK5nccASGmJB+pz1p+t2S1pPnNwcCg=;
        b=FrGm3AKOc/WBl+fChEyHAl8IQrd9TvduNhmo+/6vOJTfTDQOb0xWynjYjuiwzUDWLT
         Kj4jK4Rrn1pd7gMEgMGtHSFvdLjSq9/Y9gOrw3Oh1lnp569PxAJhl3xY/hcJCmlFAsAk
         dbInUEqD/sJq3CQB/Yh313TphlB5N+8xj4SvNjfOns530NZZb1sqn+zGEjQFxoe3LghU
         G5vm0DUqdKm/asovXjQoZQOrHUUpizPcjPgy+gXyR2KmkIP6n7iePalD2FPETlM4Hhwn
         iWZ/DzlUAU8Yq3CaSZxEnFQDJAJNzxoLldLtUldbqaIL7M8AZ36I95lHM+EwSNdkFBkU
         kHzA==
X-Forwarded-Encrypted: i=1; AJvYcCXKQfKe+bCU1uQtVvuv3HqQCi47wXj4RUGLKyRFbJKWFUCwwEY47P31uP6suUGqQNLeNSU=@lists.linux.dev
X-Gm-Message-State: AOJu0YxDr8nuAwSHrqM4Higf58c+P4rVzdOQ19ylmQPdN5tDEdyZzXgq
	Bbb0uvHA4SgqPaGGenyJ2MCrt37lduOtxjRn7O1PD04737ZqBsNlGIurJ+TZ5Q==
X-Gm-Gg: ASbGncscgbRtGEf5NxpPnmXuwm5vBhC2y0H2mIctpjA1hZaClaOVVIFyN3BWLxVE9ra
	uKqkAxn3UL7YBAziTruChhxaeJUDKxPs9d82pV2VOV50Nq2ggCjaFilNZ6eoDrQa0vvOPtCsCHH
	T07teE4+ic/etmqYk1yIqXz0RI5VG/V9FX6hnFzljzDwp4Oj9S+Aj6Uh1Yi03fVf9Y7GRKSLMI+
	icrUpMvcDvqZWd3RX633egq5Biw7+ijmj3NC52N6Tm65hkaFZBSfDyCNm8oXFWgIeYlXQTjsWSZ
	8rmJ1uJLNww4zZKQlEHKZA5qVxNBa1iCCkhPKWbP0GrkJ81eMhBqvgr1CxppC7zHeEXGR8Yj5jB
	GuktLLqyPROaXW5SWE7S9Bt/GmQ==
X-Google-Smtp-Source: AGHT+IHUlDQ+8T8tJBBjlEl1fBdQro1rUV9Mv6DERcV9yDN6Y7jf2idWbeN2dXO8HL+sLwc3wFmtdg==
X-Received: by 2002:a17:902:e847:b0:250:c893:6cc1 with SMTP id d9443c01a7336-2516c8957d3mr130386165ad.8.1757424319001;
        Tue, 09 Sep 2025 06:25:19 -0700 (PDT)
Received: from [10.113.169.105] ([38.76.119.195])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24b905689d1sm189561115ad.64.2025.09.09.06.25.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 06:25:17 -0700 (PDT)
Message-ID: <8631e4d5-8cbc-4ec3-a9ba-e8ba32260484@gmail.com>
Date: Tue, 9 Sep 2025 06:25:14 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] station: improve scan_freqs_order channel subsets
To: Alexander Ganslandt <alexander.ganslandt@axis.com>, iwd@lists.linux.dev
References: <20250829-roam-scan-improvements-v2-0-888c6bbdd310@axis.com>
 <20250829-roam-scan-improvements-v2-2-888c6bbdd310@axis.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <20250829-roam-scan-improvements-v2-2-888c6bbdd310@axis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Alexander,

On 8/29/25 12:43 AM, Alexander Ganslandt wrote:
> From: Alexander Ganslandt <alexanga@axis.com>
>
> Splits the scan frequencies into more subsets that have been ordered
> such that the more common frequencies appear first, and the more uncommon
> frequencies last. Non-DFS channels are also added to the earlier
> subsets to prioritize fast-scanning frequencies.
>
> This approach allows iwd to scan the frequencies with the statistically
> highest chance for BSSes first, resulting in shorter scan times until a
> good BSS is found. In future patches this will also be used when
> roaming.
> ---
>   src/station.c | 122 ++++++++++++++++++++++++++++++++++++++++++----------------
>   1 file changed, 89 insertions(+), 33 deletions(-)
>
> diff --git a/src/station.c b/src/station.c
> index f8069d89..c2e18fc9 100644
> --- a/src/station.c
> +++ b/src/station.c
> @@ -125,7 +125,7 @@ struct station {
>   	struct l_queue *roam_bss_list;
>   
>   	/* Frequencies split into subsets by priority */
> -	struct scan_freq_set *scan_freqs_order[3];
> +	struct scan_freq_set *scan_freqs_order[5];
>   	unsigned int dbus_scan_subset_idx;
>   
>   	uint32_t wiphy_watch;
> @@ -4500,8 +4500,7 @@ static bool station_dbus_scan_results(int err, struct l_queue *bss_list,
>   		return false;
>   	}
>   
> -	last_subset = next_idx >= L_ARRAY_SIZE(station->scan_freqs_order) ||
> -		station->scan_freqs_order[next_idx] == NULL;
> +	last_subset = next_idx >= L_ARRAY_SIZE(station->scan_freqs_order);
>   	station->dbus_scan_subset_idx = next_idx;
>   
>   	station_set_scan_results(station, bss_list, freqs, false);
> @@ -4516,6 +4515,15 @@ static bool station_dbus_scan_subset(struct station *station)
>   {
>   	unsigned int idx = station->dbus_scan_subset_idx;
>   
> +	/* Find the next non-empty subset */
> +	while (idx < L_ARRAY_SIZE(station->scan_freqs_order) &&
> +			scan_freq_set_isempty(station->scan_freqs_order[idx]))
> +		idx++;
> +	station->dbus_scan_subset_idx = idx;
> +
> +	if (idx >= L_ARRAY_SIZE(station->scan_freqs_order))
> +		return false;
> +
>   	station->dbus_scan_id = station_scan_trigger(station,
>   						station->scan_freqs_order[idx],
>   						station_dbus_scan_triggered,
> @@ -5061,40 +5069,91 @@ static void station_fill_scan_freq_subsets(struct station *station)
>   				wiphy_get_supported_freqs(station->wiphy);
>   	unsigned int subset_idx = 0;
>   
> -	/*
> -	 * Scan the 2.4GHz "social channels" first, 5GHz second, if supported,
> -	 * all other 2.4GHz channels last.  To be refined as needed.
> -	 */
> +	station->scan_freqs_order[subset_idx] = scan_freq_set_new();
> +
> +	/* Subset 0: 2.4GHz "social channels" and low 5GHz non-DFS channels */
>   	if (allowed_bands & BAND_FREQ_2_4_GHZ) {
> -		station->scan_freqs_order[subset_idx] = scan_freq_set_new();
> +		/* Channels 1, 6, 11 */
>   		scan_freq_set_add(station->scan_freqs_order[subset_idx], 2412);
>   		scan_freq_set_add(station->scan_freqs_order[subset_idx], 2437);
>   		scan_freq_set_add(station->scan_freqs_order[subset_idx], 2462);
> -		subset_idx++;
>   	}
>   
> -	/*
> -	 * TODO: It may might sense to split up 5 and 6ghz into separate subsets
> -	 *       since the channel set is so large.
> -	 */
> -	if (allowed_bands & (BAND_FREQ_5_GHZ | BAND_FREQ_6_GHZ)) {
> -		uint32_t mask = allowed_bands &
> -					(BAND_FREQ_5_GHZ | BAND_FREQ_6_GHZ);
> -		struct scan_freq_set *set = scan_freq_set_clone(supported,
> -								mask);
> -
> -		/* 5/6ghz didn't add any frequencies */
> -		if (scan_freq_set_isempty(set)) {
> -			scan_freq_set_free(set);
> -		} else
> -			station->scan_freqs_order[subset_idx++] = set;
> +	if (allowed_bands & BAND_FREQ_5_GHZ) {
> +		/* Channels 32 - 48 */
> +		for (int i = 5160; i <= 5240; i+=20) {
> +			scan_freq_set_add(station->scan_freqs_order[subset_idx], i);
> +		}
No need for the braces around this loop and others below.
>   	}
>   
> -	/* Add remaining 2.4ghz channels to subset */
> +	scan_freq_set_constrain(station->scan_freqs_order[subset_idx], supported);
> +	station->scan_freqs_order[++subset_idx] = scan_freq_set_new();
> +
> +	/* Subset 1: Remaining common 2.4GHz channels and high 5GHz non-DFS channels */
>   	if (allowed_bands & BAND_FREQ_2_4_GHZ) {
> -		station->scan_freqs_order[subset_idx] = scan_freq_set_new();
> -		scan_freq_set_foreach(supported, station_add_2_4ghz_freq,
> -					station->scan_freqs_order[subset_idx]);
> +		/* Channels 2 - 10, except 6 */
> +		for (int i = 2417; i < 2462; i+=5) {
> +			if (i != 2437)
> +				scan_freq_set_add(station->scan_freqs_order[subset_idx], i);
> +		}
> +	}
> +
> +	if (allowed_bands & BAND_FREQ_5_GHZ) {
> +		/* Channels 149 - 177 */
> +		for (int i = 5745; i <= 5885; i+=20) {
> +			scan_freq_set_add(station->scan_freqs_order[subset_idx], i);
> +		}
> +	}
> +
> +	scan_freq_set_constrain(station->scan_freqs_order[subset_idx], supported);
> +	station->scan_freqs_order[++subset_idx] = scan_freq_set_new();
> +
> +	/* Subset 2: Uncommon 2.4GHz channels and 5GHz DFS channels */
> +	if (allowed_bands & BAND_FREQ_2_4_GHZ) {
> +		/* Channels 12 - 14 */
> +		scan_freq_set_add(station->scan_freqs_order[subset_idx], 2467);
> +		scan_freq_set_add(station->scan_freqs_order[subset_idx], 2472);
> +		scan_freq_set_add(station->scan_freqs_order[subset_idx], 2484);
> +	}
> +
> +	if (allowed_bands & BAND_FREQ_5_GHZ) {
> +		/* Channels 52 - 68 */
> +		for (int i = 5260; i <= 5340; i+=20) {
> +			scan_freq_set_add(station->scan_freqs_order[subset_idx], i);
> +		}
> +
> +		/* Channels 96 - 144 */
> +		for (int i = 5480; i <= 5720; i+=20) {
> +			scan_freq_set_add(station->scan_freqs_order[subset_idx], i);
> +		}
> +	}
> +
> +	scan_freq_set_constrain(station->scan_freqs_order[subset_idx], supported);
> +	station->scan_freqs_order[++subset_idx] = scan_freq_set_new();
> +
> +	/* Subset 3: 6GHz channels */
> +	if (allowed_bands & BAND_FREQ_6_GHZ) {
> +		struct scan_freq_set *set = scan_freq_set_clone(supported, BAND_FREQ_6_GHZ);
> +
> +		if (scan_freq_set_isempty(set))
> +			scan_freq_set_free(set);
> +		else
> +			scan_freq_set_merge(station->scan_freqs_order[subset_idx], set);
> +	}
> +
> +	scan_freq_set_constrain(station->scan_freqs_order[subset_idx], supported);
> +	station->scan_freqs_order[++subset_idx] = scan_freq_set_clone(supported, allowed_bands);
> +
> +	/* All channels that are both supported and allowed should be in the subsets,
> +	 * if this is not the case then some new channel has been added that we are
> +	 * not tracking, put it in the last subset to make sure it's scanned */
> +	for (int i = 0; i < 4; i++) {
> +		scan_freq_set_subtract(station->scan_freqs_order[subset_idx],
> +				station->scan_freqs_order[i]);
> +	}
> +
> +	if (!scan_freq_set_isempty(station->scan_freqs_order[subset_idx])) {
> +		l_warn("Final subset is not empty");
>   	}
>   
>   	/*
> @@ -5273,11 +5332,8 @@ static void station_free(struct station *station)
>   
>   	l_queue_destroy(station->anqp_pending, remove_anqp);
>   
> -	scan_freq_set_free(station->scan_freqs_order[0]);
> -	scan_freq_set_free(station->scan_freqs_order[1]);
> -
> -	if (station->scan_freqs_order[2])
> -		scan_freq_set_free(station->scan_freqs_order[2]);
> +	for (uint8_t i = 0; i < L_ARRAY_SIZE(station->scan_freqs_order); i++)
> +		scan_freq_set_free(station->scan_freqs_order[i]);
>   
>   	wiphy_state_watch_remove(station->wiphy, station->wiphy_watch);
>   
>
