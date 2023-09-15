Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B672230CE1
	for <iwd@lists.linux.dev>; Fri, 15 Sep 2023 14:42:21 +0000 (UTC)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-59b4ec8d9c1so23971677b3.0
        for <iwd@lists.linux.dev>; Fri, 15 Sep 2023 07:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694788940; x=1695393740; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LgRdWJVK+rQ9hpiYGunZ9pIEpxo7FzTkDd+UHbEf1CY=;
        b=LJabg+RZP7bw1fWWqGJNAPdgWZuzCBXKJ16qlytlDHeVtz3DE/U4sbMEsjaKqcFo5S
         pn7Gy5laHBHsBwTrgt2UBzsUg/FN56vkNfldS88O6djC0mjIM7Q9pUNwG1wP0Q0OIxeL
         fCb8pgBFO0mTas0rr5fzaFCiV0o9GrsWk+USi/qyTeIEKNaxl96u8rvQht50sWu02UKt
         u9yLMmKDEmm2D9NVefE7scjj6v+DwOlZuMlS39wW8Qe37gvXXHYeRpNw/CJf69aWB2wr
         SiWbNNa1vnwrj5ITtECmbydOFc1hQazdvrLBNZNti9yDKNI5finugOfCD/bcCXk/UsuU
         BuXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694788940; x=1695393740;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LgRdWJVK+rQ9hpiYGunZ9pIEpxo7FzTkDd+UHbEf1CY=;
        b=YtELmt+yqABekn2x/3YqjUg0juuyBU6pDcQjh68WGR0ErwWj6ir/H2CGVlubwSBRyg
         wjVqZsZUVWZfv57gzAFSrrFqeKqB5UJaTyaUUOxjfVfWioj7s9jFEwDQ8XSKjiw7cr/T
         lzNjF6S+WfxCyPipYwNF0ygeFN+8m2Dg/ujKQGCagEo1cEZh0WKw23yEDW6vZhGP7jj6
         E0chfib09U3IhScnhngy03fQ8LzJtGm+7T6UV+KNK4RsXNXM14tik4XOPE6Pto+6b/E/
         eT6IiZ/Yeo+dL+6UCLuFuC5aWHaEBwQnLmiNggmXZt3c58bKQU0Pw+ulcrypby5AJodQ
         V8RA==
X-Gm-Message-State: AOJu0YyvZ2kdF5D18ImLR0gCnglMBoybtREH7pNbq2OAKsodMoHnZg9l
	5UGmqopamm22bSeJOmGSXxI=
X-Google-Smtp-Source: AGHT+IGpz5qe17UMKClZ8WL/Sj6I/XSPZTaBgbgarSbtoDkRrBpe1c0jBWyrC8G4jrc22Y8H4FQKSg==
X-Received: by 2002:a81:4f8d:0:b0:59b:f46d:a54 with SMTP id d135-20020a814f8d000000b0059bf46d0a54mr1838865ywb.14.1694788940499;
        Fri, 15 Sep 2023 07:42:20 -0700 (PDT)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id o8-20020a817308000000b00594fff48796sm891576ywc.75.2023.09.15.07.42.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 07:42:19 -0700 (PDT)
Message-ID: <8629e294-0550-436d-91b3-e0cf1c84f8e7@gmail.com>
Date: Fri, 15 Sep 2023 07:42:17 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Force use of 5GHz band
Content-Language: en-US
To: Denis Kenzior <denkenz@gmail.com>,
 =?UTF-8?Q?Jonas_Gro=C3=9Fe_Sundrup?= <cherti-iwd@letopolis.de>,
 iwd@lists.linux.dev
References: <cfdbbdb5774c4db1c8d3ec7d1e09e70e340f075c.camel@grosse-sundrup.com>
 <34795e04-66e4-4359-a6b2-59b3f47eaf64@gmail.com>
 <d0b59d7ddf82006b6280e3b6652614d9ece09f7a.camel@grosse-sundrup.com>
 <6aac9366-36fd-474d-882e-1bcc940fb444@gmail.com>
 <ea23c922129d3c18c4affb0f0e4a737b7e2a03e5.camel@grosse-sundrup.com>
 <e74c1a50-b5bf-48eb-a53e-100d9706e7f5@gmail.com>
 <43d47533-a4a3-e3d5-8f17-30467475660a@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <43d47533-a4a3-e3d5-8f17-30467475660a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 9/15/23 7:30 AM, Denis Kenzior wrote:
> Hi James,
> 
> On 9/14/23 13:33, James Prestwood wrote:
>>
>> On 9/14/23 11:22 AM, Jonas Große Sundrup wrote:
>>> On Thu, 2023-09-14 at 11:16 -0700, James Prestwood wrote:
>>>> Yep that would do it.
>>>
>>> automatically quick scan upon start: https://p.nnev.de/12646
>>>
>>> explicit scan triggered via "station wifi scan":
>>> https://p.nnev.de/12647
>>>
>>> anything insightful in there?
>>
>> A value of 1000 should definitely work... Are you sure the syntax is 
>> right inside main.conf:
> 
> Careful about using high factors like this.  Right now the rank is 
> computed using a double, but truncated to a uint32_t and clamped to 
> USHRT_MAX / uint16_t.  This works fine, but the FT roaming calculation 
> is a bit more careless.  Could lead to very funny results.

I don't think FT uses that ranking factor, but either way yes some huge 
factor like that shouldn't be needed.

> 
> We may be better off introducing 2.4GHz factor and suggesting using a 
> 0.0 multiplier to turn bands off.  Or add an explicit setting.

I actually was thinking this would be nice. We actually don't even run a 
2.4ghz network at all so that would reduce extra scanning cycles, even 
if just a couple seconds. I'll go ahead and add support for 0.0 factors 
disabling the band, and add a 2.4 factor setting.

> 
> Regards,
> -Denis
> 
