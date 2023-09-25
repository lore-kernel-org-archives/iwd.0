Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CCA1C288
	for <iwd@lists.linux.dev>; Mon, 25 Sep 2023 14:30:59 +0000 (UTC)
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3aa1446066aso4347342b6e.1
        for <iwd@lists.linux.dev>; Mon, 25 Sep 2023 07:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695652258; x=1696257058; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HJK/U8Ppq7mjaRRA+oj3HmlnGTtSzqOxuvsMtgrc3FU=;
        b=Tkswb3+8dZ1munyyjYbUoaP7AnXRsSafGG/JsaYN93A8tsL3o2JeOy/1MOJbQQyW1D
         DQw8yYNeeysLkz5BjNS9Pvih2PBOpZr0a2eVBLJsRz+N7KGyUT+0vOmF4IxDqzJEJthB
         f1RmbKAdfdnUn8FHlnnA2BUyu8qEkIkzbpFXR5vMMW4wSZuq0QYiaWp9JKpAcK47iMMv
         77G6pohJsPx9epO9NVKup4VOICpmtdVVd6XGGlHEklU3v5bmGUP/zFPp6q3kqWEohLZg
         VWi1aEXQ6uDGBiGX3Df2VudmGeE2Yc9vF4EB0qDQYQjY39YwZ3xk0eD1r5Q4BSHuI1Fj
         regw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695652258; x=1696257058;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HJK/U8Ppq7mjaRRA+oj3HmlnGTtSzqOxuvsMtgrc3FU=;
        b=prAFG+BCIKGe9dc/It9dXVpradlwDUqgL6y3qsDwc/VSlrOtPWnPtRcjlgQzkA/nKU
         a/u5yb7BxGouONt+6/q5iEtMVxPxBno97nuxYoghqpjIHkgkRMHpVJYdEQYyxXodSoeV
         2mm6RURhBVlc+MTImc1TzsCXZHL4jrcfPGIJ48wh++ers0K8rR99k6SIQzkGi/OOV91F
         IyYzeQGhCrY+5LqAsdW09Rxv5xWMlHIxx8+AvY12BMzs1k8HgXVlk4pNtp1M/V5BFd2a
         kj2n3dglZ5Lijzdjcl+LwUjtRT2GPUkmT2Rl1sjro7AoGK/4osQs4tIzi/56O3jMMah1
         U2Vg==
X-Gm-Message-State: AOJu0Yx4R6piefKSt9NgZ0JnUiBzz8SFAH2FxFxMfTYl0Saj3t+1SijI
	W/8mamWTh8MRFLJ/podlhLD0hWJOESQ=
X-Google-Smtp-Source: AGHT+IF9Ayo0wzg/6r6QyDHCEhI3TlWh/30wNtQR2YYSfwEvrRe7z8ljNPXjhRTJ/G74mxy9thTW4w==
X-Received: by 2002:a05:6808:d4a:b0:3a8:1727:5af4 with SMTP id w10-20020a0568080d4a00b003a817275af4mr9907349oik.24.1695652258378;
        Mon, 25 Sep 2023 07:30:58 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id r35-20020a056808212300b003a43759b9cdsm1675964oiw.29.2023.09.25.07.30.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 07:30:57 -0700 (PDT)
Message-ID: <93790e53-0ed1-46de-a0df-a3df04571b71@gmail.com>
Date: Mon, 25 Sep 2023 09:30:54 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] wiphy: fix wiphy_contrain_freq_set skipping last
 channel
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20230919165923.1352279-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20230919165923.1352279-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 9/19/23 11:59, James Prestwood wrote:
> The loop iterating the frequency attributes list was not including
> the entire channel set since it was stopping at i < band->freqs_len.
> The freq_attrs array is allocated to include the last channel:
> 
> band->freq_attrs = l_new(struct band_freq_attrs, num_channels + 1);
> band->freqs_len = num_channels;
> 
> So instead the for loop should use i <= band->freqs_len. (I also
> changed this to start the loop at 1 since channel zero is invalid).
> ---
>   src/wiphy.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Both applied, thanks.

Regards,
-Denis

