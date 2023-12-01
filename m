Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF06BC8EA
	for <iwd@lists.linux.dev>; Fri,  1 Dec 2023 16:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VmX+WS7f"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-777754138bdso117048685a.1
        for <iwd@lists.linux.dev>; Fri, 01 Dec 2023 08:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701446808; x=1702051608; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gAzmwyu4XtG9CNbHtZ27JEXHfYiQLL5Zb2+to3P4GqQ=;
        b=VmX+WS7fnsJODd1Qwc1T2dBsRY0+6gmGhvjLL+L/lmvoeezHPDJnPeWsBAnFT8rsHJ
         BTakPrp5buCpz91PsbH0rBzOPOegzDI7ORxIdrIxUF5G5BYIZ5cqKpOdksgZcHnNZaZQ
         6xGTaKjVTzV9H683poVBkJZsvru5pW6ENPJVSFtQFWuP11BKg0UxU3MWxKh29UerD5M1
         En4VzOcGzZddF06w73vTZaJjaDUP+CeDTihluHRLMJ70fCfnmCe6gRkkUwBTdR08TZ7b
         nHXMoBU7Ccox3cqQ6TP1c3WCUDLFAH0O1k4lbyYUdFoddFNnfejRd5mVmbDsMeoJ5ztt
         WnLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701446808; x=1702051608;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gAzmwyu4XtG9CNbHtZ27JEXHfYiQLL5Zb2+to3P4GqQ=;
        b=mp5HHfA3K4SOMKpqjFN3IUDqk5vCUhSnvmk4QB9btne/XT4NivHBb9UIU8CplSXBLS
         pFWl0j4CD38ZRuWVtNF/e4BQTVlpR0JizkaHcfPhA2UJ99T9CuegrXM9GoSd8f1D/gMF
         KaSouWzeYdbP/jHGbttfc2fKBAwI6Zp1iU3Dh8rRAlbiFgUYBrRhQATRAKGhqzOt9yoT
         Q8sNIz48jjipxVNzu7iwKurge/lxo4KiQMqAhPmgSq+xzcpL9kyR1zycZZ9VdcyNVQ3J
         dLHsUT5vhRkCx7+yfvAe+yggFkZNxkLV0mj57eywF3T8DeNnuUh+ewexaqAcYmPLB8iR
         IKSQ==
X-Gm-Message-State: AOJu0YxAsbLJjHR6ddJcrQ/Gbirp1Ra4H9qqBNIZ75e8BgCpVSUZZYVa
	WUn2w+Qhj/SZZ/d3PfARI2I=
X-Google-Smtp-Source: AGHT+IFjseXS3LgNSwswkTvZrTOh3skpjoyVFwJqpzYUeQMn7/0b5PB9fYCxqJM/BTalO02RZeIl4g==
X-Received: by 2002:a05:620a:f0f:b0:77d:b8fb:e19d with SMTP id v15-20020a05620a0f0f00b0077db8fbe19dmr15279717qkl.10.1701446808386;
        Fri, 01 Dec 2023 08:06:48 -0800 (PST)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id e15-20020a37ac0f000000b007659935ce64sm1603646qkm.71.2023.12.01.08.06.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Dec 2023 08:06:47 -0800 (PST)
Message-ID: <7a80e9d4-ecd8-4592-a5ec-d81cbe666991@gmail.com>
Date: Fri, 1 Dec 2023 08:06:45 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] handshake: Add cleanup function for handshake_state
From: James Prestwood <prestwoj@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20231201040020.161143-1-denkenz@gmail.com>
 <c0e09d22-519b-4161-b8ab-32e3830569fd@gmail.com>
 <b656ec75-6f85-49c6-b78b-75d15f0aff08@gmail.com>
 <43b52716-991d-436b-b1b6-a6d9d459ff8c@gmail.com>
 <6a803951-646d-4fbc-87e8-44b8c3a6436b@gmail.com>
Content-Language: en-US
In-Reply-To: <6a803951-646d-4fbc-87e8-44b8c3a6436b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 12/1/23 07:32, James Prestwood wrote:
>
> On 12/1/23 07:22, James Prestwood wrote:
>> Hi Denis,
>>
>> On 12/1/23 07:08, Denis Kenzior wrote:
>>> Hi James,
>>>
>>> On 12/1/23 06:42, James Prestwood wrote:
>>>> Hi Denis,
>>>>
>>>> On 11/30/23 20:00, Denis Kenzior wrote:
>>>>> To allow _auto_(handshake_state_free) variables to be used.
>>>>> ---
>>>>>   src/handshake.c | 7 ++++++-
>>>>>   src/handshake.h | 3 +++
>>>>>   2 files changed, 9 insertions(+), 1 deletion(-)
>>>> All LGTM
>>>>
>>>
>>> Any ideas why testPSK-roam tests are failing?  They seem to be quite 
>>> flaky on my machine as well, passing only 4/9?  Doesn't seem related 
>>> to this series though?
>>>
>>> |     testPSK-roam    |   4    |   5    |    0    | 256.84 |
>>
>> Not seeing that on my end (with and without your patches). The 
>> packet-loss roam tests is always flaky on the CI, but I've never seen 
>> that many failures.
>>
>> What UML kernel are you running so I can take that out of the equation?
> Nvm, I'm getting the 4 failures on a 6.6 kernel now. Something must 
> have changed so I'll look into it.

6.2 - works

6.5 - works

6.6 - broken

I tried applying that patch [1] from Johannes onto 6.6 but it failed to 
apply. So anyways it appears CQM events are broken in at least 6.6.

[1] 
https://lore.kernel.org/linux-wireless/bbfd6f959e7ff4b567084ef3d962bf255aa25c85.camel@sipsolutions.net/T/#t

>>
>>>
>>>
>>> Regards,
>>> -Denis
>>>
