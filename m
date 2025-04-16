Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8DCFC0E
	for <iwd@lists.linux.dev>; Wed, 16 Apr 2025 16:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744821991; cv=none; b=SAkBxq178ps2JEqZROrTqbqCQUPTFyfn8ANQjjpHJ+x5itfHqymtD0huqrhqTsM1k82MPOCMOIEWbbZ1IV/v1JiglP9e5XH4fElSGGzvviA//nM2DpgGzR/7dAcO8kLRgQy4VPDZMRTm7qvtEtgtDqTLG9kf6kosJKtqZf3yXsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744821991; c=relaxed/simple;
	bh=C/4NXZwF2VW+AnATtD0fhyRsBfcOayyExHEovXb4ce8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VqYKM63z5jN8G1YboAVsBfs2xwN+5LicKPzTJvqyMI6FGhK64DoxBOf+9FP7iM3nWrhGhv8GM+dUdYNTOObB0w8okXmbv9HB+inyPST0uO4JO9tfaM8gVvR2s1zz2aKh4gEH3gn4/j7VbEVXAEBq0Qsogt5YURNbpSq7PzD2KN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lBOAtjVG; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBOAtjVG"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-224100e9a5cso81895835ad.2
        for <iwd@lists.linux.dev>; Wed, 16 Apr 2025 09:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744821988; x=1745426788; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fPZf9JB0rpQyv2ddYkRH8hglMIYL0/X575l34h+GpFU=;
        b=lBOAtjVG9cUP8YnJ7vomKdaq+uQBjpKnvasWQutMa/c9iDamzENePMbcYAGWCnF6Lr
         PegKH7kQ74F2BQX3UQcyvcvObX/hPEsJMavzPCoZ1PIvWfL9uESclmX2sigf1AeAwMvC
         nD2TJuPjen5IjF0EJeVfMWrwHOTfq5jeywAxfNkIJIk09eIPzPb3wRV1KquQWUOvLbTb
         qrJiS5nzNx5qayqr9eOJL3mJvt6MkKf52Y1JDIZCsdqOPk2okInDXvtI1UZoGiWai0FW
         axG8JU9mLrd6Nq+9/pFVgTQp0gijeMWC1rdLiDSakOhN9BYQ4eiDIYChbP4Vs5+UdIaq
         fo4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744821988; x=1745426788;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fPZf9JB0rpQyv2ddYkRH8hglMIYL0/X575l34h+GpFU=;
        b=wReHKzcXjWjHjJrCZnTDV+kaHuv6ce6p4wJjo5LB4xg9IUUtjaT8heOk/5jGY4PxEC
         /GStvTsY3r1DlP1XOcpbfj1KIrDqR/63F9ldHuCnC7MuoH9p2qT3Btkcz7W7siJt592B
         8GMvAkyVTGtM3Ixbl5Ppis03deTN8HiWH5obWaDIKOv2ACHyj/0tL7BUMCNk2sQy4q/U
         nQ9S/I+QmRjGgZiTV98zCj1vdNHFnhHH+i9EAlE/oCDDzSzkyY09r8DN8D8cNbeLdIFb
         Br4aNfFchyoexfaliD6vYFNOuDGPqpNp67uBbahkfGw5GzoDH+diJSauBeoVPg5NswFS
         KHig==
X-Forwarded-Encrypted: i=1; AJvYcCXeRx6x4vHR8T9BHNp1ew1mZcqogqIcs8D8vI+Xk/+7CFjegKWnFsk4AyQmQ4eN6iDLe3Q=@lists.linux.dev
X-Gm-Message-State: AOJu0Ywi1KY+tLiyV1Pt3wcQs7xFS4qZxXlMGHcFgmopJvOUuT0iU99s
	jGj+d4gRaMfDvHIPoMHVV+nLJa2SAwV/2nJ4u4i9QkD3Va/idmpM
X-Gm-Gg: ASbGnctkbw5g0Atep5XcJA8XFbIFr3TGMsPVmTP5yh7gPkSOb7PVtUswzU+J6ugHpQp
	y9MLdRi88WGvlQsG2jIqVJxaSyEyB+3hrzlHUoimhKQ/RyS74dIzBkXqV5pueKftuZH6Z3ebMxn
	tz1zBxl6X6m6cvdJZM+qjA8L1yhq307OutYaH0WV6iAwvwuSPASj+EvnsrI8MDyhJXlCPf9sBdJ
	pHdfuER3xJwm4mmE8GFHLAOIAkd/0eALc2266rOnxXzPgMEzfNqik2eJnxHc1G/cZmcuG6vdLp+
	jvSIiUcGNxjIxi6yGRzuNMdLBuYavPp9G0QU43rkYVGw
