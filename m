Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8975E328CA
	for <iwd@lists.linux.dev>; Thu, 16 Nov 2023 15:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="laD3MLIK"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-77a453eb01cso54129285a.0
        for <iwd@lists.linux.dev>; Thu, 16 Nov 2023 07:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700149749; x=1700754549; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L94GBMljSXS6TG2BPcg2exOQXkEe6dx+KJlnpuFmVJM=;
        b=laD3MLIKl0pP2oHtAXeLbC1OfROf2ztGOXoZiACKyjTqdD4pfLFMREW5x8n0Jd8VMS
         R0OmMH25NDqyJ8QG0cYJEoY5Z9XtRRh9aeVnWPkWWy5nmU8mnXzQb96hytXSYYBI6Zd3
         AQVmw3hNxbKnXyMrNvfm3c/ss1FdStyMLhvl7LDvn0DbEVKGQ6BDiJRW2wJx/Aynhb8r
         SWD3Zpsq1UDuKnbLt4YU/QLVkchbeg6sYaYO2000V3d30OgLdvdAkZR7YrJZfzSXE8c0
         Mi158TVu52opQvqG1ktwWXAoBK1DfmDorOBrMxq/HlKbCSJoWaIc4rLSjI+0I4uugO43
         dWRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700149749; x=1700754549;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L94GBMljSXS6TG2BPcg2exOQXkEe6dx+KJlnpuFmVJM=;
        b=CI36uPMwGY0D6hqO/ikqa3UT9Yq8IPiK3ApH0UmbF4WeAw65eLyUd+ykiC7t7g6x1o
         QR8TSQqFgzXC5dMmWGjn4KVfVMg/Ii+eUmBmXi4ClvFREGA7JWnEobw8oZMcSgr392B8
         PeKHHE7nhpBJ0h6pGaTa6zxkOisk2E3TlRyT73FNfpzj/IOrgmt6H/BnYuvzIFdmLGUW
         WeS8OFcfqPrOKAKptQ6TzGfmChwjPvKb0ePz6hQC99Y31lZRSy89qn+pRGTGUIclCx8x
         765YoWIPXI81pulDpOrt0oZdssOVUzcxZzTeq647gblXYzD2h11NQo/M6zlVbyfQZm8j
         Ualg==
X-Gm-Message-State: AOJu0YwiDOUsgl2JpAUiH1+qXI0jS/aFJAFDRdmsbroDgl6lhLZSvf+z
	yi093A3b6vYvJAJ4hhkIijQ=
X-Google-Smtp-Source: AGHT+IGhHNNFlz6UHUgWeb5HybYk1ZswRaBkGNSqI2jNfrg4KrNswO2TDda5J+RuNYuP6C2f4N1+yw==
X-Received: by 2002:a05:620a:9c2:b0:778:8b8a:37e with SMTP id y2-20020a05620a09c200b007788b8a037emr8895553qky.21.1700149749323;
        Thu, 16 Nov 2023 07:49:09 -0800 (PST)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id u3-20020a05620a022300b0076f19b9e96fsm4350676qkm.107.2023.11.16.07.49.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 07:49:09 -0800 (PST)
Message-ID: <73c2acb7-dcaa-4498-8eb4-4fa21923d7fd@gmail.com>
Date: Thu, 16 Nov 2023 07:49:06 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RFC: Support full profile sharing via DPP 3rd party
 attributes
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20231113182800.344348-1-prestwoj@gmail.com>
 <fcb4e7bf-7947-4db0-aac7-990aff70542f@gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <fcb4e7bf-7947-4db0-aac7-990aff70542f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 11/16/23 07:29, Denis Kenzior wrote:
> Hi James,
>
> On 11/13/23 12:28, James Prestwood wrote:
>> If an IWD profile contains network-specific settings which are
>> required to utilize the network correctly configuring via DPP
>> will not carry over those settings to the enrollee. The DPP
>> configuration object only contains the SSID/PSK to connect and
>> anything else set in the configurators profile is not included.
>>
>> This is likely something that the majority of users will not
>> need (most networks don't need additional settings) but if the
>> network does it would be convenient for the configurator to send
>> over its exact configuration to the enrollee. This is useful for
>> an automated use case where a configuration should be consistent
>> across all devices.
>>
>> DPP allows for arbitrary 3rd party attributes in the configuration
>> object (section 4.5.2) which can be used to communicate additional
>> settings.
>>
>> The plan is to define a new object within the overall
>> configuration object who's keys are IWD profile groups and values
>> are objects containing settings for those groups:
>>
>> {
>>    "ssid": "my_ssid",
>>    ... main configuration object ...
>>
>>    ... The IWD profile, converted to JSON ...
>>    "/net/connman/iwd": {
>>      "Network": {
>>        "MutlicastDNS": "true"
>>      },
>>      "IPv4": {
>>        "SendHostname": "true"
>>      },
>>      ... etc ...
>>    }
>> }
>>
>> The "/net/connman/iwd" object could then be parsed by the enrollee
>> (potentially if the feature is enable in main.conf?) and set to
>> the profile as it is now with the passphrase/psk.
>>
>> Several profile values don't apply here like MAC/IP address
>> overrides. Mainly the settings that do matter would be:
>>
>> [IPv4].SendHostname
>
> Yeah I can see this one since this might be a network-wide DHCP server 
> quirk...

To be completely honest SendHostname is all I actually needed. I was 
trying to make it more generic and allow any setting but it certainly 
simplifies the implementation if we just pick individual settings we want.

Thanks,

James

