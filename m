Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BFF28E1E
	for <iwd@lists.linux.dev>; Thu,  4 Jan 2024 18:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFCUbfVD"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-594cb19c5d9so691775eaf.0
        for <iwd@lists.linux.dev>; Thu, 04 Jan 2024 10:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704394534; x=1704999334; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y2w0SS8HOQvSI4r+8+xBMi4r04uBni0teq7vlGaixzk=;
        b=fFCUbfVD9YxFAB0kvVeVnSr/zMt/NTg6vyioZ0J7DVvu8Eb7a645fQrZKHHy/UAPZz
         LRNR8m02PzNcp7bDSPTQb/1/bexoqUy4OS0lOHmUj5QIjk+cCwbmmx1tL7A59ii5wcNp
         NCf4/Uj/OJmVnmnJzeKIzMVtod4i16Sih4Wu+1C3xpi9xVDSmfuKae5mDFq7PlZpaHOC
         HvwUBkA61yJegYy4oTbbBOGkcHicAgF7wfCxCp0ILlTKDWA3pyvOGiEu8D+IXYlVd6h2
         iYsyZB/59UgjzINktDaWUOpp5yXFeL1cqtpUazWZPb6l8FYTjUz+vUjjH6jsPjBAe0iv
         CMKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704394534; x=1704999334;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y2w0SS8HOQvSI4r+8+xBMi4r04uBni0teq7vlGaixzk=;
        b=peWjZweH4aMyq1pwXeVW66khJq+igb1MprjV7oftDUz5xuf3Wr2/W3StV0wd9t0/Mc
         /8r07+P6NrCjCu8WK3vnl7PMBwjGSErdMkU8kQUdHAmVVJ63CURp8QqWMAzvatAG7Du0
         Tx28eeS3zw7HGMbXvu1pkKJFwWRk3v47AWwGm23S13Bq+7QeUaXqCB6YDDCeKx4G48VZ
         PIzE2IF5Gq7rVSEEvKN9VVVUMJ8EaYZoXib23GM1LuGnfS8RrOHpzu9CyBHI0qb8Gu6r
         Vxj/4FKK5WnPiXbsBz5MbpYIc0K4QSlNJnv5DV/k7JwZrh8hBBVHgFtOBXVEQigFTCLP
         KmMA==
X-Gm-Message-State: AOJu0Yz2jf7CGZlo5yPRerBPugSUOyvX/fmEbzCbgRXPyyAiyfaHnZCU
	com/JRtY/Liqx73eLH9J90xSbdDql8E=
X-Google-Smtp-Source: AGHT+IHDOo7b8E1nqGnPiE+OqwtP5ZOJqw2GXYdDx5NcG0ONjDZtfY4jnR589iOfc7QrxzKsYvdeVg==
X-Received: by 2002:a05:6871:341c:b0:205:cab0:5adc with SMTP id nh28-20020a056871341c00b00205cab05adcmr329115oac.43.1704394534384;
        Thu, 04 Jan 2024 10:55:34 -0800 (PST)
Received: from [172.16.49.130] (216.106.68.145.reverse.socket.net. [216.106.68.145])
        by smtp.googlemail.com with ESMTPSA id gv5-20020a056870aa0500b0020520aee37bsm16616oab.47.2024.01.04.10.55.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 10:55:33 -0800 (PST)
Message-ID: <a0fbeeb4-f53a-4afc-aff3-8731ec914e71@gmail.com>
Date: Thu, 4 Jan 2024 12:55:33 -0600
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
 <9196b264-5f4c-4830-88eb-b273c39489ad@gmail.com>
 <ee118809-a4a5-410b-b552-bdb1ad2cf347@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <ee118809-a4a5-410b-b552-bdb1ad2cf347@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi James,

>> Another weirdness is that I think we're sending the d-bus reply after 
>> connecting to the AP, but before netconfig runs.
> Probably this as well... But I'm not sure we can really send it after netconfig 
> unless we want to add a timeout error or something. If netconfig takes a long 

We already should be disconnecting if netconfig fails.  It is part of the 
NETCONFIG_EVENT_FAILED handling this patch was touching actually.  I'm not sure 
how this was tested exactly, but Andrew was pretty adamant that we should be 
doing so and I thought his arguments were compelling enough.

> time DBus will be unhappy. IMO netconfig is somewhat of a special case in this 
> regard, and consumers of the API should be waiting on the connected state, not 
> only the DBus method return.

netconfig should take a max of a few seconds under normal circumstances. 
Capping the DHCP time might make sense anyway and I think there are even some 
TODO items inside ell/netconfig.c about this.

Anyhow, this is a smaller issue compared to the one above.

>>> @@ -2043,8 +2044,9 @@ static void station_netconfig_event_handler(enum 
>>> netconfig_event event,
>>> dbus_pending_reply(&station->connect_pending, reply);
>>>           }
>>>   -        if (L_IN_SET(station->state, STATION_STATE_CONNECTING,
>>> -                STATION_STATE_CONNECTING_AUTO))
>>> +        if (L_IN_SET(station->state, STATION_STATE_NETCONFIG,
>>> +                STATION_STATE_ROAMING, STATION_STATE_FT_ROAMING,
>>> +                STATION_STATE_FW_ROAMING))
>>
>> I understand why NETCONFIG state is in the set, but why the others?
> This was because if we are roaming and netconfig fails for some reason we want 
> to disconnect, right?

Well, AFAIK, the original intent of this piece was to discard secrets if the 
initial connection failed.  This is now covered by the NETCONFIG state which is 
roughly equivalent to CONNECTING.

The addition of roaming states modifies the original intent.  Hence why I'm 
wondering why this is being added?

>> Also, shouldn't this also cover the roaming states?  And do we still need this 
>> check given wiphy_work?  Does netconfig use wiphy work to make sure nothing 
>> tries to scan or go off-channel?
> Yes, we shouldn't scan/offchannel while roaming. And no netconfig doesn't uses 
> the wiphy queue, but it really should.
>>
>>>           return dbus_error_busy(message);
>>>         if (!l_dbus_message_get_arguments(message, "aq", &iter))
> So sounds like I opened up a can of worms here :) We only noticed these issues 
> cropping up recently because of extended server upgrade times, i.e. the DHCP 

Yep, there's always going to be nasty corner cases to deal with.  I suspect your 
earlier change to re-start netconfig exposed some of these inconsistencies as well.

> server was down for a long time. Clients roamed and if they didn't have the 
> recent changes to restart netconfig they'd be stuck connected without an IP. I 

Hence why I think it is better to treat this as an initial connection failure 
rather than pretending that we roamed and dealing with the consequences.

> then noticed some of these other limitations now, but at least currently being 
> unable to roam is better than having no IP and requiring physical attention.

Regards,
-Denis