X-Google-Smtp-Source: AGHT+IEJfH3nIOx37i+/ACnjMjbGAfcGBxs1VTp5kmSv/pxfyvEr/b09dEYmzqygOFOcjRbezbHRGg==
X-Received: by 2002:a17:902:f705:b0:21a:8300:b9d5 with SMTP id d9443c01a7336-22c358e7b70mr43657515ad.23.1744821988066;
        Wed, 16 Apr 2025 09:46:28 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd2198a89sm10673013b3a.5.2025.04.16.09.46.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 09:46:27 -0700 (PDT)
Message-ID: <c121d4af-bc61-4bcd-a4d7-49918306c39f@gmail.com>
Date: Wed, 16 Apr 2025 09:46:24 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/3] station: improve roam scan strategy
To: Alexander Ganslandt <alexander.ganslandt@axis.com>, iwd@lists.linux.dev
References: <20250415-roam-scan-improvements-v1-0-12827e086895@axis.com>
 <20250415-roam-scan-improvements-v1-3-12827e086895@axis.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <20250415-roam-scan-improvements-v1-3-12827e086895@axis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Alexander,

On 4/15/25 1:21 AM, Alexander Ganslandt wrote:
> When IWD decides to roam, it scans either neighbor freqs or known freqs
> (if neighbors are not available). If it fails to roam after getting the
> scan results, it scans ALL freqs. In my testing there's a high chance
> that both neighbor and/or known scans fail to roam and we end up
> scanning all freqs. This is very slow and if you're already moving away
> from the current BSS, there's a high chance you will lose connection
> completely before the scan is finished.
>
> Instead of scanning all freqs at once, split them up into prioritized
> subsets. Each subset contains a handful of freqs each, a lower index for
> the subset means that its freqs are more common. So subset 0 has the
> most common freqs and subset 3 has the least common freqs. The first two
> subsets also contain no DFS channels, speeding up scanning even more. In
> order to make this efficient, use the "scan_freq_map" to avoid scanning
> freqs that were recently scanned.
>
> When a roam scan is triggered, add the most prioritized freqs to the
> list of freqs that should be scanned. The order of priority is:
>
> 1. Neighbor freqs
> 2. Known freqs
> 3. Subsets, starting with index 0 and incrementing if the subset is
>     exhausted
>
> For each freq candidate, check the scan_freq_map to see how long time
> ago this freq was last scanned, this is denoted as its "age". If its age
> is above a threshold, add the freq to the list, otherwise discard it.
> Once the list has a certain size, start the scan. If no roaming occurs
> after the scan is completed, run the same function again. It will now
> pick new freqs since the previous freqs have been updated in
> scan_freq_map.
>
> This approach results in more scans, but fewer freqs per scan, leading
> to shorter delays between scan results. It also avoids scanning the same
> freqs back-to-back, which is generally not very useful. In combination
> with the freq priority, this increases the chance of finding a good BSS
> early.
> ---
>   src/station.c | 190 +++++++++++++++++++++++++++++++++++++++++++++-------------
>   1 file changed, 149 insertions(+), 41 deletions(-)
>
> diff --git a/src/station.c b/src/station.c
> index 9972ea76..87cf9df0 100644
> --- a/src/station.c
> +++ b/src/station.c
> @@ -67,6 +67,8 @@
>   
>   #define STATION_RECENT_NETWORK_LIMIT	5
>   #define STATION_RECENT_FREQS_LIMIT	5
> +#define STATION_MAX_SCAN_FREQ_AGE	3
> +#define STATION_MAX_SCAN_FREQS	10
>   
>   static struct l_queue *station_list;
>   static uint32_t netdev_watch;
> @@ -124,7 +126,7 @@ struct station {
>   	struct l_queue *roam_bss_list;
>   
>   	/* Frequencies split into subsets by priority */
> -	struct scan_freq_set *scan_freqs_order[3];
> +	struct scan_freq_set *scan_freqs_order[4];
>   	unsigned int dbus_scan_subset_idx;
>   
>   	uint32_t wiphy_watch;
> @@ -2385,6 +2387,8 @@ static void station_roam_retry(struct station *station)
>   		station_roam_timeout_rearm(station, roam_retry_interval);
>   }
>   
> +static void station_start_roam(struct station *station);
> +
>   static void station_roam_failed(struct station *station)
>   {
>   	l_debug("%u", netdev_get_ifindex(station->netdev));
> @@ -2414,10 +2418,9 @@ static void station_roam_failed(struct station *station)
>   		goto delayed_retry;
>   
>   	/*
> -	 * If we tried a limited scan, failed and the signal is still low,
> -	 * repeat with a full scan right away
> +	 * If the signal is still low, keep trying to roam
>   	 */
> -	if (station->signal_low && !station->roam_scan_full) {
> +	if (station->signal_low) {
>   		/*
>   		 * Since we're re-using roam_scan_id, explicitly cancel
>   		 * the scan here, so that the destroy callback is not called
> @@ -2426,8 +2429,8 @@ static void station_roam_failed(struct station *station)
>   		scan_cancel(netdev_get_wdev_id(station->netdev),
>   						station->roam_scan_id);
>   
> -		if (!station_roam_scan(station, NULL))
> -			return;
> +		station_start_roam(station);
> +		return;
>   	}
>   
>   delayed_retry:
> @@ -3102,12 +3105,85 @@ static void station_neighbor_report_cb(struct netdev *netdev, int err,
>   		station_roam_failed(station);
>   }
>   
> +static void station_filter_roam_scan_freq(uint32_t freq, void *user_data)
> +{
> +	struct scan_freq_set *freqs = user_data;
> +	uint64_t age = scan_get_freq_age(freq);
> +
> +	if (scan_freq_set_size(freqs) >= STATION_MAX_SCAN_FREQS) {
> +		return;
> +	}
> +
> +	if (age < STATION_MAX_SCAN_FREQ_AGE) {

Won't this start reusing the same frequencies after a few scans? Say 
your first N scans take more than 3 seconds, you'd then begin using 
those frequencies again on subsequent scans since their ages are under 
the threshold?

Rather than a hard threshold simply sorting by age seems like the best 
way to do this:

  - Sort the frequencies by least recently used -> Take the first N 
frequencies -> Scan
  - No candidates found? -> Repeat ^^^
> +		return;
> +	}
> +
> +	scan_freq_set_add(freqs, freq);
> +}
> +
> +static struct scan_freq_set *station_get_roam_scan_freqs(struct station *station)
> +{
> +	struct scan_freq_set *tmp;
> +	struct scan_freq_set *scan_freqs;
> +
> +	scan_freqs = scan_freq_set_new();
> +
> +	/* Add current frequency, always scan this to get updated data for the
> +	 * current BSS */
> +	scan_freq_set_add(scan_freqs, station->connected_bss->frequency);
> +
> +	/* Add neighbor frequencies */
> +	scan_freq_set_foreach(station->roam_freqs, station_filter_roam_scan_freq, scan_freqs);
> +	if (scan_freq_set_size(scan_freqs) >= STATION_MAX_SCAN_FREQS) {
> +		goto out;
> +	}
> +
> +	/* Add known frequencies */
> +	const struct network_info *info = network_get_info(
> +						station->connected_network);
> +	tmp = network_info_get_roam_frequencies(info,
> +					station->connected_bss->frequency,
> +					10);
> +	scan_freq_set_foreach(tmp, station_filter_roam_scan_freq, scan_freqs);
> +	scan_freq_set_free(tmp);
> +	if (scan_freq_set_size(scan_freqs) >= STATION_MAX_SCAN_FREQS) {
> +		goto out;
> +	}
> +
> +	/* Add frequencies based on the prioritized subsets */
> +	for (uint8_t i = 0; i < L_ARRAY_SIZE(station->scan_freqs_order); i++) {
> +		scan_freq_set_foreach(station->scan_freqs_order[i], station_filter_roam_scan_freq, scan_freqs);
> +		if (scan_freq_set_size(scan_freqs) >= STATION_MAX_SCAN_FREQS) {
> +			goto out;
> +		}
> +	}
> +
> +out:
> +	/* TODO: Arbitrary number to not have too small freq list */
> +	if (scan_freq_set_size(scan_freqs) <= 5) {
> +		/* Might as well add the neighbors */
> +		scan_freq_set_merge(scan_freqs, station->roam_freqs);
> +	}
> +
> +	return scan_freqs;
> +}
> +
>   static void station_start_roam(struct station *station)
>   {
>   	int r;
> +	struct scan_freq_set *freqs;
>   
>   	station->preparing_roam = true;
>   
> +	/* TODO: Need to request neighbor report here, like below */
> +
> +	freqs = station_get_roam_scan_freqs(station);
> +	station_roam_scan(station, freqs);
> +
> +	scan_freq_set_free(freqs);
> +
> +	return;
> +
>   	/*
>   	 * If current BSS supports Neighbor Reports, narrow the scan down
>   	 * to channels occupied by known neighbors in the ESS. If no neighbor
> @@ -5007,44 +5083,79 @@ static void station_add_2_4ghz_freq(uint32_t freq, void *user_data)
>   
>   static void station_fill_scan_freq_subsets(struct station *station)
>   {
> -	const struct scan_freq_set *supported =
> -				wiphy_get_supported_freqs(station->wiphy);
>   	unsigned int subset_idx = 0;
>   
> -	/*
> -	 * Scan the 2.4GHz "social channels" first, 5GHz second, if supported,
> -	 * all other 2.4GHz channels last.  To be refined as needed.
> -	 */
> +	station->scan_freqs_order[subset_idx] = scan_freq_set_new();
> +
> +	/* Subset 0: 2.4GHz "social channels" and lower 5GHz non-DFS channels */
>   	if (allowed_bands & BAND_FREQ_2_4_GHZ) {
> -		station->scan_freqs_order[subset_idx] = scan_freq_set_new();
> -		scan_freq_set_add(station->scan_freqs_order[subset_idx], 2412);
> -		scan_freq_set_add(station->scan_freqs_order[subset_idx], 2437);
> -		scan_freq_set_add(station->scan_freqs_order[subset_idx], 2462);
> -		subset_idx++;
> +		scan_freq_set_add(station->scan_freqs_order[subset_idx], 2412); /* 1 */
> +		scan_freq_set_add(station->scan_freqs_order[subset_idx], 2437); /* 6 */
> +		scan_freq_set_add(station->scan_freqs_order[subset_idx], 2462); /* 11 */
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
> +		scan_freq_set_add(station->scan_freqs_order[subset_idx], 5180); /* 36 */
> +		scan_freq_set_add(station->scan_freqs_order[subset_idx], 5200); /* 40 */
> +		scan_freq_set_add(station->scan_freqs_order[subset_idx], 5220); /* 44 */
> +		scan_freq_set_add(station->scan_freqs_order[subset_idx], 5240); /* 48 */
>   	}
>   
> -	/* Add remaining 2.4ghz channels to subset */
> +	station->scan_freqs_order[++subset_idx] = scan_freq_set_new();
> +
> +	/* Subset 1: 2.4GHz common "middle channels" and high 5GHz non-DFS channels */
>   	if (allowed_bands & BAND_FREQ_2_4_GHZ) {
> -		station->scan_freqs_order[subset_idx] = scan_freq_set_new();
> -		scan_freq_set_foreach(supported, station_add_2_4ghz_freq,
> -					station->scan_freqs_order[subset_idx]);
> +		scan_freq_set_add(station->scan_freqs_order[subset_idx], 2422); /* 3 */
> +		scan_freq_set_add(station->scan_freqs_order[subset_idx], 2427); /* 4 */
> +		scan_freq_set_add(station->scan_freqs_order[subset_idx], 2447); /* 8 */
> +		scan_freq_set_add(station->scan_freqs_order[subset_idx], 2452); /* 9 */
> +	}
> +
> +	if (allowed_bands & BAND_FREQ_5_GHZ) {
> +		scan_freq_set_add(station->scan_freqs_order[subset_idx], 5745); /* 149 */
> +		scan_freq_set_add(station->scan_freqs_order[subset_idx], 5765); /* 153 */
> +		scan_freq_set_add(station->scan_freqs_order[subset_idx], 5785); /* 157 */
> +		scan_freq_set_add(station->scan_freqs_order[subset_idx], 5805); /* 161 */
> +		scan_freq_set_add(station->scan_freqs_order[subset_idx], 5825); /* 165 */
> +	}
> +
> +	station->scan_freqs_order[++subset_idx] = scan_freq_set_new();
> +
> +	/* TODO: Add 6GHz here, after more common 2.4 and 5GHz, but before DFS */
> +
> +	/* Subset 2: 2.4GHz remaining channels and 5GHz most common DFS channels */
> +	if (allowed_bands & BAND_FREQ_2_4_GHZ) {
> +		scan_freq_set_add(station->scan_freqs_order[subset_idx], 2417); /* 2 */
> +		scan_freq_set_add(station->scan_freqs_order[subset_idx], 2432); /* 5 */
> +		scan_freq_set_add(station->scan_freqs_order[subset_idx], 2442); /* 7 */
> +		scan_freq_set_add(station->scan_freqs_order[subset_idx], 2457); /* 10 */
> +	}
> +
> +	if (allowed_bands & BAND_FREQ_5_GHZ) {
> +		scan_freq_set_add(station->scan_freqs_order[subset_idx], 5260); /* 52 */
> +		scan_freq_set_add(station->scan_freqs_order[subset_idx], 5280); /* 56 */
> +		scan_freq_set_add(station->scan_freqs_order[subset_idx], 5300); /* 60 */
> +		scan_freq_set_add(station->scan_freqs_order[subset_idx], 5320); /* 64 */
> +		scan_freq_set_add(station->scan_freqs_order[subset_idx], 5500); /* 100 */
> +		scan_freq_set_add(station->scan_freqs_order[subset_idx], 5520); /* 104 */
> +		scan_freq_set_add(station->scan_freqs_order[subset_idx], 5540); /* 108 */
> +		scan_freq_set_add(station->scan_freqs_order[subset_idx], 5560); /* 112 */
> +	}
> +
> +	station->scan_freqs_order[++subset_idx] = scan_freq_set_new();
> +
> +	/* Subset 3: Remaining 5GHz DFS channels */
> +	if (allowed_bands & BAND_FREQ_5_GHZ) {
> +		scan_freq_set_add(station->scan_freqs_order[subset_idx], 5340); /* 68 */
> +		scan_freq_set_add(station->scan_freqs_order[subset_idx], 5480); /* 96 */
> +		scan_freq_set_add(station->scan_freqs_order[subset_idx], 5580); /* 116 */
> +		scan_freq_set_add(station->scan_freqs_order[subset_idx], 5600); /* 120 */
> +		scan_freq_set_add(station->scan_freqs_order[subset_idx], 5620); /* 124 */
> +		scan_freq_set_add(station->scan_freqs_order[subset_idx], 5640); /* 128 */
> +		scan_freq_set_add(station->scan_freqs_order[subset_idx], 5660); /* 132 */
> +		scan_freq_set_add(station->scan_freqs_order[subset_idx], 5680); /* 136 */
> +		scan_freq_set_add(station->scan_freqs_order[subset_idx], 5700); /* 140 */
> +		scan_freq_set_add(station->scan_freqs_order[subset_idx], 5720); /* 144 */

This seems overly "manual" adding all these frequencies in the context 
of an initial scan to connect. What I fear is the cases of forgetting to 
add a channel, or new channels get added to the spec. We're now tracking 
a massive list of manual channels here that needs to be maintained.

At the very least it would be good to have a final scan subset to 
include anything we missed. If this final subset is always expected to 
be empty (i.e. we added all the channels in other subsets) then we could 
warn on that.

>   	}
>   
>   	/*
> @@ -5223,11 +5334,8 @@ static void station_free(struct station *station)
>   
>   	l_queue_destroy(station->anqp_pending, remove_anqp);
>   
> -	scan_freq_set_free(station->scan_freqs_order[0]);
> -	scan_freq_set_free(station->scan_freqs_order[1]);
> -
> -	if (station->scan_freqs_order[2])
> -		scan_freq_set_free(station->scan_freqs_order[2]);
> +	for (uint8_t i = 0; i < 4; i++)
> +		scan_freq_set_free(station->scan_freqs_order[i]);
>   
>   	wiphy_state_watch_remove(station->wiphy, station->wiphy_watch);
>   
>
