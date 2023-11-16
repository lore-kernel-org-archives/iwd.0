Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA81FBE8
	for <iwd@lists.linux.dev>; Thu, 16 Nov 2023 15:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgvzSCz7"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-77a453eb01cso54251485a.0
        for <iwd@lists.linux.dev>; Thu, 16 Nov 2023 07:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700149873; x=1700754673; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SyF/C4tCOzlKnLGzTThIvlmXRkXaGsyQnq2X0dFd1ms=;
        b=fgvzSCz71ZW/v1RhmNRWLNdFV4UJsGGM1smc6+Nz4xErtEKRu1ZCxmFPnRH2rwgKXp
         u9ssoJ5Pw9FGaC8T7zZ//TES0J7WzZcjsMS4biLWoDp0i3w4yHk/HU4WlYvn9J0C/i1m
         4x51uhHWyxNk2H7czaaefuoxQVi8sw23lIvjHOVlVKy4ug97oy3qDyyVa+UpIvmpGnwl
         LMqnqBsQz7FM74kvpFd/HI3LQ5Uo38zj1MYfNIZZWBBIP9ePQ00LV042bQfqUFPBjkLU
         Uldm9elh2pI4pCaWupl6etuNSy1RGPG1n47iguXyIZbwNE5Zns3XHPw3ofsN4DaavbVG
         ly0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700149873; x=1700754673;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SyF/C4tCOzlKnLGzTThIvlmXRkXaGsyQnq2X0dFd1ms=;
        b=nCYo7xPfd/c9WVxIOb8eNM6cssyvziNJejUtfaJGpukvsiXuwliGuvIV9fp++qqAq3
         2mDMeHC03iTgzyRSXuiWPdjFr8+wzcWwJ6NmrYaHpa0FxJPvoD/X1WLF9HPb3gN6OcvY
         v0P0x8rF+cxmJVpxI1qhmgeL/lWsm2UUCSay/R+J9v4sdJE4AYgghOU7n2gqU7gNdklc
         IYdNcu+v9yKQFkJ4ZcWud/v1FEOfANR+bgr8RBFk1TZ87L8TvtymHKwYFsfiEbXUv1mA
         VH0FFbb9/Rcd38C7EcTukd7PHuW+JX9AD2bzsyrZ6FvX3G/q6UhqnPCiCtFkeJ8r+jYQ
         PHbQ==
X-Gm-Message-State: AOJu0YyMyLGnhSjnimEV8rniwMX1ur6k0ak5t/aguegyBTceC956DLUm
	Xo3RFWs66u1QgezpHMSYEVxhEMTzN3s=
X-Google-Smtp-Source: AGHT+IHM0hDQJgpUmr+NaXFrODPd9DzDwFXKTr83sXDSorVKM1S6FC6rhRvV2T+bLNQnVHZjFFUkRQ==
X-Received: by 2002:ae9:e111:0:b0:774:c82:7536 with SMTP id g17-20020ae9e111000000b007740c827536mr9742571qkm.71.1700149873491;
        Thu, 16 Nov 2023 07:51:13 -0800 (PST)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id z22-20020a05620a101600b007671b599cf5sm4354666qkj.40.2023.11.16.07.51.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 07:51:13 -0800 (PST)
Message-ID: <1770d2fa-eeb8-4997-9d1f-2f2ecf11c3d1@gmail.com>
Date: Thu, 16 Nov 2023 07:51:11 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] dpp: fix fragile scan/connecting logic
Content-Language: en-US
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20231113175401.343239-1-prestwoj@gmail.com>
 <20231113175401.343239-3-prestwoj@gmail.com>
 <805ef134-6b99-4f5e-aad8-be5cff7de444@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <805ef134-6b99-4f5e-aad8-be5cff7de444@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 11/16/23 07:18, Denis Kenzior wrote:
> Hi James,
>
> On 11/13/23 11:54, James Prestwood wrote:
>> The post-DPP connection was never done quite right due to station's
>> state being unknown. The state is now tracked in DPP by a previous
>> patch but the scan path in DPP is still wrong.
>>
>> It relies on station autoconnect logic which has the potential to
>> connect to a different network than what was configured with DPP.
>> Its unlikely but still could happen in theory. In addition the scan
>> was not selectively filtering results by the SSID that DPP
>> configured.
>>
>> This fixes the above problems by first filtering the scan by the
>> SSID. Then setting the scan results into station without triggering
>> autoconnect. And finally using network_autoconnect() directly
>> instead of relying on station to choose the SSID.
>> ---
>>   src/dpp.c | 44 +++++++++++++++++++++++++++++++++++++++++---
>>   1 file changed, 41 insertions(+), 3 deletions(-)
>>
>
> All 4 applied, but one comment:
>
>> diff --git a/src/dpp.c b/src/dpp.c
>> index 06ae2929..a95f93e2 100644
>> --- a/src/dpp.c
>> +++ b/src/dpp.c
>> @@ -853,13 +853,42 @@ static bool dpp_scan_results(int err, struct 
>> l_queue *bss_list,
>>   {
>>       struct dpp_sm *dpp = userdata;
>>       struct station *station = 
>> station_find(netdev_get_ifindex(dpp->netdev));
>> +    struct scan_bss *bss;
>> +    char ssid[33];
>> +    struct network *network;
>>         if (err < 0)
>> -        return false;
>> +        goto reset;
>> +
>> +    if (!bss_list || l_queue_length(bss_list) == 0)
>> +        goto reset;
>> +
>> +    /*
>> +     * The station watch _should_ detect this and reset, which 
>> cancels the
>> +     * scan. But just in case...
>> +     */
>> +    if (L_WARN_ON(station_get_connected_network(station)))
>> +        goto reset;
>> +
>> +    /* Purely for grabbing the SSID */
>> +    bss = l_queue_peek_head(bss_list);
>>   -    station_set_scan_results(station, bss_list, freqs, true);
>> +    memcpy(ssid, bss->ssid, bss->ssid_len);
>> +    ssid[bss->ssid_len] = '\0';
>
> Are you sure this SSID is UTF8? station_set_scan_results will filter 
> any SSIDs that are not.

Good catch, I hadn't considered that. BUT in theory this shouldn't 
happen since utf8 is verified when parsing the configuration object. 
Either way, I still sent a patch because an extra check doesn't hurt, 
and its results coming from the kernel so I'd rather avoid a crash if 
something ever changed in the future.

Thanks,

James

