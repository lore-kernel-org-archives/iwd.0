Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B922155A55
	for <iwd@lists.linux.dev>; Tue,  7 May 2024 15:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715097076; cv=none; b=U+J/nmF6Sn4n2Aq35uQgGI1shD72vqX9VB9e1f7nQ34sWFPS3h3O4sATR1VAHGdeySTIdDUgkRxXxLAhhSmLv9O5OUqbDuLt0BqWoz18xmBjVEbqXq2lyPLkm8GoVLi3RiK5CTC9T3rC918XeaWRZQc7wLGLK6Ium80bUNZueN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715097076; c=relaxed/simple;
	bh=Ii4R3yTBjDBT8BAus2ckU4RSpprMz6ix8194kSHv8pU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hxOssFQnVgRSlDMmFYLFnzara2L66upu6xv7/CDvkVDpxPklWU/H7YIXoh6vXaLN/0nxtuHr+MnIl9ziErxasy6Th/vrEpOaPGPEaYNciVdbgY2ToXn+I6rDJbERQtrQ/Ug0qOlMUBJxoFFUWw81W39lQJ6TXB2JzRS/Q2pZ90E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZGWBl6Bl; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZGWBl6Bl"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5b1ff50e8d1so1813440eaf.0
        for <iwd@lists.linux.dev>; Tue, 07 May 2024 08:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715097074; x=1715701874; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RBYNUBWWlL+m2DomiGqgdZ8Vg6KcsC4w8JGS60aFPec=;
        b=ZGWBl6BlZWj4Zsv3zis39Bm+GynyxrQb/g1BJef8fhZuSKQ2zf2BxyIsUda2eIaNN6
         Oe2uU7wX6t35dTv79ivowMSZ3srPENN9F4dPH3tCbQ5kxed0I++eTCCscAiL7BXkbKHU
         FZ6aoAC0pTCBr0E4oVCotJXMdabTyq/WTy1Km+OJzWqHQuHkk/+Totq4Od5Hmwt9EI9O
         VlYxmVHKOf2w1QTB0jkgOCJxCXZQI0A6xqKZeM6NKnlrY+eYTLs67uDDNJliFOxgt9/q
         tOw8EbsEPK+RQZXp2FoC2XSX73tePvAC/WWXNJPY3KN07nCeXaE/z68mi/a18LGiDX/T
         n+JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715097074; x=1715701874;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RBYNUBWWlL+m2DomiGqgdZ8Vg6KcsC4w8JGS60aFPec=;
        b=eZU2W5+CpSB1TCwauwcXhTzdIkYj/psXGqrQ5GUhJf0qL67QXomB+wipXAqo0fmxSE
         EvjMxJtBLQ6JlbYa3AEQ27U7F9qDn4dfQnz025ff9u0F8dCvcytm+4qAHuLlGtwyu+T6
         KbUoVNythqkJQ9UyKkfdnZQsTT5AfatUXkqMPPe3S9+pLL/FInc98dkiSstYR4bEyfne
         fyGsbRfdk5P6ns4592n8fy4YndgW9ZuFRhOglfxRpojzB8phlbSIY0W1sYztGTwhMbSn
         ibGmjngsCkvGyYYM/l4yJ8CIx58gdITm2jQF6sN2NWF3Xzy4ijxrSthXTZQ70gflWPGz
         Q0fA==
X-Forwarded-Encrypted: i=1; AJvYcCWwPCly/py+wovnaAA4m8b+pNpKo4HscKtH5T8C8RnF7DHJ02gIGTmGlBbB6ijmjOtINduQFhAN1+YqwZ49Gj+73uZa
X-Gm-Message-State: AOJu0YzUzQNJRBlhzzFBode0pAyUWAT9xhluwVngKOfJtMlVPg5Ez7Sg
	URSgB2lmvRLdg16MdS1aaSuR86BzFBhXR68+CqKlUOPvFnuB62p/O3WTWg==
X-Google-Smtp-Source: AGHT+IEy55T8ivoLA8tpQk8rXpULP9f3V/vtP2i7bJzgg0MaVkbDPHXxhmG+dMD6RUBPa8tgxriVKg==
X-Received: by 2002:a4a:44c1:0:b0:5b2:9d0:4d91 with SMTP id o184-20020a4a44c1000000b005b209d04d91mr7013179ooa.1.1715097074369;
        Tue, 07 May 2024 08:51:14 -0700 (PDT)
Received: from [192.168.1.20] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id bh15-20020a056820088f00b005b1e10646a5sm2039929oob.39.2024.05.07.08.51.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 08:51:14 -0700 (PDT)
Message-ID: <45018896-6df5-4646-9630-8a9765f37285@gmail.com>
Date: Tue, 7 May 2024 10:51:12 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/18] unit: fix SAE unit tests
To: John Brandt <brandtwjohn@gmail.com>, iwd@lists.linux.dev
References: <20240506003518.320176-1-brandtwjohn@gmail.com>
 <20240506003518.320176-4-brandtwjohn@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240506003518.320176-4-brandtwjohn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi John,

On 5/5/24 7:30 PM, John Brandt wrote:
> Don't mark either client as being the authenticator. In the current unit
> tests, both instances act as clients to test functionality. This ensures
> the unit does not show an error during the following commits where SAE
> for AP mode is added.
> ---
>   unit/test-sae.c | 3 ---
>   1 file changed, 3 deletions(-)
> 

Applied, thanks.

Regards,
-Denis

