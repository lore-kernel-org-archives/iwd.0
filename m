Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37D215A4B5
	for <iwd@lists.linux.dev>; Wed, 24 Jul 2024 14:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721831420; cv=none; b=Mp7XyUr9v5HJaTdBMFziFlhEOHagOSM4krOOaMYH7Ecs4l1MuUGOTuHg5FbtDeR/KKABXsiZqy3fQrSW4QG2FuRWibunebJOFuQkp0q/5PzhZVCzJpZmsRafJgwkzvffblsA2lL2O/7t+PX0ACvoq4XrR8d3Rz7DlVneVAWvNWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721831420; c=relaxed/simple;
	bh=K2LGt9S6qrHataMZdPXC4jYyqB6PBm1b7U+/vDYA5L4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Yb5Ay2V4Pzq5amH78Y8Gx5r87pwA294VEgi3A33r/szqcwP5xAh6FXJgEPj8f7PMzzwo9S9GgajOtxel4+DO+DSPB7DQA/jMrrC6XelVheI0MQrQqlFhwal8lbABqlxRJtoEaNnK1iQctbyiHyjmZWmCGwG4vDoY2BYt63++FtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CLUTWvEb; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CLUTWvEb"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3d94293f12fso4064880b6e.3
        for <iwd@lists.linux.dev>; Wed, 24 Jul 2024 07:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721831418; x=1722436218; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xZuuQvHYM2fkUyUyJvhDyApmni4qzd4rd/55Ye7sqes=;
        b=CLUTWvEbt5DRS292lWlh47uv1zqqTzC4D2dzdS4hE8aM+AydOezU0NHVWVtrli3v1z
         yir1mRaLLH4TxaQQYfmzNOW9gueAF3xFK2s8qg8y4ffucx1wQwUgayS1dHkzMJf5QtNr
         XuUz5pTA9j8YKjKaD2jW7PQ7tgsL0y61kPI/DcaRvI2wlkarV8W3uWywD2VZGZ5GWQLK
         d5H3QmsaRSn8r56QDafCs5wehGR6MUQUHFPqtn/ggWBbKCFVcGQj5DNUz4T1PTY9liR4
         vIcSsW2kfOWIBzUoEC+Lr0UoPkH4IWDMCzDXQFp9pq42ERSESiGM5OoFgPtz+GktanSD
         41uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721831418; x=1722436218;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xZuuQvHYM2fkUyUyJvhDyApmni4qzd4rd/55Ye7sqes=;
        b=jnPmSsWns6Ay+wW1uLb+O6USNH5Suop0ahHq2fubpjCsde2By5orFIftfJlRNhHKx1
         NXYlKDQ9w+4o4FLkiouT7L072gyasYQ/Q2fyKUvRtA0DSjsEJxnE7us+GTtCOYOv1P1d
         2OviSuaXDH74+L12P5q9PLtCeKw4GoDnAmHH6k9rqNArSk+LskNx9lATdfe/Dxty+Cqh
         0a01Nglrm9wMpTHw1NKhTkNGKMT37/Ak1q2oMIkDZHriFYRwPkWdHEm5xRZPp955vaJW
         NnNRe5IO5lVinDyR10iuWs2+AQNXS90PXCEhIjnenyCpnncvaBdEgd3+f9EeYHpCWz6W
         fQoA==
X-Forwarded-Encrypted: i=1; AJvYcCUXmcfv+vBfXej/3B3YGKpdVQUBApEYVEtH4N02ubBlBgBM8f4L3csK4vl0zchWyu41q5uCuiQ9vIk3E6ksmMLmnYf6
X-Gm-Message-State: AOJu0Yyk/MWNgqTGHYv1aZgfYjiF4rcelc/cOSvOxMp20Wtfz665igXg
	ytMri3M/I5azbg2dWDcNwVjEspbLK5yAvKO/lIn9X28ncfFpplDI
X-Google-Smtp-Source: AGHT+IHQwueo6rnRioMxHNzeqDfigQbUrvijhSld+Bm85vSdvsnSUVQeIkfBUU57kXVTKc7ujAkXFQ==
X-Received: by 2002:a05:6808:182a:b0:3d9:2a77:b81b with SMTP id 5614622812f47-3db06e06c4amr4024612b6e.34.1721831417591;
        Wed, 24 Jul 2024 07:30:17 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-3daf59bdb7dsm1319828b6e.50.2024.07.24.07.30.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jul 2024 07:30:17 -0700 (PDT)
Message-ID: <a1b40f90-e69b-4b70-80ef-c228fe54be94@gmail.com>
Date: Wed, 24 Jul 2024 09:30:16 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] dpp: explicitly disconnect station if enrollee is
 started
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240722182932.4091008-1-prestwoj@gmail.com>
 <20240722182932.4091008-3-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240722182932.4091008-3-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 7/22/24 1:29 PM, James Prestwood wrote:
> Prior to now the DPP state was required to be disconnected before
> DPP would start. This is inconvenient for the user since it requires
> extra state checking and/or DBus method calls. Instead model this
> case like WSC and issue a disconnect to station if DPP is requested
> to start.
> 
> The other conditions on stopping DPP are also preserved and no
> changes to the configurator role have been made, i.e. being
> disconnected while configuring still stops DPP. Similarly any
> connection made during enrolling will stop DPP.
> 
> It should also be noted that station's autoconfigure setting is also
> preserved and set back to its original value upon DPP completing.
> ---
>   src/dpp.c | 195 +++++++++++++++++++++++++++++++++++++++---------------
>   1 file changed, 143 insertions(+), 52 deletions(-)
> 

