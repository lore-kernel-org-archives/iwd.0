Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D751D689
	for <iwd@lists.linux.dev>; Thu,  4 Jan 2024 18:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQ2S8QUq"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-67fdfed519dso3708706d6.2
        for <iwd@lists.linux.dev>; Thu, 04 Jan 2024 10:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704393067; x=1704997867; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WUapBpoB+4vnqLCrmhZV/WX+phYurVoq0N+DBDMuGGw=;
        b=OQ2S8QUq5SXjWmcPr3RvKL+4fUsSqp9MhDWgCKwUSTbwbxh1GMuQKFu3Dl027RTFU9
         oBNfPzchhgCJpcLKGbVj09+ISbrtx3LZ0uDXUFrkTFvETCMe9JpfsjdwtYjeM5ouSv9T
         fzZjGMKWoy66fB/a6etsamKQcnxO3uI4MKceU0nqHsslijIOVAOHdaB16W3JgBvC0S1w
         iBp4eFeSDvqeSKCI6YIwSh999KCJl2ylCPZUvlaeVbh8WgO3IMXPMHci9ai0FtiwqUEA
         4zA75FIfI1raKRgH0ADH7Lf7ZPC72Mf+Xf1q74O2gpA7hpaYfj9Kc4TJqGdXwgeR5wrW
         +yJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704393067; x=1704997867;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WUapBpoB+4vnqLCrmhZV/WX+phYurVoq0N+DBDMuGGw=;
        b=Z6gWUUte4e8N07lYO/V8+M/vJqh+yAHYFgLPaovOUIsKKbZeFWWVK+4Dfd8E9DeaWT
         D/GBeC0XzN5gnNQJ5ltiyD5pZszhqIYPLvVTIbDHGlS5wxty5+DRV00hJlla25k2En/4
         DX39xC0wZdeFwFYfVEGUtqc0NTzRUw12f8bDRkiInN8CyFNwTh2XoIlfsatjtWwJ59yS
         Jb3eHhVBCzntWTU01Gst1L+0/tpzI71zuEBed2FH4WmzftwIrd3ZVk7d/QJ2Ko09CL7G
         Mkk0ogjUTsJGLjNkL3lp17dGsKV1G4Vcbeeyss4LvGEJ6sj+g8sXv3wKeAggssnMRFyc
         cpvA==
X-Gm-Message-State: AOJu0YwZ4ISXpWnHZNckEfO5n1JOCZw9K5fokHjWwsrDgQk0pg7ju/1b
	DuPSOqWnQ0X9YoYn3JriIw22SOjN78U=
X-Google-Smtp-Source: AGHT+IGGQDkdj3/2+Ll6wjjNblPdfRhge8zd6l7/yuwf3nMDOCCZvbWNOWBZ7ZdwihtKfojnf1OAFw==
X-Received: by 2002:a05:6214:29c1:b0:67f:28d6:7108 with SMTP id gh1-20020a05621429c100b0067f28d67108mr1022051qvb.40.1704393066723;
        Thu, 04 Jan 2024 10:31:06 -0800 (PST)
Received: from [10.102.4.159] ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id dy4-20020ad44e84000000b00680b1288e4bsm3502853qvb.59.2024.01.04.10.31.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 10:31:05 -0800 (PST)
Message-ID: <ee118809-a4a5-410b-b552-bdb1ad2cf347@gmail.com>
Date: Thu, 4 Jan 2024 10:31:03 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] station: add handling for new NETCONFIG state
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20240103184638.533221-1-prestwoj@gmail.com>
 <20240103184638.533221-3-prestwoj@gmail.com>
 <9196b264-5f4c-4830-88eb-b273c39489ad@gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <9196b264-5f4c-4830-88eb-b273c39489ad@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 1/4/24 10:14 AM, Denis Kenzior wrote:
> Hi James,
>
> On 1/3/24 12:46, James Prestwood wrote:
>> There was an unhandled corner case if netconfig was running and
>> multiple roam conditions happened in sequence, all before netconfig
>> had completed. A single roam before netconfig was already handled
>> (23f0f5717c) but this did not take into account any additional roam
>> conditions.
>
> So if netconfig hasn't completed, we're in the 'connecting' state.  
> Any subsequent roams should still be treated as if we are in 
> 'connecting' state. Are we transitioning from connecting -> roaming at 
> the D-Bus API level? We shouldn't be.
Yes we are as it is today.
>
> Another weirdness is that I think we're sending the d-bus reply after 
> connecting to the AP, but before netconfig runs.
Probably this as well... But I'm not sure we can really send it after 
netconfig unless we want to add a timeout error or something. If 
netconfig takes a long time DBus will be unhappy. IMO netconfig is 
somewhat of a special case in this regard, and consumers of the API 
should be waiting on the connected state, not only the DBus method return.
>
>>
>> If IWD is in this state, having started netconfig, then roamed, and
>> again restarted netconfig it is still in a roaming state which will
>> prevent any further roams. IWD will remain "stuck" on the current
>> BSS until netconfig completes or gets disconnected.
>
> Makes sense, since roaming means netconfig isn't really doing anything.
>
>>
>> To fix this a new internal station state was added (no changes to
>> the DBus API) to distinguish between a purely WiFi connecting state
>> (STATION_STATE_CONNECTING/AUTO) and netconfig
>> (STATION_STATE_NETCONFIG). This allows IWD roam as needed if
>> netconfig is still running.
>
> Okay, but how would you distinguish between connecting -> netconfig 
> and netconfig->roaming->netconfig?
I hadn't had a need to distinguish, but given the above of wanting to 
remain the connecting state I think we'll need to.
>
>>
>> The change is mainly just adding STATION_STATE_NETCONFIG anywhere
>> that STATION_STATE_CONNECTING is to maintain the same behavior,
>> except within the netconfig event handler. In this case we should
>> never get here without being in either a NETCONFIG or ROAMING
>> state.
>>
>> For some background this scenario happens if the DHCP server goes
>> down for an extended period, e.g. if its being upgraded/serviced.
>> ---
>>   src/station.c | 23 +++++++++++++++++------
>>   1 file changed, 17 insertions(+), 6 deletions(-)
>>
>> diff --git a/src/station.c b/src/station.c
>> index 57d22e91..8f310ec8 100644
>> --- a/src/station.c
>> +++ b/src/station.c
>> @@ -1768,6 +1768,7 @@ static void 
>> station_reset_connection_state(struct station *station)
>>       if (station->state == STATION_STATE_CONNECTED ||
>>               station->state == STATION_STATE_CONNECTING ||
>>               station->state == STATION_STATE_CONNECTING_AUTO ||
>> +            station->state == STATION_STATE_NETCONFIG ||
>>               station_is_roaming(station))
>>           network_disconnected(network);
>>   }
>> @@ -2043,8 +2044,9 @@ static void 
>> station_netconfig_event_handler(enum netconfig_event event,
>> dbus_pending_reply(&station->connect_pending, reply);
>>           }
>>   -        if (L_IN_SET(station->state, STATION_STATE_CONNECTING,
>> -                STATION_STATE_CONNECTING_AUTO))
>> +        if (L_IN_SET(station->state, STATION_STATE_NETCONFIG,
>> +                STATION_STATE_ROAMING, STATION_STATE_FT_ROAMING,
>> +                STATION_STATE_FW_ROAMING))
>
> I understand why NETCONFIG state is in the set, but why the others?
This was because if we are roaming and netconfig fails for some reason 
we want to disconnect, right?
>
>> network_connect_failed(station->connected_network,
>>                           false);
>>   @@ -2070,9 +2072,14 @@ static bool netconfig_after_roam(struct 
>> station *station)
>>                       network_get_settings(network)))
>>           return false;
>>   -    return netconfig_configure(station->netconfig,
>> +    if (L_WARN_ON(!netconfig_configure(station->netconfig,
>>                       station_netconfig_event_handler,
>> -                    station);
>> +                    station)))
>
> You already have an L_WARN_ON in the single call site of 
> netconfig_after_roam?
>
>> +        return false;
>> +
>> +    station_enter_state(station, STATION_STATE_NETCONFIG);
>> +
>> +    return true;
>>   }
>>     static void station_roamed(struct station *station)
>> @@ -3255,6 +3262,8 @@ static void station_connect_ok(struct station 
>> *station)
>>                           station_netconfig_event_handler,
>>                           station)))
>>               return;
>> +
>> +        station_enter_state(station, STATION_STATE_NETCONFIG);
>>       } else
>>           station_enter_state(station, STATION_STATE_CONNECTED);
>>   }
>> @@ -4067,7 +4076,8 @@ static struct l_dbus_message 
>> *station_dbus_scan(struct l_dbus *dbus,
>>           return dbus_error_busy(message);
>>         if (station->state == STATION_STATE_CONNECTING ||
>> -            station->state == STATION_STATE_CONNECTING_AUTO)
>> +            station->state == STATION_STATE_CONNECTING_AUTO ||
>> +            station->state == STATION_STATE_NETCONFIG)
>
> Might as well use L_IN_SET here
>
>>           return dbus_error_busy(message);
>>         station->dbus_scan_subset_idx = 0;
>> @@ -5025,7 +5035,8 @@ static struct l_dbus_message 
>> *station_debug_scan(struct l_dbus *dbus,
>>           return dbus_error_busy(message);
>>         if (station->state == STATION_STATE_CONNECTING ||
>> -            station->state == STATION_STATE_CONNECTING_AUTO)
>> +            station->state == STATION_STATE_CONNECTING_AUTO ||
>> +            station->state == STATION_STATE_NETCONFIG)
>
> Also, shouldn't this also cover the roaming states?  And do we still 
> need this check given wiphy_work?  Does netconfig use wiphy work to 
> make sure nothing tries to scan or go off-channel?
Yes, we shouldn't scan/offchannel while roaming. And no netconfig 
doesn't uses the wiphy queue, but it really should.
>
>>           return dbus_error_busy(message);
>>         if (!l_dbus_message_get_arguments(message, "aq", &iter))
So sounds like I opened up a can of worms here :) We only noticed these 
issues cropping up recently because of extended server upgrade times, 
i.e. the DHCP server was down for a long time. Clients roamed and if 
they didn't have the recent changes to restart netconfig they'd be stuck 
connected without an IP. I then noticed some of these other limitations 
now, but at least currently being unable to roam is better than having 
no IP and requiring physical attention.
> Regards,
> -Denis
