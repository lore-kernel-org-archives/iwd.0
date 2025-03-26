Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89DC1F7069
	for <iwd@lists.linux.dev>; Wed, 26 Mar 2025 17:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743011403; cv=none; b=FspqECcz5VagG1udiYfmqcnVjdxpj8fZlYZ4H85Lrql/cl/BQd9Jwjgi0dQ4NIBXBIsVNioLisAJFha+AP9btAsIHMa0bm8xTHGmbQmmM7HygvVcmSDcqBA2Teb2P4GGwN3XgKsZhvxHPfYCEkkGauJnFPLhEXnaTxO0+heN+sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743011403; c=relaxed/simple;
	bh=TYE8UKrAXPKGTn4cB4fRaNbhaLdn3/BEH9GpFimPojM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=F6klWtr8OX8+KX82BQs8dgCDWtKISkCn+k72lui5lLAk2BNtuZhY/o7IAZndzjZgSU0J4NGgyqIQSaWXp+EzI3dBPMWdOtR6JqcxS8tEzdR+PL7tN6mfY4Gan52HPh5LfbufiPt4FIKsKCJJ649srfmQ1RZYkf0QuOZO/Haapt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bR1RNx7N; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bR1RNx7N"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ff64550991so95408a91.0
        for <iwd@lists.linux.dev>; Wed, 26 Mar 2025 10:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743011401; x=1743616201; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=le5L28UCIxQfqQFdXUaPLacTS4vya8kloLsmhQTzCx8=;
        b=bR1RNx7Nve3wZUTTW7/q7ghpnaVuf+Oeey6w75iiMQgmoRweig8ymHXeeSfWMv1CYV
         wtjQSYY3zcbQ05URNJYMVp4QXOm/qqez7Q7vNoTOmKW+YYkzvPKhxstmsHYmdWTGmk/A
         FuWJDuN9aWuywXcjIgc5QCCzLQ8vo9YhwmXAyTI5aRt115RjQfc0m2aa7ZknRJr5gnms
         VsYDi5SXa6pMWufSRYbYd3oiZoNl4+EAmuFHs6EBXeectztqrM7DGt8HuLU+GvwbjO5y
         b0aokMRA8QpvuDl765Nd7oNom2bWSfF7tu+6tzI8vUvJO5irWekh8d8t+yYi8ZOBnxRx
         /yBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743011401; x=1743616201;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=le5L28UCIxQfqQFdXUaPLacTS4vya8kloLsmhQTzCx8=;
        b=mEp6lG1niiPZyQH7ymm88eBak1LqUDD546p9mXtzNdYdYP5L9NpJYQVXKlPymr/a15
         bXGdWty2fPJY/T5hIec6X/li8AOscYnW/YmerKnCaEQJ+1AFXImmId6PHOX432KAlbU4
         ZMBbZjd2SX+Vb20HvHjjaDx9QR8mLCb3bFAK90Eu+C7GLf05gCwjMjbvtCfFSL27pKoZ
         4BLxwl7tyk6Wxv2Gbfp5bUkX9llAd9/ZaY3r0YIQB4JGuqgUhy4csL3zzgpZNgC0k9Fk
         5tk7a//kLi++dcgmNoPmDwpWDfXVZx2+yfXMOZI28FXw8U0Ct9maEgXecDn2iUFaDqFl
         kNZg==
X-Gm-Message-State: AOJu0Yx/Q1fPauYcvjcbHCWQ/PCclQbf15Iu4+IpcoWJ6rJbTowBnhis
	ZZLrwNVnW5lIPoCK6Fkdu9s0YBzPdw16h95Ux4ZLzLDoeKmgtvuw3peFZA==
X-Gm-Gg: ASbGncurehWgx/zuVG8aOkBKBO7SJy2f3RrtJ42Znv5ElNRMqvW00yvNQkwy/GLHDe7
	Cd/BcLcvVlZORk2Sg41QNdVaJ8/yqzRPexxUAoLfMZ121ShTWLodd4fkRgcZX583BC8YyejtFBB
	cgPHKt2aZOrGtMc4f1ntWuo5AelgI+q6YOzCwqNCipLVKwhW2iR1Pb2kIsHzoKP+9MhW6woqpeW
	e0EJPOYvmXvcnB3iGkRKBkn7+sPkGR4DauHfA1DS9rkDRuUv0F+meY7lQJXSRq5ad8NDjY4KqsL
	z0+QcABuXPMsxlU1aRVNgAOzQSGglKp8XsgT+Tz7eBt/fIvDzjv6r4sSDMQ=
