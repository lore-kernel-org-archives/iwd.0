Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B1B41A86
	for <iwd@lists.linux.dev>; Wed, 10 Jan 2024 16:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nezIA9qh"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3bb9b28acb4so3554072b6e.2
        for <iwd@lists.linux.dev>; Wed, 10 Jan 2024 08:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704905231; x=1705510031; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QBansm3MvcA99crmOvo/ODE3q33IrZ0yDu9PLMTe7II=;
        b=nezIA9qhyS9f1Cnkp4D6I9P89QveG1/hH8afL+oA3gsSCj+pDV5NmIkWbHprXWpoBN
         kSV26lvkssHzWiqjXI0SXET+VX3Umg6GDLl4yDltGqZA6GrDkDw2Js0ZoKLruu/osOhv
         r8gEpUPgt93AC8BvAxGk2/VnZWMvojcz79uYuwkQ496IBPZcvkeFC+zuXMwk14uDarix
         STDwsg/yrnB0L721D4qcjXPEPDcSBaGWB7rYszl8YaLuZFaLi4BRkqf3ntBcj9mHm/VK
         vtjQq7BOcZZgNKC1awmo/sWY3IazoOtLHUD+OCsclEym1Kq282Lx1hp2T0a5IZONnr8J
         lXgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704905231; x=1705510031;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QBansm3MvcA99crmOvo/ODE3q33IrZ0yDu9PLMTe7II=;
        b=djyZEKB0WpCElmR2s3ODPEMjRhsdmz48fj1ZLIN1IN72ZufTzt1/Xi0yktuErgCCGK
         /d7xIpVdgwcywCP/3NY7hh/bgjh9W9v93yJ/MUShh923UvolWSlZms78T8cYoAHe2VSC
         Pd5Z4Car2Sgt2bAXVydUUuwKo4SQlCoud4XMMRUUTGAZKsHV1kwpba8Knilw3icPiK0B
         yhnkTX0Uxko3he/FXM9bHK0CKoO1eS/ZyB5q+5F71DPFofuqIqZJukl8Zs4OWZ36DjMb
         AmQ+ELq9Nlut/dj6Ki15UdhFpKv8fOT2qUJ8IrB+4Fb1L9lVqaUe/YWg+y0AYWebzVZH
         qCbg==
X-Gm-Message-State: AOJu0YxTexWsfGiry4DTRoWK6dVJWQRzZ0LjUWv6DFIWDNpIUmATLQRp
	gGAzYCbfCvVj/iY9EhF6A4k=
X-Google-Smtp-Source: AGHT+IEMMuqwQNx9z6Hr8dPILfSy+Moe7WigBkctnSmuou3oil2rTKPm1MT9lDIJZDBR1mNh46cwcg==
X-Received: by 2002:a05:6808:171c:b0:3bd:3db7:7bdc with SMTP id bc28-20020a056808171c00b003bd3db77bdcmr1335136oib.11.1704905231019;
        Wed, 10 Jan 2024 08:47:11 -0800 (PST)
Received: from [172.16.49.130] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id t29-20020a056808159d00b003bd26c33a8bsm754483oiw.46.2024.01.10.08.47.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 08:47:10 -0800 (PST)
Message-ID: <44da90d8-88c4-4a92-9114-0ed875e86cc7@gmail.com>
Date: Wed, 10 Jan 2024 10:47:09 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Log falling back from SAE to WPA2
Content-Language: en-US
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Fiona Klute <fiona.klute@gmx.de>, iwd@lists.linux.dev
References: <20240109095926.1541238-1-fiona.klute@gmx.de>
 <214422a4-25bc-4676-8a4a-8bf8d67c7ab9@gmail.com>
 <BD87F517-7D4C-48AA-BB73-D18C9AE6322C@holtmann.org>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <BD87F517-7D4C-48AA-BB73-D18C9AE6322C@holtmann.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Marcel,

On 1/10/24 07:12, Marcel Holtmann wrote:
> Hi Denis,
> 
>>> I've had connections to a WPA3-Personal only network fail with no log
>>> message from iwd, and eventually figured out to was because the driver
>>> would've required using CMD_EXTERNAL_AUTH. With the added log messages
>>> the reason becomes obvious.
>>
>> Interesting.  Last time I checked only the quantenna driver used this feature and it wasn't very common.  If it isn't a secret, what card / driver do you have?
> 
> according to Arend on an email thread with the Apple WiFi support, he hinted that Broadcom with their devices/firmware opted for the CMD_EXTERNAL_AUTH option while the Cypress/Infineon devices with their firmware (like Raspberry Pi) are using the SAE offload feature.

Yeah I saw that as well.  I don't have any Cypress devices.  AFAIK Raspberry Pi 
uses brcmfmac + firmware that supports SAE authentication in CMD_CONNECT, not 
CMD_EXTERNAL_AUTH.  Someone who knows better please correct me.

> 
> So maybe it is time to implement support for CMD_EXTERNAL_AUTH.

Sure.  I don't have any devices that use CMD_EXTERNAL_AUTH, however.  Patches 
are always welcome though.

Regards,
-Denis
