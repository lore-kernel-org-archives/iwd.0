Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A9833061
	for <iwd@lists.linux.dev>; Thu, 16 Nov 2023 15:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lda3zix3"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-1f4a9dd83d6so483657fac.0
        for <iwd@lists.linux.dev>; Thu, 16 Nov 2023 07:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700148602; x=1700753402; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cyAHcRfjo/kpgktiiYNctgFuw2vSYipPxbc+Ua9Xtx0=;
        b=lda3zix333zu4dofR9wrVn/U9+qAebDWe+eAGDPAXmiZjY0BjfmegjM6P21hAj3kWC
         FSNlrGjUqDejJwbtWRuk4Ft8fBJm5agwFsM+qSvFboEzmyCA9+u6tvAaEDcSoraCsHrv
         NXUEDWNYIjxISZxSgbiv93AYJDuAElMteOrWsJVnOTDL9QMtKgTn3wC5/iza0M7f9XQX
         lw15A0Ha7vvszZOAADE3P27OUjx+tGrBwIJsdDguoWcAvPubQ3cB4zVPaTg0Bwf2dDJs
         m0MNKXIJ6kdFKKhSZC2/PAQAEB8sqosj0E2TFJn/6HZuxt+Yv8gazutqxJDwVEzXvCr9
         n09Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700148602; x=1700753402;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cyAHcRfjo/kpgktiiYNctgFuw2vSYipPxbc+Ua9Xtx0=;
        b=sxG9jNfTaYk582d0G33TpvZow8MDxQxoGFVGpGlbDUInO1OBZgKKdiM7liafOhWxgN
         /mh5Rt5oNPrsTa+OWGfBt+IZwe2qVddnsZKxtEQCfj/ylfRgRWVkr210FKcTD4LHQt5/
         U0IaR31I22q6kNIyqP5oA01dwB1Pgg3IdlzcDyBjosLum27CClFEQgJUHRU8yX9ProTb
         HmWnNJCGxep5a+bHxJF04RT/NvFa0U7vyZVF8VNNVFXmAqYxT4LZwCaSxqd1vbpMd4kl
         3I754oNkq+7VRKHUyqSXl037wbTcil3A1Bw0WsBx3mexjoQQYNCr9vSDtxhRXEiqLYYL
         mAMw==
X-Gm-Message-State: AOJu0Yzv6yTGiZCRzHin6Hpfkpp6GZCiO9AyQOSyxF+XebhXIweGF6eD
	3N8+f8FjR/6FNguSpbT5DvkiqyfnPIM=
X-Google-Smtp-Source: AGHT+IFgdCcKrLN+GfwX4gMuZgVszPvKr7F6kt8jSaaD8WiXjyq8GmChZuTc367eWwFbS+4IBHfmWg==
X-Received: by 2002:a05:6870:c49:b0:1ef:9f6c:3df1 with SMTP id lf9-20020a0568700c4900b001ef9f6c3df1mr19906968oab.14.1700148601908;
        Thu, 16 Nov 2023 07:30:01 -0800 (PST)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id g8-20020a9d6488000000b006b8b55297b5sm946367otl.42.2023.11.16.07.30.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 07:30:01 -0800 (PST)
Message-ID: <fcb4e7bf-7947-4db0-aac7-990aff70542f@gmail.com>
Date: Thu, 16 Nov 2023 09:29:58 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RFC: Support full profile sharing via DPP 3rd party
 attributes
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231113182800.344348-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231113182800.344348-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 11/13/23 12:28, James Prestwood wrote:
> If an IWD profile contains network-specific settings which are
> required to utilize the network correctly configuring via DPP
> will not carry over those settings to the enrollee. The DPP
> configuration object only contains the SSID/PSK to connect and
> anything else set in the configurators profile is not included.
> 
> This is likely something that the majority of users will not
> need (most networks don't need additional settings) but if the
> network does it would be convenient for the configurator to send
> over its exact configuration to the enrollee. This is useful for
> an automated use case where a configuration should be consistent
> across all devices.
> 
> DPP allows for arbitrary 3rd party attributes in the configuration
> object (section 4.5.2) which can be used to communicate additional
> settings.
> 
> The plan is to define a new object within the overall
> configuration object who's keys are IWD profile groups and values
> are objects containing settings for those groups:
> 
> {
>    "ssid": "my_ssid",
>    ... main configuration object ...
> 
>    ... The IWD profile, converted to JSON ...
>    "/net/connman/iwd": {
>      "Network": {
>        "MutlicastDNS": "true"
>      },
>      "IPv4": {
>        "SendHostname": "true"
>      },
>      ... etc ...
>    }
> }
> 
> The "/net/connman/iwd" object could then be parsed by the enrollee
> (potentially if the feature is enable in main.conf?) and set to
> the profile as it is now with the passphrase/psk.
> 
> Several profile values don't apply here like MAC/IP address
> overrides. Mainly the settings that do matter would be:
> 
> [IPv4].SendHostname

Yeah I can see this one since this might be a network-wide DHCP server quirk...

> [Network].MulticastDNS

But why would you want this one?

> [Settings] (most values here, except AddressOverride)

What settings do you want from here besides Hidden?  Transition disable settings 
would be automagically restored as soon as the transition network is connected to.

You may want to drop the IPv4/Network hierarchy and make these more generic.

Regards,
-Denis
