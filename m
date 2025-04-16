Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5425917A304
	for <iwd@lists.linux.dev>; Wed, 16 Apr 2025 17:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744823970; cv=none; b=r9R/+0woWM4/GHb0wt1qpTUSi+LQssyJaG1riec8CcVE5mnBkGaaOBRZ1qyYl4Am72t2QLMKxDV6PFc53iDrnGA4XjpFQLQfW2C8nk3ilndbatIXcxQoyhPc1r+N9ruPFAt/kI1hy/JorvyhygZbcL6jRJ1PSj4KODbQ5hvVTFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744823970; c=relaxed/simple;
	bh=CTo5YKIDUoYfOINngWVXz+otZU5iQj97HqE3IRpwmGI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gK2Fg6uUHyTG6+7ilIdxL+k38hDvf5XG4zqX8FY2Wr23hwAMTf7i/XZS51MBZA67Ci5asBN3dq1OhRV/faooG+FE3rAAFZJaiLycuHfocLEm3zfrZwpDikl+KuW7X5ohsSgC4z2Ux61NhYsmJ1WqDoEa3uy+CUa1igTOcrFncWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hgu6h9fj; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hgu6h9fj"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6044db4b55cso3139665eaf.2
        for <iwd@lists.linux.dev>; Wed, 16 Apr 2025 10:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744823966; x=1745428766; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mPOlnV84tZ0cQ90yr2Y6U63Q4voUxRXo57qRF9+2MOI=;
        b=Hgu6h9fj4W2/meS3Ja+kpN3I4n6RxD6LzB2GpH9wp192lXklDo6z+ouZjO0e5iSuLx
         GKY3v4uvfXjNGV/n9E/PMh0eio5ySv9G+PUAPqRsDt4G3Lh7X/jk4s6H/13vBgUGCEpj
         UZlobdK1GPjvzBHTKfXBYiLNMSucDYYtBzlYjKKaGLej7LqC2+kTueyo8RR8CEqavJ9K
         I194FXkNt/W5qS/Hu2SdpNo7Jny+PdSzYvhEz/k44OY1k6Sa/pHNXaYa7M87BShCVsed
         8nLhAV+5gESz902kToRrbZS5i42AEuwgCu8Cl74Zlv7KH3g8DFhaqbRdLP0YjzgAYXsq
         HjOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744823966; x=1745428766;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mPOlnV84tZ0cQ90yr2Y6U63Q4voUxRXo57qRF9+2MOI=;
        b=JMOGxuI0fpeKwfUNevDYDGMfooItqhLQsiCjOoWcbv5uZAXmdkKs3Ud/gVA0HfeEkS
         XUHcoz2yaVSWd6E/UqQIZS4jT3jCIvBllkAnxeesimiuS1Wf/64TyvtGRIVEXOUAFP/4
         cMZaZgfpm0SWX0LKSDqHW5PyYa1hxlrghBUsXAGlSv8exi0fWHhD4uXiN5l4a6jTOgYH
         YDJ2nAJyAZ32Onls1oJk7lt8J6cZ44KU67H/1DyJ3iJO48ganPKnhkK+PHF1DnIeOtTy
         z7DKgbKfGEYJGbG4fuQhdwKLJ7qxHHJp8nv5hzrzLsdTsOgkXZ0gsUgsDj/E1lxmuK7X
         A2tg==
X-Forwarded-Encrypted: i=1; AJvYcCWFfSyJIB/+kYd/j7IwxKkq84OUkdgIYyv3PJ9DKEea/JCroAykIu3Njsus0wJnTAfP088=@lists.linux.dev
X-Gm-Message-State: AOJu0YxyAWrHyHe5+hWZ9UPpHy+ed2194LNpaMVK1qagHyibRcVYGkUX
	YCkFHQEYGd0c89eHBEWECN2h0BZW+QijOxk6CQZh2UGZ4L0QkHmeU2XNMg==
