Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2B35387
	for <iwd@lists.linux.dev>; Thu,  4 Aug 2022 19:33:04 +0000 (UTC)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-10cf9f5b500so680070fac.2
        for <iwd@lists.linux.dev>; Thu, 04 Aug 2022 12:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=ILhpMCYCqRFQi4SLYVGwJJb3OrUMf/1tHqnutYpQDpQ=;
        b=M87Viwj6tTKeMhvw6sOkElgT9w6AaZaHRKCANTlTqr6kv63QaOt4klIW44MMWOQPc3
         hCOFu9hJbaGTQzRARCxp+jlqtquDhZtjUMEvLQcZNqZ/0keJqKFNmyPLKaZyM0bvpDJF
         V7fiwpTLRkVswJFlxMtBAetb1ISFbQHgwxGVErVMit2ajCqIHcOwHrfcuaGA43lhRo9U
         W1XB/exgzXQpTeM7nWEFjpILxI8UIbI9OQm8k8aqtBkPik/Tzz+0X7U5crrcr5b80yPx
         Ht2rEBqeF9QdMYJu26wb7HzgR231nCAqD6XBclbqgH9nV562YeZ1pRlasGNsWotQMEDd
         ZVnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=ILhpMCYCqRFQi4SLYVGwJJb3OrUMf/1tHqnutYpQDpQ=;
        b=Mq/bYbu/rAi+gNo5CFdUaYlpjMijjmRyvuumPNSi6M9V1o73VYZt1EqvArfx1sozww
         afPnh4x+8CP2JNU62oLy/L26ce4vtEM84bKErxgxUNqdUymIa5SkdmyKvjB5aywmCToY
         38iYxWv6lzFV2gC5tDc+f0SngMXW3M+yrJ5gEWaXpnqS108fT6n+JABcbG6QDiBa/phU
         3/rnVmUUua6llHcGb98rKxkcgEwB5+4wuS4IrYVlBq73RYQViu01BQ30G/RRTnf/bllr
         iCPZ3o9Q8IGXdUS34dhBcPCdn1wZO09HtexdoZiD6cfHbZpwwVIClTPZxh0/oHiO7rro
         7IyA==
X-Gm-Message-State: ACgBeo1Ksp+lFJc0N9d/GEXkD7F+9/zsturdJWF0ZN7MUf/aRZXjF9x1
	xSt8FMAZRsyx0uek75eYpS0=
X-Google-Smtp-Source: AA6agR6UZ0PwObTWhWYy/JEqSIw2AaKYmFi15ytnWDGD7pyX6BxCZQAaUGYDbbWSHJ3QRPYv/Fp5AA==
X-Received: by 2002:a05:6870:8314:b0:10c:cc1a:57fc with SMTP id p20-20020a056870831400b0010ccc1a57fcmr5129289oae.153.1659641583699;
        Thu, 04 Aug 2022 12:33:03 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id cz38-20020a05687064a600b0010ea56a12a4sm294338oab.10.2022.08.04.12.33.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 12:33:03 -0700 (PDT)
Message-ID: <bdcaea9d-eb72-c759-9589-5c1e761485ea@gmail.com>
Date: Thu, 4 Aug 2022 14:18:27 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 1/7] wiphy: track GET_REG ID
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20220804185112.457670-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220804185112.457670-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 8/4/22 13:51, James Prestwood wrote:
> Keep track of the GET_REG call so it can be canceled if the wiphy
> goes down.
> ---
>   src/wiphy.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> v3:
>   * Moved this out into its own patch
> 

Patch 1,2,3 and 7 applied, thanks.

Regards,
-Denis

