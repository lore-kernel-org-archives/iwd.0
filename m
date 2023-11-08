Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DD6EBC
	for <iwd@lists.linux.dev>; Wed,  8 Nov 2023 02:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OIegBpYZ"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3b2ea7cc821so3976155b6e.1
        for <iwd@lists.linux.dev>; Tue, 07 Nov 2023 18:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699410533; x=1700015333; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v8B+UgVBJ4rfnXlKkKIudTgUBVE1ZXTb6rRjLNrr4/8=;
        b=OIegBpYZYp9T5av3V7QRdQUfYWWu3w0AFHn+1M4XdRV1wrs809ipK1aqdbHvK4w9Uu
         eD2XM70joI2Stw9475vDK9ki866hDZ/Y2fEXi2hrMGfMRJEjTL12vi5s1/D3siMNpwL8
         1TIDK1vBlCdU/ewpFveKQtHnoDFNHP+Ig0StBiQ5/dBMTnWrs/X5+IdKci6GRIlYoKD7
         RqnY7GB9sd2dDJsARiX+3EoljJ/PDhNc6afaYY5zY+yCw5Pok3YG6vM2sagLOfBc6kao
         V0Qj6BttHIXFWXPx7SszKK9xGnWO7Dvd3a0IVG8XQA6jYySvnKmtQrPLa1h00Hgn5kqm
         lRiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699410533; x=1700015333;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v8B+UgVBJ4rfnXlKkKIudTgUBVE1ZXTb6rRjLNrr4/8=;
        b=L4cR1F3/RxmHHqSjF230hYQ9DkiLlmX2Zu/jrgrsw+zDFCJUkvR1V01iZRCv67gOTP
         2pr7sNajHuPxXOmxzo8PfmtuFAg7JRLrr+g/5+9zyuw+7EAmV16R9WcVefuizRuQyVcC
         K+vje047lyHmplQ78P2ShVp7RrdsunW8HJXK++IcAB5C94pEXjVEqBcxTP04VV194O0n
         ed0YkJGu3WXHF7UEfn2CD7XC4f0d6sb/3LbJU/1tpEQPNlKkinqqhBap+MLU8mUi3o6+
         HKbdS9q7i2kB0CHpmqFzT4S9GcAWhWJXwOQjKpI+L24DNfEZPbORMwtONpebhfSfF00Y
         zAYg==
X-Gm-Message-State: AOJu0Ywzh3AjMe3SicnGhpxJWAJ5Ppi6VMbpFazWKR4dxDt70YW4NAkY
	Afs9zq+FajuUD6xOw/qNUW7Jtgnwa3Y=
X-Google-Smtp-Source: AGHT+IHprWCGNd57DkFRMgTHLmspjx+RQENZb7SuJ44L9P3dz9k1jrooaGYvH+xuaEnI54Fba/ODaQ==
X-Received: by 2002:a05:6808:308f:b0:3a8:1877:2d28 with SMTP id bl15-20020a056808308f00b003a818772d28mr1033211oib.50.1699410532845;
        Tue, 07 Nov 2023 18:28:52 -0800 (PST)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id q27-20020a0568080a9b00b003b2daf09267sm1769280oij.48.2023.11.07.18.28.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 18:28:52 -0800 (PST)
Message-ID: <86b15990-4f85-4fdc-9747-8ba8f9e263be@gmail.com>
Date: Tue, 7 Nov 2023 20:28:51 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] doc: PKEX support for DPP
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231107170629.1831655-1-prestwoj@gmail.com>
 <20231107170629.1831655-2-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231107170629.1831655-2-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 11/7/23 11:06, James Prestwood wrote:
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
> static shared code (optionally identifier) passed in as the
> argument to this method.
> 
> StartEnrollee(a{sv}) will start a PKEX enrollee using a static
> shared code (optionally identifier) passed as the argument to
> the method.
> 
> StartConfigurator(o) will start a PKEX configurator and use the
> agent specified by the path argument. The configurator will query
> the agent for a specific code when an enrollee sends the initial
> exchange message.
> 
> After the PKEX protocol is finished, DPP bootstrapping keys have
> been exchanged and DPP Authentication will start, followed by
> configuration.
> ---
>   doc/device-provisioning-api.txt | 142 ++++++++++++++++++++++++++++++++
>   1 file changed, 142 insertions(+)
> 

Applied, thanks.

Regards,
-Denis