<snip>

> @@ -3734,27 +3740,50 @@ static void dpp_frame_watch(struct dpp_sm *dpp, uint16_t frame_type,
>    *     DPP finishes.
>    *
>    * Other conditions shouldn't ever happen i.e. configuring and going into a
> - * connecting state or enrolling and going to a disconnected/roaming state.
> + * connecting state or enrolling and going to a roaming state.
>    */
>   static void dpp_station_state_watch(enum station_state state, void *user_data)
>   {
>   	struct dpp_sm *dpp = user_data;
>   
> -	if (dpp->state == DPP_STATE_NOTHING)
> +	if (dpp->state == DPP_STATE_NOTHING ||
> +					dpp->interface == DPP_INTERFACE_UNBOUND)

Is this check needed?  It looks like you create the state watch after setting 
state and interface accordingly?

>   		return;
>   

<snip>

> @@ -3927,6 +3947,64 @@ static void dpp_start_presence(struct dpp_sm *dpp, uint32_t *limit_freqs,
>   	dpp_start_offchannel(dpp, dpp->current_freq);
>   }
>   
> +static int dpp_disconnect_started(struct dpp_sm *dpp)
> +{
> +	int ret = 0;

Is initialization needed?

> +	struct station *station = station_find(netdev_get_ifindex(dpp->netdev));
> +
> +	/* Unusual case, but an enrollee could still be started */
> +	if (!station)
> +		return false;

Function signature returns int, but you're returning false.

> +
> +	dpp->autoconnect = station_get_autoconnect(station);
> +	station_set_autoconnect(station, false);
> +
> +	switch (station_get_state(station)) {
> +	case STATION_STATE_AUTOCONNECT_QUICK:
> +	case STATION_STATE_AUTOCONNECT_FULL:
> +		/* Should never happen since we just set autoconnect false */
> +		l_warn("Still in autoconnect state after setting false!");
> +
> +		/* fall through */
> +	case STATION_STATE_DISCONNECTED:
> +		ret = false;
> +		goto register_watch;
> +	case STATION_STATE_ROAMING:
> +	case STATION_STATE_FT_ROAMING:
> +	case STATION_STATE_FW_ROAMING:
> +	case STATION_STATE_CONNECTING:
> +	case STATION_STATE_CONNECTING_AUTO:
> +	case STATION_STATE_CONNECTED:
> +	case STATION_STATE_NETCONFIG:
> +		/*
> +		 * For any connected or connection in progress state, start a
> +		 * disconnect
> +		 */
> +		ret = station_disconnect(station);
> +		if (ret < 0)
> +			goto error;
> +
> +		/* fall through */
> +	case STATION_STATE_DISCONNECTING:
> +		l_debug("Delaying DPP start until after disconnect");
> +
> +		ret = true;
> +		goto register_watch;
> +	}
> +
> +error:
> +	l_warn("failed to start disconnecting (%d)", ret);
> +	station_set_autoconnect(station, dpp->autoconnect);
> +
> +	return ret;
> +
> +register_watch:
> +	dpp->station_watch = station_add_state_watch(station,
> +						dpp_station_state_watch,
> +						dpp, NULL);
> +	return ret;
> +}
> +
>   static void dpp_start_enrollee(struct dpp_sm *dpp)
>   {
>   	uint32_t freq = band_channel_to_freq(6, BAND_FREQ_2_4_GHZ);
> @@ -3955,27 +4033,27 @@ static struct l_dbus_message *dpp_dbus_start_enrollee(struct l_dbus *dbus,
>   						void *user_data)
>   {
>   	struct dpp_sm *dpp = user_data;
> -	struct station *station = station_find(netdev_get_ifindex(dpp->netdev));
> +	int ret;
>   
>   	if (dpp->state != DPP_STATE_NOTHING ||
>   				dpp->interface != DPP_INTERFACE_UNBOUND)
>   		return dbus_error_busy(message);
>   
> -	/*
> -	 * Station isn't actually required for DPP itself, although this will
> -	 * prevent connecting to the network once configured.
> -	 */
> -	if (station && station_get_connected_network(station)) {
> -		l_warn("cannot be enrollee while connected, please disconnect");
> -		return dbus_error_busy(message);
> -	} else if (!station)
> -		l_debug("No station device, continuing anyways...");
> -
>   	dpp->state = DPP_STATE_PRESENCE;
>   	dpp->role = DPP_CAPABILITY_ENROLLEE;
>   	dpp->interface = DPP_INTERFACE_DPP;
>   
> -	dpp_start_enrollee(dpp);
> +	ret = dpp_disconnect_started(dpp);
> +	if (ret < 0) {
> +		dpp_reset(dpp);
> +		return dbus_error_from_errno(ret, message);
> +	} else if (ret == false)
> +		dpp_start_enrollee(dpp);

I'm super confused here

> +
> +	/*
> +	 * If a disconnect was started/in progress the enrollee will start once
> +	 * that has finished
> +	 */
>   
>   	dpp->pending = l_dbus_message_ref(message);
>   

Regards,
-Denis

