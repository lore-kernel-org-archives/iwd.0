Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA09FBE8
	for <iwd@lists.linux.dev>; Thu, 16 Nov 2023 15:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TVDFl+XL"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-779fb118fe4so53359585a.2
        for <iwd@lists.linux.dev>; Thu, 16 Nov 2023 07:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700149977; x=1700754777; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aC78INwO0nQzGwGva/t72cmweJs/oDOBjjwez6dRvYg=;
        b=TVDFl+XLd57XznC+mIPe1Tq2ng1mf7KH9xv9XKIdhR8rfk0Mckw3c4q+HqK7KCCMSM
         OHs28Eyva00SztiOiCX5kb5MNSMzBndJQBiwxi0Ef1u5hFlYgy3QulOPOhObnJ2OeQyE
         QBxeNtpgq/W/CrJPi0w5XQSM0T5N3sXWHIE3Bbi/ztrJmw86Rvs6xqqEnkNlIW6qdNEQ
         kFmNOWHkRpaRwQ5AKc1RqAsKotVnNf+hA92UN5qX8nPKRpZke5Sv4IpBCL7eznSfl9rX
         LgTra1Z51wYOEJIl6+/OktgzOt9oPDIJCU7YXi/FTsZN5gFK4e+RX59a2GO2mMG6uGsD
         FykA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700149977; x=1700754777;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aC78INwO0nQzGwGva/t72cmweJs/oDOBjjwez6dRvYg=;
        b=QlBvA8dYaY+u6jStM0qSuGAZ2UDLgq1rQyR8YrMFDRYJkOTJqMGX3SOyxx1posszu4
         TjMyCSLReNKfUw9rnlEcfaMO76MY20bsrTvtM6Dxu+6yA7YB9yaoX4rKn0jV492waAaN
         ZRjyeMf+STXVHE5XFjGzaG+aIQHMB//NVp7hHWJlZ51lFPHyCrtBbz4Jzisw67PLMmgg
         5Cp8wyBYX8V8qEoWkVi6NUjSHkEUyWUrEuNQTNYdP/Fwg0s4wwYsF68NjrZAsWdkhI4a
         Z/r76seIY43EWdL+yEA0SMzDsui7s4txy2IZHapT/12a06oIAmam3whUs9gp7U2kdVae
         xjjw==
X-Gm-Message-State: AOJu0YyrilTu6Da67E1KWeOOOUho6t0EIzCZ/taHV/3vQ/id7q8+A+/c
	BnOkvkCR73zHSDhA+ZlezLGei7CQmkc=
X-Google-Smtp-Source: AGHT+IH0pKU5IjriFLVt3T1jTTVAwuL6eZMzXPaJDQNCSyYkRAUMyif3jczoBLnCYMqe51iCoPokoQ==
X-Received: by 2002:a05:620a:2a07:b0:779:dbe5:cd84 with SMTP id o7-20020a05620a2a0700b00779dbe5cd84mr10294872qkp.36.1700149976787;
        Thu, 16 Nov 2023 07:52:56 -0800 (PST)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id az36-20020a05620a172400b0077580becd52sm4347302qkb.103.2023.11.16.07.52.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 07:52:56 -0800 (PST)
Message-ID: <957e1fdd-6573-4d01-a3aa-04caaca4352d@gmail.com>
Date: Thu, 16 Nov 2023 07:52:54 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dpp: check for non-utf8 SSID's in scan results
Content-Language: en-US
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20231116154439.33880-1-prestwoj@gmail.com>
 <20231116154439.33880-2-prestwoj@gmail.com>
 <210c60de-f02c-4ba4-bb66-17c54a2f0f29@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <210c60de-f02c-4ba4-bb66-17c54a2f0f29@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 11/16/23 07:51, Denis Kenzior wrote:
> Hi James,
>
> On 11/16/23 09:44, James Prestwood wrote:
>> In theory this shouldn't be possible because the configuration object
>> validates that the SSID is utf-8. But it doesn't hurt to check
>> especially since we can't control what the kernel sends us.
>> ---
>>   src/dpp.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/src/dpp.c b/src/dpp.c
>> index 18b2a7c6..8da79603 100644
>> --- a/src/dpp.c
>> +++ b/src/dpp.c
>> @@ -884,6 +884,9 @@ static bool dpp_scan_results(int err, struct 
>> l_queue *bss_list,
>>       /* Purely for grabbing the SSID */
>>       bss = l_queue_peek_head(bss_list);
>>   +    if (L_WARN_ON(!util_ssid_is_utf8(bss->ssid_len, bss->ssid)))
>> +        goto reset;
>> +
>
> This still seems brittle.  You have the validated SSID from the DPP 
> session, shouldn't you be storing that and using it to filter the scan 
> results?  There's no guarantee that a filtered active scan is going to 
> return only the SSID you asked for (lets say a misbehaving or 
> malicious AP), so assuming that the first BSS in the scan results list 
> is the SSID you want isn't really guaranteed.

Sure I can do that. I was banking on the kernel filtering, but we can be 
100% sure and just store the SSID in the dpp_sm.

>
>>       memcpy(ssid, bss->ssid, bss->ssid_len);
>>       ssid[bss->ssid_len] = '\0';
>
> Regards,
> -Denis
