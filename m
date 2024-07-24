Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8DA15B0E3
	for <iwd@lists.linux.dev>; Wed, 24 Jul 2024 14:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721832817; cv=none; b=UD/uPhdWVvsUb6Rl56b5RBCs3lPu9da+xEYvA6tckMKKlPLusTRLGgaPU3+BLTwHYqb1S4vlyyGErSToxfTlt/UxwdFt7fpmh1UuTS+FgA2S6GsaqQh8GNANUmkWabt6McmdRJGAm654ulZ4YhB21We+Z+0YKTgJQ1hGHPj1GtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721832817; c=relaxed/simple;
	bh=ED7eMVFufeBQH0j5sfwMXyPcy9K0qaOUNdcfIGm5Q+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mJKZXiXshsB22KDZcdob4hOQ5pywgXoH8KqPaNcYSUMNuC74poZcmPCeOud0KIFPTOC4N4GAUyWUl4AeBjm8PVx+zCx4ECy7hejb5MPaMnPpaOwpxAwwEdaXv3fEhOfcXKhpTD7A0ZHPJscErmoBCsmZr6Y7BrpVCAWhNiXrrvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQ3w32D6; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQ3w32D6"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-44fe106616eso813271cf.1
        for <iwd@lists.linux.dev>; Wed, 24 Jul 2024 07:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721832814; x=1722437614; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XFr5YI3C8AANdJhL9axiA1tqtNcHFNLsQHoMYtlsTP0=;
        b=UQ3w32D6uLr+p1YeWis+NMpGLwScKOFCQuH600A+J2oOLSBUwGbWtOFCxnuO7c+w01
         JToX/apnmxalD6Rx6T5NAymjMo+rGYjGnclTxq7Upz963LsKNodLUWCrWdgK7MfEaPtC
         JhjL4YO+5kKVOLTV0yXGih6RXPkXQ7ZNCXuTQuC/ZPpk+iC4jmLBXh9bjAI7VTO/q7Uk
         N9/J0lDuob3m/oGAsmZRcg1f8lkU8Yc27bQzc/JmZAmzx7BALq4oFPO6ahOwA4Cq0cpI
         xxIg5gnRXtGSK5qUgvG+D4u1Du3TmlJt2bEeZXUNS1FlZm2oYEKhHh6b+DxJzDsHWniY
         parg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721832814; x=1722437614;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XFr5YI3C8AANdJhL9axiA1tqtNcHFNLsQHoMYtlsTP0=;
        b=ms8+nMPrOJH8qJ4oI1lWfJLJFwKA++7pthYsTOQ8tQJJfLxqMXbrm/cZJOYQ7pdCqF
         ToQRZFhcqdmsGPkYK2GhiagIBhOPa3EEjVKBrPEaDcfhQ0MAb8gbLhFgiX291LMEHbxH
         hqkqUmm1Ja4Yr88ysJ6lZYz2/k64AD4zTnxGk3oODV/GWbpuNA3Pwb51ZzLEmc5XOvKT
         ilE9zCJEBOzc9l88u2pjhtvzOas+Alfy1yiOws0lGIowoEEkWDrDQDKszrYRPBVnkRNG
         hbr8Xe43UltdvZinVRwI9aTNFbE1Ip3zFzNC/3vnsgwutDdvGrZP7D6wAZFw4040b04K
         34rQ==
X-Forwarded-Encrypted: i=1; AJvYcCXej7Ksh2Vj7WQdqd1GAUieiwU2yNwt85g375muegeeX30oaBaMcIfE0mbXftJHwyxi60PmKGRBNRHS6OoCH5lYNkLk
X-Gm-Message-State: AOJu0YyPV2LesRsyoxrwdR4YzODefRH/wUi+oSJb7rCi0eQZ2elfR1gf
	okrPLhzoyHGqNCgUzQBawARgfklvexD0nHBW2//qpYvCVdCUbuL0FFzyng==
