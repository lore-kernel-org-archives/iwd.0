Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B1B1B6D06
	for <iwd@lists.linux.dev>; Wed, 28 May 2025 17:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748454481; cv=none; b=Nibs+6aFkN5M0CpKubGsfuWJDcsC7joaM4n8DZ39Wg7v5+x9ionVfVJU1lBbmsD4MH5fMpzQkVOdV5Z7LO7A2a5QK8UZjgdRPNcRTwnBkbbwQeQ89WD+/KxmpELHgXeHCNM+ropytNK8ANyAHU7Pw9YupV1Kwr3ahM0nqHv6Qrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748454481; c=relaxed/simple;
	bh=BLlrRRv/6/52k8S/pKzcQ7YSPf2U+jaHix4iriSF0hw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KRHJAKekxiyN/GBPLQoLEwfokeJGquIP3PpDUbxEQFaBxaIuJWI7teDKgh5J+0NpL1dvHQsmomW63Ff24zeCZiDW1o8Cy6uxfyxtq/DKHjP4X7hlyjgCF9vgTymSpQl1psMcwB/A1N+0k6LqHX6rhWaa7IuW6xaYGvJisAgoez8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tr01R4fu; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tr01R4fu"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6f8b2682d61so12047556d6.0
        for <iwd@lists.linux.dev>; Wed, 28 May 2025 10:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748454479; x=1749059279; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=79uirMoM6ogWbu0UaVfNQY4HCxWswP1a32K6v1hNsj8=;
        b=Tr01R4fuWgSfFHq7RpnV2ViaGnGinndSU7X2UQUv7suUdC9R9TSRyLPFeLSgb4PsA6
         PC4AJeP+qRTYzgQ4Tp5ifkbnK+ntAZjrxZR//AyKBdggHDDrerL4/ywQVBLr3x7DXIZe
         Mt8a+WJXEHmfSVsIFMdZ2yn5mV5MfZW02cgsz7GBp+YFkBqPdmsQgW+AHILuU1Cc0ZNs
         /E8Fa02j8u1A6w4/uM+Ic8EPlUpVPYV5+3IZ1ihg8ZgCg891ddhA+Tha8cQLv86ICtMX
         YNowCFTuQNh5jjiJWiGBtzxCFakvUNpSbF/26L3iZMY+Ur5+uq9CaxS5iVMbX28KYVUZ
         GLbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748454479; x=1749059279;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=79uirMoM6ogWbu0UaVfNQY4HCxWswP1a32K6v1hNsj8=;
        b=E436Og2oyNTIRQhI28BXtpNAufXfteIyBcwBSlTcOhRb7PHI91wu5BWk5mLfS0fe0H
         tYPGS85grlnmcfUzLA9kbGAECUnGj5+egB4RlAhLmWkhUkIJqpsHQ6obolVq8kLDLomN
         bOScxneGb1lt6MQR2AL+8+gPkXUU0N+TxAAxIfW4nHA8lQhRva2byuUdCsdR2FXOg0pD
         kA4VD8d+FO5SyZ8x3I+1u5SknlG3JzThI+yOXOy2sjA4rPXyGt9YLhMHY3AgPPHc+gl+
         P/JI3hukk3oD+ifSYP7IFdVhUwAJDTKo8l8lXGBw3gZ6wGTjihpvu4+frdmSGiSgLV93
         9U1g==
X-Forwarded-Encrypted: i=1; AJvYcCWJn02N31bguh6epmWkgFWpBLfkJCtD75rEidlbJuZKk9HlLJb8qidnYxQpqcWCShZErZQ=@lists.linux.dev
X-Gm-Message-State: AOJu0YyPRjRnLDBUbKkM5BlRa6QqQb878gkgP+kpk1q1mUIeQW2xlsjZ
	U1lQc0GUJ5u0+08WM+u/NzDLHHg/aS2iumXhWhoZbrtOIrFq05x8hKN6iZSAyw==
X-Gm-Gg: ASbGncsbnaK8HMHVBHI0DO7TqYLnotAoCkXwYN65X3410+7yY6wGl+/G3DZGpvC+dpM
	2AMFy1KmIBTImYxMBQawirWzNNBAu2J2nI8DQDaUlH+Wkhh0HITKrKYqkjFWMNBaG8sPoxW6taL
	takdRSOq97UtueQK8xiWNS2PlGqFxK5CBAXquQYOfopJwcW5yUqvb6QZ1deVJvUZqJsShZCUPrf
	tkmowbtojTtylcF7kHqrQxakm7daLKQ2300Z8pQScA+cm7X0qaZgmDG3AZfNhE9nf5a42BAPZ3q
	wxjwzjlvX3xvuM1k8UjxLxfgTM5ARuM23vBfz0QqTRYhSFQxCPujHh5wrniiz+RyqBJgVhhuroH
	yrlqBYE5Nw8loNHDExMbn3iCJCu8=
