Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D506106
	for <iwd@lists.linux.dev>; Tue,  9 Jan 2024 04:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mP4j/YtJ"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3bbd6ea06f5so1226908b6e.1
        for <iwd@lists.linux.dev>; Mon, 08 Jan 2024 20:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704774060; x=1705378860; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oFqF8ap1ldvXz+SGKca8E1RJsJeSJNyJHWjOugTEfus=;
        b=mP4j/YtJI5Yr5eEGW1O9UZFJWZt/t2VbnlhShoDoEicxnE7stxxtYQwWEGlNVs4etJ
         pc405OzZbzzqu5mPDe3TKN71SE6vM12VcBeiNWfoz+Cuhbw/6EzVK3cZByf2gF7/4Ybi
         b35KDvx4hY5VDd8I4cARG5fUG8YowqsQnfqhktvkjGR/iAPeKm5Ol0p/bxV0UU0vGP5Q
         gcZ2jRQmtHlfq0jiC7AcFessn8aBX3Ikqwpd3nC3U44gXk4NFG7j5vNm9lHkn35UOJNd
         OymYtmfNKFTc51mL+ScCiZlGAsjATAnXCs9SVRpZ+bH2RJLNloook4W/Qv7wF7Wzl6lk
         enVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704774060; x=1705378860;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oFqF8ap1ldvXz+SGKca8E1RJsJeSJNyJHWjOugTEfus=;
        b=ZuqGeUSlYcfJLCXDkIJTi8ftuzkskjD90MWaMqkuOV15T74RTcLIGzhCHwVd/A06rb
         yekGUqunY5Z6Qi3etCgj3M+E7wW+hzYj+af2PHyICoW+BbcbQhJmC24DmjJ5ynysnPMk
         yrswMQyjrrSXAZbolr2VY0+kAyvys0E4ahU2CHpisne4IpBW+YeaJRZ4pM2Qdwz5ax4s
         x+OMWT7BXSyblsAzCZKTbwUcmMfySnhorMhTJxz+HDwo3autJ2akCO4uExfxSzk/jEmM
         TVJNnH81Y3oulCNEuX7aNt6c8A9EzXnm4fexuarjjTYjwDTa+7YmdTyy0gU7l1Vq6HYV
         oI/w==
X-Gm-Message-State: AOJu0YzQRsnwt8TVePZogyf0lyHZqHmGbPbLoEQg7rS2aeVY1MIQKIce
	6YC3SVbVbt42td2rbY7vgE8=
X-Google-Smtp-Source: AGHT+IEE/Tv1IlHh1Vr0ctkGqQXodGoS7Qr6xjAyAhibcAAJkOG46QuHzU9vQH2hd3gxlEfEVQD3Pw==
X-Received: by 2002:a05:6808:219c:b0:3bd:252e:1918 with SMTP id be28-20020a056808219c00b003bd252e1918mr66820oib.3.1704774059924;
        Mon, 08 Jan 2024 20:20:59 -0800 (PST)
Received: from [172.16.49.130] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id b1-20020a056808010100b003bd39b8bfcesm207433oie.39.2024.01.08.20.20.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jan 2024 20:20:59 -0800 (PST)
Message-ID: <5dbb6341-edde-4c34-9d7e-36b0067d8931@gmail.com>
Date: Mon, 8 Jan 2024 22:20:58 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] station: add additional internal state,
 STATION_STATE_NETCONFIG
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240105144750.839705-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240105144750.839705-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 1/5/24 08:47, James Prestwood wrote:
> This is still treated as "connecting" from a DBus perspective but
> will allow for better handling internally for some roaming corner
> cases.
> ---
>   src/dpp.c     | 1 +
>   src/station.c | 5 +++++
>   src/station.h | 1 +
>   src/wsc.c     | 1 +
>   4 files changed, 8 insertions(+)
> 

All applied, thanks.

Regards,
-Denis

