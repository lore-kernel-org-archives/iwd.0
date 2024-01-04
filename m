Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C092C1BB
	for <iwd@lists.linux.dev>; Thu,  4 Jan 2024 19:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L80Vn2W6"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5f254d1a6daso8782247b3.2
        for <iwd@lists.linux.dev>; Thu, 04 Jan 2024 11:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704398152; x=1705002952; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h+7emTpHjk4b2yJVBoXEznkd1NQjXoPDY7tK4BLnKSw=;
        b=L80Vn2W6ngOiSNK4rsGGkicfRHLiwyzqNuuOLcDjhvzZRJkXm1zHo2+WwP+6JHMJl7
         krsbhStOoWXMQ+/QLbVCOqMUmG4OIa6xQ6lvxWtFztmrIApbCGdVLsZ/5DutJ+9KNMFC
         i3Z/LH1a+MAIlJTHilmUK2mI9/bLETTznoNGxj++MM3ltKaVAWVfoV3+plNnGOqQtyig
         fqM5zx6nw3bSAT24X9stH1OfJEW/1ZfrSs32OtwqWsGhwjsu3gCP9iS9oHAPYp3m9fBU
         cuy+2NiuHWhSnC+o+fKlTI9efDimWKGooCLg8eU9f73OuywYFrb+rdcDZgbVKAO7sD/s
         /DhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704398152; x=1705002952;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h+7emTpHjk4b2yJVBoXEznkd1NQjXoPDY7tK4BLnKSw=;
        b=fzSVGjkteO5Dz1qPgyYmruEzIzxpwHXLb5FOssmxDPkJkdNwUonmxe2R43EYvL2b8H
         kZvIchKKQi3h/OXgxl3uKmowHZJjggV/i1UwDxGgo/WKhm3RPH7a+oZlW+F8HA4i8v7e
         KAJ5jyge0F10FK+cknsNqpjkGqN4JF9Nrw4frd8uOiaxQDWLGpwexQcPQRmNQOTw9l4K
         Whf0mrheJs6lkgdpyPnX1msq61ivKbzJbV+uQLDBld/tIHiw5tFGD4cEBnRIs3/w456i
         Q+LUlnEns7HLyFixpQhINln4HTUrx+W8oR259Y1833a8SZD30fyVCFqvxCHftiukYGRK
         Ei1g==
X-Gm-Message-State: AOJu0YzMH/7u7z6z7joiOfCB9nLnYYjwNT51pItoNMLrPX81Sf/Zoe4g
	UIJPZMh1hpVonA9WgK7WgUs=
X-Google-Smtp-Source: AGHT+IEFgds69lMqcD18XweApsGt+Z9HOy3bt3vZkZ/1pGXGVnzMLZJXxPayZOOkLdmiHLfzhBzCZw==
X-Received: by 2002:a81:ae50:0:b0:5f5:63ee:6adf with SMTP id g16-20020a81ae50000000b005f563ee6adfmr823697ywk.93.1704398151621;
        Thu, 04 Jan 2024 11:55:51 -0800 (PST)
Received: from [10.102.4.159] ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id y18-20020a37e312000000b007815c45cdc5sm45524qki.95.2024.01.04.11.55.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 11:55:51 -0800 (PST)
Message-ID: <27188916-f1b9-4476-ab58-05d27d361820@gmail.com>
Date: Thu, 4 Jan 2024 11:55:49 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] station: add handling for new NETCONFIG state
Content-Language: en-US
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20240103184638.533221-1-prestwoj@gmail.com>
 <20240103184638.533221-3-prestwoj@gmail.com>
 <9196b264-5f4c-4830-88eb-b273c39489ad@gmail.com>
 <ee118809-a4a5-410b-b552-bdb1ad2cf347@gmail.com>
 <a0fbeeb4-f53a-4afc-aff3-8731ec914e71@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <a0fbeeb4-f53a-4afc-aff3-8731ec914e71@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 1/4/24 10:55 AM, Denis Kenzior wrote:
