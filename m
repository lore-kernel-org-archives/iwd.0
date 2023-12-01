Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961431945F
	for <iwd@lists.linux.dev>; Fri,  1 Dec 2023 15:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ki7lkEiq"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-58d54612d9cso1246919eaf.1
        for <iwd@lists.linux.dev>; Fri, 01 Dec 2023 07:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701444770; x=1702049570; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jo45pgpAsT/fYAMvIFhy3WxKzSkIahtacQvjcSvodfQ=;
        b=Ki7lkEiqQwInIdqYskRmuFgAk/D1foU1CL4sFvkXkQIpkP4wzv2MdtQP2YqSKcY07T
         /xsCvukVhp3FBqzRTMkNciFPJuFXOzxl1NC9zAPZm6k+NS6JSue+hre8wGgIHmVd31aC
         jXZ6nGNE5MP0Mo08BBC5gv83ABRNxtvLXAGes1I/GES4nNTX1J8/puOKLMUI8lBe/3af
         893OmUitnuyzWQ+vsctse0EZiggD+95x8RRqNaZ9xd+DUa9jGtuqX8nUP2wTRrzBiqae
         mYgQxNkvq6ziC1UhAHwqgzdXGDLhYYXQDrwK3WcdDf4Vq12yGFcs5rraLcgm/keDcNBZ
         7NIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701444770; x=1702049570;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jo45pgpAsT/fYAMvIFhy3WxKzSkIahtacQvjcSvodfQ=;
        b=YzZCkxyTt8YUaeU/Ek/8Jiqe+c8wKwQMrtzY5voeYBW2VNaPWnf+kXrPTC9QG1f9xs
         t2iORKaA4c4VRYYrvXeDgrA11TiHW1Dg4LTqabva+0lU9OjmZdn8cmiyZTaMS81shCuA
         0Tv53rgsTcNrO0Im6ZZgDqtPMwTYypS26y9nRNSZ7heG2JJ4KHCwkiD57LLfG/d57Sk8
         CehyfjalfrZGAIkv38dPbNd7N7e4yb1fJC/TqZeLPwOBNkPu2hPOqoqlhI4vRETkJgpC
         qWbKUjz+4Wo/aF+mbhUkzoHFuvJX9H8WAUhezs1YC/m+2JcvC0aSR/ApiyE28Js6HKLl
         gIHA==
X-Gm-Message-State: AOJu0Yzv14fD25mb7fBaamuqqEgnhiLiQQRUdoqyFncyrIFmkmpzqmEM
	bq2hCnnfV9vDuhCetz3DfeQ=
X-Google-Smtp-Source: AGHT+IHxOOWKa3c6s7xhvnbs5nBwweq4xcT6mUngAn0+9DW24fpw+sXhaM+HR1gkkYtTfyuluq2Zog==
X-Received: by 2002:a05:6359:150a:b0:170:73d:fce9 with SMTP id jt10-20020a056359150a00b00170073dfce9mr4166686rwb.16.1701444769562;
        Fri, 01 Dec 2023 07:32:49 -0800 (PST)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id bu17-20020ad455f1000000b0067aa1068670sm285452qvb.11.2023.12.01.07.32.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Dec 2023 07:32:49 -0800 (PST)
Message-ID: <6a803951-646d-4fbc-87e8-44b8c3a6436b@gmail.com>
Date: Fri, 1 Dec 2023 07:32:46 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] handshake: Add cleanup function for handshake_state
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20231201040020.161143-1-denkenz@gmail.com>
 <c0e09d22-519b-4161-b8ab-32e3830569fd@gmail.com>
 <b656ec75-6f85-49c6-b78b-75d15f0aff08@gmail.com>
 <43b52716-991d-436b-b1b6-a6d9d459ff8c@gmail.com>
In-Reply-To: <43b52716-991d-436b-b1b6-a6d9d459ff8c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 12/1/23 07:22, James Prestwood wrote:
> Hi Denis,
>
> On 12/1/23 07:08, Denis Kenzior wrote:
>> Hi James,
>>
>> On 12/1/23 06:42, James Prestwood wrote:
>>> Hi Denis,
>>>
>>> On 11/30/23 20:00, Denis Kenzior wrote:
>>>> To allow _auto_(handshake_state_free) variables to be used.
>>>> ---
>>>>   src/handshake.c | 7 ++++++-
>>>>   src/handshake.h | 3 +++
>>>>   2 files changed, 9 insertions(+), 1 deletion(-)
>>> All LGTM
>>>
>>
>> Any ideas why testPSK-roam tests are failing?  They seem to be quite 
>> flaky on my machine as well, passing only 4/9?  Doesn't seem related 
>> to this series though?
>>
>> |     testPSK-roam    |   4    |   5    |    0    | 256.84 |
>
> Not seeing that on my end (with and without your patches). The 
> packet-loss roam tests is always flaky on the CI, but I've never seen 
> that many failures.
>
> What UML kernel are you running so I can take that out of the equation?
Nvm, I'm getting the 4 failures on a 6.6 kernel now. Something must have 
changed so I'll look into it.
>
>>
>>
>> Regards,
>> -Denis
>>
