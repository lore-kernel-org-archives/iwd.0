Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C49633D2
	for <iwd@lists.linux.dev>; Mon,  1 May 2023 15:53:53 +0000 (UTC)
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7512da2d994so119240385a.2
        for <iwd@lists.linux.dev>; Mon, 01 May 2023 08:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682956432; x=1685548432;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nj+xhWM08DEz5cIta6ArPR8PvKg9hbZmA7ukOWUNYK0=;
        b=KJ9VIhE1fh/4lxW3YbFZkjTeFtP1CAAXAXJ7qGPCqdQRZmkLuQV/A2x3dx7LPKsgMT
         6LyneEmZHNkCDW9YK17yFpZyporUVih00w4RVWI2CO1f0lsPdREMk1pxxigxUcU8QDtE
         mnIjNx9I1fgOHnEvVkxTcTlfxNa8PAlKr65lGrU6ojT7ub5Z5CNwypEVBeZxZCL4Ca5G
         9CXL7tAq3t0h/GhLynmlpTVX55LpL5T/ZV2ib7gnnSTcNhPHgF10yqW3aOBGPPfGurny
         izTuYDiZWy8XBVGSSEtBcU5RzxrL5GZNh3+Kb/OadMv+pqB6bo5BoqsT4UGqrUE8kPl5
         SZyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682956432; x=1685548432;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nj+xhWM08DEz5cIta6ArPR8PvKg9hbZmA7ukOWUNYK0=;
        b=eAwp9D2Omcja5dWYB3abnQ9Z5ZoSG42TCpX6gm16uZFwTpslnoCw09zTShKd4uwWeV
         TJsb/evz8438m6KApFgTC2ojpShyyk8cPaYHaBbsJRz2EU0+LZ188K9Q8MAXpclCN/kx
         z5BmrhJNVPlFw/5IsP48WNxYzqCAUS2x/ss4ub0d8UJ4avxZYJU5xlg5UedBdQrFsbIL
         9UzvsVlF59kqpGdQ/WX6v5KqlYTF4anwHjRxTZiCP0UdwNDbwD+hKCwVD+W2LmGRC78u
         +fOD1b8TRd+9gkmAxHfpSGfAaveykaGTtHfwGjFO4PP+c8o37rnFGJmGuR1AjfCExVGm
         I9Iw==
X-Gm-Message-State: AC+VfDxTREHr+vjOar+KyNV74smkCYut7zT6YemthRRh6J8C8u7KU/yr
	92k6e+Ca8PyE6A2AoCh0aMk=
X-Google-Smtp-Source: ACHHUZ7BwXBVqhQSxGjrT4vxbiEbRaHvwO/Av2Na0IMmj4/uI3c6p3pYJdcxMHO12d8ueWVq6jlOkw==
X-Received: by 2002:a05:6214:27e6:b0:5ad:13a6:b45b with SMTP id jt6-20020a05621427e600b005ad13a6b45bmr577461qvb.11.1682956431861;
        Mon, 01 May 2023 08:53:51 -0700 (PDT)
Received: from [10.193.157.43] ([208.216.218.212])
        by smtp.gmail.com with ESMTPSA id o1-20020a05620a2a0100b007468765b411sm8950534qkp.45.2023.05.01.08.53.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 May 2023 08:53:51 -0700 (PDT)
Message-ID: <f79812ac-205d-9cca-40a0-e7f4ca551738@gmail.com>
Date: Mon, 1 May 2023 08:53:49 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] station: handle ROAMING state in disconnect event (again)
Content-Language: en-US
To: =?UTF-8?Q?Alvin_=c5=a0ipraga?= <ALSI@bang-olufsen.dk>
Cc: =?UTF-8?Q?Alvin_=c5=a0ipraga?= <alvin@pqrs.dk>,
 "iwd@lists.linux.dev" <iwd@lists.linux.dev>,
 Dimitrios Karnikis <DIKA@bang-olufsen.dk>,
 Claudio Cabral <CLCA@bang-olufsen.dk>
