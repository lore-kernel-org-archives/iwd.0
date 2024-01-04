Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE02C28E13
	for <iwd@lists.linux.dev>; Thu,  4 Jan 2024 18:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TE6TXloy"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5961bfe0f35so290581eaf.1
        for <iwd@lists.linux.dev>; Thu, 04 Jan 2024 10:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704392052; x=1704996852; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cT0chuAMB32ZVyqkGCtvjwQ0Z7my5C7qFPXow00uaZk=;
        b=TE6TXloyBiketE01h7q68svofqvUfeYNnU3rT0QbkpmE2ydMpyVXqhGmC+CY1oXTxS
         h7LuavvNMkh6bhkjEscoiUBn9XyWYxpUfgynEozidbb7tbPWKluBQptqgWXCGgotwsme
         vecTp1swx9fMYaSHAR7bGW+zVHxBXpb5EbqmkwlGEW/NNH9eJM01PovSclxRPPOR02D4
         AiteVVZPcpMeJrjvaVwbQRsgSaThpvQvt3wmrzh+OCAx1Ieivp6YNuw7zDn0FH7FPG2d
         u6yFobB+NUfWi/TA/G2eCqNSPE7LpHDLap9bLL3OTopIx705PKHBa1lPVEPB+LKRXCc2
         TD6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704392052; x=1704996852;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cT0chuAMB32ZVyqkGCtvjwQ0Z7my5C7qFPXow00uaZk=;
        b=Rm0dEBO0eltYuxspZiOg4LPA8ZuNEamX6k3TOj1X0Y0mqlW9X2DqYtwVj447Brx4/9
         tDHLEu2d9CQwGUFEcb93Xrd5v+s+Ogj9mYp2RHMnQvDbVrlhyElz5971v2lZyLGocRtY
         nu6xEPO9QabUkD3/lgq3/9HdEOzRUEdiEdg0YN5rSK99juuxMlbY0/KaIvPhzRf4BPeU
         CdfIRJcnh0AMAHPDXavXFpdBPPrFGcbP/E0TJwqmQvd4cx7OzXyEUXjbqfQgoMm2wch9
         D/E4/gg4js1LdRl9UJsE0kkor3jISoatT//zD58AxntgDvt7emW/yle/FpuSe2eQCnSp
         +yGw==
X-Gm-Message-State: AOJu0Yxy0gFTT0Nxz7XilhT5+8M4qnnw4KRFpA48T8t0jIhy74wrV9PJ
	I/S3GPWKUaMg4RBtzW7vPc0=
X-Google-Smtp-Source: AGHT+IF36w+8rgQfOp7WzJ8ZszuBFYd9ycO2PMFzD87qMUfkmEMs5xgrwiNrW0cFmzY3PF6GGc5u/w==
X-Received: by 2002:a4a:1d47:0:b0:594:bb06:fcc8 with SMTP id 68-20020a4a1d47000000b00594bb06fcc8mr361058oog.5.1704392051825;
        Thu, 04 Jan 2024 10:14:11 -0800 (PST)
Received: from [172.16.49.130] (216.106.68.145.reverse.socket.net. [216.106.68.145])
        by smtp.googlemail.com with ESMTPSA id 123-20020a4a0381000000b0058df21de4fasm5406194ooi.10.2024.01.04.10.14.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 10:14:11 -0800 (PST)
Message-ID: <9196b264-5f4c-4830-88eb-b273c39489ad@gmail.com>
Date: Thu, 4 Jan 2024 12:14:10 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] station: add handling for new NETCONFIG state
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240103184638.533221-1-prestwoj@gmail.com>
 <20240103184638.533221-3-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240103184638.533221-3-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 1/3/24 12:46, James Prestwood wrote:
> There was an unhandled corner case if netconfig was running and
> multiple roam conditions happened in sequence, all before netconfig
> had completed. A single roam before netconfig was already handled
> (23f0f5717c) but this did not take into account any additional roam
> conditions.

So if netconfig hasn't completed, we're in the 'connecting' state.  Any 
subsequent roams should still be treated as if we are in 'connecting' state. 
Are we transitioning from connecting -> roaming at the D-Bus API level? We 
shouldn't be.

Another weirdness is that I think we're sending the d-bus reply after connecting 
to the AP, but before netconfig runs.

> 
> If IWD is in this state, having started netconfig, then roamed, and
> again restarted netconfig it is still in a roaming state which will
> prevent any further roams. IWD will remain "stuck" on the current
> BSS until netconfig completes or gets disconnected.