X-Google-Smtp-Source: AGHT+IGajIdGcgUynSAKmwxMPOQX72+Yaa76iIPJDooNm5BhLjfyEep0Mk3yq83BRJpcIdujyvo9jg==
X-Received: by 2002:a05:6870:8a2b:b0:2d4:e8ce:7bcc with SMTP id 586e51a60fabf-2e8fc90aff1mr306988fac.8.1748454468450;
        Wed, 28 May 2025 10:47:48 -0700 (PDT)
Received: from [192.168.1.25] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-2e8e16bead3sm319986fac.10.2025.05.28.10.47.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 10:47:47 -0700 (PDT)
Message-ID: <1453aee8-9caa-49c9-9492-beaf4ca3e3af@gmail.com>
Date: Wed, 28 May 2025 12:47:46 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] station: treat netconfig failures as connection
 failures
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20250528142750.498252-1-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20250528142750.498252-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 5/28/25 9:27 AM, James Prestwood wrote:
> Currently the netconfig functionality is somewhat separated from
> IWD's "connection" process. Regardless if netconfig is enabled
> the method return from Connect() will happen after IWD has completed
> the 4-way handshake. If netconfig fails its shows externally as an
> IWD state change rather than part of the method return from
> Connect(). Overall this doesn't pose a significant problem since a

It looks like you're fixing this as part of this commit to send the DBus reply 
after the netconfig has been completed.  Can you separate this change into a 
separate commit and document it for posterity?  Not sure if NM relies on this 
behavior (hopefully not), but we should have a Fixes tag as well.

Maybe 72e7d3ceb83d ("station: Handle NETCONFIG_EVENT_FAILED") ?

