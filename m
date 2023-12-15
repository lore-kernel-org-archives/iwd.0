Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5409F3BB25
	for <iwd@lists.linux.dev>; Fri, 15 Dec 2023 16:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Io/ERwoA"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2030eae5051so341755fac.0
        for <iwd@lists.linux.dev>; Fri, 15 Dec 2023 08:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702657695; x=1703262495; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8NQGvVSTS8SzDFks0CEZNzBKHtGY0nUzIolEhx4IRM4=;
        b=Io/ERwoA6e+yPhtsSipzZKBf5oqHA07TJ/ZmzV59xT1OrDb0WxPggH3bRk9/25fn6X
         5UsyN7xxmdGpmkFLBK8Nq+Q4YkQ4scuvyWvn0qPxyREf1po+5pOBL2OVVlicEOVkxtnv
         kg3K3ua+RP3917BS9NUISsTa1/49NFQwyOWC0quRgkBWFN+erypc+9EvcxzaJ3gMTler
         MeelLVgYQRHMKZ/GPPxk9PkV0HL6rqXcf/HZgvq9krG0dtv8HB3IV6dbhIHVzLx11abZ
         tksU3o9LOhRlhZgladwvWLKH+ETsRQnCHt/tZd2xqQ4r1QVK2VB8AfSMV21TiwU8Baj0
         M5rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702657695; x=1703262495;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8NQGvVSTS8SzDFks0CEZNzBKHtGY0nUzIolEhx4IRM4=;
        b=kGs0VbcZlTcVZTT8NkwbaUT1p0l2N52qCYnEIc/AhIYcRBg59v9m64F9UiptgpXdDw
         7vHBbyNBfrT8EzLcduhVh1RIEtWtGBy/lhyzfAFOFPhnKpVlTfIqIgDK3aWqtblsqR0W
         pY/4LRfTNAJpEtERHyZdgbCGe3so+MfgIrJGlY+z1nWisfFfutxArPsPZUbth2GO3pWZ
         S93HbzudwghpXRq7BhYPHaCvrfLa1BXNS5wwEb4XOiuSF0wrwZWmENP0WOAt+1zoX1W1
         6PMmZ2EqJFHcZirYu+umamwxbpFTAKed/rNd8zvzy028wrC4CJPdFLIQNePDS/u/l1yx
         X3vw==
X-Gm-Message-State: AOJu0YzE7mBQM7wmR1ciE0HcZeE/FC4WYzOmkj+WCdeUa0uYphnPrUXb
	V0U60I4uYLtRMKwVpHil6WY=
X-Google-Smtp-Source: AGHT+IHPn+QWAFxu9g67ZGYO4IIPOHt+r0cDRAiNmFENr3tiQXQWFX/giSZbKw+i+SfaNCQMfF9UyA==
X-Received: by 2002:a05:6870:239f:b0:1fa:df5e:48be with SMTP id e31-20020a056870239f00b001fadf5e48bemr5087348oap.15.1702657695354;
        Fri, 15 Dec 2023 08:28:15 -0800 (PST)
Received: from [172.16.49.130] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id hq15-20020a0568709b0f00b002032d9a4c0dsm1363510oab.43.2023.12.15.08.28.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Dec 2023 08:28:15 -0800 (PST)
Message-ID: <d1f5aabe-1066-4e36-8128-29f0ea3b329f@gmail.com>
Date: Fri, 15 Dec 2023 10:28:13 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] network: remove 'path' from settings_load_pt_ecc
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231214180110.130991-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231214180110.130991-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 12/14/23 12:01, James Prestwood wrote:
> The path argument was used purely for debugging. It can be just as
> informational printing just the SSID of the profile that failed to
> parse the setting without requiring callers allocate a string to
> call the function.
> ---
>   src/network.c | 9 +++------
>   1 file changed, 3 insertions(+), 6 deletions(-)
> 

Applied, thanks.

Regards,
-Denis

