Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57BD1DA3D
	for <iwd@lists.linux.dev>; Wed, 13 Dec 2023 17:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWrDPr8H"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5913922ab10so1382752eaf.1
        for <iwd@lists.linux.dev>; Wed, 13 Dec 2023 09:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702488766; x=1703093566; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O5+t81BSAg1sIIL4qbK4V0A9N11wuhMBBe8S9fKlU3g=;
        b=PWrDPr8Hoi6J/8o5XrzKioTU5xxc7RjkKnOt+fdNL0iz+KxhMcq5g+/B2WdKZJiR2R
         CkcUYLXnu3cbjCJTl39DblNwsCTpmT5AUnowOD1ZPdr9ljABWYhLotWJqzSuHvitdTBm
         VxBP8Ob5PUok/ivAdRgpoJ+Rk6gRhOydqUHiMbVX7oyB28N3FJnpNx7x0ux4MH5UuXag
         5oaSAqvDcN/1tU0ED5fybeN9AaDPAW209Jq7Esza2tCaLhW6aKHpyHyvWmJnQY3HBSVp
         NIg8QIABp1qbrl7VKrvQqn6SHHuRC59gN7yhdtatHDMC0XBCAqRM2IyEGWN+VXytRm2q
         umhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702488766; x=1703093566;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O5+t81BSAg1sIIL4qbK4V0A9N11wuhMBBe8S9fKlU3g=;
        b=C+XcQDeME8aW9VrMPmlorx9vlgWSy6P1+1Wrfkuoo6pyQUZ0vYaNBBF3CcBCClnbQO
         UF9nMNn2+ic5TT4I46fG6JWGUqDWdpdWNxbEidxP124xfadOxvAGg9pj1b29dYnnWnuc
         A9zGXYngw80/9TwRBl2pxr/09XlsBbRyBeIFhnyXoMECG2wmJ/J/y3bjC8WVczZSMP4i
         Zg9MSDksvi6UJXpovclyBDrVziaWbY0I/VN6QynUIrw8nGCyLRpq7oErczKQYEY/mPJb
         nAyXx3maJ2Ch0RS4bbffC0G8NJNWSykTjXHJw4OxcKgXBggBuGHjDzzndRlTHy4pAhfa
         jdGQ==
X-Gm-Message-State: AOJu0YwMft6wKJ8GEGWHbjEy9agfby7GSZ14zCtgKhL1eBZBkVIFx1KT
	DC2ldENKQTHPx/iarF9bQeKFE8jz8bc=
X-Google-Smtp-Source: AGHT+IEilIRQWMWsjBEPMZROm/yPft1Y5sE3W+LPA8n/nHcqh9YS1hqyrFc+kdLeCmS+QBhWj9Vmqg==
X-Received: by 2002:a05:6358:5e04:b0:16d:e151:a7d8 with SMTP id q4-20020a0563585e0400b0016de151a7d8mr5336252rwn.14.1702488766298;
        Wed, 13 Dec 2023 09:32:46 -0800 (PST)
Received: from [10.102.4.159] ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id c16-20020a05620a11b000b0076efaec147csm4644161qkk.45.2023.12.13.09.32.45
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 09:32:46 -0800 (PST)
Message-ID: <bd054f31-541e-46ff-adf7-0cadbfacbf15@gmail.com>
Date: Wed, 13 Dec 2023 09:32:43 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/4] station: unify scan cancelation
Content-Language: en-US
To: iwd@lists.linux.dev
References: <20231213172546.145998-1-prestwoj@gmail.com>
 <20231213172546.145998-3-prestwoj@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <20231213172546.145998-3-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 12/13/23 09:25, James Prestwood wrote:
> The scan cancelation was all being done manually so group all the
> automatic-type scans into a single cancel function. This includes
> hidden, quick, owe, and periodic scans.
>
> This is being done in order to avoid scan failures after DPP
> initiates a connection. This is ultimately done through
> __station_connect_network which has no cancelation logic. This
> patch will move the scan cancelation into station_enter_state
> when the state changes to CONNECTING. All the mentioned scans will
> be canceled at that point.
>
> DBus scans were left out intentionally as they are an explicit
> type of scan rather than one that IWD starts on its own.
> ---
>   src/station.c | 96 +++++++++++++++++++++++----------------------------
>   1 file changed, 43 insertions(+), 53 deletions(-)
>
> diff --git a/src/station.c b/src/station.c
> index 10860808..95ffee05 100644
> --- a/src/station.c
> +++ b/src/station.c
> @@ -279,16 +279,8 @@ static int station_autoconnect_next(struct station *station)
>   			bss->signal_strength);
>   
>   		r = network_autoconnect(network, bss);
> -		if (!r) {
> -			if (station->quick_scan_id) {
> -				scan_cancel(netdev_get_wdev_id(station->netdev),
> -						station->quick_scan_id);
> -				station->quick_scan_id = 0;
> -				station_property_set_scanning(station, false);
> -			}
> -
> +		if (!r)
>   			return 0;
> -		}
>   
>   		l_debug("autoconnect: network_autoconnect: %s (%d)",
>   							strerror(-r), r);
> @@ -1542,6 +1534,36 @@ static void station_set_drop_unicast_l2_multicast(struct station *station,
>   
>   static void station_signal_agent_notify(struct station *station);
>   
> +static void station_cancel_scans(struct station *station)
> +{
> +	if (station->hidden_network_scan_id) {
> +		scan_cancel(netdev_get_wdev_id(station->netdev),
> +				station->hidden_network_scan_id);
> +
> +		dbus_pending_reply(&station->hidden_pending,
> +				dbus_error_failed(station->hidden_pending));
> +	}
> +
> +	if (station->quick_scan_id) {
> +		scan_cancel(netdev_get_wdev_id(station->netdev),
> +				station->quick_scan_id);
> +		station->quick_scan_id = 0;
> +		station_property_set_scanning(station, false);
> +	}
> +
> +	if (station->owe_hidden_scan_ids) {
> +		void *ptr;
> +
> +		while ((ptr = l_queue_pop_head(station->owe_hidden_scan_ids)))
> +			scan_cancel(netdev_get_wdev_id(station->netdev),
> +					L_PTR_TO_UINT(ptr));
> +
> +		l_queue_destroy(station->owe_hidden_scan_ids, NULL);
Just realized I should set this to NULL here or we could reference it 
somewhere else after its freed.
> +	}
> +
> +	periodic_scan_stop(station);
> +}
> +
>   static void station_enter_state(struct station *station,
>   						enum station_state state)
>   {
> @@ -1594,7 +1616,9 @@ static void station_enter_state(struct station *station,
>   		if (station->signal_agent)
>   			station_signal_agent_notify(station);
>   
> -		periodic_scan_stop(station);
> +		/* Scans issued during a connection will fail */
> +		station_cancel_scans(station);
> +
>   		break;
>   	case STATION_STATE_CONNECTED:
>   		l_dbus_object_add_interface(dbus,
> @@ -3539,27 +3563,15 @@ void station_connect_network(struct station *station, struct network *network,
>   	struct l_dbus *dbus = dbus_get_bus();
>   	int err;
>   
> -	/*
> -	 * If a hidden scan is not completed, station_is_busy would not
> -	 * indicate anything is going on so we need to cancel the scan and
> -	 * fail the connection now.
> -	 */
> -	if (station->hidden_network_scan_id) {
> -		scan_cancel(netdev_get_wdev_id(station->netdev),
> -				station->hidden_network_scan_id);
> -
> -		dbus_pending_reply(&station->hidden_pending,
> -				dbus_error_failed(station->hidden_pending));
> -	}
> -
> -	if (station->quick_scan_id) {
> -		scan_cancel(netdev_get_wdev_id(station->netdev),
> -				station->quick_scan_id);
> -		station->quick_scan_id = 0;
> -		station_property_set_scanning(station, false);
> -	}
> -
>   	if (station_is_busy(station)) {
> +		/*
> +		 * All scans will be canceled when entering into a connecting
> +		 * state but since we have an async disconnect callback cancel
> +		 * them early so we don't potentially trigger a scan in the
> +		 * middle of connecting. This also takes care of failing any
> +		 * hidden network connection
> +		 */
> +		station_cancel_scans(station);
>   		station_disconnect_onconnect(station, network, bss, message);
>   
>   		return;
> @@ -4539,8 +4551,6 @@ static void station_free(struct station *station)
>   		station->netconfig = NULL;
>   	}
>   
> -	periodic_scan_stop(station);
> -
>   	if (station->signal_agent) {
>   		station_signal_agent_release(station->signal_agent,
>   					netdev_get_path(station->netdev));
> @@ -4551,10 +4561,6 @@ static void station_free(struct station *station)
>   		dbus_pending_reply(&station->connect_pending,
>   				dbus_error_aborted(station->connect_pending));
>   
> -	if (station->hidden_pending)
> -		dbus_pending_reply(&station->hidden_pending,
> -				dbus_error_aborted(station->hidden_pending));
> -
>   	if (station->disconnect_pending)
>   		dbus_pending_reply(&station->disconnect_pending,
>   			dbus_error_aborted(station->disconnect_pending));
> @@ -4567,23 +4573,7 @@ static void station_free(struct station *station)
>   		scan_cancel(netdev_get_wdev_id(station->netdev),
>   				station->dbus_scan_id);
>   
> -	if (station->quick_scan_id)
> -		scan_cancel(netdev_get_wdev_id(station->netdev),
> -				station->quick_scan_id);
> -
> -	if (station->hidden_network_scan_id)
> -		scan_cancel(netdev_get_wdev_id(station->netdev),
> -				station->hidden_network_scan_id);
> -
> -	if (station->owe_hidden_scan_ids) {
> -		void *ptr;
> -
> -		while ((ptr = l_queue_pop_head(station->owe_hidden_scan_ids)))
> -			scan_cancel(netdev_get_wdev_id(station->netdev),
> -					L_PTR_TO_UINT(ptr));
> -
> -		l_queue_destroy(station->owe_hidden_scan_ids, NULL);
> -	}
> +	station_cancel_scans(station);
>   
>   	station_roam_state_clear(station);
>   
