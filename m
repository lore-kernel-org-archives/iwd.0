Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F591292D4
	for <iwd@lists.linux.dev>; Wed, 14 Feb 2024 20:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707940969; cv=none; b=KDEe9Gna9Y41PdGBVhQb2WFvOk8FjgdXFtYBg36cfESX0l1oxMr4nU7NQpfTtpQtrarwS8H5IsI28U1G7UKf2ooBsqT73tI8A1iDjTX+DVwuWjHUtNLtvxXNIr4Ohu8JiyTCfEyUIfGEWCvALFGDnxX4Zs5hondPfjEnvgxts3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707940969; c=relaxed/simple;
	bh=ojQZjGwj5GiSnQfhA5qMRyW5Fdhk4PPwXcN+rEWU2Uc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OkP8MikKHIL+hmd4BO0MWXDxAzIU73dLfPgYyQ5VkG4Fz6qn98tYtOjvOcE6Yu711XU6p28mB0Shjx9FI8rZHk2VyhaGK+zJRabMogMVKU39tJ1xpgLihbzB/qjGmzMNbw1d9iyIlHPjwKeX+Ng2S7XoAFpaQzLT1Z79LsIyBg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DbZ6W5N6; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DbZ6W5N6"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso118246a12.3
        for <iwd@lists.linux.dev>; Wed, 14 Feb 2024 12:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707940967; x=1708545767; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YNY+XhG79HRpyhzCkfynbm/yWdDakjk3pe3EA+f5Nk8=;
        b=DbZ6W5N61ce1pa/ROTshgpXSOzmphDUIYgY7EhObqfAGM60drDv4CgWiMR60e3Q1JA
         hGkIH9ENo2pV+bSbxuwkGFc2+au06jXgY9zExkyx1NZ6O80B/PNYPFXe7Svt72Io7l4e
         J2R+cN15ls/26oqrdmX9M4elf4/rh4tTO+wvNh3/ph3X+F0rYJehUpEW3daUWkQY5O2+
         iFnyGG81Lw0Pd9sYsMV0b7yJp1V0olo1C1dl687VvYOVcaM8ZwFzlJA9kk2fvDKpllhn
         XwW6nZN9nUL7KexgmNNcwYwv7HXDEmg06X1FhDkWqUNefoQxcGHR5aFYIWt2rXaa707f
         yvyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707940967; x=1708545767;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YNY+XhG79HRpyhzCkfynbm/yWdDakjk3pe3EA+f5Nk8=;
        b=RAXoEbWiEpzJ74NasBkaHxiUAQppgsCLPmmYr3sqFvA9ZfiNKE2yTpbh5E3RRH6o8o
         VjZ3si0AW2A9x/vTauCLux5tSRg5S9MHlRuUpUTezrsF24UrnYCyq2rj+Ad6AlSCRSjB
         f6LRHGa0kY7OquI2JF9aEoFc1qFXNJPTbb/zaZH/ZU+YU9wfWMQSIZWEFgbltG89ox15
         C8HfY7QCbyIL1+3MUK98N6rQJJ4+90etfrEgGRaD6TynHIcWZz53KAlacVIelRkXFQxw
         uzmIAc4sdZ5OTCGLuV6ouXQULVVhaGNBFhEnCGXp4ogtu0JaGYr0c1SwAVr2IdMbdMf6
         CsWg==
X-Gm-Message-State: AOJu0YzzOhXipqsJx5Hmya+G+tSWNiSjhRAIfeXHYM5vC69hP/qWUXIF
	AE7JpV7+6D081jXhJCjdz356OcTVRDskoUbXiOMRTjQz+uNMjUog5VSpJ4B3Y6k=
X-Google-Smtp-Source: AGHT+IFmRwPUTLTC62khynY8/HQhwUF2G+C7V4Wa62rqPCmRZ3tPaZ1Qw8syPHPl5Y/8HZ4lOtGFog==
X-Received: by 2002:a05:6a21:3987:b0:19c:ae59:1602 with SMTP id ad7-20020a056a21398700b0019cae591602mr4866888pzc.53.1707940967528;
        Wed, 14 Feb 2024 12:02:47 -0800 (PST)
Received: from [10.102.4.159] ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id w12-20020a056a0014cc00b006e03c68ae9asm10044955pfu.16.2024.02.14.12.02.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 12:02:47 -0800 (PST)
Message-ID: <95c6f271-2f18-4381-b0d9-b31e86741700@gmail.com>
Date: Wed, 14 Feb 2024 12:02:45 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/5] station: use l_notice for station_debug_event, allow
 arguments
Content-Language: en-US
To: Marcel Holtmann <marcel@holtmann.org>
Cc: iwd@lists.linux.dev
References: <20240214193743.963349-1-prestwoj@gmail.com>
 <20240214193743.963349-3-prestwoj@gmail.com>
 <708401D3-CE90-4A7C-9008-F64904877BC9@holtmann.org>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <708401D3-CE90-4A7C-9008-F64904877BC9@holtmann.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Marcel,

