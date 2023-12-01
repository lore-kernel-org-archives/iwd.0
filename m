Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D394D58E
	for <iwd@lists.linux.dev>; Fri,  1 Dec 2023 16:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBXFgzv3"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-58a42c3cbb8so1323598eaf.3
        for <iwd@lists.linux.dev>; Fri, 01 Dec 2023 08:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701448356; x=1702053156; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1P/1PBW2S5vLtEtsHRcRcA2mSlRJu258HdP7HKuSHLo=;
        b=HBXFgzv3llHmMd2FJDB6QQTL9MJ4mq4CrrwCr7J7CkrrxuFlSr6QP2QGLcUJ5gqPwB
         07PyM6GWzQt6Ig5QohW7cqob7rm6Q3eIg2xqQNoC29COgfvsKQz71BHkjVGk2OSuni2g
         AS7vqX0i7BjMV40tUPqAkFcjsXb2m2dhs0Gp7l9uRwZkN3mu5EJOOSRgAtS/GgeYrH7C
         dPsGUZk53v1dxwfZhG9RoSqz0hNVI13pulN6hwuXe6vB7NKWnueC9w7Iqv1G9yiZ4ejK
         +My2sfmxr9ibHx4nVKy99uY1Yi9+wyyJtd4bSc9twuT4YdiqODlK4/nsJpo6nCys25Wz
         h5mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701448356; x=1702053156;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1P/1PBW2S5vLtEtsHRcRcA2mSlRJu258HdP7HKuSHLo=;
        b=r+hnTN6378kidmrrblZ1tJxYisgtRH/DeROt/Xs2m6TZ1yTdWjkaQ4qieT1aOg4/Nc
         uqbgTI2EOt7rSRhGKsjRu9EWYeHXo+fhHv9sXf1pXmTKgMuKJn9psFcTIIlMaW+fLgTP
         PHLKxgYLoOsCW/fO+nBeVwl4Ta0nCHg/ghkZPp7x3q4mNLH8sdvfLtIF5xVTjl6xk0/o
         VbMBcqpUQOR95ezeglGRgkyxmJCKCX0xaX8sHQPiLPkIZ+GDyg/UES1nHc8Z5F8EijW4
         cuTtTJQtyvVYj+Uv8j+rMGDn6Tn8Vo/z4CjdZfE7Qu2TWJwQKdp9qvGiMqXfr0Auvn4E
         xUxQ==
X-Gm-Message-State: AOJu0Yy7e+f29noNUZbfNvwvRA5yh1uylzwpPkbY62p91KB7XRiiApA2
	tjemmv79CWlzdRAYzxy1vB8=
X-Google-Smtp-Source: AGHT+IFONMaabgZoScnRKzTzytWHDv20Izjz4MV5E+wVyEHXDekJTH7LwmawCTqzdIqH6ggbOXYlOQ==
X-Received: by 2002:a05:6820:160c:b0:58d:9b89:8b20 with SMTP id bb12-20020a056820160c00b0058d9b898b20mr3537428oob.7.1701448355789;
        Fri, 01 Dec 2023 08:32:35 -0800 (PST)
Received: from [172.16.49.130] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id t67-20020a4a5446000000b0058df9ed9291sm445395ooa.34.2023.12.01.08.32.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Dec 2023 08:32:35 -0800 (PST)
Message-ID: <b6ea29ea-5fa8-4ac2-afea-3ff2507322eb@gmail.com>
Date: Fri, 1 Dec 2023 10:32:34 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] handshake: Add cleanup function for handshake_state
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231201040020.161143-1-denkenz@gmail.com>
 <c0e09d22-519b-4161-b8ab-32e3830569fd@gmail.com>
 <b656ec75-6f85-49c6-b78b-75d15f0aff08@gmail.com>
 <43b52716-991d-436b-b1b6-a6d9d459ff8c@gmail.com>
 <6a803951-646d-4fbc-87e8-44b8c3a6436b@gmail.com>
 <7a80e9d4-ecd8-4592-a5ec-d81cbe666991@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <7a80e9d4-ecd8-4592-a5ec-d81cbe666991@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

>> Nvm, I'm getting the 4 failures on a 6.6 kernel now. Something must have 
>> changed so I'll look into it.
> 
> 6.2 - works
> 
> 6.5 - works
> 
> 6.6 - broken

Sigh, figures.  I doubt the patch from Johannes would fix anything for us since 
we don't query carrier state directly if I recall correctly.  We only react to 
events, at least on the connect path.

Regards,
-Denis