> Hi James,
>
>>> Another weirdness is that I think we're sending the d-bus reply 
>>> after connecting to the AP, but before netconfig runs.
>> Probably this as well... But I'm not sure we can really send it after 
>> netconfig unless we want to add a timeout error or something. If 
>> netconfig takes a long 
>
> We already should be disconnecting if netconfig fails.  It is part of 
> the NETCONFIG_EVENT_FAILED handling this patch was touching actually.  
> I'm not sure how this was tested exactly, but Andrew was pretty 
> adamant that we should be doing so and I thought his arguments were 
> compelling enough.
>
>> time DBus will be unhappy. IMO netconfig is somewhat of a special 
>> case in this regard, and consumers of the API should be waiting on 
>> the connected state, not only the DBus method return.
>
> netconfig should take a max of a few seconds under normal 
> circumstances. Capping the DHCP time might make sense anyway and I 
> think there are even some TODO items inside ell/netconfig.c about this.
This seems much simpler to implement and maintain...
>
> Anyhow, this is a smaller issue compared to the one above.
>
>>>> @@ -2043,8 +2044,9 @@ static void 
>>>> station_netconfig_event_handler(enum netconfig_event event,
>>>> dbus_pending_reply(&station->connect_pending, reply);
>>>>           }
>>>>   -        if (L_IN_SET(station->state, STATION_STATE_CONNECTING,
>>>> -                STATION_STATE_CONNECTING_AUTO))
>>>> +        if (L_IN_SET(station->state, STATION_STATE_NETCONFIG,
>>>> +                STATION_STATE_ROAMING, STATION_STATE_FT_ROAMING,
>>>> +                STATION_STATE_FW_ROAMING))
>>>
>>> I understand why NETCONFIG state is in the set, but why the others?
>> This was because if we are roaming and netconfig fails for some 
>> reason we want to disconnect, right?
>
> Well, AFAIK, the original intent of this piece was to discard secrets 
> if the initial connection failed.  This is now covered by the 
> NETCONFIG state which is roughly equivalent to CONNECTING.
>
> The addition of roaming states modifies the original intent. Hence why 
> I'm wondering why this is being added?
>
>>> Also, shouldn't this also cover the roaming states?  And do we still 
>>> need this check given wiphy_work?  Does netconfig use wiphy work to 
>>> make sure nothing tries to scan or go off-channel?
>> Yes, we shouldn't scan/offchannel while roaming. And no netconfig 
>> doesn't uses the wiphy queue, but it really should.
>>>
>>>>           return dbus_error_busy(message);
>>>>         if (!l_dbus_message_get_arguments(message, "aq", &iter))
>> So sounds like I opened up a can of worms here :) We only noticed 
>> these issues cropping up recently because of extended server upgrade 
>> times, i.e. the DHCP 
>
> Yep, there's always going to be nasty corner cases to deal with. I 
> suspect your earlier change to re-start netconfig exposed some of 
> these inconsistencies as well.
>
>> server was down for a long time. Clients roamed and if they didn't 
>> have the recent changes to restart netconfig they'd be stuck 
>> connected without an IP. I 
>
> Hence why I think it is better to treat this as an initial connection 
> failure rather than pretending that we roamed and dealing with the 
> consequences.
So when I originally sent the netconfig after roam change I wanted to 
actually prevent any roaming until netconfig finished, but instead we 
allowed the roam and restarted netconfig. So yes, I feel like this 
wasn't the right direction to go. I'm thinking instead we should prevent 
any roaming, cap the netconfig time (e.g. 15 seconds) and fail the 
connection if netconfig doesn't finish. Then we avoid all these nasty 
details of state changes and trying to manage roams but appear as 
"connecting" on DBus etc.
>> then noticed some of these other limitations now, but at least 
>> currently being unable to roam is better than having no IP and 
>> requiring physical attention.
>
> Regards,
> -Denis