Makes sense, since roaming means netconfig isn't really doing anything.

> 
> To fix this a new internal station state was added (no changes to
> the DBus API) to distinguish between a purely WiFi connecting state
> (STATION_STATE_CONNECTING/AUTO) and netconfig
> (STATION_STATE_NETCONFIG). This allows IWD roam as needed if
> netconfig is still running.

Okay, but how would you distinguish between connecting -> netconfig and 
netconfig->roaming->netconfig?

> 
> The change is mainly just adding STATION_STATE_NETCONFIG anywhere
> that STATION_STATE_CONNECTING is to maintain the same behavior,
> except within the netconfig event handler. In this case we should
> never get here without being in either a NETCONFIG or ROAMING
> state.
> 
> For some background this scenario happens if the DHCP server goes
> down for an extended period, e.g. if its being upgraded/serviced.
> ---
>   src/station.c | 23 +++++++++++++++++------
>   1 file changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/src/station.c b/src/station.c
> index 57d22e91..8f310ec8 100644
> --- a/src/station.c
> +++ b/src/station.c
> @@ -1768,6 +1768,7 @@ static void station_reset_connection_state(struct station *station)
>   	if (station->state == STATION_STATE_CONNECTED ||
>   			station->state == STATION_STATE_CONNECTING ||
>   			station->state == STATION_STATE_CONNECTING_AUTO ||
> +			station->state == STATION_STATE_NETCONFIG ||
>   			station_is_roaming(station))
>   		network_disconnected(network);
>   }
> @@ -2043,8 +2044,9 @@ static void station_netconfig_event_handler(enum netconfig_event event,
>   			dbus_pending_reply(&station->connect_pending, reply);
>   		}
>   
> -		if (L_IN_SET(station->state, STATION_STATE_CONNECTING,
> -				STATION_STATE_CONNECTING_AUTO))
> +		if (L_IN_SET(station->state, STATION_STATE_NETCONFIG,
> +				STATION_STATE_ROAMING, STATION_STATE_FT_ROAMING,
> +				STATION_STATE_FW_ROAMING))

I understand why NETCONFIG state is in the set, but why the others?

>   			network_connect_failed(station->connected_network,
>   						false);
>   
> @@ -2070,9 +2072,14 @@ static bool netconfig_after_roam(struct station *station)
>   					network_get_settings(network)))
>   		return false;
>   
> -	return netconfig_configure(station->netconfig,
> +	if (L_WARN_ON(!netconfig_configure(station->netconfig,
>   					station_netconfig_event_handler,
> -					station);
> +					station)))

You already have an L_WARN_ON in the single call site of netconfig_after_roam?

> +		return false;
> +
> +	station_enter_state(station, STATION_STATE_NETCONFIG);
> +
> +	return true;
>   }
>   
>   static void station_roamed(struct station *station)
> @@ -3255,6 +3262,8 @@ static void station_connect_ok(struct station *station)
>   						station_netconfig_event_handler,
>   						station)))
>   			return;
> +
> +		station_enter_state(station, STATION_STATE_NETCONFIG);
>   	} else
>   		station_enter_state(station, STATION_STATE_CONNECTED);
>   }
> @@ -4067,7 +4076,8 @@ static struct l_dbus_message *station_dbus_scan(struct l_dbus *dbus,
>   		return dbus_error_busy(message);
>   
>   	if (station->state == STATION_STATE_CONNECTING ||
> -			station->state == STATION_STATE_CONNECTING_AUTO)
> +			station->state == STATION_STATE_CONNECTING_AUTO ||
> +			station->state == STATION_STATE_NETCONFIG)

Might as well use L_IN_SET here

>   		return dbus_error_busy(message);
>   
>   	station->dbus_scan_subset_idx = 0;
> @@ -5025,7 +5035,8 @@ static struct l_dbus_message *station_debug_scan(struct l_dbus *dbus,
>   		return dbus_error_busy(message);
>   
>   	if (station->state == STATION_STATE_CONNECTING ||
> -			station->state == STATION_STATE_CONNECTING_AUTO)
> +			station->state == STATION_STATE_CONNECTING_AUTO ||
> +			station->state == STATION_STATE_NETCONFIG)

Also, shouldn't this also cover the roaming states?  And do we still need this 
check given wiphy_work?  Does netconfig use wiphy work to make sure nothing 
tries to scan or go off-channel?

>   		return dbus_error_busy(message);
>   
>   	if (!l_dbus_message_get_arguments(message, "aq", &iter))

Regards,
-Denis
