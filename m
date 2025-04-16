Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69220225413
	for <iwd@lists.linux.dev>; Wed, 16 Apr 2025 19:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744833512; cv=none; b=e5S2RqHolVXTPURENkM1FOmC4WfEAb9/niJViGLh/ywb/Nlq3v1QCAzJy53x4QFiLYp4gPIqVBasbT+SvZzrm12pLG12qWst2q2WV+DkFMcKlfF/JMbBgAFEKnpfRmC/3qtxG3Ld3epteNz3+eoeBkYR4XA1NqI3dwdLrAxxgtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744833512; c=relaxed/simple;
	bh=X089IarCrtiwnmKrAG67Jo21po0oz6xh+vQK+Hv++9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LQ3QyVZRxJV0XkptqvTYGwVdwZjqKup0gqQC7bZe32zHzqZmYzYr2nvXjUpXpFO0/ntiAjQ6KF8kIzpOZtkjSeIQ/s+nqTg4eRUBdHiBf7b0lwd2KizDiDsrgOtf7RVvwlKMKGRKDiDIf18cP/U/KFtqEiqRQoRmjnIXEOUON7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d0ZPFkYZ; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0ZPFkYZ"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-603ff8e915aso2058512eaf.3
        for <iwd@lists.linux.dev>; Wed, 16 Apr 2025 12:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744833510; x=1745438310; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UwKNxpT0Mmu+9XFaW5N+jNcPz3fMMEraTmXeowp3kDg=;
        b=d0ZPFkYZ8hvIGXww3WCVrnSCNPP7/j7fUbrSBa1cl9J1Jwztld8aFPk/NiPuEQLrpr
         10hsTJCHry2I0F9oaJ3xhzpB27mVELXla+z+xmpjJUVhjY9r5a804eKvafxfmUjAo6vQ
         raycFSlpWxTosaoehORVyfCkQlh9YBm6tIwVHPuAodr3BdX8rUaDkEvVAQb5Cgq1ifsM
         SzpjsgqASC9LY1ePMumCtVLlpqFrTSvWK4ifaJJHQBSOTRZAzGInUtFUsLIp0Fg+7AKQ
         vmgee0C9CwwySNhRLwA/Pa2ctxJoUTTGxaM8Xyk+w9BweGlNMRaJKjKIHTx+mP5BNGh/
         iuFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744833510; x=1745438310;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UwKNxpT0Mmu+9XFaW5N+jNcPz3fMMEraTmXeowp3kDg=;
        b=K4qZsOwu93hDlOjvkk4YIn9xfyLuwwZWLsd8KHbs2bMSH7Ga5uo5JpRVrUZqt8CXd0
         yOQSmGwN/1NoqHVGqXPdKOVuqeYc0XH3/cMGZcQ8pgBo2f6x8O8tfhZSrKawf2u6Mxub
         q9bTpO5SglXOOrmjI9X07CWc4WnV/uLUKKoIuwcGuKSjh8A/YpZr+gDEbJT3I4Ev1QG3
         w3saD+VFKTmAxelM9jFxPKpXw4NrV66lgk6FBviWMUER5O6jr0w7PcPC1gLz2B6CHA8z
         mWFiGAEZnaOhnk9LnsR2uEgKMlPjc8+6Hlp8wDdcqHNWGAaDa2HNDqbzIhkoIlKsNndn
         qT+A==
X-Forwarded-Encrypted: i=1; AJvYcCV0mGcxenohsWduRoFUeQpvonQi5zOacpuNA0WcDoVAd7eFdJWm48JQBdfhDEb9zX/vLrY=@lists.linux.dev
X-Gm-Message-State: AOJu0YwYm1va55owwxicNXozIGZZJxTiYnP0buEh07FjdJX3QyhkD7yQ
	+P1c/ncd2nKbeXUUv5NtsBUkSghWlYzsaJ82r8L+DXYSWXlIc2UK8nUOXA==
X-Gm-Gg: ASbGnctM07h0ycgMQeDgEnjXk9GWPSdR9ITMDqxPee3fFZ0XV+et6H5LzVm1siGCsYx
	bE7FjWjT0dRB09JBYiNSnlo8iWT9iserOclbl1HNjj84Q69AoXJF1EXvTShM4fLlLrD52ZinTxP
	9ykpjeKCU4lzxnKlsTHucT4O6GJiuOaKmGrX0MlhIllqZm9dmM596VgP6mJQnrAhg/J010OeENr
	eNHqe8j7ovOlP9Plk92THYrPkv/+MnnQz880xyI4E3uvKGTsQS4bMMNF9BGuQPdvAbkLZ83GPeu
	+pSGb0D52bpYuJUT3QEs0Wv8ThndDNnb8pqnz2Fw/RqT/zninsl4LxwcaM3LS8PoRAMotRtkhDg
	sy2y12Q==
X-Google-Smtp-Source: AGHT+IF8llQPWg/g3RxItgL1LZPg6skscOUUJbmtOs3SzD92rZHGnZRDTMBfQ/9E1qtU2oW9H+gzcw==
X-Received: by 2002:a4a:e911:0:b0:604:4846:78a with SMTP id 006d021491bc7-604a90d7397mr1820086eaf.2.1744833510368;
        Wed, 16 Apr 2025 12:58:30 -0700 (PDT)
Received: from [192.168.1.25] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-604a5c4bd5csm475620eaf.30.2025.04.16.12.58.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 12:58:29 -0700 (PDT)
Message-ID: <39d7cd94-9836-4610-8b10-e3936ae495f5@gmail.com>
Date: Wed, 16 Apr 2025 14:58:28 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/9] monitor: fix spelling Exausted -> Exhausted
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20250416173345.136025-1-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20250416173345.136025-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 4/16/25 12:33 PM, James Prestwood wrote:
> Caught by codespell
> 
> Fixes: 83a24575 ("monitor: add support for limiting PCAP size/count")
> ---
>   monitor/nlmon.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

All applied, thanks.

Regards,
-Denis
