Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF716E2A6
	for <iwd@lists.linux.dev>; Tue,  5 Dec 2023 21:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xuy4U425"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3b9ba82d8ccso1375316b6e.1
        for <iwd@lists.linux.dev>; Tue, 05 Dec 2023 13:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701812736; x=1702417536; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YWPcDDQHMlT8a+oCHrqY6i5PppixmGbliHoEyYonEAE=;
        b=Xuy4U4254Iy25LQP3XlsbSXf9pwntOorZevdYTZg21Zzayc74OUNGKYbFCJm7RGKFE
         FkguQXu5BK3WkVSjQHysplZeO2bH4t7sqXt04uHH1cBm8bJgAw8Zngvbc6K3veiB9du1
         rIojVusSfMVRWdXiI3zdUeleLTH2fPh8/1Z1gCKCmEanuYucp4aoomjnyCpiQYwil4Fw
         KR7Pfpf2Cem785/rDL7+2ezPKFeUqOi9vUu6BcM8/7yuFHnkGBXO4qLgxI8nHwTUcRnd
         wrqj8gBsCyiYnnkMEtXbzWosietrFfFmIsvvpSE/wFacySNRT29PQ2jfD6Yz4lu57t5c
         ZAWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701812736; x=1702417536;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YWPcDDQHMlT8a+oCHrqY6i5PppixmGbliHoEyYonEAE=;
        b=r+Ga2sahoqqo6Dn/iOchGmNXiXP45ztKwC5sDTUYE9+dIF3mkVf34RHYvlxICye4jF
         Uk0n795VLLlkzpsLQCiurss+nQ8jp8kadJQpyousWIdJ4sVvviLZObnui+91q8lK6Sod
         QbrApDRNyD6s/RTGWp9TK4J8R0aal6YNDKzDN1uIs7LoMsUXUpWxefjxyn2jtOu8D8Ca
         lKRTN5TZ2BHZDOO2wMkvDr9bf0x1V7qWK2Cpfm2stKWsr58f9h/sVaqxBu7HTUbzNGUE
         1jA+nFUEg2+k2zTgleVWzKTPjMgb6fxtp8CRDCFfk5+uCYxQOe05XMnoL+fC45Kv7j/G
         b/TQ==
X-Gm-Message-State: AOJu0YzgITyf19mpj886DThv07sDUpVrnuCWyXTYsGBO9ygDxF0i1CgY
	r8Twlco/0xdEo7yxWwVnbjQh4C7p9hE=
X-Google-Smtp-Source: AGHT+IHV+A+2e0YIGZxap9eHTKh/Y7uGmmTItoTi5yZ7G44zbW91X8eVxWN3kqAhOgxGSEgPIraLFA==
X-Received: by 2002:a05:6808:308:b0:3b8:b063:5067 with SMTP id i8-20020a056808030800b003b8b0635067mr6432597oie.104.1701812736490;
        Tue, 05 Dec 2023 13:45:36 -0800 (PST)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id dt11-20020a05620a478b00b0077d74f884d9sm5396634qkb.117.2023.12.05.13.45.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 13:45:36 -0800 (PST)
Message-ID: <2f2871a4-faed-477a-b327-33d4355ec55f@gmail.com>
Date: Tue, 5 Dec 2023 13:45:34 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] netdev: hack back in disconnect event
Content-Language: en-US
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20231205175203.1935692-1-prestwoj@gmail.com>
 <20231205175203.1935692-3-prestwoj@gmail.com>
 <9b1a1ce7-16eb-4e37-8b7b-2750d0ed66fd@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <9b1a1ce7-16eb-4e37-8b7b-2750d0ed66fd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 12/5/23 13:37, Denis Kenzior wrote:
> Hi James,
>
> On 12/5/23 11:52, James Prestwood wrote:
>> Not sure how we want to address this, but FT is special in that it
>> has no connect_cb but can still trigger an associate timeout.
>> Currently if FT times out associating IWD will hang indefinitely.
>
> Do our auto tests cover this case?  I wonder why they didn't flag this 
> earlier?
They don't (only auth timeouts), but patches 1/2 add an associate 
timeout test.
>
>>
>> This behavior can be tested with the prior autotest patches (without
>> this patch applied).
>>
>> Fixes: 30c6a10f28 ("netdev: Separate connect_failed and disconnected 
>> paths")
>> ---
>>   src/netdev.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/src/netdev.c b/src/netdev.c
>> index f2e887b4..2d1120c4 100644
>> --- a/src/netdev.c
>> +++ b/src/netdev.c
>> @@ -3045,7 +3045,13 @@ static void netdev_associate_event(struct 
>> l_genl_msg *msg,
>>                * out. The failed connection must be explicitly
>>                * initiated here.
>>                */
>> -            netdev_connect_failed(netdev,
>> +            if (!netdev->ap) {
>
> if (netdev->in_ft) ?
>
>> +                if (netdev->event_filter)
>> +                    netdev->event_filter(netdev,
>> +                        NETDEV_EVENT_DISCONNECT_BY_SME,
>> +                        NULL, netdev->user_data);
>> +            } else
>> +                netdev_connect_failed(netdev,
>>                       NETDEV_RESULT_ASSOCIATION_FAILED,
>>                       status_code);
>>               return;
>
> I wonder if we should make ft_associate use netdev_reassociate?

So pass station_connect_cb into ft_associate, then to netdev? That seems 
reasonable.

> Regards,
> -Denis
