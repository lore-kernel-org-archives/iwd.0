Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20847273F9
	for <iwd@lists.linux.dev>; Fri,  6 Oct 2023 16:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fUfh1wd7"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1c760b34d25so18067825ad.3
        for <iwd@lists.linux.dev>; Fri, 06 Oct 2023 09:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696608857; x=1697213657; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wHPJYHFyzYaLTCyQuGuxt7IiRfIhPhi6zjviNh9rYUg=;
        b=fUfh1wd7Beg+Nxp1px/18C+/a2fanlcICNRdUlLbDhQSxI7LXMQWW2Km0sZFcI1Wc+
         9ijOm217wPTygfyg19R4H5RkcmaHkloRAl66eDiNuowPM2UnYIZhG7yCK+/JWCQf6N31
         t4JTxwTJHI/FHinlPjH4wKkolW8UUVTJ+BxkoiLnpMXvteb1Kb10Q3aa9mfqPMpDSb69
         Pim94b7Ua2C94NSutVQ+97KhzsO8+jik4VIvcgxIx/rDCQ1+qrfB8jYcoSGSxqYpx3tE
         yyMxry0Cl3K2jx7J3iusMSsQIHL7p2V/OUZ8hcyZ7e6udZY7WY8+10hNBDpim9/71uGM
         JwWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696608857; x=1697213657;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wHPJYHFyzYaLTCyQuGuxt7IiRfIhPhi6zjviNh9rYUg=;
        b=uwt5x5pYflPwyLU5uQpxgFtSGYjkptSNBv4YT3PeR/0B4SMwGwFGYOctalOKls+52E
         Z4UeaeGrmOpjdwbZWBzpEUc5XD49R1iYDRt+unFSAIwIazNrpVee6VgT4NCfFwdZuC8s
         3+B95/iC+2AYfjX7+7YpH7GCh1FJnITJvrdSeNH5sHTDKxsm7hmS2GcNKgLBvB5sCLDm
         7oAHGVfYHVjMYRlvZjhGzopmvWmSQRP2eXqtf6LeK7eX/UlvwwSJlGOqr69PeSVTA0s/
         Ncd1NPgeBEskj5jeGIhKQt49nSNFlVkhJcEmC2KdRYggJl74M0JEL7cFIMrGzonEES1E
         Ukaw==
X-Gm-Message-State: AOJu0YzukuDgqKqccRs5mp+QhdZ0OeP/6j0oiggYnH5WLhciaUda79jU
	HcnvPTynCuYRqrzYrP5Go1JoQSOI5ZY=
X-Google-Smtp-Source: AGHT+IGiE14NCjUrNREywiRsZqqVz+QPuVT8mk6Pdd1htkQM85sZ6RWWypFqlTkyWUc6WJobsemEiw==
X-Received: by 2002:a17:902:e550:b0:1b9:e937:9763 with SMTP id n16-20020a170902e55000b001b9e9379763mr10112687plf.12.1696608857215;
        Fri, 06 Oct 2023 09:14:17 -0700 (PDT)
Received: from [192.168.254.38] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id iw11-20020a170903044b00b001ab2b4105ddsm4085303plb.60.2023.10.06.09.14.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 09:14:16 -0700 (PDT)
Message-ID: <c54e631d-5b39-4630-bb75-cf810839b1d4@gmail.com>
Date: Fri, 6 Oct 2023 09:14:14 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RFC: PKEX support for DPP
Content-Language: en-US
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20231005123034.15802-1-prestwoj@gmail.com>
 <50060562-b877-e087-82a6-c526779c1038@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <50060562-b877-e087-82a6-c526779c1038@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/6/23 7:55 AM, Denis Kenzior wrote:
> Hi James,
> 
> On 10/5/23 07:30, James Prestwood wrote:
>> PKEX is part of the WFA EasyConnect specification and is
>> an additional boostrapping method (like QR codes) for
>> exchanging public keys between a configurator and enrollee.
>>
>> PKEX operates over wifi and requires a key/code be exchanged
>> prior to the protocol. The key is used to encrypt the exchange
>> of the boostrapping information, then DPP authentication is
>> started immediately aftewards.
>>
>> This can be useful for devices which don't have the ability to
>> scan a QR code, or even as a more convenient way to share
>> wireless credentials if the PSK is very secure (i.e. not a
>> human readable string).
>>
>> This only documents the DBus API for now to get an idea of how
>> and where this module would live. The current plan is to keep
>> it in dpp.c. This module is getting rather large but all the
>> infrastructure exists for offchannel/frame callbacks and
>> state so it makes sense to keep it there. The plan is to add
>> some additional states to dpp for PKEX which would happen
>> prior to AUTHENTICATION and allow the PRESENCE state to be
>> skipped.
>>
> 
> Sounds good.
> 
>> PKEX would be used via the two DBus APIs. PkexConfigure would
>> start listening and wait for an Enrollee to send a PKEX
>> exchange request. The enrollee would be started with PkexEnroll
>> and initiate the exchange. PKEX would proceed and once done
>> DPP Authentication would start using the boostrapping keys
>> exchanged.
> 
> I would really like to avoid camel case abbreviations in APIs.  Also, we 
> like to use more easily understood terminology in our APIs whenever 
> possible.  For example, SignalStrength not RSSI, SimpleConfiguration not 
> WSC, etc.  Also, this is very different in feel compared to the rest of 
> DeviceProvisioning Methods.
> 
> Perhaps this should be moved to its own interface, something like 
> SharedCodeDeviceProvisioning.

