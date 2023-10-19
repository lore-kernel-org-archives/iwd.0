Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321F127EDE
	for <iwd@lists.linux.dev>; Thu, 19 Oct 2023 14:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUrZdzvp"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6cd0aa8d245so906099a34.0
        for <iwd@lists.linux.dev>; Thu, 19 Oct 2023 07:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697727545; x=1698332345; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zy4zrcTNsn0MGyYwNyqdYIIWviVvu059PLe8Ozm/otI=;
        b=TUrZdzvp9HqHV5nlLCooBpKn3eM1GjG+UZ5lWsSdGXTznZpJ3jlrZz1DKmHb/YK6ly
         q3gb4mUqJr9NWtyImSD4QTMSWvWxMcID8Iw8CIyaokNepUysax7uru35/CbeR3sCdt5B
         RsyGQWbrggx8DmasvXqgmi4Ii7qZT37MeoUwSHMCfY+SXgbziU70QCla2Xdfy+AFIGF+
         sIYhd+uxTePLlNvPrmITSRXeWJfalhAUwRhgRX2zaeFvRdxAr0KKr1/jc4XLPok/U8mD
         cys4/xfT4a915KPXpH6uBJotw4LlgaKhYgq9CDRw+xrgRqVnP4YkfyXYEawb1IQVch02
         o3yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697727545; x=1698332345;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zy4zrcTNsn0MGyYwNyqdYIIWviVvu059PLe8Ozm/otI=;
        b=KnwrzBfY0cd4Keyn/X4X+drjHC9VE4DTmxAZEHrGiRI31uF9fgYvcpvh4gmnq/t/Ue
         G7hZzHarXhRPqDkVbL6G+zcVqzhqKGI+9U6ZfuOdtXJTiJ9GVEXYoeDHW/U4K5OpU6aC
         JHEeGYwBzv45w+RA9h2RYoYaESudtaGUCcI48TLQNjeCV39h/nj33yCjZz4Sicyz2ihK
         otWUh9KfBMGOpoPGp5D1dESJ7YEbnL03gABH5YrekLxvMErXIyLoanSD4NBIMBXIKbds
         Pv1sEVvOOCgoPrbmS5XjXoqJwkuxThYN0/4+ZQYGi/gpTX8eyNrDmx8CDL7YOImQcnDq
         DJlA==
X-Gm-Message-State: AOJu0YwQ7D6AyafOh/Oh8rtTyZN9JPOxVcxpZ5Tv2Y6+BfdDHb2K81hc
	S57dc5Mz9AmOXl3RT/FYDzc=
X-Google-Smtp-Source: AGHT+IH3Gy+tBlRuHtW8uOv0vDjDMfEM/X9iIrHLWctXucyC1eHgCh9SHI2R4My4Nm24g8+w4eYFQg==
X-Received: by 2002:a05:6830:4490:b0:6cc:d4f7:e37d with SMTP id r16-20020a056830449000b006ccd4f7e37dmr3118506otv.5.1697727544950;
        Thu, 19 Oct 2023 07:59:04 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id d21-20020a9d5e15000000b006c4edf462d7sm1097113oti.43.2023.10.19.07.59.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 07:59:04 -0700 (PDT)
Message-ID: <41078822-99da-466e-b612-91a8c223dbde@gmail.com>
Date: Thu, 19 Oct 2023 09:59:03 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/21] doc: PKEX support for DPP
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231012200150.338401-1-prestwoj@gmail.com>
 <20231012200150.338401-12-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231012200150.338401-12-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 10/12/23 15:01, James Prestwood wrote:
> PKEX is part of the WFA EasyConnect specification and is
> an additional boostrapping method (like QR codes) for
> exchanging public keys between a configurator and enrollee.
> 
> PKEX operates over wifi and requires a key/code be exchanged
> prior to the protocol. The key is used to encrypt the exchange
> of the boostrapping information, then DPP authentication is
> started immediately aftewards.
> 
> This can be useful for devices which don't have the ability to
> scan a QR code, or even as a more convenient way to share
> wireless credentials if the PSK is very secure (i.e. not a
> human readable string).
> 
> PKEX would be used via the two DBus APIs on a new interface
> SharedCodeDeviceProvisioning.
> 
> StartConfigurator() will start listening and wait for an
> Enrollee to send a PKEX exchange request.
> 
> StartEnrollee() will initiate the exchange.
> 
> PKEX would proceed and once done DPP Authentication will start
> using the boostrapping keys exchanged.
> ---
>   doc/device-provisioning-api.txt | 30 ++++++++++++++++++++++++++++++
>   1 file changed, 30 insertions(+)
> 
> diff --git a/doc/device-provisioning-api.txt b/doc/device-provisioning-api.txt
> index ac204f46..4c0ecb28 100644
> --- a/doc/device-provisioning-api.txt
> +++ b/doc/device-provisioning-api.txt
> @@ -71,3 +71,33 @@ Properties	boolean Started [readonly]
>   
>   			Indicates the DPP URI. This property is only available
>   			when Started is true.
> +
> +
> +Interface	net.connman.iwd.DeviceProvisioning [Experimental]

nit: [experimental]

> +Object path	/net/connman/iwd/{phy0,phy1,...}/{1,2,...}
> +
> +		StartConfigurator()
> +			Start a PKEX configurator. IWD must be currently
> +			connected to a BSS and have at least the

To a network?

> +			[Security].DeviceProvisioningSharedCode option set in
> +			the network profile. An identifier can be set with
> +			[Security].DeviceProvisioningIdentifier.

I would think [DeviceProvisioning] SharedCode and Identifier?

But I do have to ask, this is used for PSK networks where profiles are rarely 
touched by the user.  Do you really expect someone to muck around in them?  I 
wonder if autogenerating such codes / identifiers or an Agent API is more 
appropriate?

> +
> +			Possible errors:	net.connman.iwd.Busy
> +						net.connman.iwd.NotConnected
> +						net.connman.iwd.InvalidArguments
> +						net.connman.iwd.NotConfigured
> +
> +		StartEnrollee(a{sv} args)
> +			The 'args' dictionary contains parameters for the PKEX
> +			enrollee.
> +
> +			string Key - The PKEX key. This is required and must
> +			match the configurer's key.

Why is this not symmetric with Configurator role?  I assume this should be 
SharedCode?

> +
> +			string Identifier - The PKEX key identifier. This is > +			optional, but if used both the Configurer and enrollee

Configurator?

> +			must use the same value.
> +
> +			Possible errors:	net.connman.iwd.Busy
> +						net.connman.iwd.InvalidArguments
> \ No newline at end of file

Regards,
-Denis
