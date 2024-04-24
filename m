Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34C6159919
	for <iwd@lists.linux.dev>; Wed, 24 Apr 2024 12:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713960356; cv=none; b=BlIqbgDfXR9un3+2zHjt07js+w+rBKvxKBs6PvNPvfJTb9Jc/LpdOKAqy618ixZJDBaw55vxZsrcfs+KaI9i4uf3sk8OwkjjhQ9UwdWds0LkQC5rQkCZqFJZFrQctvRu9q4m6skLo7qHhze5jLTLuQncJIaSQyHHSA5tGc8eMhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713960356; c=relaxed/simple;
	bh=Xs1O5F9HglwBYGxbnzco1XAw3lw90pQGTZGr8a8T7xk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ey/1dpkm2eZP9gsXmpp5p17JtgUF8OYiZYr6gQ1MeEx0KXPk24JeI32oYAWYEfYKE3+zfy4Fnh08adanz6/noyjCejSsgm9bzoDFIM/spQKNUmnGkRlKxp3GMWsiB2TSZ7vyMYapzVNxyInpJUSsioOKyg4l5WwX4wbIrkrMz9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TnbPTUFG; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TnbPTUFG"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6eb7ee5a776so4063671a34.3
        for <iwd@lists.linux.dev>; Wed, 24 Apr 2024 05:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713960354; x=1714565154; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Znqdr+BxPPs6cNLUAxAKSYlLZuWN0ROIuR+E6TMB2AM=;
        b=TnbPTUFGStRqKkQ6nqCI//DqQ34N65btRO2Ghznwi/iQ8uwzQzMCresXVLsGgcZYlS
         /VUmnd+mq8u6lLmTjjP44LB8OfswRZhI2iHjdzG6onuJfGWgOmf7l5OLHa+ZFuQ5dpwV
         5pnMkD9sf8/ZAUfNn/6+rqh3A8DS26XLju8/Bbc8qptSleXaZQ9aPGWdRx7mlUqnzHIp
         OnoBxcjEfarg359c+6vhC6KptSidUPI1UU4iKK/b/V01zQKmDFbOCVId6JSB7175nEhg
         DhI7JL+nof6JEyXSdiUjCIRRLctb09D7fFpSCEiM9eO9FRJrsGOJPJHY2gViefmQlxWb
         EZKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713960354; x=1714565154;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Znqdr+BxPPs6cNLUAxAKSYlLZuWN0ROIuR+E6TMB2AM=;
        b=CUegqpsiJOG5a45eoYGRP7hxkbHtkEku2MJVfiPL0GsAr8bTp8MpZ3pTSHSrjVUHU9
         4W1n6OpEyxD7J7s6+yh9h5p1qST7DWy7xmJmfuaAvkKAb0tRyYvfg92KsW4kiEEFuzHN
         AiC5Kbh+uMrm4hjc8W8ybXeUMQ/RK9h4Ar8xlQzBRG13z5rFLQLkfnEvwU/a+nT0fxNw
         HnxsNwLLhSXwBuZeYDuNZRvA0esavb3wfp1HBQW6/VScRIG/yhHPtk8hK5LkwPuiVWGg
         0+cCYhkCUJWpkEP0k27Axv4vHXHZp28dxLD3dV3YFfC75OoWozWD4quCTolU7SLdFkZM
         421A==
X-Forwarded-Encrypted: i=1; AJvYcCW3tluAeUvbzVe34VS7VLSftgjE6+ysPQYoxxst2O9bey/bllaqecjnlCZ6VhYYbIc8+77FXUUG9gBnLU60wAYZvcGM
X-Gm-Message-State: AOJu0YxtKbKIIYwYxQ+sctPABAmd4jXuCOGtxVI1Eg039/5nSzP3t41B
	xX5gdYopwG7sU57OYkbxEBmZchiKW5Br6+AMgmR6/t3XG+CjQ6Uq
X-Google-Smtp-Source: AGHT+IEHgGUlFex7ZZkiEBm8yS5M3hvB9VckU6lqxs0TbbjIka2YuMQcph3j3WvuoOgqlrAxN4p1Rw==
X-Received: by 2002:a05:6808:68b:b0:3c7:4c0e:5389 with SMTP id k11-20020a056808068b00b003c74c0e5389mr2006742oig.14.1713960353861;
        Wed, 24 Apr 2024 05:05:53 -0700 (PDT)
