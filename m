Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5761CA9A
	for <iwd@lists.linux.dev>; Fri,  6 Oct 2023 14:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZlnMBlBE"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-57ba5f05395so1269418eaf.1
        for <iwd@lists.linux.dev>; Fri, 06 Oct 2023 07:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696604151; x=1697208951; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+d8J5BTWFLwBTTZc/gPAstV6+nh1y8ihKwrtD1GxpBg=;
        b=ZlnMBlBEJAClPM88KW0mJ0z82fUq1vcTcC4yg/HEg18pDKhpNSY+dBUMxEexyw1gQn
         1H2s7FnFZrlqhsN7u/7Rg99HkODJR0nJsL1ogrxJ9A6QzsorUwXzRJiJx2f4zi5VtAHY
         Q1SDauRnKhMBZDCsQN0DxGfZSyGRrTolTTGNoM9L7rbise8XjAVYzzi1X9gx+EvCNkkY
         5FVI4d0Xg7NIGE10jVAXsAY0EFRpMPset95P5wEALtkUg1CNhEEO2GSzoAjKA2jPlOHp
         v4sAC860z1V4TGECDxw8HFBC2RGsSyBJsyOQH1r8NYFT5ttj4ve2lGqPujVihIiQdpOs
         ebZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696604151; x=1697208951;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+d8J5BTWFLwBTTZc/gPAstV6+nh1y8ihKwrtD1GxpBg=;
        b=dUE2ebDjGhBKWVnnWBuPoimDEowY2hAvsYakecW2bOCLLWp+hhvKp0PlQJkFiiYVoa
         3gSZO2kyneC8R1uUYolgosB/1MVuTnewdH9r97LfDzJPSMyV7tID860/XH1SUEA/aOzW
         Ln3uy6lhTignKPKN8xVMj0zP30VbWv2pCTJDzDdhug9g6ZwBPV8FVPqmsWPTOLQdsZCq
         c0OFP9L+gidKwFxsQJuCh0I0O8kCRUq1b5Q7vzNgSu2Y8jwaGueXB4uhy1S9CMa3L32+
         1tkZu3moVxLuPajV6OVKbTMYZG0XrWe2lalZsIOgGI88BYUmNpHF01K3HcitQEbbEKI3
         78rw==
X-Gm-Message-State: AOJu0Yxdlk98/Q5LBfqJX/mNpddG95v1stkvuYdrXqRpgItfl6InIbZq
	NT9d0fN43iAnOZ/+3nABkps=
X-Google-Smtp-Source: AGHT+IEVK+JeGERo42HIsFM2c1CoGn2vK4O+yvKDEw5kQk2axNm83BxiJ0KiMLy5DZXZynCRkScWrg==
X-Received: by 2002:a4a:2406:0:b0:57b:e345:43ad with SMTP id m6-20020a4a2406000000b0057be34543admr8487438oof.4.1696604150888;
        Fri, 06 Oct 2023 07:55:50 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 124-20020a4a1482000000b00573fb6178a6sm403438ood.44.2023.10.06.07.55.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 07:55:50 -0700 (PDT)
Message-ID: <50060562-b877-e087-82a6-c526779c1038@gmail.com>
Date: Fri, 6 Oct 2023 09:55:47 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] RFC: PKEX support for DPP
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231005123034.15802-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231005123034.15802-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 10/5/23 07:30, James Prestwood wrote:
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
> This only documents the DBus API for now to get an idea of how
> and where this module would live. The current plan is to keep
> it in dpp.c. This module is getting rather large but all the
> infrastructure exists for offchannel/frame callbacks and
> state so it makes sense to keep it there. The plan is to add
> some additional states to dpp for PKEX which would happen
> prior to AUTHENTICATION and allow the PRESENCE state to be
> skipped.
> 

Sounds good.

> PKEX would be used via the two DBus APIs. PkexConfigure would
> start listening and wait for an Enrollee to send a PKEX
> exchange request. The enrollee would be started with PkexEnroll
> and initiate the exchange. PKEX would proceed and once done
> DPP Authentication would start using the boostrapping keys
> exchanged.

I would really like to avoid camel case abbreviations in APIs.  Also, we like to 
use more easily understood terminology in our APIs whenever possible.  For 
example, SignalStrength not RSSI, SimpleConfiguration not WSC, etc.  Also, this 
is very different in feel compared to the rest of DeviceProvisioning Methods.

Perhaps this should be moved to its own interface, something like 
SharedCodeDeviceProvisioning.

> 
> For convenience/security the PKEX key could be specified in the
> IWD provisioning file (part of the Security group). This would

Why don't you just make this the default and drop the dictionary parameters.

> allow IWD to encrypt it and avoid the need for some other entity
> to store the key in order to call PkexConfigure (e.g. if not
> initiated by a human entering the key).
> ---
>   doc/device-provisioning-api.txt | 44 +++++++++++++++++++++++++++++++++
>   1 file changed, 44 insertions(+)
> 
> diff --git a/doc/device-provisioning-api.txt b/doc/device-provisioning-api.txt
> index ac204f46..c8b2e4a5 100644
> --- a/doc/device-provisioning-api.txt
> +++ b/doc/device-provisioning-api.txt
> @@ -57,6 +57,50 @@ Methods		string StartEnrollee()
>   						net.connman.iwd.NotSupported
>   						net.connman.iwd.Busy
>   
> +		PkexConfigure(dict args)
> +			The 'args' dictionary (a{sv}) contains parameters for
> +			the PKEX configurer. This can be empty or contain the
> +			following dictionary members:
> +
> +			string Key - The PKEX key. This is required if not
> +			specified in the network profile already.
> +
> +			string Identifier - The PKEX key identifier. This is
> +			optional, but if used both the Configurer and enrollee
> +			must use the same value. Can also be specified in the
> +			network profile.
> +
> +			uint32_t Timeout - A timeout (in seconds) for
> +			configuration. This is optional, but suggested to
> +			prevent a device from indefinitely configuring
> +			enrollees (if Stop() was never called).

I would pick something reasonable (or read it from the provisioning file) and 
drop this from the API entirely.

> +
> +			Possible errors:	net.connman.iwd.Busy
> +						net.connman.iwd.NotConnected
> +						net.connman.iwd.InvalidArguments
> +						net.connman.iwd.NotConfigured
> +
> +		PkexEnroll(dict args)
> +			The 'args' dictionary (a{sv}) contains parameters for
> +			the PKEX enrollee.
> +
> +			string Key - The PKEX key. This is required and must
> +			match the configurer's key.
> +
> +			string Identifier - The PKEX key identifier. This is
> +			optional, but if used both the Configurer and enrollee

"configurator"

> +			must use the same value.
> +
> +			array(y) Address - The address of the PKEX listener. If
> +			not specified a broadcast address is used.

array(y)?  Nack :)

> +
> +			array(u) Frequencies - A list of frequencies to
> +			discover on. If not specified channel 2, 44, and 149
> +			are used per the DPP spec.

Same here.

I would drop Address and Frequencies from this API.  No human is going to be 
entering these via a UI.

> +
> +			Possible errors:	net.connman.iwd.Busy
> +						net.connman.iwd.InvalidArguments
> +
>   Properties	boolean Started [readonly]
>   
>   			True if DPP is currently active.

Regards,
-Denis
