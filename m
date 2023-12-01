Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDD21C685
	for <iwd@lists.linux.dev>; Fri,  1 Dec 2023 12:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I754x0+h"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-67a9cba087aso1775186d6.3
        for <iwd@lists.linux.dev>; Fri, 01 Dec 2023 04:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701434577; x=1702039377; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BMPABMUF46B7nS0cBiZ3zkUJ/9xX6XknagI3LQCLFPA=;
        b=I754x0+hHCMTxBOLXLya5xRO9gqYIr+34SjPcZhno8qqXYTo2E8tKjG8JjX+DRscHB
         J2fMz9Js1qWltakROcWwAUugLsovzZbFXwQPvIUNNsHwetftvHuAopTVZdNDC4u/nmXw
         IF8hbCDekaqDxmBOALfPEn5vdUaEXYwf1NVXItvpjd/4FTtie/Sj6fZ7KOTgVH1onCos
         ewcggce6izNS4rmkOP8amQQqFALv93/KuHbmNrrN9weCAROMyJOsyky+XF1q64gheRKU
         X/aLE0r7qTojIAM+n3FqhbiJnVU6y0pzmkyGfW3fVtfMw+X1aeKnc1UUycxqaZAR81Px
         9HhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701434577; x=1702039377;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BMPABMUF46B7nS0cBiZ3zkUJ/9xX6XknagI3LQCLFPA=;
        b=OPNlrG0zcyW88lvzyIHygZSFHIKFFhbP2iDkEHWlfGSXq87yvGvVQsqhG/DZsojtlU
         pwM/7hQLGXo+TEYDhQ0nzsBpSR5TOhm9uopTQHkcuuUIPG/Syoz+kFznoS5MY5jLrKv4
         eBu1H0hFeP0W5P4CjIL2FZ7FAY7FijL2VHXvFXOwzRvM4ZhedP2w+lkQQrCOj/Is7f/F
         PPWFYvsq+Sm15Xx72alA4zr70sRxSyoaXMWr7RBGGRt1d4PYxGiG5lDjoeHrWMM+LuXH
         d1yLntqIUDZeLUVlRbbcRftPriQJ8YKn9p9aGNmmHL8r+0NQR/g0n2OdXFIO1gfDyVur
         BVrg==
X-Gm-Message-State: AOJu0YxFhpkj7oXs7BbmA57pm1JmbmpyNqbWFeRB9Vs+/xrsp2CcGmDe
	weA57ulxs6SvHeLVx0BjVKg=
X-Google-Smtp-Source: AGHT+IHqKYTpy97tBlOPkUVDYahIeCyvbV51/d1rY7z8DnztACKWLxhIyntZPnqtkvh8INIE1EIZtQ==
X-Received: by 2002:a05:6214:5294:b0:67a:255c:c43f with SMTP id kj20-20020a056214529400b0067a255cc43fmr22537348qvb.18.1701434577029;
        Fri, 01 Dec 2023 04:42:57 -0800 (PST)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id pp6-20020a056214138600b0067a2c201c95sm1367803qvb.51.2023.12.01.04.42.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Dec 2023 04:42:56 -0800 (PST)
Message-ID: <c0e09d22-519b-4161-b8ab-32e3830569fd@gmail.com>
Date: Fri, 1 Dec 2023 04:42:56 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] handshake: Add cleanup function for handshake_state
Content-Language: en-US
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20231201040020.161143-1-denkenz@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <20231201040020.161143-1-denkenz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Denis,

On 11/30/23 20:00, Denis Kenzior wrote:
> To allow _auto_(handshake_state_free) variables to be used.
> ---
>   src/handshake.c | 7 ++++++-
>   src/handshake.h | 3 +++
>   2 files changed, 9 insertions(+), 1 deletion(-)
All LGTM

Thanks,

James