References: <20230403141927.235014-1-alvin@pqrs.dk>
 <c9b5a931-ac35-2755-c656-acd567c1505f@gmail.com>
 <bfvlzfzk2ov4gzgedn66pblygsbzx5znyfa6vg5b7rocqbnnmp@qdwzifi5ofmq>
 <nxr432iqvnvzmhkp5afjjt3oggkh5b3yydemd2litlaex2qud5@vus3zhhuo4a6>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <nxr432iqvnvzmhkp5afjjt3oggkh5b3yydemd2litlaex2qud5@vus3zhhuo4a6>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Alvin,

On 4/30/23 3:22 AM, Alvin Šipraga wrote:
> Hi again,
> 
> On Wed, Apr 05, 2023 at 09:12:20AM +0000, Alvin Šipraga wrote:
>> Hi James,
>>
>> On Mon, Apr 03, 2023 at 03:35:28PM -0700, James Prestwood wrote:
>>> Hi Alvin,
>>>
>>> On 4/3/23 07:19, Alvin Šipraga wrote:
>>>> From: Alvin Šipraga <alsi@bang-olufsen.dk>
>>>>
>>>> The blamed commit clobbered the non-FT (Reassociation) roaming case
>>>> in the disconnect event handler, causing iwd to potentially get stuck in
>>>> the ROAMING state after a failed reassociation during non-FT roaming.
>>>> Add it back.
>>>>
>>>> The subject is inspired by a previous commit which did the same thing,
>>>> but introduced before the new roaming states were added, namely commit
>>>> 8758cc89487b ("station: handle ROAMING state in disconnect event"). The
>>>> rationale here is the same.
>>>>
>>>> Fixes: edf556cc7bb9 ("station: add two new roaming states (FT/FW)")
>>>
>>> IIRC leaving out the old ROAMING state in this switch was actually done
>>> intentionally. This is because netdev_reassociate() takes a callback and any
>>> failures with the roam *should* show up in netdev_connect_event(), and in
>>> turn call the callback which then leads to the same station_disassociated()
>>> call. We wanted to avoid the potential of a disconnect event AND the connect
>>> callback both calling station_disassocated().
>>
>> Yes, that makes sense.
>>
>>>
>>> Do you happen to have an iwmon pcap/log of this behavior? If its a kernel
>>> bug and a CMD_CONNECT connect event never comes then we probably do need
>>> this patch, but maybe instead with an L_WARN_ON or a big debug print because
>>> it really shouldn't be happening.
>>
>> Yes, this will be our next direction of inquiry. Easter is coming up and the
>> issue is reproducible by colleagues who are on holiday. But I will follow up.
> 
> Just a short update on this. Currently we root-caused the failure to a bug where
> the 2nd packet of the 4-Way Handshake gets silently dropped by the firmware we
> are using and the vendor is looking into it. Until this is fixed we can't point
> any fingers at IWD. I'll follow up once that is fixed. Thanks!

So was IWD not handling this? We keep a timer for eapol, so if packet 
2/4 was lost IWD should recover regardless. Even if its a FW bug IWD 
shouldn't get stuck.

> 
> Kind regards,
> Alvin
> 
>>
>> Thanks for the quick reply.
>>
>> Kind regards,
>> Alvin
>>
>>>
>>> Thanks,
>>>
>>> James
>>>
>>>> ---
>>>>    src/station.c | 1 +
>>>>    1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/src/station.c b/src/station.c
>>>> index d5650a2995a9..69f9be79880d 100644
>>>> --- a/src/station.c
>>>> +++ b/src/station.c
>>>> @@ -3201,6 +3201,7 @@ static void station_disconnect_event(struct station *station, void *event_data)
>>>>    					event_data, station);
>>>>    		return;
>>>>    	case STATION_STATE_CONNECTED:
>>>> +	case STATION_STATE_ROAMING:
>>>>    	case STATION_STATE_FT_ROAMING:
>>>>    	case STATION_STATE_FW_ROAMING:
>>>>    		station_disassociated(station);