On 2/14/24 11:46 AM, Marcel Holtmann wrote:
> Hi James,
>
>> For anyone debugging or trying to identify network infrastructure
>> problems the IWD DBus API isn't all that useful and ultimately
>> requires going through debug logs to figure out exactly what
>> happened. Having a concise set of debug logs containing only
>> relavent information would be very useful. In addition, having
>> some kind of syntax for these logs to be parsed by tooling could
>> automate these tasks.
>>
>> This is being done, starting with station, by using l_notice. The
>> use of l_notice in IWD will be strictly for the type of messages
>> described above. Modules using l_notice should follow the same
>> log format so tooling can parse the messages generically. The
>> format should be zero or more comma-separated key value pairs,
>> starting with "event: <event name>".
>>
>> station_debug_event is being modified to use l_notice as most of
>> the events are useful for debugging. This was modified slightly
>> to allow arguments to be passed in order to provide extra
>> information if available.
>> ---
>> src/station.c | 25 +++++++++++++++----------
>> 1 file changed, 15 insertions(+), 10 deletions(-)
>>
>> diff --git a/src/station.c b/src/station.c
>> index ea505ca2..a097174e 100644
>> --- a/src/station.c
>> +++ b/src/station.c
>> @@ -215,15 +215,13 @@ static bool station_is_roaming(struct station *station)
>> station->state == STATION_STATE_FW_ROAMING;
>> }
>>
>> -static bool station_debug_event(struct station *station, const char *name)
>> +static bool station_emit_event(struct station *station, const char *name)
>> {
>> struct l_dbus_message *signal;
>>
>> if (!iwd_is_developer_mode())
>> return true;
>>
>> - l_debug("StationDebug.Event(%s)", name);
>> -
>> signal = l_dbus_message_new_signal(dbus_get_bus(),
>> netdev_get_path(station->netdev),
>> IWD_STATION_DEBUG_INTERFACE, "Event");
>> @@ -233,6 +231,12 @@ static bool station_debug_event(struct station *station, const char *name)
>> return l_dbus_send(dbus_get_bus(), signal) != 0;
>> }
>>
>> +#define station_debug_event(station, name, fmt, ...) \
>> +({ \
>> + l_notice("event: %s, " fmt, name, ##__VA_ARGS__); \
>> + station_emit_event(station, name); \
>> +})
>> +
>> static void station_property_set_scanning(struct station *station,
>> bool scanning)
>> {
>> @@ -1565,7 +1569,7 @@ static void station_enter_state(struct station *station,
>> station_state_to_string(station->state),
>> station_state_to_string(state));
>>
>> - station_debug_event(station, station_state_to_string(state));
>> + station_debug_event(station, station_state_to_string(state), "");
>>
>> disconnected = !station_is_busy(station);
>>
>> @@ -2351,13 +2355,14 @@ static bool station_ft_work_ready(struct wiphy_radio_work_item *item)
>> l_queue_insert(station->roam_bss_list, rbss,
>> roam_bss_rank_compare, NULL);
>>
>> - station_debug_event(station, "ft-fallback-to-reassoc");
>> + station_debug_event(station, "ft-fallback-to-reassoc", "");
>>
>> station_transition_start(station);
>> l_steal_ptr(rbss);
>> break;
>> case -ENOENT:
>> - station_debug_event(station, "ft-roam-failed");
>> + station_debug_event(station, "ft-roam-failed",
>> + "reason: authentication timeout");
>> try_next:
>> station_transition_start(station);
>> break;
>> @@ -2560,7 +2565,7 @@ static void station_roam_scan_triggered(int err, void *user_data)
>> return;
>> }
>>
>> - station_debug_event(station, "roam-scan-triggered");
>> + station_debug_event(station, "roam-scan-triggered", "");
> this is really awful.
>
> Lets have the event / state name as enum or something so that it is const.
>
> And then having the empty “” all the time is insane. That is horrible API and in 2 month you wonder what the “” is for. So let’s not do that. Rather have station_debug_event and station_debug_event_printf.

So, I can separate station_debug_event from this l_notice stuff, it just 
fit nicely together from the standpoint of these "debug events" are 
useful, and I didn't want have repeated calls like:

station_debug_event(...)

l_notice(...)

The extra argument was to avoid manually parsing some arbitrary number 
of args by always passing in a format string but we could avoid this by 
separating the two and making them independent calls.

>
> Or just shorten it into STATION_DBG_EVT and STATION_DEBUG_EVT_PRINTF. I mean, the assumption is that this code is purely for debug and has not functional meaning. So if left out, the code will do the right thing. If not, then never ever call it debug.
>
> Regards
>
> Marcel
>