X-Gm-Gg: ASbGnct4xkdhvZbsJN6iQozGX7PWK7LBNBKw8/SB2uU0Ob0sKUklgWTBEbGSNWMzshn
	WHz8hzxUaUkKytK0N4SYbbCXY14WJRazQSfMt+yxJNOujWd+fktlWl99VbUMJirtz4B+h+hx0F8
	AXWbL53Dnfa2Tbv6U6rnZH6m42S28M2N6TzSiBrsHjdfAhUMM/85/bKNlMnxFHYeMSgOkRseMrE
	EMxCroNDD+6ZuG+rPVyEuUugMak8yDM0h+U3VhddhwFn8Nr7XOjiVR67OAC/6nfvXa9msdokvVO
	/gUCTg1bfz6SGV/HzVt8W8KncFH2S0FZ/HOVwhPPGz93UqnOnEHJaCdibkVzpD5eIToqG5qvbuM
	PUiKd+g==
X-Google-Smtp-Source: AGHT+IFRmF+0twyr3qKy+hYKXxqmaB0xp2rulZk0JHX/pD2bIWmbtYpVCfVvfzsDMY90JllrT6ydHg==
X-Received: by 2002:a05:6820:60f:b0:603:ffc3:60f0 with SMTP id 006d021491bc7-604a90d79femr1704418eaf.1.1744823966185;
        Wed, 16 Apr 2025 10:19:26 -0700 (PDT)
Received: from [192.168.1.25] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-604a5bbb894sm432680eaf.19.2025.04.16.10.19.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 10:19:25 -0700 (PDT)
Message-ID: <ab31a956-b65b-4b42-b37c-a1c63385d3c9@gmail.com>
Date: Wed, 16 Apr 2025 12:19:24 -0500
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
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20250415-roam-scan-improvements-v1-3-12827e086895@axis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/15/25 3:21 AM, Alexander Ganslandt wrote:
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

<snip>

> @@ -2385,6 +2387,8 @@ static void station_roam_retry(struct station *station)
>   		station_roam_timeout_rearm(station, roam_retry_interval);
>   }
>   
> +static void station_start_roam(struct station *station);
> +

Just FYI, we don't like forward-declarations of static functions.  See 
doc/coding-style.txt item M17

> +static void station_filter_roam_scan_freq(uint32_t freq, void *user_data)
> +{
> +	struct scan_freq_set *freqs = user_data;
> +	uint64_t age = scan_get_freq_age(freq);

Have you considered maintaining a scan_freq_set of all the frequencies scanned 
by the neighbor and known-frequency stages instead of maintaining an hashtable 
based on age?
> +
> +	if (scan_freq_set_size(freqs) >= STATION_MAX_SCAN_FREQS) {
> +		return;
> +	}
> +
> +	if (age < STATION_MAX_SCAN_FREQ_AGE) {
> +		return;
> +	}

This is against the preferred Linux Kernel coding style.

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

So the idea is to add up to STATION_MAX_SCAN_FREQS to a new set, starting in 
order of preference with:
	1. neighbor frequency set
	2. known network set
	3. scan frequency ordering set

while filtering the frequencies already scanned.

How do you know when to give up the current attempt?

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

Why 5?  Why is this different from STATION_MAX_SCAN_FREQS?

> +		/* Might as well add the neighbors */
> +		scan_freq_set_merge(scan_freqs, station->roam_freqs);
> +	}
> +
> +	return scan_freqs;
> +}
> +

<snip>

> @@ -5007,44 +5083,79 @@ static void station_add_2_4ghz_freq(uint32_t freq, void *user_data)
>   
>   static void station_fill_scan_freq_subsets(struct station *station)
>   {
> -	const struct scan_freq_set *supported =
> -				wiphy_get_supported_freqs(station->wiphy);

For the most part the changes in this function make sense to me.  They can also 
be split out into a standalone commit since they improve on the already existing 
scan_freqs_order logic and will in theory speed up discovery via the Scan() api.

How do you deal with strange channels that might be supported only on some hardware?

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

Ensure that lines are <= 80 columns.  See doc/coding-style.txt

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

For example, there may be the weird channel 13 in 2.4G band.

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
>   	}

There is now a left-over if() here that cannot happen and should be taken out.

Does the logic now need to take into account the fact that any given frequency 
set might be empty?

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

We prefer somewhat old style C here.  Also magic number 4 should be changed to 
L_ARRAY_SIZE.

>   
>   	wiphy_state_watch_remove(station->wiphy, station->wiphy_watch);
>   
> 

Regards,
-Denis