Received: from [10.102.4.159] ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id r15-20020a0c8d0f000000b006a045780b77sm3393748qvb.51.2024.04.24.05.05.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 05:05:53 -0700 (PDT)
Message-ID: <1e152991-95dc-4348-9723-ff5de9fcf9c4@gmail.com>
Date: Wed, 24 Apr 2024 05:05:52 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] ap: accept PSK/SAE in auth depending on config
Content-Language: en-US
To: John Brandt <brandtwjohn@gmail.com>, iwd@lists.linux.dev
References: <20240421125050.6649-1-brandtwjohn@gmail.com>
 <20240421125050.6649-3-brandtwjohn@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <20240421125050.6649-3-brandtwjohn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi John,

On 4/21/24 5:50 AM, John Brandt wrote:
> On reception of an authentication frame, accept both PSK and SAE as AKM
> depending on the config. Save the client's AKM for later use.
> ---
>   src/ap.c | 28 +++++++++++++++++++++-------
>   1 file changed, 21 insertions(+), 7 deletions(-)
>
> diff --git a/src/ap.c b/src/ap.c
> index d50f9e4f..14268551 100644
> --- a/src/ap.c
> +++ b/src/ap.c
> @@ -132,6 +132,7 @@ struct sta_state {
>   	uint8_t *assoc_ies;
>   	size_t assoc_ies_len;
>   	uint8_t *assoc_rsne;
> +	enum ie_rsn_akm_suite akm_suite;
>   	struct eapol_sm *sm;
>   	struct handshake_state *hs;
>   	uint32_t gtk_query_cmd_id;
> @@ -2606,6 +2607,7 @@ static void ap_auth_cb(const struct mmpdu_header *hdr, const void *body,
>   	const uint8_t *from = hdr->address_2;
>   	const uint8_t *bssid = netdev_get_address(ap->netdev);
>   	struct sta_state *sta;
> +	enum ie_rsn_akm_suite akm_suite;
>   
>   	l_info("AP Authentication from %s", util_address_to_string(from));
>   
> @@ -2627,17 +2629,27 @@ static void ap_auth_cb(const struct mmpdu_header *hdr, const void *body,
>   		}
>   	}
>   
> -	/* Only Open System authentication implemented here */
> -	if (L_LE16_TO_CPU(auth->algorithm) !=
> -			MMPDU_AUTH_ALGO_OPEN_SYSTEM) {
> +	if ((ap->akm_suites & IE_RSN_AKM_SUITE_SAE_SHA256) &&
> +	    (L_LE16_TO_CPU(auth->algorithm) == MMPDU_AUTH_ALGO_SAE) ) {
> +		/* When using SAE it must be COMMIT or CONFIRM frame */
> +		if (L_LE16_TO_CPU(auth->transaction_sequence) > 2) {
Probably want to explicitly check for a transaction of 1 or 2. This 
allows zero.
> +			ap_auth_reply(ap, from, MMPDU_REASON_CODE_UNSPECIFIED);
> +			return;
> +		}
> +		akm_suite = IE_RSN_AKM_SUITE_SAE_SHA256;
> +	} else if ((ap->akm_suites & IE_RSN_AKM_SUITE_PSK) &&
> +		   (L_LE16_TO_CPU(auth->algorithm) == MMPDU_AUTH_ALGO_OPEN_SYSTEM) ) {
> +		/* When using PSK it must be Open System authentication */
> +		if (L_LE16_TO_CPU(auth->transaction_sequence) != 1) {
> +			ap_auth_reply(ap, from, MMPDU_REASON_CODE_UNSPECIFIED);
> +			return;
> +		}
> +		akm_suite = IE_RSN_AKM_SUITE_PSK;
> +	} else {
>   		ap_auth_reply(ap, from, MMPDU_REASON_CODE_UNSPECIFIED);
>   		return;
>   	}
>   
> -	if (L_LE16_TO_CPU(auth->transaction_sequence) != 1) {
> -		ap_auth_reply(ap, from, MMPDU_REASON_CODE_UNSPECIFIED);
> -		return;
> -	}
>   
>   	sta = l_queue_find(ap->sta_states, ap_sta_match_addr, from);
>   
> @@ -2666,6 +2678,8 @@ static void ap_auth_cb(const struct mmpdu_header *hdr, const void *body,
>   	if (!ap->sta_states)
>   		ap->sta_states = l_queue_new();
>   
> +	sta->akm_suite = akm_suite;
> +
>   	l_queue_push_tail(ap->sta_states, sta);
>   
>   	/*
