Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179061B26D
	for <iwd@lists.linux.dev>; Sat, 11 Nov 2023 16:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKzs/6Yo"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-1e9c9d181d6so1844298fac.0
        for <iwd@lists.linux.dev>; Sat, 11 Nov 2023 08:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699720201; x=1700325001; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SMXBQ3uGlSvJi8JHZiggTigleBcTbdHgU01FO+hYk8U=;
        b=FKzs/6YoEl11PJ8vTT6wbvNmHSMISNrEPzNGCf8cNaX3fbcm6l6Tf8nwtjuaOpMFXN
         wnySWi/HNR+GWtyNx2oPTfx19XsUbV9nGgQiAP67gPa6uGPoUeBJmZvVSzklNZm8TMgM
         IYFAlXbO7zNxUTKQn0t5yiudTzPz7YKwp27WFir4LTM/iFmtCzcREbQeftKniwwiXKT9
         0MiAjrmkueZmC1onG+E6TqZsogF1p4JgxdvdCU0d9jzlYAp5VK4VdhUckCT4eeOBDkYb
         daDG1K6OYIf+Wo3Z3gu/6koU9RlEJlzbwqPmktv6ZBlSu/guhyaYOlvwc98o3JXnp3w1
         YW7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699720201; x=1700325001;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SMXBQ3uGlSvJi8JHZiggTigleBcTbdHgU01FO+hYk8U=;
        b=K7IFJpncWztx0hkCOskLpIiE3monoAX8ip7r2bBO9aoUh9STOuiTxac1qTOzhqeHbq
         21394oGmoYC3zGVS40/pBP6jKkkaOI/e5wLY+n5eN5A1jLvuT+7PLZWu8RRd2FP1lUFI
         ycr/0EPh/a8T9manYcLGW+AYZZzXPr1yRf290RagmstU/RQLOXYMjD7sL4pfADH3DS0J
         DyMVI5HQZD9OO0OaTUshGRsGjKK5OWCbqoL7+qTb1zQjRFVOXTSWYb8pKnIW0vv79ZYq
         rRap4SB6kCr116E60LReDqJTKQgRVYRADNeXbiH0jswZcYLTKlxxOYV3nEkK7R49kVvi
         DxYg==
X-Gm-Message-State: AOJu0Yxh2DRu1vyvUg/P3x0d8MDwkqkorHD2HdeQaOypfOcrAX8mmWAd
	cd8jFrMftmrLqlXFuqPqLYY=
X-Google-Smtp-Source: AGHT+IHgBaHa1bXdQ8gF6DUKgEBXW+uzDkC4UrtvkMISjv9cHowWCmixeJgJtnORlhhoDZzhUaiqdA==
X-Received: by 2002:a05:6870:fb9e:b0:1bf:787c:411b with SMTP id kv30-20020a056870fb9e00b001bf787c411bmr3146270oab.10.1699720201184;
        Sat, 11 Nov 2023 08:30:01 -0800 (PST)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id kz26-20020a05687c321a00b001eac9c1b923sm363247oac.51.2023.11.11.08.30.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Nov 2023 08:30:00 -0800 (PST)
Message-ID: <7bbbd401-0ff6-4ef1-97b3-73dd4fd26ee3@gmail.com>
Date: Sat, 11 Nov 2023 10:29:59 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] client: Add shared code DBus interface
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231110125812.69911-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231110125812.69911-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 11/10/23 06:58, James Prestwood wrote:
> ---
>   client/dbus-proxy.h | 3 +++
>   1 file changed, 3 insertions(+)
> 
> v2:
>   * Fixed copyright
> 

Both applied, thanks.

Regards,
-Denis

