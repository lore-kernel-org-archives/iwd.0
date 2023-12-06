Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3011548CEE
	for <iwd@lists.linux.dev>; Wed,  6 Dec 2023 16:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SFJKVxDG"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-67a934a5b7eso44216d6.3
        for <iwd@lists.linux.dev>; Wed, 06 Dec 2023 08:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701881349; x=1702486149; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yhV4x6FAzwAr36UjdqAZHYaTT7li/3itgp1J5cI/tI4=;
        b=SFJKVxDGUg2B8Jic2BfhITkzItCe1J3noy0n96QDWbuapa1j7BEgqVo//mROCz864C
         HHZ07+DHI94gUBNluJNtflewnVwJFnwG0OIZ49TYvPpq4rxRa3iQ+J5nDabcSE8/S1au
         g+oGmq5qfsujiMMZ1GjjM6V6IMkl1cqQcnAXdOnM4ids3n+rvUoKmV0AZLOsdKEtcEA9
         IDJeU6wGHDq0P8/NHgJgXnC9zE9q7/jaN54MWWEZV8wqIAe3M3BJZXmwgNmOSanHQxxS
         Q89ovF2hCS4JnHB54RmEyPUK/cnQQxdQidqsIDrAXCjxWgQWyKKmwN0mIfQjABxKr5iV
         YMzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701881349; x=1702486149;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yhV4x6FAzwAr36UjdqAZHYaTT7li/3itgp1J5cI/tI4=;
        b=ALHIofrY3aJT3jdTliSlMhBGPwUWW8K+z2EP46z79edzfwUT0ebKHg+Y+LrRK5zaKI
         hVZ9JviAlDSlcyWGuQAsIbhHLxGeEH/RSkAzvkXDFRXBkM2ahYnjx5JUj3RBMqW0QGDq
         pZ7Tvlnp2BVBGiUlWw0RfsJSRnv3QrEWVtd2iUcS8NTxMMOe5gmh6T9FEsTeiQinmca5
         rxGu66z/sHnKIfGGYvAbryXH58QPWWI3FMRme5mWFN6Ac8UsESDMt4mAFdDWPkfpEkQo
         ErvKXX9vi4CHRBZ0CyBDoYAHvMNpP6XQwhGuaAgYxTQ67WjMBZNCAV/0Aqi+EOYEar1R
         yyMA==
X-Gm-Message-State: AOJu0Yx4yUTTDujCbMTMs/YNYtqgAJAdjuC+T7Yvi0M/osVMgcdld1XA
	lV9/5zsBqORHFO4w75tcSF4=
X-Google-Smtp-Source: AGHT+IErkp6tCQKx7QhtDqnRqNO9x//GB433UpdyUdDrZw4SAaP/R9vfHNEJNhgBXq7tn8ZzErGfhg==
X-Received: by 2002:a05:6214:580a:b0:67a:6041:6f94 with SMTP id mk10-20020a056214580a00b0067a60416f94mr1213404qvb.24.1701881348941;
        Wed, 06 Dec 2023 08:49:08 -0800 (PST)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id n13-20020a056214008d00b0067a11a3be11sm107958qvr.61.2023.12.06.08.49.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 08:49:08 -0800 (PST)
Message-ID: <33f261dd-5dbb-4c5f-9943-0cbadc2773a6@gmail.com>
Date: Wed, 6 Dec 2023 08:49:07 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/9] netdev: add netdev_ft_reassociate
Content-Language: en-US
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20231206150708.2080336-1-prestwoj@gmail.com>
 <20231206150708.2080336-7-prestwoj@gmail.com>
 <054746c2-f399-4c2c-b041-b76e7a34ada7@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <054746c2-f399-4c2c-b041-b76e7a34ada7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 12/6/23 08:40, Denis Kenzior wrote:
> Hi James,
>
> On 12/6/23 09:07, James Prestwood wrote:
>> Essentially exposes (and renames) netdev_ft_tx_associate in order to
>> be called similarly to netdev_reassociate/netdev_connect where a
>> connect callback can be provided. This will fix the current bug where
>> if association times out during FT IWD will hang and never transition
>> to disconnected.
>>
>
> I like it!
>
> Nitpick below...
>
>> This also removes the calling of the FT_ROAMED event and instead just
>> calls the connect callback (since its now set). This unifies the
>> callback path for reassociation and FT roaming.
>> ---
>>   src/netdev.c | 44 ++++++++++++++++++++++++++------------------
>>   src/netdev.h |  5 +++++
>>   2 files changed, 31 insertions(+), 18 deletions(-)
>>
>
> <snip>
>
>> diff --git a/src/netdev.c b/src/netdev.c
>> index f2e887b4..7d52ffea 100644
>> --- a/src/netdev.c
>> +++ b/src/netdev.c
>> @@ -1409,16 +1409,14 @@ static void netdev_connect_ok(struct netdev 
>> *netdev)
>>               scan_bss_free(netdev->fw_roam_bss);
>>             netdev->fw_roam_bss = NULL;
>> -    } else if (netdev->in_ft) {
>> -        if (netdev->event_filter)
>> -            netdev->event_filter(netdev, NETDEV_EVENT_FT_ROAMED,
>> -                        NULL, netdev->user_data);
>> -        netdev->in_ft = false;
>>       } else if (netdev->connect_cb) {
>>           netdev->connect_cb(netdev, NETDEV_RESULT_OK, NULL,
>>                       netdev->user_data);
>>           netdev->connect_cb = NULL;
>> -    }
>> +        netdev->in_ft = false;
>> +        netdev->in_reassoc = false;
>
> Why do we set in_reassoc to false here?  Shouldn't it be taken care of 
> already by the associate_event?
I did this out of an abundance of caution. But yes I see we set it to 
false if !netdev->ap && !netdev->in_ft, so I can remove this.
>
>> +    } else
>> +        l_warn("Connection event without a connect callback!");
>>         netdev_rssi_polling_update(netdev);
>
> <snip>
>
>> @@ -6256,7 +6265,6 @@ static int netdev_init(void)
>>       __eapol_set_install_pmk_func(netdev_set_pmk);
>>         __ft_set_tx_frame_func(netdev_tx_ft_frame);
>> -    __ft_set_tx_associate_func(netdev_ft_tx_associate);
>
> This part probably belongs in the next patch or even patch 8.

The problem is I removed the function so gcc will warn/break the build.

>
>>         unicast_watch = l_genl_add_unicast_watch(genl, 
>> NL80211_GENL_NAME,
>>                           netdev_unicast_notify,
>
> Regards,
> -Denis
>
