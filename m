Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD00B30CE0
	for <iwd@lists.linux.dev>; Fri, 15 Sep 2023 14:55:18 +0000 (UTC)
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3aa14ed0e7eso1201764b6e.1
        for <iwd@lists.linux.dev>; Fri, 15 Sep 2023 07:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694789718; x=1695394518; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yfUKiOEmsJy45kahZfR8rC5y65QOM/SXgmlR0tKjjNQ=;
        b=BryA9Ot0MZz2aR3ra5JMcrZTaN3EPFvw/WQyud9FjxD/LVFcP3LFNl4Aesn6Pn+qF4
         HZckBn9i31+TaZBB3ShdImQ5XDvs1PimQCOQq+bv7dw2iZQWFUTp1HRO3JqQSU1v/yrv
         FeKVRO4yYcNq+s8wAJszvtMfWTlpjPxTVOVizWQW/iuvhYxzJytI+plAHPbIWX5aWNXQ
         8t7dzLrZeszcSl2YgsiWETKC2kaLRCrixFs8yvYQm91DYmx95h53P0/6nDF95DA2YESB
         AscS0dIioCQf4mv/p4z0QP9jTxMXopZlJzVqQZEpjWRIzax6TjayCaNlBbo8eSq5Sk/6
         eZYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694789718; x=1695394518;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yfUKiOEmsJy45kahZfR8rC5y65QOM/SXgmlR0tKjjNQ=;
        b=tarFAy3wdFcrNGNmoxZoU7FRnDKJO2rOjbbRRxC9u98DYgTsefaiGNWFeepvVRhhDQ
         C57lRwaD1V0sTK6kitI5wdpMy+yTMjffjPPq577qJQUqBJrS/I6TY/2I+liONjjiPwpY
         krikCrloa17LptOd36JXGBZ5LWRRK6hbASaxs6/STSOSYMYa8kvwk3kJdHIEQRTKln1O
         sHnzrId04vN6HUbBR3fobGgvFFzmavmSgo3wZkOICfqZiDW318Psp+W+IbRUD6X1QeFT
         cY6Gcx7Iz8ZAvqtF1l4iJs/5anPNWh77rU1gsm7Fs2uznhDTk134cbj890xtkcyb2NyU
         +ICQ==
X-Gm-Message-State: AOJu0YxS1zCltLQyA6pgI+OE6BzfpRs1VEAtCrLro7aqyO71QuAm5Pyd
	4Gpwdb3bbvkRMo0VhUiaaLk=
X-Google-Smtp-Source: AGHT+IGkP/r2BQOopvit1O88LfqF/cCJrFxWN6W/3VVH7Uk2rE5DdAnfo1KqQoODktXZhJfkuB9RCQ==
X-Received: by 2002:a05:6808:1527:b0:3a4:47f8:2bcb with SMTP id u39-20020a056808152700b003a447f82bcbmr3630922oiw.15.1694789717818;
        Fri, 15 Sep 2023 07:55:17 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 129-20020a4a0087000000b00573f244af0fsm1853919ooh.11.2023.09.15.07.55.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 07:55:17 -0700 (PDT)
Message-ID: <99efdffb-4d50-9536-b580-a5527d39524c@gmail.com>
Date: Fri, 15 Sep 2023 09:55:16 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Force use of 5GHz band
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>,
 =?UTF-8?Q?Jonas_Gro=c3=9fe_Sundrup?= <cherti-iwd@letopolis.de>,
 iwd@lists.linux.dev
References: <cfdbbdb5774c4db1c8d3ec7d1e09e70e340f075c.camel@grosse-sundrup.com>
 <34795e04-66e4-4359-a6b2-59b3f47eaf64@gmail.com>
 <d0b59d7ddf82006b6280e3b6652614d9ece09f7a.camel@grosse-sundrup.com>
 <6aac9366-36fd-474d-882e-1bcc940fb444@gmail.com>
 <ea23c922129d3c18c4affb0f0e4a737b7e2a03e5.camel@grosse-sundrup.com>
 <e74c1a50-b5bf-48eb-a53e-100d9706e7f5@gmail.com>
 <0d355152339b4e937910fb2440d1d3ace453514a.camel@grosse-sundrup.com>
 <449345bf-a1e2-b435-f855-7048ab0770e3@gmail.com>
 <2152545f-6de7-425a-8181-c3f76d8b7d63@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <2152545f-6de7-425a-8181-c3f76d8b7d63@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi James,

On 9/15/23 09:44, James Prestwood wrote:
> On 9/15/23 7:35 AM, Denis Kenzior wrote:
>>
>> Hi Jonas,
>>
>>>
>>> (Feature Request: also accept "5GHz" as spelling, given that's the
>>> correct unit spelling? 😅)
>>
>> Yeah we really should.  Too bad we somehow screwed up the capitalization in 
>> this case and settings keys are case-sensitive.
> 
> The API is camel case, so I could see the argument the 'h' should be lower case. 
> But I don't care either way, supporting both is easy enough to add.

True, this is a bit of a grey area.  We don't use strict camel case for 
abbreviations in (some of?) our settings (IPv4, DNSList, APRange, etc).

But yeah, capability for settings to retrieve keys in case-insensitive manner 
would be useful.

Regards,
-Denis
