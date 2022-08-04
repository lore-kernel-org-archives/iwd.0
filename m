Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C0D2585
	for <iwd@lists.linux.dev>; Thu,  4 Aug 2022 14:33:45 +0000 (UTC)
Received: by mail-oi1-f179.google.com with SMTP id u190so3259140oie.3
        for <iwd@lists.linux.dev>; Thu, 04 Aug 2022 07:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=xl457wi+vUK2uBF1XQQ6yhB9mC1KYBjknmTfrMCGmTs=;
        b=SJ2ctpmf6zzKe9TWLcODm33Ey8AHai9cftyWqkVjdSJFkF9T+9m7RJlZ3PjhCl5mmz
         iYsCIqPXNtjgONJ/LRat3EYRIVDajOycBnnFi9RaRZhzisUYx45VVysl/Qzwv7/t9HbY
         uBmLZkg/YBIOFiT+wJRxM9G2tLd3U4aE7skOdRU3caYAdL6uI9S9rHnfbDJFMKTbU4FK
         kKV7PIIbmjnjehqprMjrtqCpafscoac80V1iG75OyVJ51TMVEQjP0GVFRAJd2yywQCLQ
         +qOITpkXZ3B3O703B44Xq/o9k3QGKExRTryTm7+m7G0LeJRWMkw6iy7LbPdIeL0omeVJ
         e2cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=xl457wi+vUK2uBF1XQQ6yhB9mC1KYBjknmTfrMCGmTs=;
        b=1xUjuL7Y+2U7GyEBScscJrA6JosmhQTjf+GXEzSHqz+S17o1i7WqbG5zt7tJ24BF1C
         tqbL99R1SILRe+y7NI75fWn2L1SOCQf49MDUrzz+11D4X2+z0Osov7JScrxGZm21jcQ/
         8uPYCxv1IF5bE2IRictSouqaz2G45B3Y07YB6lg94C8AR9VxxmNPGhcyBvw7Lp40LK0G
         mLQ6Y9uwc/0KmxNq3EAPHvLbbT52/OLjP3J8P+YbLF3PKZ0/yjZRWSsGwsgSzPiN6ldj
         6iI7ANhOapRB7YyWO6A76gVayY78AfMdl00uG32TgORdRtQ97nBEUgttfEXfflDphW4M
         ALeQ==
X-Gm-Message-State: ACgBeo2Alh8J1tdNaWwG1mHI9zes/d/y8GKpi5qhZ0A/tgOzb6AI/GgS
	OAl69TbQ92RpLMIt3JxndnA=
X-Google-Smtp-Source: AA6agR54djfyDlsaBprUGyj2JBXF17XzvzaCM6QLgkXO9TQignGvEyuN9EoS1HtrbYQyFbTjDO0ybA==
X-Received: by 2002:a05:6808:1182:b0:32d:a9d3:4e0 with SMTP id j2-20020a056808118200b0032da9d304e0mr4028194oil.146.1659623624701;
        Thu, 04 Aug 2022 07:33:44 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id v19-20020a056870709300b0010d75440f41sm139646oae.45.2022.08.04.07.33.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 07:33:44 -0700 (PDT)
Message-ID: <cd5d2054-dc74-8acb-442b-266f19fed206@gmail.com>
Date: Thu, 4 Aug 2022 09:16:05 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] manager: Fix typo
Content-Language: en-US
To: Alexander Kobel <a-kobel@a-kobel.de>, iwd@lists.linux.dev
References: <323e3bd2-e17f-bd9e-51ac-714d2befd060@a-kobel.de>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <323e3bd2-e17f-bd9e-51ac-714d2befd060@a-kobel.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Alexander,

On 8/4/22 06:05, Alexander Kobel wrote:
> ---
>   src/manager.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks.

Regards,
-Denis