> netconfig failure essentially appears as if IWD became disconnected
> but more critical is that IWD will not iteratively try more BSS's if
> netconfig fails.
> 
> For example a BSS may be misconfigured, or not able to communicate to
> the DHCP server. IWD could connect to it, and fail netconfig thereby
> restarting the autoconnect logic. IWD will then choose the "best" BSS
> which may be the one it just failed on. This would then repeat
> indefinitely or until a better BSS comes around which could be never.
> 
> To improve this netconfig has been adopted into the IWD's BSS retry
> logic. If netconfig fails this will not result in IWD transitioning
> to a disconnected state, and instead the BSS will be network
> blacklisted and the next will be tried. Only once all BSS's have been
> tried will IWD go into a disconnected state and start autoconnect
> over.
> ---
>   src/station.c | 104 +++++++++++++++++++++++++-------------------------
>   1 file changed, 51 insertions(+), 53 deletions(-)
> 
> diff --git a/src/station.c b/src/station.c
> index 2b6a18f8..81c1e595 100644
> --- a/src/station.c
> +++ b/src/station.c
> @@ -1795,6 +1795,13 @@ static void station_enter_state(struct station *station,
>   		periodic_scan_stop(station);
>   		break;
>   	case STATION_STATE_CONNECTED:
> +		if (station->connect_pending) {
> +			struct l_dbus_message *reply =
> +				l_dbus_message_new_method_return(
> +						station->connect_pending);
> +			dbus_pending_reply(&station->connect_pending, reply);
> +		}
> +

Looks like this part should be in a separate commit per above comment.

>   		l_dbus_object_add_interface(dbus,
>   					netdev_get_path(station->netdev),
>   					IWD_STATION_DIAGNOSTIC_INTERFACE,
> @@ -2214,6 +2221,26 @@ static void station_early_neighbor_report_cb(struct netdev *netdev, int err,
>   				&station->roam_freqs);
>   }
>   
> +static bool station_try_next_bss(struct station *station)
> +{
> +	struct scan_bss *next;
> +	int ret;
> +
> +	next = network_bss_select(station->connected_network, false);
> +
> +	if (!next)
> +		return false;
> +
> +	ret = __station_connect_network(station, station->connected_network,
> +						next, station->state);
> +	if (ret < 0)
> +		return false;
> +
> +	l_debug("Attempting to connect to next BSS "MAC, MAC_STR(next->addr));
> +
> +	return true;
> +}
> +
>   static bool station_can_fast_transition(struct station *station,
>   					struct handshake_state *hs,
>   					struct scan_bss *bss)
> @@ -2256,28 +2283,28 @@ static bool station_can_fast_transition(struct station *station,
>   	return true;
>   }
>   
> -static void station_disconnect_on_error_cb(struct netdev *netdev, bool success,
> -					void *user_data)
> +static void station_disconnect_on_netconfig_failed(struct netdev *netdev,
> +							bool success,
> +							void *user_data)
>   {
>   	struct station *station = user_data;
> -	bool continue_autoconnect;
>   
> -	station_enter_state(station, STATION_STATE_DISCONNECTED);
> +	if (station_try_next_bss(station))
> +		return;
>   
> -	continue_autoconnect = station->state == STATION_STATE_CONNECTING_AUTO;
> +	network_disconnected(station->connected_network);

Hmm, why is this needed? station_reset_connection_state() already invokes this.

>   
> -	if (continue_autoconnect) {
> -		if (station_autoconnect_next(station) < 0) {
> -			l_debug("Nothing left on autoconnect list");
> -			station_enter_state(station,
> -					STATION_STATE_AUTOCONNECT_FULL);
> -		}
> +	if (station->connect_pending) {
> +		struct l_dbus_message *reply = dbus_error_failed(
> +						station->connect_pending);
>   
> -		return;
> +		dbus_pending_reply(&station->connect_pending, reply);
>   	}
>   
> -	if (station->autoconnect)
> -		station_enter_state(station, STATION_STATE_AUTOCONNECT_QUICK);
> +	station_reset_connection_state(station);
> +
> +	station_enter_state(station, STATION_STATE_DISCONNECTED);
> +	station_enter_state(station, STATION_STATE_AUTOCONNECT_FULL);
>   }
>   
>   static void station_netconfig_event_handler(enum netconfig_event event,
> @@ -2287,26 +2314,24 @@ static void station_netconfig_event_handler(enum netconfig_event event,
>   
>   	switch (event) {
>   	case NETCONFIG_EVENT_CONNECTED:
> +		network_connected(station->connected_network);
>   		station_enter_state(station, STATION_STATE_CONNECTED);
>   		break;
>   	case NETCONFIG_EVENT_FAILED:
> -		if (station->connect_pending) {
> -			struct l_dbus_message *reply = dbus_error_failed(
> -						station->connect_pending);
> +		station_debug_event(station, "netconfig-failed");
>   
> -			dbus_pending_reply(&station->connect_pending, reply);
> -		}
> +		netconfig_reset(station->netconfig);
>   
>   		if (station->state == STATION_STATE_NETCONFIG)
>   			network_connect_failed(station->connected_network,
>   						false);
>   
> +		network_blacklist_add(station->connected_network,
> +						station->connected_bss);
> +
>   		netdev_disconnect(station->netdev,
> -					station_disconnect_on_error_cb,
> +					station_disconnect_on_netconfig_failed,
>   					station);
> -		station_reset_connection_state(station);
> -
> -		station_enter_state(station, STATION_STATE_DISCONNECTING);
>   		break;
>   	default:
>   		l_error("station: Unsupported netconfig event: %d.", event);
> @@ -3409,26 +3434,6 @@ static void station_event_channel_switched(struct station *station,
>   	network_bss_update(network, station->connected_bss);
>   }
>   
> -static bool station_try_next_bss(struct station *station)
> -{
> -	struct scan_bss *next;
> -	int ret;
> -
> -	next = network_bss_select(station->connected_network, false);
> -
> -	if (!next)
> -		return false;
> -
> -	ret = __station_connect_network(station, station->connected_network,
> -						next, station->state);
> -	if (ret < 0)
> -		return false;
> -
> -	l_debug("Attempting to connect to next BSS "MAC, MAC_STR(next->addr));
> -
> -	return true;
> -}
> -
>   static bool station_retry_owe_default_group(struct station *station)
>   {
>   	/*
> @@ -3581,13 +3586,6 @@ static void station_connect_ok(struct station *station)
>   
>   	l_debug("");
>   
> -	if (station->connect_pending) {
> -		struct l_dbus_message *reply =
> -			l_dbus_message_new_method_return(
> -						station->connect_pending);
> -		dbus_pending_reply(&station->connect_pending, reply);
> -	}
> -
>   	/*
>   	 * Get a neighbor report now so future roams can avoid waiting for
>   	 * a report at that time

And this chunk belongs in a separate commit as well.

> @@ -3598,8 +3596,6 @@ static void station_connect_ok(struct station *station)
>   			l_warn("Could not request neighbor report");
>   	}
>   
> -	network_connected(station->connected_network);
> -

I'm not so sure about this part.  network_connected() is mainly about syncing 
the PSK to disk.  Since we connected successfully, that should still happen, 
regardless of whether netconfig succeeds or not.

>   	if (station->netconfig) {
>   		if (hs->fils_ip_req_ie && hs->fils_ip_resp_ie) {
>   			struct ie_fils_ip_addr_response_info info;
> @@ -3639,8 +3635,10 @@ static void station_connect_ok(struct station *station)
>   			return;
>   
>   		station_enter_state(station, STATION_STATE_NETCONFIG);
> -	} else
> +	} else {
> +		network_connected(station->connected_network);
>   		station_enter_state(station, STATION_STATE_CONNECTED);
> +	}
>   }
>   
>   static void station_connect_cb(struct netdev *netdev, enum netdev_result result,

Regards,
-Denis
