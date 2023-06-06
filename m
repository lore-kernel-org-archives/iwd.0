Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D977737B97
	for <iwd@lists.linux.dev>; Tue,  6 Jun 2023 15:36:29 +0000 (UTC)
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-392116b8f31so3410317b6e.2
        for <iwd@lists.linux.dev>; Tue, 06 Jun 2023 08:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686065788; x=1688657788;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=coiClikK6dJZy0BOxfOPT116kYlXSQhjUmahLZlE+Zc=;
        b=V21yVmqbAH32NzCmLY/f5A2YXm87v/c6rKYaivvR1fg7Be+o0SpiR4+x4qViqm1ZzH
         NmOjKeImHjzzv+owXOhlVVBNDS4BcjnvflI5PpUYTw13vNgouzZWVLXslxGYPxTfo2qU
         VYFmjJOhazuPB7a41sIyDTwqfUGK2Pky00cNziPLV5Mg7BOkUs9Y0AxqqGrOk7NiRog4
         YmRMyN28qRf5abaYKqtTjP8cdzBuIkG5mXZK9NZtGbGnBQFAhrecf+4tTGRf1mFhR0ts
         Mj0rDomJI5Ij/4pTelMZLmT6cDmE+23f1i1zJg0MGP9sS956Vkr/BSx6DGriCUNx0NOz
         kDRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686065788; x=1688657788;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=coiClikK6dJZy0BOxfOPT116kYlXSQhjUmahLZlE+Zc=;
        b=dfEcDxHXcwsDck/SvHGF0bZZzXxuLBmmcBsxUjxSCzsUALCakKdYwD/AEYOIlr+B9c
         5zosX1xT6TzLTdV3UHdcGElUcX2k5IIbMSTbJyTXlMvTJA9CaYXkfQHwu+5C3KyoZa1F
         ntaVZMIWtamjHrt3JvxIJiQ98IaCjR301NEfVO56v0dBoznBmV2sNHzFJww9dMvqIx86
         WTioDoryBs8+k2c+XAABOMqpJ/d2BVRMDBIaCiaF355gBYSJa+x8eDcedFeiMPUDafd6
         hwg7yFgBmDP7RKmZzU60KayTP9vCEIWvHZhO7oj29nztnjd6j0qnNDO/7pOSvY2bUrE/
         IgfA==
X-Gm-Message-State: AC+VfDy8nxP6iiCUGKq9nu9KptDdJv2vDLgeMj/AKg7ERwi/257WIpqV
	BJGWIypQXFxSPOwDQDFqwKU=
X-Google-Smtp-Source: ACHHUZ565jy5kylhoMonePhjEmpJSFPPAQ2RBBq8/dxa0G4aeC7zCwVXNHjqFjNZIfDFMUo0iNTyMA==
X-Received: by 2002:a54:4090:0:b0:39c:3b38:e5c1 with SMTP id i16-20020a544090000000b0039c3b38e5c1mr1603966oii.44.1686065788512;
        Tue, 06 Jun 2023 08:36:28 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id e184-20020acab5c1000000b003942036439dsm4720589oif.46.2023.06.06.08.36.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 08:36:27 -0700 (PDT)
Message-ID: <885040dd-d0ac-e2c1-8847-da74da899345@gmail.com>
Date: Tue, 6 Jun 2023 10:35:43 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] ft: add debugging in __ft_rx_authenticate
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20230606150416.115864-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20230606150416.115864-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 6/6/23 10:04, James Prestwood wrote:
> If there was some problem during the FT authenticate stage
> its nice to know more of what happened: whether the AP didn't
> respond, rejected the attempt, or sent an invalid frame/IEs.
> ---
>   src/ft.c | 13 ++++++++++---
>   1 file changed, 10 insertions(+), 3 deletions(-)
> 

Applied, thanks.

Regards,
-Denis

