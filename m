Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D88234572D
	for <iwd@lists.linux.dev>; Tue,  9 Sep 2025 13:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757424914; cv=none; b=GQYPVdmvTzYESjp3/DnfyV11DOX0gZQKEMXt79CIeGQlG3gxwblQUmpW9Rcx3L2yp4EoMnn7UNR1I7MOiEGhmYIVMouXQn7eI8gk2Cgu1sWAU2KB6MrvaUIxL3ZE+0jF3BJUiUCmwuEUQGlwfHX3q2y3sf6EuUCqKa9a2cphRLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757424914; c=relaxed/simple;
	bh=gX3Q1nl2j21Qi5/SDQDscUYu7jd8Xnt8XDdNAOebIpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qtyEA+SbgZN3K5fUkmK3r8wXSvw9fQs3xesAapKH3twjOOVHkmIoVUKCFxg8rDIYrecIBYDoTb5Fo7EQxrgDMIl8Bx76M32SWotyT/UQAHmLYtSplhe8FGF+InZnrb0nHjGR7GfBytOk7FidNavJrLyHeeo5Kou1wtDZQzphPf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DHC4Jadv; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DHC4Jadv"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7722c88fc5fso5064453b3a.2
        for <iwd@lists.linux.dev>; Tue, 09 Sep 2025 06:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757424911; x=1758029711; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h5uw+5J+998YYffV21JYcnqMr5Rc97l7BNR7pKPc6kg=;
        b=DHC4JadvA9s38iWI46SmCu9B3JAqhF6FEd2QC2j5B+djJ4QBLaOWMC7JSf1/E9Xvyv
         B1+whH631Y4/y7bqhlwqCWojmtoMIGADK6zJvOuEFZ6Lfz2/hI4BKUVMmajwPiiKlRjS
         TawdK8ZXXLcuI4brpEmK8NF4NZXBd+KLXx9447r3BTB0RqscMHfFGtnnfifoS6IJe3Ht
         fYJgmciK9tIn+X0JKa0KP9jPI5N8bbJCXnIDDW3I7F+0LwPiOIiaeFSevMFD9f+gqwKQ
         zdTiufnj2zlOheuCxZVFifuR3Elz/NwxMesJWLSUx2N4dJSW26a0EEkd0BY5bxjpjTVx
         pHGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757424911; x=1758029711;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h5uw+5J+998YYffV21JYcnqMr5Rc97l7BNR7pKPc6kg=;
        b=srqtdScu5B6HfdkQpO3KNqsdw1aGYnVuAyG2pP1Ds9oOoe0uoOPpd6rHFDfo/m0wek
         7dd2HxHtZudCaakbB6HmtGmbhWM7hrP6SD0O/71PxON+8F2DGoEsJhVwKtsk58wq2Pfk
         7fMO+qKdJ0Vpx/JgqRAy8By5IkfNMS6/Vu4zjh5fdaKQ7zf3Uhx+OeesRijp2PpyJ+Wn
         2QoBs6w7uW2eKp8SxMou3M9U0/vDaW7w4YpyKY/IOJvsHM4EJh5kl1zyWG21woCwf6xQ
         5QtKwRwi2ZnJXwVzIpsSdzm89/11ldREORWivmHPNaLjwMmUJ3NDXPzMB/QESqnECvCz
         ivTA==
X-Forwarded-Encrypted: i=1; AJvYcCV+/a9P1zVIC5k0gBoLsC8HLEDJ84PpxDW+4kkouf32WFEaQ1e84eSUReLcAJ1BwezdMvs=@lists.linux.dev
X-Gm-Message-State: AOJu0Yy2MKh/3M7p0Xynf3Ro6kSUowSITfj/nBlFRXHbZE88+JuCnB31
	ud5tIFLED84DtwLLBgO6nwVTRHgHWPnUw5+ucyqrZhYyBjlH/i1gge0b5+XZ6Q==