X-Google-Smtp-Source: AGHT+IGjlnvj+DtsjdCP6qSFmcwl+zitXoM0GsuqEA+h0yiePwmah6H33IvMzXcHTpzZgN1kxy6Rrg==
X-Received: by 2002:a17:90a:d64d:b0:2ef:67c2:4030 with SMTP id 98e67ed59e1d1-303a85c6304mr630838a91.27.1743011400261;
        Wed, 26 Mar 2025 10:50:00 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3039dff0c76sm517605a91.20.2025.03.26.10.49.59
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 10:49:59 -0700 (PDT)
Message-ID: <d311d92a-b236-4ff1-89bc-377a200e4cb4@gmail.com>
Date: Wed, 26 Mar 2025 10:49:57 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/10] station: roam blacklist BSS's, and consider when
 roaming
To: iwd@lists.linux.dev
References: <20250325180041.238676-1-prestwoj@gmail.com>
 <20250325180041.238676-7-prestwoj@gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <20250325180041.238676-7-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 3/25/25 11:00 AM, James Prestwood wrote:
> If the BSS is requesting IWD roam elsewhere add this BSS to the
> blacklist using BLACKLIST_REASON_ROAM_REQUESTED. This will lower
> the chances of IWD roaming/connecting back to this BSS in the
> future.
>
> This then allows IWD to consider this blacklist state when picking
> a roam candidate. Its undesireable to fully ban a roam blacklisted
> BSS, so some additional sorting logic has been added. Prior to
> comparing based on rank, BSS's will be sorted into 3 groups:
>
> Optimal - Not roam blacklisted, and above the roaming threshold
> Above Threshold - May be blacklisted, and above the roaming threshold
> Below Threshold - BSS is below the roaming threshold
> ---
>   src/station.c | 88 ++++++++++++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 84 insertions(+), 4 deletions(-)
>
> diff --git a/src/station.c b/src/station.c
> index e2ed78f3..e3c7c189 100644
> --- a/src/station.c
> +++ b/src/station.c
> @@ -155,6 +155,57 @@ struct anqp_entry {
>   	uint32_t pending;
>   };
>   
> +/*
> + * Rather than sorting BSS's purely based on ranking a higher level grouping
> + * is used. The purpose of this higher order grouping is the consider the BSS's
> + * roam blacklist status. The roam blacklist is a "soft" blacklist in that we
> + * still should connect to these BSS's if they are the only "good" option.
> + * The question here is: what makes a BSS "good" vs "bad".
> + *
> + * For an initial (probably nieve) approach here we can use the RoamThreshod[5G]
> + * and sort BSS's into "above" or "below" this threshold. Within each of these
> + * groups a BSS may be blacklisted, meaning it should get sorted lower on the
> + * list compared to others within the same group.
> + *
> + * Since we have several call sites needing to check/compare these groupings
> + * a bitmask can be used to describe the grouping:
> + *
> + * Each group will have 2 bits. The lower order bit signifies the BSS is in the
> + * group, but also blacklisted. The higher order bit signifies the BSS is in
> + * the group, but not blacklisted. The bitmask between two BSS's can then be
> + * compared directly similar to rank.
> + */
> +
> +#define UNDER_THRESHOLD_BIT 1
> +#define ABOVE_THRESHOLD_BIT 3
> +
> +static uint32_t evaluate_bss_group(const uint8_t *addr, uint32_t freq,
> +					int16_t signal_strength)
> +{
> +	int threshold;
> +	int signal = signal_strength / 100;
> +	bool roam_blacklist;
> +	uint32_t mask = 0;
> +
> +	if (blacklist_contains_bss(addr, BLACKLIST_REASON_CONNECT_FAILED))
> +		return mask;
> +
> +	roam_blacklist = blacklist_contains_bss(addr,
> +					BLACKLIST_REASON_ROAM_REQUESTED);
> +
> +	if (freq > 4000)
> +		netdev_get_low_signal_thresholds(NULL, &threshold);
> +	else
> +		netdev_get_low_signal_thresholds(&threshold, NULL);
> +
> +	if (signal >= threshold)
> +		set_bit(&mask, ABOVE_THRESHOLD_BIT - roam_blacklist);
> +	else
> +		set_bit(&mask, UNDER_THRESHOLD_BIT - roam_blacklist);
> +
> +	return mask;
> +}
> +
>   /*
>    * Used as entries for the roam list since holding scan_bss pointers directly
>    * from station->bss_list is not 100% safe due to the possibility of the
> @@ -164,11 +215,13 @@ struct roam_bss {
>   	uint8_t addr[6];
>   	uint16_t rank;
>   	int32_t signal_strength;
> +	uint32_t group;
>   	bool ft_failed: 1;
>   };
>   
>   static struct roam_bss *roam_bss_from_scan_bss(const struct scan_bss *bss,
> -						uint16_t rank)
> +						uint16_t rank,
> +						uint32_t group)
>   {
>   	struct roam_bss *rbss = l_new(struct roam_bss, 1);
>   
> @@ -176,6 +229,7 @@ static struct roam_bss *roam_bss_from_scan_bss(const struct scan_bss *bss,
>   	rbss->rank = rank;
>   	rbss->signal_strength = bss->signal_strength;
>   	rbss->ft_failed = false;
> +	rbss->group = group;
>   
>   	return rbss;
>   }
> @@ -184,6 +238,12 @@ static int roam_bss_rank_compare(const void *a, const void *b, void *user_data)
>   {
>   	const struct roam_bss *new_bss = a, *bss = b;
>   
> +	if (bss->group > new_bss->group)
> +		return 1;
> +	else if (bss->group < new_bss->group)
> +		return -1;
> +
> +	/* BSS's both have the same group, sort by rank */
>   	if (bss->rank == new_bss->rank)
>   		return (bss->signal_strength >
>   					new_bss->signal_strength) ? 1 : -1;
> @@ -2805,6 +2865,7 @@ static bool station_roam_scan_notify(int err, struct l_queue *bss_list,
>   	struct handshake_state *hs = netdev_get_handshake(station->netdev);
>   	struct scan_bss *current_bss = station->connected_bss;
>   	struct scan_bss *bss;
> +	uint32_t cur_bss_group = 0;
>   	double cur_bss_rank = 0.0;
>   	static const double RANK_FT_FACTOR = 1.3;
>   	uint16_t mdid;
> @@ -2835,6 +2896,9 @@ static bool station_roam_scan_notify(int err, struct l_queue *bss_list,
>   	bss = l_queue_find(bss_list, bss_match_bssid, current_bss->addr);
>   	if (bss && !station->ap_directed_roaming) {
>   		cur_bss_rank = bss->rank;
> +		cur_bss_group = evaluate_bss_group(current_bss->addr,
> +						current_bss->frequency,
> +						current_bss->signal_strength);
This is what caused the CI to fail on testPSK-roam. Instead I should 
have done the group evaluation on the "bss" pointer, not "current_bss". 
This will take into account the most recent scan, rather than the stale 
object we have from past scans.
>   
>   		if (hs->mde && bss->mde_present && l_get_le16(bss->mde) == mdid)
>   			cur_bss_rank *= RANK_FT_FACTOR;
> @@ -2859,6 +2923,9 @@ static bool station_roam_scan_notify(int err, struct l_queue *bss_list,
>   	while ((bss = l_queue_pop_head(bss_list))) {
>   		double rank;
>   		struct roam_bss *rbss;
> +		uint32_t group = evaluate_bss_group(bss->addr,
> +							bss->frequency,
> +							bss->signal_strength);
>   
>   		station_print_scan_bss(bss);
>   
> @@ -2889,7 +2956,15 @@ static bool station_roam_scan_notify(int err, struct l_queue *bss_list,
>   		if (hs->mde && bss->mde_present && l_get_le16(bss->mde) == mdid)
>   			rank *= RANK_FT_FACTOR;
>   
> -		if (rank <= cur_bss_rank)
> +		/*
> +		 * First check the group:
> +		 *   - If worse, disregard BSS candidate
> +		 *   - If better, keep BSS candidate
> +		 *   - If equal, compare based on rank
> +		 */
> +		if (group < cur_bss_group)
> +			goto next;
> +		else if (group == cur_bss_group && rank <= cur_bss_rank)
>   			goto next;
>   
>   		/*
> @@ -2898,7 +2973,7 @@ static bool station_roam_scan_notify(int err, struct l_queue *bss_list,
>   		 */
>   		station_update_roam_bss(station, bss);
>   
> -		rbss = roam_bss_from_scan_bss(bss, rank);
> +		rbss = roam_bss_from_scan_bss(bss, rank, group);
>   
>   		l_queue_insert(station->roam_bss_list, rbss,
>   				roam_bss_rank_compare, NULL);
> @@ -3268,6 +3343,10 @@ static void station_ap_directed_roam(struct station *station,
>   	l_timeout_remove(station->roam_trigger_timeout);
>   	station->roam_trigger_timeout = NULL;
>   
> +	blacklist_add_bss(station->connected_bss->addr,
> +				BLACKLIST_REASON_ROAM_REQUESTED);
> +	station_debug_event(station, "ap-roam-blacklist-added");
> +
>   	if (req_mode & WNM_REQUEST_MODE_PREFERRED_CANDIDATE_LIST) {
>   		l_debug("roam: AP sent a preferred candidate list");
>   		station_neighbor_report_cb(station->netdev, 0, body + pos,
> @@ -5344,7 +5423,8 @@ static bool station_force_roam_scan_notify(int err, struct l_queue *bss_list,
>   	/* The various roam routines expect this to be set from scanning */
>   	station->preparing_roam = true;
>   	l_queue_push_tail(station->roam_bss_list,
> -				roam_bss_from_scan_bss(target, target->rank));
> +				roam_bss_from_scan_bss(target, target->rank,
> +				0xffff));
>   
>   	station_update_roam_bss(station, target);
>   