Sounds good.

> 
>>
>> For convenience/security the PKEX key could be specified in the
>> IWD provisioning file (part of the Security group). This would
> 
> Why don't you just make this the default and drop the dictionary 
> parameters.
> 
>> allow IWD to encrypt it and avoid the need for some other entity
>> to store the key in order to call PkexConfigure (e.g. if not
>> initiated by a human entering the key).
>> ---
>>   doc/device-provisioning-api.txt | 44 +++++++++++++++++++++++++++++++++
>>   1 file changed, 44 insertions(+)
>>
>> diff --git a/doc/device-provisioning-api.txt 
>> b/doc/device-provisioning-api.txt
>> index ac204f46..c8b2e4a5 100644
>> --- a/doc/device-provisioning-api.txt
>> +++ b/doc/device-provisioning-api.txt
>> @@ -57,6 +57,50 @@ Methods        string StartEnrollee()
>>                           net.connman.iwd.NotSupported
>>                           net.connman.iwd.Busy
>> +        PkexConfigure(dict args)
>> +            The 'args' dictionary (a{sv}) contains parameters for
>> +            the PKEX configurer. This can be empty or contain the
>> +            following dictionary members:
>> +
>> +            string Key - The PKEX key. This is required if not
>> +            specified in the network profile already.
>> +
>> +            string Identifier - The PKEX key identifier. This is
>> +            optional, but if used both the Configurer and enrollee
>> +            must use the same value. Can also be specified in the
>> +            network profile.
>> +
>> +            uint32_t Timeout - A timeout (in seconds) for
>> +            configuration. This is optional, but suggested to
>> +            prevent a device from indefinitely configuring
>> +            enrollees (if Stop() was never called).
> 
> I would pick something reasonable (or read it from the provisioning 
> file) and drop this from the API entirely.
> 
>> +
>> +            Possible errors:    net.connman.iwd.Busy
>> +                        net.connman.iwd.NotConnected
>> +                        net.connman.iwd.InvalidArguments
>> +                        net.connman.iwd.NotConfigured
>> +
>> +        PkexEnroll(dict args)
>> +            The 'args' dictionary (a{sv}) contains parameters for
>> +            the PKEX enrollee.
>> +
>> +            string Key - The PKEX key. This is required and must
>> +            match the configurer's key.
>> +
>> +            string Identifier - The PKEX key identifier. This is
>> +            optional, but if used both the Configurer and enrollee
> 
> "configurator"
> 
>> +            must use the same value.
>> +
>> +            array(y) Address - The address of the PKEX listener. If
>> +            not specified a broadcast address is used.
> 
> array(y)?  Nack :)
> 
>> +
>> +            array(u) Frequencies - A list of frequencies to
>> +            discover on. If not specified channel 2, 44, and 149
>> +            are used per the DPP spec.
> 
> Same here.
> 
> I would drop Address and Frequencies from this API.  No human is going 
> to be entering these via a UI.

The issue I foresee is trying to find configurators since they stay on 
the current operating channel which likely isn't 2, 44, or 149 (I 
suppose we could have them go offchannel, but I wanted to avoid that). 
But I agree, its not something a human would know or want to type in.

Enrollees could instead iterate all supported channels, but that would 
take a while (200ms per channel per the spec, and actually the spec 
wants 5 retries per channel but I wasn't planning on doing that). But 
maybe this is the only way to do it in an automatic way.

One idea I had was to have the enrollee scan first, iterate channels 
from nearby APs, if nothing is found repeat. That would likely reduce 
the number of frequencies significantly.

> 
>> +
>> +            Possible errors:    net.connman.iwd.Busy
>> +                        net.connman.iwd.InvalidArguments
>> +
>>   Properties    boolean Started [readonly]
>>               True if DPP is currently active.
> 
> Regards,
> -Denis
