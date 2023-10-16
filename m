Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E982AB54
	for <iwd@lists.linux.dev>; Mon, 16 Oct 2023 19:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QD4P4kNg"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-1ea48ef2cbfso819151fac.2
        for <iwd@lists.linux.dev>; Mon, 16 Oct 2023 12:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697485561; x=1698090361; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Cr4xkW0ShvtxLns7CU/3BXGWw63LnHNLfL/iKGB7AA=;
        b=QD4P4kNgmT7A+uX8mKJbQvrFvKfQwraEDH6W9EuTpJ5kLwLXOk/ALz4d/zWlABzmBr
         E/LqzbSCApwFzkNRAigIzXpq6un3Sh64K/LWVSeHqrRbZVxDmJWhHQkeM5kob4mv4Ia7
         vkxpseZrP0KTojdLPrTwFFItR3pchi4T3dDac97tVwM2eLDIgQHILyaOOzhxlzxA6DTC
         ZToe/IUHeQCmC7RX589CS+Q3O2ItoM27O/Iye+ejudNncuA/NI8WZgS9EiuBYU1WuEJE
         n2KG4u3gTIqbSVvKLilO3NZ2aJTw6ymWIWvB1+YXZOpmid4EE0j6HWOlO8l9MQPDH3ub
         yfLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697485561; x=1698090361;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Cr4xkW0ShvtxLns7CU/3BXGWw63LnHNLfL/iKGB7AA=;
        b=KFd0SkmrJhvv0UrFoacCd12jeOY2XIcBYtwf2/T6nTWsLC0l42YNRPhphH+LIVrki1
         hTosMAz0GCXbuTeu2tWsyoc0Weg7Oxy9TzzBFALzM9tl9HpY+L3CkoYvJacSmCjr+BMX
         jwXXKF4Y++iZUWu3x4ai+e6Be2svI9M0FzJSmAjFdunxNKUlCQPCm3EnqOn4nJ45cou2
         Ovk2wZOLMebBFeOX0RG9Z8A299FBbQFgDgh1mdUnw0N9bzsLGNx33yhcxRJQZmCCJ/Pr
         MAeOxWGAejO2IhvHcSHsPyv/b789xIJUUdbQIMUPnxasH4Ssxb3G5yvhEi45EWxn+jpW
         y8KQ==
X-Gm-Message-State: AOJu0YwIlJ7rll7xbfZgcqR+WLHp7M8ChTtWy2ZMVz83dprMSeHnt6Wu
	CO0NF6nIAg2gkidQ/+w2Mas=
X-Google-Smtp-Source: AGHT+IHH1bRxbolwBZrkr8eQribIjNctoxzQczOmoiz3phnAAht+vGA+z+DkT9T7/sv7xJW0infpqw==
X-Received: by 2002:a05:6870:9a99:b0:1e9:907b:1642 with SMTP id hp25-20020a0568709a9900b001e9907b1642mr141306oab.16.1697485561238;
        Mon, 16 Oct 2023 12:46:01 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id m3-20020a056870a10300b001e98fa5c9edsm2120184oae.40.2023.10.16.12.46.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 12:46:00 -0700 (PDT)
Message-ID: <075d94c6-4ce3-4945-b765-71ad6285dd67@gmail.com>
Date: Mon, 16 Oct 2023 14:45:59 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] eap-mschapv2: allow using on kernels without CRYPTO_MD4,
 and deprecate
Content-Language: en-US
To: Dimitri John Ledkov <dimitri.ledkov@canonical.com>, iwd@lists.linux.dev
References: <20231014235445.167620-1-dimitri.ledkov@canonical.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231014235445.167620-1-dimitri.ledkov@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Dimitri,

On 10/14/23 18:54, Dimitri John Ledkov wrote:
> Currently eap-mschapv2 does kernel MD4 check during init time, even
> though it is possible to use it with Password-Hash on kernels without
> MD4.

While this is true, I doubt many users actually use this setting.

> 
> Separately, mschapv2 is obsolete, deprecated, and removed even in
> Windows 11 22H2 [1][2]. Add an error message stating so encouraging
> migration to PEAP-TLS or EAP-TLS. Separately, warnings like these often
> don't work, thus likely need to remove this authentication method
> completely.

Hmm, from this description I think you misunderstand how MSCHAPv2 is used. 
Indeed, just using MSCHAPv2 as the outer authentication protocol in EAP is 
broken.  However, nobody actually uses it this way.  In other words, while 
EAP-MSCHAPv2 does exist, it isn't actually used.

However, EAP-PEAP mandates the use of MSCHAPv2 as the inner authentication 
method inside the outer TLS tunnel. "Migration to PEAP-TLS" already happened, 
but that doesn't mean that MSCHAPv2 isn't used.

> 
> IWD usage of MD4 was brought up on linux-crypto mailing list [3], upon
> my attempt to remove CRYPTO_MD4 from the kernel which is no longer used
> via crypto API by anything else.
> 
> It worries me that internet searches suggest that EDUROAM (a Wi-FI
> network spanning 106 territories) seems to still often use
> mschapv2. Thus dropping this support may leave millions of people
> without connectivity. Given how broken and isecure this authentication
> method has been since 2012, I hope that EDUROAM is migrating, or has
> migrated to P/EAP-TLS.

Yes, exactly.  See above. What this patch accomplishes is breaking EAP-PEAP 
support in iwd :)

Regards,
-Denis
