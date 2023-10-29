Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF9012E58
	for <iwd@lists.linux.dev>; Sun, 29 Oct 2023 22:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="auTZfdb+"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1ef370c2e1aso2723561fac.2
        for <iwd@lists.linux.dev>; Sun, 29 Oct 2023 15:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698618465; x=1699223265; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ibwp4553GmFTw1n9XR37QEPR3MgzwbdFbecAvyOz9h0=;
        b=auTZfdb+sjdZb5NtS9Tm26uhT2Wk7GqmD16DqnASpO0+y6AKIHCpHCFn7bt0jTWPpX
         x4Uq7g90HyPocR1So4MhQrsel3iWW/mScfgtxWh0U3tAtYqIJ3l/Acir6slAZYrJXlOK
         iy9Udio38MRptFj4lj5+VeSYZbjhOO042d0JlYXvtdA2m61+Z/0pd/AfyNDeBBhNM+Q9
         FUfgn91XAg38P334m+RgOfWaTBcnuqAi2Qz2w0ekwHlwGQW4kl7reP6fP6Ow1TxmZWp6
         6zpc+14LB52lS1myXRTUlwY5/05z2v3a5vrhFNzd5e8dz2YAmazaWyYYUZpU/8Zt7wMZ
         nzbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698618465; x=1699223265;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ibwp4553GmFTw1n9XR37QEPR3MgzwbdFbecAvyOz9h0=;
        b=cPBO/oKGlDBjKx3ViCEYr8sg2zrJVuNrag998u8SEv8KdVis/Nc2tgenZ9LhF/T2nl
         PwOpZBWrQjAitzOrv+HVMVavnrWjptARppX0x067DqMrmSDF+47DInL2eMuGFZckxUUz
         SwLksnguRoIBtfODzdOAm5uhWBkp/ZBjDcA86pC1+4H0s4M/jiwG9shrTuu8JHe6Vxil
         ImfHzWUohakX1c6dyih9F1/55PmiPFkbCo7Fk/768p18sysEaS/vTcU1ifNj7rjtS8ZU
         qzDt6bhPJxqQavyFTFJyi8ivVOU0/i/vRmyMuJcGaACNE/l2mT92i16NmeNC+Rn8IYXq
         +/fA==
X-Gm-Message-State: AOJu0Yw2ZMTkdhkP9CAC4tl1LPqw3boMJOltil7hVpC9NxExmOUE9e7+
	zvACCXGyuANtfsfk2GfI9zKR8ryXPts=
X-Google-Smtp-Source: AGHT+IFYIm67x9rd1v+/KOst+Fl9FTeb9Z0sp8/HbhUEmtYZY8Cbh4P0OY56qwPRbTEUFZTaboHe2w==
X-Received: by 2002:a05:6870:3055:b0:1e9:cd2c:ffd7 with SMTP id u21-20020a056870305500b001e9cd2cffd7mr12408095oau.19.1698618465494;
        Sun, 29 Oct 2023 15:27:45 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id g21-20020a056870c39500b001efce0658e6sm402451oao.39.2023.10.29.15.27.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Oct 2023 15:27:45 -0700 (PDT)
Message-ID: <35ca1bec-2ccb-4e23-8b98-f6dffa4675ac@gmail.com>
Date: Sun, 29 Oct 2023 17:27:44 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/15] doc: PKEX support for DPP
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231026202657.183591-1-prestwoj@gmail.com>
 <20231026202657.183591-13-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231026202657.183591-13-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 10/26/23 15:26, James Prestwood wrote:
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
> PKEX would be used via the three DBus APIs on a new interface
> SharedCodeDeviceProvisioning.
> 
> ConfigureEnrollee(a{sv}) will start a configurator with a
> static shared code (optionally identifier) passed in with the
> dictionary key.
> 
> StartConfigurator(object agent_path) will start listening and
> wait for an Enrollee to send a PKEX exchange request. Once
> received the configurator will call out to an agent
> (distinguished by 'agent_path') and request the code using the
> identifier sent by the enrollee. If no identifier was sent the
> protocol will fail. This method allows for configuring one of
> several enrollees, assuming the agent has the ability to
> look up the identifier.
> 
> StartEnrollee(a{sv}) will start a PKEX enrollee. Enrollees will
> begin iterating a channel list sending out PKEX exchange
> requests and waiting for a configurator to respond.
> 
> After the PKEX protocol is finished, DPP bootstrapping keys have
> been exchanged and DPP Authentication will start, followed by
> configuration.
> ---
>   doc/device-provisioning-api.txt | 67 +++++++++++++++++++++++++++++++++
>   1 file changed, 67 insertions(+)
> 

Okay, though much of this should be in the API doc itself.

> diff --git a/doc/device-provisioning-api.txt b/doc/device-provisioning-api.txt
> index ac204f46..02856571 100644
> --- a/doc/device-provisioning-api.txt
> +++ b/doc/device-provisioning-api.txt
> @@ -71,3 +71,70 @@ Properties	boolean Started [readonly]
>   
>   			Indicates the DPP URI. This property is only available
>   			when Started is true.
> +
> +
> +Interface	net.connman.iwd.SharedCodeDeviceProvisioning [Experimental]
> +Object path	/net/connman/iwd/{phy0,phy1,...}/{1,2,...}
> +
> +		ConfigureEnrollee(a{sv})
> +			Starts a DPP configurator using a shared code (and
> +			optionally identifier) set in the dictionary argument.
> +			Valid dictionary keys are:
> +
> +			{
> +				Code: <The shared code to use>
> +				Identifier: <Optional identifier>
> +			}

You really need to specify the types of the entries.  Since you repeat this at 
least twice, this may need to be a separate section.

> +
> +			As with the DeviceProvisioning interface, configurators
> +			must be currently connected to start.
> +
> +			Possible errors:	net.connman.iwd.Busy
> +						net.connman.iwd.NotConnected
> +						net.connman.InvalidArguments
> +
> +		StartConfigurator(object agent_path)
> +			Start a shared code configurator using an agent to
> +			obtain the shared code. This method is meant for an
> +			automated use case where a configurator is capable of
> +			configuring multiple enrollees, and distinguishing
> +			between them by their identifier.
> +
> +			After starting the configurator will listen on channel.
> +			Upon receiving an enrollees initial request it will
> +			make an agent call (on 'agent_path') to obtain the
> +			code associated with the enrollee.
> +
> +			As with the DeviceProvisioning interface, configurators
> +			must be currently connected to start.
> +
> +			Possible errors:	net.connman.iwd.Busy
> +						net.connman.iwd.NotConnected
> +						net.connman.iwd.InvalidArguments

Where is the agent documentation?

> +
> +		StartEnrollee(a{sv})
> +			Start a shared code enrollee using the Code and
> +			optionally identifier passed in the dictionary argument.
> +			As with the configurator, valid dictionary keys are:
> +
> +			{
> +				Code: <The shared code to use>
> +				Identifier: <Optional identifier>
> +			}
> +
> +			As with the DeviceProvisioning interface, enrollees
> +			must be disconnected in order to start.
> +
> +			Possible errors:	net.connman.iwd.Busy
> +						net.connman.iwd.InvalidArguments
> +
> +Properties	boolean Started [readonly]
> +
> +			True if shared code device provisioning is currently
> +			active. (configurator or enrollee is started)
> +
> +		string Role [readonly, optional]
> +
> +			Indicates the DPP role. Possible values are "enrollee"
> +			or "configurator". This property is only available when
> +			Started is true.

Regards,
-Denis
