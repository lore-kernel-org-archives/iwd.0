Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209AC3ADB92
	for <iwd@lists.linux.dev>; Wed,  8 Jul 2026 08:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783498348; cv=none; b=hKuLHLzQxRFQ3eGfo3q2rSGrui1MCtaQZkV6FXrQzarpa4kya6PJKsbc4MrFT6N886dC0uHNbjiOa6a+xzsPUWHAWFjToBbWuRBOyYw8a6cMz57Sxka3KWTn9Be/LkSlrIQjNryu2ACpzd2QXHni7DiipSiddkrQeX2/xiSdqj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783498348; c=relaxed/simple;
	bh=1hCYx/4UFD3nvwlKwgKZD2Q3ftW0dVgU625SThqPlbM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=jBBWwxYg0QsyyB/OVFg3aGxXFxC3Kr1Yz6pLPNLDD0HwYoMt5LgKjB5krSGx/Fm8cD4x1AMda3spBl1EGW84CBkRughsoCp9/irHscdzfJamCTZCHPXkuQneWlgUvIBLIT/7ziOMr2/Tvmz6Buhf98XxeiQnCf6BdjL6KL3iZa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.44.204] (unknown [185.238.219.19])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id CE7704C1A25A01;
	Wed, 08 Jul 2026 10:12:12 +0200 (CEST)
Message-ID: <d2b4a6d8-9ca4-4865-befa-8f28168a2473@molgen.mpg.de>
Date: Wed, 8 Jul 2026 10:12:09 +0200
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Three bugfixes for iwd SEGVs at receipt of EAPOL M1 msg
 with legacy roaming and repeated roam scan after ft_auth-/ft_reassoc-timeout
 occurred:
To: dierk.modrow.opensource@gmail.com
References: <20260708061651.299-1-dierk.modrow.opensource@gmail.com>
Content-Language: en-US
Cc: iwd@lists.linux.dev, dierk.modrow@sew-eurodrive.de
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260708061651.299-1-dierk.modrow.opensource@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Dierk,


Thank you for your patch.

Am 08.07.26 um 08:16 schrieb dierk.modrow.opensource@gmail.com:
> From: DEMODDIE <dierk.modrow@sew-eurodrive.de>

DEMODDIE doesn’t look right. `git config --global user.name "Dierk 
Modrow"` and `git commit --amend --author="Dierk Modrow 
<dierk.modrow@sew-eurodrive.de>" should help.

>    src/eapol.c: next try for a fix of SEGV fault at eapol_rx_packets when using mwifiex / NXP 88W9098 driver
>    src/station.c: potential bugfix in station_roam_scan_notify to avoid NULL-Ptr access to var hs
>    src/station.c: next try to fix a SEGV after auth timeout at FT roaming

It’d be great if you could make one commit for each bug.

> ---
>   src/eapol.c   |  4 ++++
>   src/station.c | 12 ++++++------
>   2 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/src/eapol.c b/src/eapol.c
> index 372549c6..c2dc4e4c 100644
> --- a/src/eapol.c
> +++ b/src/eapol.c
> @@ -2824,6 +2824,10 @@ void eapol_register(struct eapol_sm *sm)
>   
>   	l_queue_push_head(state_machines, sm);
>   
> +	/* workaround against SEGV on fct. eapol_rx_packet by avoiding for two different eapol_frame_watches with different ids, but same eapol_sm ptr */
> +	if ((sm->watch_id > 0) && eapol_frame_watch_remove(sm->watch_id)) {
> +		l_debug("existing frame_watch for sm=%p with id=%u successfully removed", sm, sm->watch_id);
> +	}
>   	sm->watch_id = eapol_frame_watch_add(sm->handshake->ifindex,
>   						rx_handler, sm);
>   	sm->protocol_version = sm->handshake->proto_version;
> diff --git a/src/station.c b/src/station.c
> index 8fcf8c70..077e510e 100644
> --- a/src/station.c
> +++ b/src/station.c
> @@ -2253,7 +2253,7 @@ static bool station_can_fast_transition(struct station *station,
>   {
>   	uint16_t mdid;
>   
> -	if (!hs->mde)
> +	if (!hs || !hs->mde)
>   		return false;
>   
>   	if (ie_parse_mobility_domain_from_data(hs->mde, hs->mde[1] + 2,
> @@ -2917,7 +2917,7 @@ static bool station_roam_scan_notify(int err, struct l_queue *bss_list,
>   
>   	orig_security = network_get_security(network);
>   
> -	if (hs->mde)
> +	if (hs && hs->mde)
>   		ie_parse_mobility_domain_from_data(hs->mde, hs->mde[1] + 2,
>   							&mdid, NULL, NULL);
>   
> @@ -2930,7 +2930,7 @@ static bool station_roam_scan_notify(int err, struct l_queue *bss_list,
>   	if (bss && !station->ap_directed_roaming) {
>   		double cur_bss_rank = bss->rank;
>   
> -		if (hs->mde && bss->mde_present && l_get_le16(bss->mde) == mdid)
> +		if (hs && hs->mde && bss->mde_present && l_get_le16(bss->mde) == mdid)
>   			cur_bss_rank *= RANK_FT_FACTOR;
>   
>   		cur_bss_group_rank = evaluate_bss_group_rank(bss->addr,
> @@ -2967,8 +2967,8 @@ static bool station_roam_scan_notify(int err, struct l_queue *bss_list,
>   			goto next;
>   
>   		/* Skip result if it is not part of the ESS */
> -		if (bss->ssid_len != hs->ssid_len ||
> -				memcmp(bss->ssid, hs->ssid, hs->ssid_len))
> +		if (hs && (bss->ssid_len != hs->ssid_len ||
> +				memcmp(bss->ssid, hs->ssid, hs->ssid_len)))
>   			goto next;
>   
>   		if (scan_bss_get_security(bss, &security) < 0)
> @@ -2986,7 +2986,7 @@ static bool station_roam_scan_notify(int err, struct l_queue *bss_list,
>   
>   		rank = bss->rank;
>   
> -		if (hs->mde && bss->mde_present && l_get_le16(bss->mde) == mdid)
> +		if (hs && hs->mde && bss->mde_present && l_get_le16(bss->mde) == mdid)
>   			rank *= RANK_FT_FACTOR;
>   
>   		group_rank = evaluate_bss_group_rank(bss->addr, bss->frequency,


Kind regards,

Paul