X-Gm-Gg: ASbGncvCJj+8jdCpiJRkbtUpcgq1xHNxZGDge3CClgXI7b7q+rgcq7O+v/1915U/jNi
	ProC0TRiB+pyyyOHCck1rYtqdnpBY0jbsQqk08GQ9qiAZLhJj+MEpP7dkpaSg/rDp1MFG8bP0qk
	7yo5iS8DypRoslu/U9Am/eaU4RRqPQewIftubK6XETh9zkej1i9T8wPB4hoJvmuPKTUsJS/0R0N
	kk6ZowrsW2mVQbLufzvNjvs8uWmAMOsFIVDhOsri7aQ2DJAqUBEe9zRqSk30DIdyNKvJxEFAPSr
	kUh9Tg23m6+PFheT0QXNFei6u3u+nWd1kHt4m3549tuJeRXJjG18wwTlqRvnOuBi5G6wqiMaTeN
	nYbXJ0So3mHCLJt/XXAK3MPZP1zYzTwRgNPik
X-Google-Smtp-Source: AGHT+IFzLUCGJHWxBFB+mO9uLwC7XbMuRb+4qmieHNqpqjrMs4yyvkgv8l+mp6cfYacVrVIcANS7dg==
X-Received: by 2002:a05:6a00:194a:b0:770:4d54:6234 with SMTP id d2e1a72fcca58-7742dd0ef20mr13695830b3a.3.1757424910939;
        Tue, 09 Sep 2025 06:35:10 -0700 (PDT)
Received: from [10.113.169.105] ([38.76.119.195])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-774662920b1sm2221093b3a.52.2025.09.09.06.35.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 06:35:10 -0700 (PDT)
Message-ID: <b69729a6-808d-4b92-a244-d148af40c7ad@gmail.com>
Date: Tue, 9 Sep 2025 06:35:07 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] station: improve roam scan strategy
To: Alexander Ganslandt <alexander.ganslandt@axis.com>, iwd@lists.linux.dev
References: <20250829-roam-scan-improvements-v2-0-888c6bbdd310@axis.com>
 <20250829-roam-scan-improvements-v2-3-888c6bbdd310@axis.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <20250829-roam-scan-improvements-v2-3-888c6bbdd310@axis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 8/29/25 12:43 AM, Alexander Ganslandt wrote:
> From: Alexander Ganslandt <alexanga@axis.com>
>
> When iwd decides to roam, it scans either neighbor freqs or known freqs
> (if neighbors are not available). If it fails to roam after getting the
> scan results, it scans ALL freqs. There's a high chance that both
> neighbor and/or known scans fail to roam and we end up scanning all
> freqs. This is very slow and if you're already moving away from the
> current BSS, there's a high chance you will lose connection
> completely before the scan is finished.
>
> Instead of scanning all freqs at once, use the already-defined subsets
> to optimize the scans. The subsets contain a handful of freqs each and
> are ordered to increase the chance of finding a good BSS early. In order
> to not scan the same freq multiple times, use a list (scanned_freqs) to
> keep track of which freqs have been scanned in the current roam attempt.
>
> When a roam scan is triggered, add the most prioritized freqs to the
> list of freqs that should be scanned. The order of priority is:
>
> 1. Neighbor freqs
> 2. Known freqs
> 3. Subsets, starting with index 0 and incrementing if the subset is
>     exhausted
>
> A freq is only added to the scan if it has not yet been scanned in the
> current roam attempt. An exception to this are neighbor freqs. They have
> a higher chance of containing good BSSes, so they're scanned every 3rd
> scan (defined by STATION_SCANS_BEFORE_NEIGHBOR_SCAN).
>
> This approach results in more scans, but fewer freqs per scan, leading
> to shorter delays between scan results. It also avoids scanning the same
> freqs back-to-back, which is generally not very useful. In combination
> with the subset ordering, this increases the chance of finding a good
> BSS early and results in better roaming performance.

