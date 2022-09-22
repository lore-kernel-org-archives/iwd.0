Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E321FBA
	for <iwd@lists.linux.dev>; Thu, 22 Sep 2022 03:09:26 +0000 (UTC)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-1278624b7c4so12019804fac.5
        for <iwd@lists.linux.dev>; Wed, 21 Sep 2022 20:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=r6D2cv4n7aOIqP+B519t9Myxxa1dE0+jpgdNDKNP1A0=;
        b=kxhat3wpgRQPlQVgwHTP4duhbntllxDNx4I7TrFcxItPxeEBKlQJMsHHYjW8QmWC/9
         sQRPm28WMqLR2GzPgORmPjEjB2xWBjW3yOyp7MQYiEpPzsCkiFLufdOqgcELG2TN1lxy
         Hzvg1h7St2uxcWLn2NG9b4KHq/6l/qaTWqQnDORPx9hIr+gaxkbmvbtcBfKmqVj1KUA0
         ioZlxhNCxyoXxJ/9y1pa3Z6T/7sR3emeH6YdtOlhD4h+Q7OLwwXNyWFaiL5bBdVkfop0
         FmbMOW/XYsyUTBRdOZCaoomSLP6GBRKV6x8Zw41a/4PhwdmI1i0arDhopRoSMn/zI7Ks
         3lxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=r6D2cv4n7aOIqP+B519t9Myxxa1dE0+jpgdNDKNP1A0=;
        b=EDJRR0ziy3voA4aBA8r1VAeJ5Q/5mj2G6icb4BROubWXUS93WflKrDD5uQCTvFHSaQ
         FVJr49nv1e08DkpxpS1nImoGvvPnUI9dJ7K2j3koEjZXqOxRjHz+MMDcPFuA2lCao+dK
         c2cypjKReXxEww/xE3s030STt90HVySc1ZmAtKa1QJTP3P8LPf6QZNblbyUcvG1n0p2q
         pNk5w+/2A5R9EMYGWey8L6MGTgqDJDIl7sCDghviLzfurawaGcwdqoxr7+AWfDqGmQGt
         /SZboFzAWzMvuelApDNAsVJQy7pLK4deilPPGf/8KXpnhHc1FlBxp1WQ6p3drggn1Ls+
         gouQ==
X-Gm-Message-State: ACrzQf2ZQFn2DU5VoU0GLpB+eO+95ERwzf5l3z/H7xjDJd4ao4azvXoO
	Z7UYLWIQ1LASBUxKcCSAVha6QK1FF0U=
X-Google-Smtp-Source: AMsMyM4KaEONlX2qbsiWfsS5p2wfLQcDVqrjQyOvyUfEuXEzWCJ78r6iXpS0Vty9uTfwiMTcCb2UfA==
X-Received: by 2002:a05:6870:249c:b0:10c:7f4d:71ab with SMTP id s28-20020a056870249c00b0010c7f4d71abmr728672oaq.15.1663816166133;
        Wed, 21 Sep 2022 20:09:26 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id cg11-20020a056830630b00b0063715f7eef8sm2197107otb.38.2022.09.21.20.09.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 20:09:25 -0700 (PDT)
Message-ID: <eba7624c-2a97-579a-dfaf-6d302e37ff52@gmail.com>
Date: Wed, 21 Sep 2022 22:09:24 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 08/15] station: create list of roam candidates
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20220921223158.704658-1-prestwoj@gmail.com>
 <20220921223158.704658-8-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220921223158.704658-8-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 9/21/22 17:31, James Prestwood wrote:
> The current behavior is to only find the best roam candidate, which
> generally is fine. But if for whatever reason IWD fails to roam it
> would be nice having a few backup BSS's rather than having to
> re-scan, or worse disassociate and reconnect entirely.
> 
> This patch doesn't change the roam behavior, just prepares for
> using a roam candidate list. One difference though is any roam
> candidates are added to station->bss_list, rather than just the
> best BSS. This shouldn't effect any external behavior.
> 
> The candidate list is built based on scan_bss rank. First we establish
> a base rank, the rank of the current BSS (or zero if AP roaming). Any
> BSS in the results with a higher rank, excluding the current BSS, will
> be added to the sorted station->roam_bss_list as well as stations
> overall BSS list. If the resulting list is empty there were no better
> BSS's, otherwise station can now try to roam starting with the best
> candidate (head of the roam list).
> ---
>   src/station.c | 84 +++++++++++++++++++++++++++++++++------------------
>   1 file changed, 54 insertions(+), 30 deletions(-)
> 
> diff --git a/src/station.c b/src/station.c
> index 868bb725..df54936e 100644
> --- a/src/station.c
> +++ b/src/station.c
> @@ -107,6 +107,7 @@ struct station {
>   
>   	/* Set of frequencies to scan first when attempting a roam */
>   	struct scan_freq_set *roam_freqs;
> +	struct l_queue *roam_bss_list;
>   
>   	/* Frequencies split into subsets by priority */
>   	struct scan_freq_set *scan_freqs_order[3];
> @@ -1640,6 +1641,11 @@ static void station_roam_state_clear(struct station *station)
>   		scan_freq_set_free(station->roam_freqs);
>   		station->roam_freqs = NULL;
>   	}
> +
> +	if (station->roam_bss_list) {
> +		l_queue_destroy(station->roam_bss_list, NULL);
> +		station->roam_bss_list = NULL;

Maybe I'm nitpicking, but why would you destroy the roam_bss_list queue itself? 
  Wouldn't just clearing it be enough?  There's not much sense in destroying / 
re-creating the queue itself all the time.

> +	}
>   }
>   
>   static void station_reset_connection_state(struct station *station)
> @@ -1981,6 +1987,11 @@ static void station_roamed(struct station *station)
>   			l_warn("Could not request neighbor report");
>   	}
>   
> +	if (station->roam_bss_list) {
> +		l_queue_destroy(station->roam_bss_list, NULL);
> +		station->roam_bss_list = NULL;
> +	}
> +

as above?

>   	station_ft_ds_action_start(station);
>   
>   	station_enter_state(station, STATION_STATE_CONNECTED);
> @@ -2005,6 +2016,11 @@ static void station_roam_failed(struct station *station)
>   {
>   	l_debug("%u", netdev_get_ifindex(station->netdev));
>   
> +	if (station->roam_bss_list) {
> +		l_queue_destroy(station->roam_bss_list, NULL);
> +		station->roam_bss_list = NULL;
> +	}
> +

And here

>   	/*
>   	 * If we attempted a reassociation or a fast transition, and ended up
>   	 * here then we are now disconnected.
> @@ -2186,8 +2202,7 @@ static void station_preauthenticate_cb(struct netdev *netdev,
>   	station_transition_reassociate(station, bss, new_hs);
>   }
>   
> -static void station_transition_start(struct station *station,
> -							struct scan_bss *bss)
> +static void station_transition_start(struct station *station)
>   {
>   	struct handshake_state *hs = netdev_get_handshake(station->netdev);
>   	struct network *connected = station->connected_network;
> @@ -2195,6 +2210,7 @@ static void station_transition_start(struct station *station,
>   	struct handshake_state *new_hs;
>   	struct ie_rsn_info cur_rsne, target_rsne;
>   	int ret;
> +	struct scan_bss *bss = l_queue_peek_head(station->roam_bss_list);
>   
>   	l_debug("%u, target %s", netdev_get_ifindex(station->netdev),
>   			util_address_to_string(bss->addr));
> @@ -2334,12 +2350,10 @@ static bool station_roam_scan_notify(int err, struct l_queue *bss_list,
>   	struct handshake_state *hs = netdev_get_handshake(station->netdev);
>   	struct scan_bss *current_bss = station->connected_bss;
>   	struct scan_bss *bss;
> -	struct scan_bss *best_bss = NULL;
> -	double best_bss_rank = 0.0;
> +	double cur_bss_rank = 0.0;
>   	static const double RANK_FT_FACTOR = 1.3;
>   	uint16_t mdid;
>   	enum security orig_security, security;
> -	bool seen = false;
>   
>   	if (err) {
>   		station_roam_failed(station);
> @@ -2358,6 +2372,21 @@ static bool station_roam_scan_notify(int err, struct l_queue *bss_list,
>   		ie_parse_mobility_domain_from_data(hs->mde, hs->mde[1] + 2,
>   							&mdid, NULL, NULL);
>   
> +	station->roam_bss_list = l_queue_new();

That way you can create it only in station_new, free it in station_free()

Rest LGTM.

Regards,
-Denis
