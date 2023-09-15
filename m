Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCF9CA6F
	for <iwd@lists.linux.dev>; Fri, 15 Sep 2023 17:36:24 +0000 (UTC)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-59be8a2099bso25169707b3.0
        for <iwd@lists.linux.dev>; Fri, 15 Sep 2023 10:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694799383; x=1695404183; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t/d8clZ1ovv8D9xlZSwv8q6WDXRmHK9sNh4JMJyL/yw=;
        b=PDqIwgCGuq/c1gAZ8qBWbcio9Sv+tvy4+4/Tsd3ZkKW3w1Nz0QqgUzl8qKojQ/zqn0
         JwYe/GOd9KkbakN3nR96hDrRYgCaAWwO13SCYuJsawe3Kh7fIp+Mv6VZkOmiNEGkygVz
         TKAuQ7VYUwaQ/klT/B6CQhYnsF3modlwspbIiJ2buyG4NivYuEOHvv7eOqpYsuiBdd/P
         4d4EUTbGpFkAZy0xPOpWyaGHyZ+XrGg22tuj0BpbgRZg1dh+tvWjTbFvZPHIKpPH5xJc
         R2hCm1sNw7KUvG1NRe47Z3NVF7z0NaIA/mUlIjMeCyCqEPMowYzrzRSNc4jBqEryyp21
         QGpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694799383; x=1695404183;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t/d8clZ1ovv8D9xlZSwv8q6WDXRmHK9sNh4JMJyL/yw=;
        b=wGHt4kumcjVa3VtSi3nL/R9Rlwaw+XBWVRe7DmROu6Q/EED1qcP1Otyhx2WPui/Uoy
         jcQtrESO0CeV3kKgYirUW/kk+E8GA07nkUcL8O0zv3fyQh/WCBSET5zCiOCLCoU1CHvz
         IvLoeUQ5tA13ltizRRt6k1lNNNiijXD8iXGd5WleCfGIm1L6ksjKf3aUScK46beQ8pW/
         axriPAWxIE2tRpJ9517Sn8U19bVcHKxH8T2nQms6bs3l/qPeEbKHZ89mC3uREfvKpI9+
         01osnQ81GOW5790UjZxvGrdzcgNuUxcC6dgorI8pOh/fyBJSP8a0f9TaZ6R5kN3KxWMp
         keOw==
X-Gm-Message-State: AOJu0YwMz6gnH4KulJoT6HEp/0bB0S2dcRjvKtSW8pb80S72MXJdrQl2
	4ANpIid+28QXJvXHKUrQ39Q=
X-Google-Smtp-Source: AGHT+IH+uLzIwkMy7V4pWY0n6tRX/m1++g2ZJdo5qnKRoAOKsemzQ48DWCZSABpXRRpu28aKwsVprQ==
X-Received: by 2002:a81:fd07:0:b0:583:c917:7ff0 with SMTP id g7-20020a81fd07000000b00583c9177ff0mr1983840ywn.51.1694799383060;
        Fri, 15 Sep 2023 10:36:23 -0700 (PDT)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id z5-20020a81a245000000b005832fe29034sm953602ywg.89.2023.09.15.10.36.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 10:36:22 -0700 (PDT)
Message-ID: <e144f8a4-82b2-4882-bf25-5fac6165b9af@gmail.com>
Date: Fri, 15 Sep 2023 10:36:19 -0700
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
 <8629e294-0550-436d-91b3-e0cf1c84f8e7@gmail.com>
 <42efcf9a-6aca-c728-ba9d-fe95a6066900@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <42efcf9a-6aca-c728-ba9d-fe95a6066900@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 9/15/23 7:47 AM, Denis Kenzior wrote:
> Hi James,
> 
>>> Careful about using high factors like this.  Right now the rank is 
>>> computed using a double, but truncated to a uint32_t and clamped to 
>>> USHRT_MAX / uint16_t.  This works fine, but the FT roaming 
>>> calculation is a bit more careless.  Could lead to very funny results.
>>
>> I don't think FT uses that ranking factor, but either way yes some 
>> huge factor like that shouldn't be needed.
>>
> 
> Right, but it uses another factor and truncates to a uint16_t.  So if 
> you have USHRT_MAX as rank, multiply then truncate -> fun things happen.
> 
>>>
>>> We may be better off introducing 2.4GHz factor and suggesting using a 
>>> 0.0 multiplier to turn bands off.  Or add an explicit setting.
>>
>> I actually was thinking this would be nice. We actually don't even run 
>> a 2.4ghz network at all so that would reduce extra scanning cycles, 
>> even if just a couple seconds. I'll go ahead and add support for 0.0 
>> factors disabling the band, and add a 2.4 factor setting.
> 
> Excellent.

How would you prefer I do this? We've got quite a few modules using scan 
APIs so I question if we want to filter the frequencies before calling 
scan_*

If we filter in scan.c and call back as if the scan returned no results 
we shouldn't need to touch anything except scan.c. The downside is its a 
bit of wasted work doing this since we have to create requests and work 
items for nothing, but the alternative of adding this specific logic to 
each module using scan calls seems worse IMO, what do you think?

> 
> Regards,
> -Denis
