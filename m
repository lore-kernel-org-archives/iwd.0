Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FCB1D6AA
	for <iwd@lists.linux.dev>; Wed, 13 Dec 2023 16:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZ6/oF+d"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3b9df0a6560so4799598b6e.2
        for <iwd@lists.linux.dev>; Wed, 13 Dec 2023 08:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702483588; x=1703088388; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M2fdJlj1unrpEukQm3hXFkQ3jdxpDFofR4SBOoS+46g=;
        b=ZZ6/oF+dI4W9S2e2tsfGVBZMEPWOfjkwsQDgy5GC+8l2o9OpxxpUcMBBdMombbHvV8
         CTMnPmPrc76cJZjBwEP2DDl+7zhOF47Ld2i6WydpPJ0bHcVerJQa5KFSyxzyhU5zThW1
         7rl/HDCdlynFcVstfIqxs3vtwez5iaIhaFoaS6y0K9pfJdcfUK1wX0Sc0ngv98xrKyMp
         BQXkLfENnBOy5i5JnVGxpbXLdZf+eMo6yow6ltxZjuCFGsUCnl1HbAaTWLXp6tcyQnPG
         3lZR97gNvUtG51Mic8k6tgLb4t3Stpy1vs/LucU/snRM3WEuiMh8Zn4qC+iei7CiTCzH
         UyCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702483588; x=1703088388;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M2fdJlj1unrpEukQm3hXFkQ3jdxpDFofR4SBOoS+46g=;
        b=l3N4zR+eWAdNwsscxU+tEcjj4ak4lK/LnBlJ2htAWg4JKF6MlQT1rPeu/Qxdj90Uzm
         56Zwpnvltjp1H5SvFxZClhdaNGzsxXZPC4TBJX8DR4H0mZxxA1dd6vMtXCrBZeVA/rwF
         NUX7aacMri1dzJP+VPF64DO+jsMg+j3mKT+EZTQMd9Qrt9vlbdS8uXAFWfrNI1Fc0s3D
         CZdrlzbNL+gpEK+rjjO77cjN6esXicTloMlPZ8yJ+sifdSzmJt9HyP94zf83UqmBdpvc
         7/T5Z0Bn8+zDxzBBcg+tEEIiVByuIaBp9dBG/GmCxdsGuguRQsJFfRnvjW1GCTOVq7pZ
         2lwQ==
X-Gm-Message-State: AOJu0YzBN0R5WBiR34guBFBFgwBdqDPd0L8ZBdo3a6prYx3p2exSLWLi
	+MzYjpfsJ6S0MU1wgWm9CUA=
X-Google-Smtp-Source: AGHT+IFmeXeyKVKO4jRMEjkL4k4h+puXz0twfr6hN4S2gxphj6wKgR/J7vUkwSvdMgKyKfc6KpQ/gQ==
X-Received: by 2002:a05:6808:3308:b0:3ba:12e2:2ba5 with SMTP id ca8-20020a056808330800b003ba12e22ba5mr4859067oib.43.1702483588015;
        Wed, 13 Dec 2023 08:06:28 -0800 (PST)
Received: from [172.16.49.130] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id e9-20020a05680809a900b003b8b1a4fbf9sm3009191oig.31.2023.12.13.08.06.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 08:06:27 -0800 (PST)
Message-ID: <e53b0f49-0efd-4864-9380-4a788e56c3fe@gmail.com>
Date: Wed, 13 Dec 2023 10:06:27 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dpp: set "" arguments to Release method call
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231211193739.64318-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231211193739.64318-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 12/11/23 13:37, James Prestwood wrote:
> Without this the DBus message does not initialize the message
> correctly which causes future DBus calls to fail.
> ---
>   src/dpp.c | 1 +
>   1 file changed, 1 insertion(+)
> 

Applied, thanks.

Regards,
-Denis