Overall I agree with this approach, but I'm still looking at this patch 
in detail as its quite intrusive to the roaming logic. One thing to 
address right off the bat is the CI failure. Looks like there were some 
incremental patch issues (applying patches 1-by-1 and building in 
between). This prevented the autotests from running but I suspect we 
will need to alter the autotests a bit due to logic changes in this patch.

Thanks,

James

> ---
>   src/station.c | 228 ++++++++++++++++++++++++++++------------------------------
>   1 file changed, 108 insertions(+), 120 deletions(-)
>
> diff --git a/src/station.c b/src/station.c
> index c2e18fc9..0aef46ec 100644
> --- a/src/station.c
> +++ b/src/station.c
> @@ -68,6 +68,8 @@
>   
>   #define STATION_RECENT_NETWORK_LIMIT	5
>   #define STATION_RECENT_FREQS_LIMIT	5
> +#define STATION_MAX_SCAN_FREQS	10
> +#define STATION_SCANS_BEFORE_NEIGHBOR_SCAN	2
>   
>   static struct l_queue *station_list;
>   static uint32_t netdev_watch;
> @@ -123,6 +125,9 @@ struct station {
>   	/* Set of frequencies to scan first when attempting a roam */
>   	struct scan_freq_set *roam_freqs;
>   	struct l_queue *roam_bss_list;
> +	struct scan_freq_set *scan_freqs;
> +	struct scan_freq_set *scanned_freqs;
> +	uint8_t roam_scans_since_neighbor_scan;
>   
>   	/* Frequencies split into subsets by priority */
>   	struct scan_freq_set *scan_freqs_order[5];
> @@ -141,7 +146,6 @@ struct station {
>   	struct handshake_state *hs;
>   
>   	bool preparing_roam : 1;
> -	bool roam_scan_full : 1;
>   	bool signal_low : 1;
>   	bool ap_directed_roaming : 1;
>   	bool scanning : 1;
> @@ -1940,7 +1944,6 @@ static void station_roam_state_clear(struct station *station)
>   	l_timeout_remove(station->roam_trigger_timeout);
>   	station->roam_trigger_timeout = NULL;
>   	station->preparing_roam = false;
> -	station->roam_scan_full = false;
>   	station->signal_low = false;
>   	station->netconfig_after_roam = false;
>   	station->last_roam_scan = 0;
> @@ -2205,27 +2208,6 @@ static void parse_neighbor_report(struct station *station,
>   	}
>   }
>   
> -static void station_early_neighbor_report_cb(struct netdev *netdev, int err,
> -						const uint8_t *reports,
> -						size_t reports_len,
> -						void *user_data)
> -{
> -	struct station *station = user_data;
> -
> -	if (err == -ENODEV)
> -		return;
> -
> -	l_debug("ifindex: %u, error: %d(%s)",
> -			netdev_get_ifindex(station->netdev),
> -			err, err < 0 ? strerror(-err) : "");
> -
> -	if (!reports || err)
> -		return;
> -
> -	parse_neighbor_report(station, reports, reports_len,
> -				&station->roam_freqs);
> -}
> -
>   static bool station_try_next_bss(struct station *station)
>   {
>   	struct scan_bss *next;
> @@ -2360,9 +2342,32 @@ static bool netconfig_after_roam(struct station *station)
>   	return true;
>   }
>   
> +static void station_neighbor_report_cb(struct netdev *netdev, int err,
> +					const uint8_t *reports,
> +					size_t reports_len, void *user_data)
> +{
> +	struct station *station = user_data;
> +
> +	if (err == -ENODEV)
> +		return;
> +
> +	l_debug("ifindex: %u, error: %d(%s)",
> +			netdev_get_ifindex(station->netdev),
> +			err, err < 0 ? strerror(-err) : "");
> +
> +	if (!reports || err) {
> +		l_debug("no neighbor report results");
> +		return;
> +	}
> +
> +	parse_neighbor_report(station, reports, reports_len, &station->roam_freqs);
> +}
> +
>   static void station_roamed(struct station *station)
>   {
> -	station->roam_scan_full = false;
> +	scan_freq_set_free(station->scanned_freqs);
> +	station->scanned_freqs = scan_freq_set_new();
> +	station->roam_scans_since_neighbor_scan = STATION_SCANS_BEFORE_NEIGHBOR_SCAN;
>   
>   	/*
>   	 * Schedule another roaming attempt in case the signal continues to
> @@ -2382,7 +2387,7 @@ static void station_roamed(struct station *station)
>   
>   	if (station->connected_bss->cap_rm_neighbor_report) {
>   		if (netdev_neighbor_report_req(station->netdev,
> -					station_early_neighbor_report_cb) < 0)
> +					station_neighbor_report_cb) < 0)
>   			l_warn("Could not request neighbor report");
>   	}
>   
> @@ -2404,8 +2409,10 @@ static void station_roam_retry(struct station *station)
>   	 * time.
>   	 */
>   	station->preparing_roam = false;
> -	station->roam_scan_full = false;
>   	station->ap_directed_roaming = false;
> +	scan_freq_set_free(station->scanned_freqs);
> +	station->scanned_freqs = scan_freq_set_new();
> +	station->roam_scans_since_neighbor_scan = STATION_SCANS_BEFORE_NEIGHBOR_SCAN;
>   
>   	if (station->roam_freqs) {
>   		scan_freq_set_free(station->roam_freqs);
> @@ -2416,6 +2423,8 @@ static void station_roam_retry(struct station *station)
>   		station_roam_timeout_rearm(station, roam_retry_interval);
>   }
>   
> +static void station_start_roam(struct station *station);
> +
>   static void station_roam_failed(struct station *station)
>   {
>   	l_debug("%u", netdev_get_ifindex(station->netdev));
> @@ -2438,39 +2447,22 @@ static void station_roam_failed(struct station *station)
>   	}
>   
>   	/*
> -	 * We were told by the AP to roam, but failed.  Try ourselves or
> -	 * wait for the AP to tell us to roam again
> +	 * Keep trying to roam if the signal is still low, or we were told by the AP
> +	 * to roam but failed.
>   	 */
> -	if (station->ap_directed_roaming) {
> -		/*
> -		 * The candidate list from the AP (or neighbor report) found
> -		 * no BSS's. Force a full scan
> -		 */
> -		if (!station->roam_scan_full)
> -			goto full_scan;
> -
> -		goto delayed_retry;
> -	}
> -
> -	/*
> -	 * If we tried a limited scan, failed and the signal is still low,
> -	 * repeat with a full scan right away
> -	 */
> -	if (station->signal_low && !station->roam_scan_full) {
> +	if (station->signal_low || station->ap_directed_roaming) {
>   		/*
>   		 * Since we're re-using roam_scan_id, explicitly cancel
>   		 * the scan here, so that the destroy callback is not called
>   		 * after the return of this function
>   		 */
> -full_scan:
>   		scan_cancel(netdev_get_wdev_id(station->netdev),
>   						station->roam_scan_id);
>   
> -		if (!station_roam_scan(station, NULL))
> -			return;
> +		station_start_roam(station);
> +		return;
>   	}
>   
> -delayed_retry:
>   	station_roam_retry(station);
>   }
>   
> @@ -3057,7 +3049,6 @@ static int station_roam_scan(struct station *station,
>   	}
>   
>   	if (!freq_set) {
> -		station->roam_scan_full = true;
>   		params.freqs = allowed;
>   		station_debug_event(station, "full-roam-scan");
>   	} else
> @@ -3080,71 +3071,68 @@ static int station_roam_scan(struct station *station,
>   	return 0;
>   }
>   
> -static int station_roam_scan_known_freqs(struct station *station)
> +static void station_filter_roam_scan_freq(uint32_t freq, void *user_data)
>   {
> -	const struct network_info *info = network_get_info(
> -						station->connected_network);
> -	struct scan_freq_set *freqs = network_info_get_roam_frequencies(info,
> -					station->connected_bss->frequency,
> -					STATION_RECENT_FREQS_LIMIT);
> -	int r = -ENODATA;
> -
> -	if (!freqs)
> -		return r;
> +	struct station *station = user_data;
>   
> -	if (!wiphy_constrain_freq_set(station->wiphy, freqs))
> -		goto free_set;
> +	if (scan_freq_set_size(station->scan_freqs) >= STATION_MAX_SCAN_FREQS)
> +		return;
>   
> -	r = station_roam_scan(station, freqs);
> +	/* Skip freq if already scanned */
> +	if (scan_freq_set_contains(station->scanned_freqs, freq))
> +		return;
>   
> -free_set:
> -	scan_freq_set_free(freqs);
> -	return r;
> +	scan_freq_set_add(station->scan_freqs, freq);
> +	scan_freq_set_add(station->scanned_freqs, freq);
>   }
>   
> -static void station_neighbor_report_cb(struct netdev *netdev, int err,
> -					const uint8_t *reports,
> -					size_t reports_len, void *user_data)
> +static void station_populate_roam_scan_freqs(struct station *station)
>   {
> -	struct station *station = user_data;
> -	struct scan_freq_set *freq_set;
> -	int r;
> +	struct scan_freq_set *tmp;
>   
> -	if (err == -ENODEV)
> -		return;
> +	station->scan_freqs = scan_freq_set_new();
>   
> -	l_debug("ifindex: %u, error: %d(%s)",
> -			netdev_get_ifindex(station->netdev),
> -			err, err < 0 ? strerror(-err) : "");
> +	/* Add current frequency, always scan this to get updated data for the
> +	 * current BSS */
> +	scan_freq_set_add(station->scan_freqs, station->connected_bss->frequency);
> +	scan_freq_set_add(station->scanned_freqs, station->connected_bss->frequency);
>   
> -	/*
> -	 * Check if we're still attempting to roam -- if dbus Disconnect
> -	 * had been called in the meantime we just abort the attempt.
> -	 */
> -	if (!station->preparing_roam || err == -ENODEV)
> +	/* Add neighbor frequencies */
> +	if (station->roam_scans_since_neighbor_scan >=
> +			STATION_SCANS_BEFORE_NEIGHBOR_SCAN && station->roam_freqs) {
> +		station->roam_scans_since_neighbor_scan = 0;
> +		scan_freq_set_merge(station->scan_freqs, station->roam_freqs);
> +		scan_freq_set_merge(station->scanned_freqs, station->roam_freqs);
>   		return;
> +	}
> +	station->roam_scans_since_neighbor_scan++;
>   
> -	if (!reports || err) {
> -		r = station_roam_scan_known_freqs(station);
> -
> -		if (r == -ENODATA)
> -			l_debug("no neighbor report results or known freqs");
> -
> -		if (r < 0)
> -			station_roam_failed(station);
> -
> +	/* Add known frequencies */
> +	const struct network_info *info = network_get_info(
> +						station->connected_network);
> +	tmp = network_info_get_roam_frequencies(info,
> +					station->connected_bss->frequency,
> +					STATION_RECENT_FREQS_LIMIT);
> +	scan_freq_set_foreach(tmp, station_filter_roam_scan_freq, station);
> +	scan_freq_set_free(tmp);
> +	if (scan_freq_set_size(station->scan_freqs) >= STATION_MAX_SCAN_FREQS) {
>   		return;
>   	}
>   
> -	parse_neighbor_report(station, reports, reports_len, &freq_set);
> -
> -	r = station_roam_scan(station, freq_set);
> -
> -	if (freq_set)
> -		scan_freq_set_free(freq_set);
> +	/* Add frequencies based on the prioritized subsets */
> +	for (uint8_t i = 0; i < L_ARRAY_SIZE(station->scan_freqs_order); i++) {
> +		scan_freq_set_foreach(station->scan_freqs_order[i], station_filter_roam_scan_freq, station);
> +		if (scan_freq_set_size(station->scan_freqs) >= STATION_MAX_SCAN_FREQS) {
> +			return;
> +		}
> +	}
>   
> -	if (r < 0)
> -		station_roam_failed(station);
> +	if (scan_freq_set_size(station->scan_freqs) <= STATION_MAX_SCAN_FREQS) {
> +		/* All freqs have been scanned after this, so empty the list of scanned
> +		 * freqs to restart */
> +		scan_freq_set_free(station->scanned_freqs);
> +		station->scanned_freqs = scan_freq_set_new();
> +	}
>   }
>   
>   static void station_start_roam(struct station *station)
> @@ -3154,34 +3142,26 @@ static void station_start_roam(struct station *station)
>   	station->preparing_roam = true;
>   
>   	/*
> -	 * If current BSS supports Neighbor Reports, narrow the scan down
> -	 * to channels occupied by known neighbors in the ESS. If no neighbor
> -	 * report was obtained upon connection, request one now. This isn't
> -	 * 100% reliable as the neighbor lists are not required to be
> -	 * complete or current.  It is likely still better than doing a
> -	 * full scan.  10.11.10.1: "A neighbor report may not be exhaustive
> -	 * either by choice, or due to the fact that there may be neighbor
> -	 * APs not known to the AP."
> +	 * If no neighbor report was obtained upon connection, request one now if BSS
> +	 * supports it. This isn't 100% reliable as the neighbor lists are not
> +	 * required to be complete or current.
> +	 * 10.11.10.1: "A neighbor report may not be exhaustive either by choice, or
> +	 * due to the fact that there may be neighbor APs not known to the AP."
> +	 *
> +	 * Continue roaming while waiting for the neighbor report, the neighbors will
> +	 * be added to the roam scan when/if they're available.
>   	 */
> -	if (station->roam_freqs) {
> -		if (station_roam_scan(station, station->roam_freqs) == 0) {
> -			l_debug("Using cached neighbor report for roam");
> -			return;
> -		}
> -	} else if (station->connected_bss->cap_rm_neighbor_report) {
> +	if (!station->roam_freqs && station->connected_bss->cap_rm_neighbor_report) {
>   		if (netdev_neighbor_report_req(station->netdev,
>   					station_neighbor_report_cb) == 0) {
>   			l_debug("Requesting neighbor report for roam");
> -			return;
>   		}
>   	}
>   
> -	r = station_roam_scan_known_freqs(station);
> -	if (r == -ENODATA)
> -		l_debug("No neighbor report or known frequencies, roam failed");
> -
> -	if (r < 0)
> -		station_roam_failed(station);
> +	station_populate_roam_scan_freqs(station);
> +	station_roam_scan(station, station->scan_freqs);
> +	scan_freq_set_free(station->scan_freqs);
> +	station->scan_freqs = NULL;
>   }
>   
>   static bool station_cannot_roam(struct station *station)
> @@ -3624,7 +3604,7 @@ static void station_connect_ok(struct station *station)
>   	 */
>   	if (station->connected_bss->cap_rm_neighbor_report) {
>   		if (netdev_neighbor_report_req(station->netdev,
> -					station_early_neighbor_report_cb) < 0)
> +					station_neighbor_report_cb) < 0)
>   			l_warn("Could not request neighbor report");
>   	}
>   
> @@ -5246,6 +5226,9 @@ static struct station *station_create(struct netdev *netdev)
>   	station->roam_bss_list = l_queue_new();
>   	station->affinities = l_queue_new();
>   
> +	station->scanned_freqs = scan_freq_set_new();
> +	station->roam_scans_since_neighbor_scan = STATION_SCANS_BEFORE_NEIGHBOR_SCAN;
> +
>   	return station;
>   }
>   
> @@ -5344,6 +5327,11 @@ static void station_free(struct station *station)
>   
>   	l_queue_destroy(station->affinities, l_free);
>   
> +	scan_freq_set_free(station->scanned_freqs);
> +
> +	if (station->scan_freqs)
> +		scan_freq_set_free(station->scan_freqs);
> +
>   	l_free(station);
>   }
>   
>
