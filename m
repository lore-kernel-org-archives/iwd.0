Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF241EF1A
	for <iwd@lists.linux.dev>; Mon, 15 Apr 2024 21:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713217937; cv=none; b=Z/ssCr8A74J2OdO9xrDNMLBJRHF3nWsHU2uWLitLdWQ2swUXxcBnONhVtp0as16elQuGs5UVe7vCTqwtoxgx0wN0GiC+hy4IG89aH88qKYeUMPKrfCNb643BivgyI9TzrW8Fys2lckYKtAezatwLH8j6Oo+qSI6AXatOrlWd+JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713217937; c=relaxed/simple;
	bh=auZ2iGZD/DyLj6YcGCdDrXKSZVL5rIJ5tqIqlpwPs0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OImnnuP/83mVlDM7AH9Fw711PxP3C2JjIkwN+ixxRJcuOI75MkJNtF7hDJvVxRkRmM8vV5F8pJkGjxGCUejFla4ZdtJRl2O06NYdhLXoyl/2WS20V7oaBJ9r9ArdeamjA1gRk+i2WgSziMEM0zuIWsYj7BWfBG+p/QEtUarEO/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IIHUSlku; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IIHUSlku"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-23333ef4a02so2623976fac.1
        for <iwd@lists.linux.dev>; Mon, 15 Apr 2024 14:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713217935; x=1713822735; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cyGt7TGHQdL1rMCts0j+tNaaGr1Z7yy2Dvra1Ad9be8=;
        b=IIHUSlkuhk4fe4ycx7+d3iIRT+5CFhrCUroEWFjezsha1lJ1sryDzAZy1BmyDrZ59x
         DDF14Zm1Gc+tElGyEcGDNEZn2unkVXuqYJv+9jaYTp9AmxoMB05eoHMJ2SP+iFxMa5bG
         A3EdofNeG/lM+I4D+PPLilkkpX5ut6Vt3Qm+m4yF8ycc4Ww7zsnZ0+2P9r0dvp9ZTkqQ
         srIhtKY/1xTcZsxa7O3B28cDWrV8wDCp9fDCfxhwQBltlT1aw9q6ikTr/FdD9qpdQWrp
         wXdEVENX3ZV1lNBiWFO07lmtwr95FT3FGpFdD2LP4MhFthXKi4gX84bbOf3P6Y0wA0K5
         wrKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713217935; x=1713822735;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cyGt7TGHQdL1rMCts0j+tNaaGr1Z7yy2Dvra1Ad9be8=;
        b=ZFWXgvZpHoPG0bEkG1f9OpEw0dHeLxvpBbvQ4RCGGrCq9Fgakd43s+59KC6iF9iTd7
         DxIv/7cKvGHJCy2PmXz9+iHRP25Gg4VkwJBlrrm2bCfDQBmq+m8F1G2LzitSiqIH91V/
         h3BC9WRMMdOkD4GmxmLilIMEE2bUEO3nxK/TwoZqlguSsFZycRasoi4ziYxp/ma5u5iq
         sHRI8U6+1kOblUBfQkNQNj3WBp0rdGdaHd5YvJRnleimYufUWqkvb/NplGRZ9rDDg9cy
         3tT40DXWiy5JWvNWOobbTS64sXB5bJUhsE/5elwd/q/9JJ+5B6+ythvjr8JeVVAdV4LF
         mQ0g==
X-Forwarded-Encrypted: i=1; AJvYcCUPhcfvP3t4UF3bBg2DVzGbhkwdjRTaZw39OsY68pYJY+BpDyyc2m6uKV0+KAaVNYwnqqun9u13XPsQxh2laR443uCF
X-Gm-Message-State: AOJu0Yysr5b+YZvQ0Exs4C/c/kzbauYxxdruPcbx5p0R77YwyOxqJ19t
	vLZHlUzZtm4SV21maOMTzYbTiaDtGlJnKrvJ4kEwL+eixr7m9RC1tXisOA==
X-Google-Smtp-Source: AGHT+IG5rifhjY2G3BzMNQZoDP5tPlW14Qg3ACgBgMlNrNCARZGZJM3/OwSBL6JqI1Wr+24LHm0V7Q==
X-Received: by 2002:a05:6870:6586:b0:221:9013:d783 with SMTP id fp6-20020a056870658600b002219013d783mr13265856oab.34.1713217934825;
        Mon, 15 Apr 2024 14:52:14 -0700 (PDT)
Received: from [192.168.1.22] ([70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id os8-20020a0568707d0800b0022a142c99a3sm2458414oab.30.2024.04.15.14.52.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 14:52:14 -0700 (PDT)
Message-ID: <43ce8442-b4bd-4d27-b31f-0acbd0db962c@gmail.com>
Date: Mon, 15 Apr 2024 16:52:13 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] wiphy: include MAC of BSS with invalid HE
 capabilities
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240415192948.65857-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240415192948.65857-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 4/15/24 14:29, James Prestwood wrote:
> The prior print was not very descriptive, and now will log the
> MAC of the offending BSS.
> ---
>   src/wiphy.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 

All applied, thanks.

Regards,
-Denis

