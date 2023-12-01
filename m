Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD22F4A9AA
	for <iwd@lists.linux.dev>; Fri,  1 Dec 2023 15:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hH/9oIzM"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-77dc733b25cso115883485a.1
        for <iwd@lists.linux.dev>; Fri, 01 Dec 2023 07:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701444139; x=1702048939; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gcyooWGXZCf0hli4wu6gwDMEMilTup5iJHYP113IjgA=;
        b=hH/9oIzMlGb9WnfjIPUSkftEsY8HxfoEhx5LEKUka6JmIBfAkJv9DzTk2yQDfR4M2i
         mEWR8xuoym4mJ2se1/X+zfp0QQEyawoxp2Zsrq/oNKnvbcsDAXrq6dahJtnr4/r7Kxbd
         7jIS2A2NIBvf1OF4N98hLbKAIvRLA9aQS30yw0zqBKAshAa25nNVhSxrWiJJ84qZfcMx
         rrRjsgWCVeyhl2826K8HLOqp9TTBXYMsVbfSDBxV1awJETMsZHMwDWVWcJ7TnKl//3vZ
         JXAQf7pWI3V11LTOEHZgWriTyQssetdOlG11lcGOIyNqNIj/JSV2KoO59s+lAqRNMUjH
         sqGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701444139; x=1702048939;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gcyooWGXZCf0hli4wu6gwDMEMilTup5iJHYP113IjgA=;
        b=GK6IMM9wqJAh7N1ZcRqoJ/H6d8mmcmuMBlUDU1hUtYTwwDO/PAp4xY9G4WvjoL9hD+
         d+N0fkvTB9F31QudUsYSRUn8FYUmvHxyaPwrBr2syLT9UANKuPM9YIb7SJaWLdZGb8yn
         FgkEVtDTCNzj6U4eQ1iyMAqAC2qvRF4nRn031HT9/PAkg0jCSKJpjYKM4Ez+xEQk2YbE
         muG7k1nkY/Y8eqchp/eDb+Zbll9kvz7cnF2aI7Dk2sztwksVJI+AStT/N3q7Q2GW/m/E
         X7XFi69bwr8duTBbPHyM44vrsEGN9p4owRgt1z1HZ0MDc6ctvPYL9LypW25L+abKoLb5
         JgTg==
X-Gm-Message-State: AOJu0YydrK8eVU6mCf2ItbkUg47YEZPsMA9BCVCPKOoqWcJdpqoFzIF5
	/CnszYS/I7UmWAkXV9g2s73mRvR+LJs=
X-Google-Smtp-Source: AGHT+IHThjjOw1+x26pw9gQWi2gl0roFlBzT1/0wbwiA0CQxHrPXZS/We66Pi7ywjo1piHwj8yLV2w==
X-Received: by 2002:a05:620a:13cc:b0:77d:c8b9:a6a4 with SMTP id g12-20020a05620a13cc00b0077dc8b9a6a4mr10170714qkl.59.1701444139538;
        Fri, 01 Dec 2023 07:22:19 -0800 (PST)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id e3-20020a05620a12c300b0077d8e229ebbsm1578322qkl.0.2023.12.01.07.22.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Dec 2023 07:22:19 -0800 (PST)
Message-ID: <43b52716-991d-436b-b1b6-a6d9d459ff8c@gmail.com>
Date: Fri, 1 Dec 2023 07:22:16 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] handshake: Add cleanup function for handshake_state
Content-Language: en-US
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20231201040020.161143-1-denkenz@gmail.com>
 <c0e09d22-519b-4161-b8ab-32e3830569fd@gmail.com>
 <b656ec75-6f85-49c6-b78b-75d15f0aff08@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <b656ec75-6f85-49c6-b78b-75d15f0aff08@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 12/1/23 07:08, Denis Kenzior wrote:
> Hi James,
>
> On 12/1/23 06:42, James Prestwood wrote:
>> Hi Denis,
>>
>> On 11/30/23 20:00, Denis Kenzior wrote:
>>> To allow _auto_(handshake_state_free) variables to be used.
>>> ---
>>>   src/handshake.c | 7 ++++++-
>>>   src/handshake.h | 3 +++
>>>   2 files changed, 9 insertions(+), 1 deletion(-)
>> All LGTM
>>
>
> Any ideas why testPSK-roam tests are failing?  They seem to be quite 
> flaky on my machine as well, passing only 4/9?  Doesn't seem related 
> to this series though?
>
> |     testPSK-roam    |   4    |   5    |    0    | 256.84 |

Not seeing that on my end (with and without your patches). The 
packet-loss roam tests is always flaky on the CI, but I've never seen 
that many failures.

What UML kernel are you running so I can take that out of the equation?

>
>
> Regards,
> -Denis
>
