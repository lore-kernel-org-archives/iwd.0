Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BC63D999
	for <iwd@lists.linux.dev>; Fri,  1 Dec 2023 15:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bi3U3Tso"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-58d1b767b2bso1222884eaf.2
        for <iwd@lists.linux.dev>; Fri, 01 Dec 2023 07:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701443318; x=1702048118; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/K2Eb3APvFkH/642Rzi3o2qAKzBFhiYhKDxPumEeRl4=;
        b=bi3U3Tso6MwhreIiokTStfBUnc5+LhQP/8P4GXhGDpH2gsiOjRYW561NvwQhHkbnmV
         zUqb52BxK8swP9cdQiczbBxVlZp9+6NUZ1aactiiycVQFGboq2wcUnwG7pWenlitMHVJ
         Obr6wAburw/fU+boyVGuwER2TE/sfBL/Dg6YtK7Q39fdVF+4yYPfhiMkSQ/PjmS9FX4Y
         PIwAyn3D8HeBdxknHljP9506HtMJMfX8V+G+0lZYZVawLVTR60n8UsemrprC0LxbCWVX
         5EN0x8ZvqbTCPsJnBPxAnIk/frAITlxRB4LJZUlcDgmURwdVstSZEtVMVE9On01wxeOt
         ONQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701443318; x=1702048118;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/K2Eb3APvFkH/642Rzi3o2qAKzBFhiYhKDxPumEeRl4=;
        b=SPoG7hS/SXucfJcFwY4sLYJlzrSrhiEBrQ6ay8z7UToEkCC03qfvnwmnSBvuiRF32r
         MOCmnuVH1Y3+0cZkM8PSX4tg+9v8f0MLObmVJKr76zX9S41PkNhSkJ6bfCC8zmIPdix2
         w8X/M1zKqeZflU8wKyZWEQbHIi3K9LDlA5yU3sq52tt9r6Hglbda5Fs6HxxNpdnf3Xnp
         ru4wiAdC0sGE7eKWoPBFwJKQlzr8WhK8g4f5KoWERTWNO2Wu1zMIYfw3Tt9/J3dSaJzL
         PhrT1taWfMihxIrRP96MgYeKt1Sqm05Bnr6ZPFOCtbkbXZ2EY0LOTKx8CMQN1DsHvx0s
         lLRQ==
X-Gm-Message-State: AOJu0YzURIBbiiq9ra0TZthUwSeA7g7nLlxKSsbrTuy7lV1375f+RFjj
	ow+/8kZ5u9gDmrWSm/YR2e7teEp1JEw=
X-Google-Smtp-Source: AGHT+IFj0+RC+diDLamIf+UOWaRZcEJE4fqjgjoyYdIGVCa2SUrTV08Mo/qg8rkCrmy6it6dpzQftw==
X-Received: by 2002:a05:6820:16a6:b0:58d:9b89:a844 with SMTP id bc38-20020a05682016a600b0058d9b89a844mr3582059oob.7.1701443318296;
        Fri, 01 Dec 2023 07:08:38 -0800 (PST)
Received: from [172.16.49.130] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id v5-20020a4a2445000000b0058a1d87d96csm597587oov.41.2023.12.01.07.08.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Dec 2023 07:08:37 -0800 (PST)
Message-ID: <b656ec75-6f85-49c6-b78b-75d15f0aff08@gmail.com>
Date: Fri, 1 Dec 2023 09:08:36 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] handshake: Add cleanup function for handshake_state
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231201040020.161143-1-denkenz@gmail.com>
 <c0e09d22-519b-4161-b8ab-32e3830569fd@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <c0e09d22-519b-4161-b8ab-32e3830569fd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi James,

On 12/1/23 06:42, James Prestwood wrote:
> Hi Denis,
> 
> On 11/30/23 20:00, Denis Kenzior wrote:
>> To allow _auto_(handshake_state_free) variables to be used.
>> ---
>>   src/handshake.c | 7 ++++++-
>>   src/handshake.h | 3 +++
>>   2 files changed, 9 insertions(+), 1 deletion(-)
> All LGTM
> 

Any ideas why testPSK-roam tests are failing?  They seem to be quite flaky on my 
machine as well, passing only 4/9?  Doesn't seem related to this series though?

|     testPSK-roam    |   4    |   5    |    0    | 256.84 |


Regards,
-Denis