X-Google-Smtp-Source: AGHT+IEc3rXL+zzepDpIPfQJ4+qXrogG9CAQHkR/+7gU4sZdDOLPPu3WSZCZtnY0CpXhbTgzfhdQ3Q==
X-Received: by 2002:ac8:57cf:0:b0:447:f514:f2b3 with SMTP id d75a77b69052e-44fd6906114mr27026051cf.58.1721832814411;
        Wed, 24 Jul 2024 07:53:34 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f9cbed910sm55288121cf.20.2024.07.24.07.53.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jul 2024 07:53:34 -0700 (PDT)
Message-ID: <09ae7769-63fd-4c61-8cfa-a40dca535c59@gmail.com>
Date: Wed, 24 Jul 2024 07:53:32 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] dpp: explicitly disconnect station if enrollee is
 started
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20240722182932.4091008-1-prestwoj@gmail.com>
 <20240722182932.4091008-3-prestwoj@gmail.com>
 <a1b40f90-e69b-4b70-80ef-c228fe54be94@gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <a1b40f90-e69b-4b70-80ef-c228fe54be94@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 7/24/24 7:30 AM, Denis Kenzior wrote:
> Hi James,
>
> On 7/22/24 1:29 PM, James Prestwood wrote:
>> Prior to now the DPP state was required to be disconnected before
>> DPP would start. This is inconvenient for the user since it requires
>> extra state checking and/or DBus method calls. Instead model this
>> case like WSC and issue a disconnect to station if DPP is requested
>> to start.
>>
>> The other conditions on stopping DPP are also preserved and no
>> changes to the configurator role have been made, i.e. being
>> disconnected while configuring still stops DPP. Similarly any
>> connection made during enrolling will stop DPP.
>>
>> It should also be noted that station's autoconfigure setting is also
>> preserved and set back to its original value upon DPP completing.
>> ---
>>   src/dpp.c | 195 +++++++++++++++++++++++++++++++++++++++---------------
>>   1 file changed, 143 insertions(+), 52 deletions(-)
>>
>
> <snip>
>
>> @@ -3734,27 +3740,50 @@ static void dpp_frame_watch(struct dpp_sm 
>> *dpp, uint16_t frame_type,
>>    *     DPP finishes.
>>    *
>>    * Other conditions shouldn't ever happen i.e. configuring and 
>> going into a
>> - * connecting state or enrolling and going to a disconnected/roaming 
>> state.
>> + * connecting state or enrolling and going to a roaming state.
>>    */
>>   static void dpp_station_state_watch(enum station_state state, void 
>> *user_data)
>>   {
>>       struct dpp_sm *dpp = user_data;
>>   -    if (dpp->state == DPP_STATE_NOTHING)
>> +    if (dpp->state == DPP_STATE_NOTHING ||
>> +                    dpp->interface == DPP_INTERFACE_UNBOUND)
>
> Is this check needed?  It looks like you create the state watch after 
> setting state and interface accordingly?
>
>>           return;
>
> <snip>
>
>> @@ -3927,6 +3947,64 @@ static void dpp_start_presence(struct dpp_sm 
>> *dpp, uint32_t *limit_freqs,
>>       dpp_start_offchannel(dpp, dpp->current_freq);
>>   }
>>   +static int dpp_disconnect_started(struct dpp_sm *dpp)
>> +{
>> +    int ret = 0;
>
> Is initialization needed?
>
>> +    struct station *station = 
>> station_find(netdev_get_ifindex(dpp->netdev));
>> +
>> +    /* Unusual case, but an enrollee could still be started */
>> +    if (!station)
>> +        return false;
>
> Function signature returns int, but you're returning false.

Yep this is intended.

true for a disconnect has started or is ongoing.
false for already disconnected
< 0 for a fatal error (i.e. station_disconnect() failed)

If this isn't desirable we could do:

-EALREADY for a disconnect is started/ongoing
0 for already disconnected
< 0 for a fatal error

We do a somewhat similar technique with wiphy_radio_work_is_running. But 
if we want to keep the return strictly integers/error codes I'm fine 
with that.

>
>> +
>> +    dpp->autoconnect = station_get_autoconnect(station);
>> +    station_set_autoconnect(station, false);
>> +
>> +    switch (station_get_state(station)) {
>> +    case STATION_STATE_AUTOCONNECT_QUICK:
>> +    case STATION_STATE_AUTOCONNECT_FULL:
>> +        /* Should never happen since we just set autoconnect false */
>> +        l_warn("Still in autoconnect state after setting false!");
>> +
>> +        /* fall through */
>> +    case STATION_STATE_DISCONNECTED:
>> +        ret = false;
>> +        goto register_watch;
>> +    case STATION_STATE_ROAMING:
>> +    case STATION_STATE_FT_ROAMING:
>> +    case STATION_STATE_FW_ROAMING:
>> +    case STATION_STATE_CONNECTING:
>> +    case STATION_STATE_CONNECTING_AUTO:
>> +    case STATION_STATE_CONNECTED:
>> +    case STATION_STATE_NETCONFIG:
>> +        /*
>> +         * For any connected or connection in progress state, start a
>> +         * disconnect
>> +         */
>> +        ret = station_disconnect(station);
>> +        if (ret < 0)
>> +            goto error;
>> +
>> +        /* fall through */
>> +    case STATION_STATE_DISCONNECTING:
>> +        l_debug("Delaying DPP start until after disconnect");
>> +
>> +        ret = true;
>> +        goto register_watch;
>> +    }
>> +
>> +error:
>> +    l_warn("failed to start disconnecting (%d)", ret);
>> +    station_set_autoconnect(station, dpp->autoconnect);
>> +
>> +    return ret;
>> +
>> +register_watch:
>> +    dpp->station_watch = station_add_state_watch(station,
>> +                        dpp_station_state_watch,
>> +                        dpp, NULL);
>> +    return ret;
>> +}
>> +
>>   static void dpp_start_enrollee(struct dpp_sm *dpp)
>>   {
>>       uint32_t freq = band_channel_to_freq(6, BAND_FREQ_2_4_GHZ);
>> @@ -3955,27 +4033,27 @@ static struct l_dbus_message 
>> *dpp_dbus_start_enrollee(struct l_dbus *dbus,
>>                           void *user_data)
>>   {
>>       struct dpp_sm *dpp = user_data;
>> -    struct station *station = 
>> station_find(netdev_get_ifindex(dpp->netdev));
>> +    int ret;
>>         if (dpp->state != DPP_STATE_NOTHING ||
>>                   dpp->interface != DPP_INTERFACE_UNBOUND)
>>           return dbus_error_busy(message);
>>   -    /*
>> -     * Station isn't actually required for DPP itself, although this 
>> will
>> -     * prevent connecting to the network once configured.
>> -     */
>> -    if (station && station_get_connected_network(station)) {
>> -        l_warn("cannot be enrollee while connected, please 
>> disconnect");
>> -        return dbus_error_busy(message);
>> -    } else if (!station)
>> -        l_debug("No station device, continuing anyways...");
>> -
>>       dpp->state = DPP_STATE_PRESENCE;
>>       dpp->role = DPP_CAPABILITY_ENROLLEE;
>>       dpp->interface = DPP_INTERFACE_DPP;
>>   -    dpp_start_enrollee(dpp);
>> +    ret = dpp_disconnect_started(dpp);
>> +    if (ret < 0) {
>> +        dpp_reset(dpp);
>> +        return dbus_error_from_errno(ret, message);
>> +    } else if (ret == false)
>> +        dpp_start_enrollee(dpp);
>
> I'm super confused here
>
>> +
>> +    /*
>> +     * If a disconnect was started/in progress the enrollee will 
>> start once
>> +     * that has finished
>> +     */
>>         dpp->pending = l_dbus_message_ref(message);
>
> Regards,
> -Denis
>
