Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3ACD14AAD
	for <iwd@lists.linux.dev>; Fri, 10 Nov 2023 12:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QPMjt6nK"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-1f06931e4f7so1127184fac.1
        for <iwd@lists.linux.dev>; Fri, 10 Nov 2023 04:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699621195; x=1700225995; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IIohc7z7hQ9Nb5p4g5BPmDx+mjs3ym0ejNDNwOxS2y8=;
        b=QPMjt6nKUIzxOKCz+GF0HHmjakN0BXhBDivif7FjQ/iPN8Zon/gg6RwaUMUs/47hrJ
         EVXeZFdyNt2m+m5YIhzzsmZ8N1B2fBMLSocvM1g4FXJuLrZFnF0nm8p75xuzcFKa1rSd
         RjOGUZJaWSp12Fjyl9t73ILYpw5rwb5YKRaESvvBTXOmGddCN46zxvKcyG32uWy7YQ5l
         ey4iYg39wFpBncVZa1P2Vv89gsN4kXZpsclgeLRd66HitwHUspb1W6WbEHP5aZCu8ZcC
         7+XWIJdW7dkxUaWA14ojDhacWlbOGHypRTksoDAfA0JDLAkEOEqzAz35ytkypS7oEYTr
         CV7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699621195; x=1700225995;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IIohc7z7hQ9Nb5p4g5BPmDx+mjs3ym0ejNDNwOxS2y8=;
        b=BsyD2AaC78pd38kBn57HG71QGK+KBeXCYpaReh+X7YB0lN7/Y2OvAgqH65n6FW0LSb
         IrOJfPzb8p4KpzA3OCF0312IBATJXKppYOvjdrgeOjK/GfXL3AupbkqJdAtIWVfuB5bE
         0n/RogRYKa+f18vkqnHc4gQO1x05SG+dsmi7M1L7Faf31i0Bp3waj5XraSlWfZMLgCv3
         3KfdNviJoBSobAZnDDJTTpqrrv5W8qhaiD5NuGMO2stAJT8nBCXRj1W45k06HMylTEKT
         TxTbM2mNjVVP1jSGyzcfUzdGUmchVNFDmGnU2+rstjBTlDQtAi6XpDZXmDMS2DK95LGy
         VtsA==
X-Gm-Message-State: AOJu0YxJofATn/EyIK4EoSZVPVxSmXGaIsCki0hWuLHNxqlks2Ch9dh1
	Zwo6QzPysOsMfZ5i7QYh8Vc=
X-Google-Smtp-Source: AGHT+IEYosBT9n6W+MI2jig46JWrouoIhIEXaMBc7FKlrWf3dpCVYVGbkkPXxdOiXiReMJozdJlFbA==
X-Received: by 2002:a05:6870:4204:b0:1e9:924a:7385 with SMTP id u4-20020a056870420400b001e9924a7385mr9839133oac.28.1699621195521;
        Fri, 10 Nov 2023 04:59:55 -0800 (PST)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id o14-20020a05620a228e00b007678973eaa1sm660577qkh.127.2023.11.10.04.59.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Nov 2023 04:59:55 -0800 (PST)
Message-ID: <31ffd845-8f12-48d4-9493-fec3f921a1ae@gmail.com>
Date: Fri, 10 Nov 2023 04:59:53 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] client: add helper to call method via builder
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20231109184926.52629-1-prestwoj@gmail.com>
 <20231109184926.52629-2-prestwoj@gmail.com>
 <8963c077-984f-474d-afec-5e02ef8182e3@gmail.com>
 <f4eae46b-977a-435b-8798-0e59343c1e2d@gmail.com>
In-Reply-To: <f4eae46b-977a-435b-8798-0e59343c1e2d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 11/10/23 4:28 AM, James Prestwood wrote:
> Hi Denis,
> 
> On 11/9/23 6:22 PM, Denis Kenzior wrote:
>> Hi James,
>>
>> On 11/9/23 12:49, James Prestwood wrote:
>>> There was no way to call a method with anything except basic
>>> arguments. Add a helper to use a builder to create more complex
>>> args.
>>> ---
>>>   client/dbus-proxy.c | 36 +++++++++++++++++++++++++++++++++++-
>>>   client/dbus-proxy.h |  9 +++++++++
>>>   2 files changed, 44 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/client/dbus-proxy.c b/client/dbus-proxy.c
>>> index 42b8427f..de252427 100644
>>> --- a/client/dbus-proxy.c
>>> +++ b/client/dbus-proxy.c
>>> @@ -2,7 +2,7 @@
>>>    *
>>>    *  Wireless daemon for Linux
>>>    *
>>> - *  Copyright (C) 2017-2020  Intel Corporation. All rights reserved.
>>> + *  Copyright (C) 2017-2023  Intel Corporation. All rights reserved.
>>
>> Is this correct?
> 
> I'm generally terrible about updating the dates on the copyright and 
> really never do it. Decided I'd try and do better this time :)
> 
> But I'm not actually sure how this works. Should there be multiple 
> copyright notices if different companies touch existing files? or should 
> we just leave the copyrights as-is if the file already exists.

Nevermind, took a look at the kernel and they just append the 
companies/dates. It had been so long at Intel I forgot how all this 
worked :)

Thanks,
James
