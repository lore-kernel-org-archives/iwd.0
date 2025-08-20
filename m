Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49ACD32275C
	for <iwd@lists.linux.dev>; Wed, 20 Aug 2025 16:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755706817; cv=none; b=aoCKpyqo0a/59x1lhjPeGDYCpTbeydXagD1j7HyVj+N4WFpNWXficQjdDietnlX0qkImfktaBkvVeN24z8XAFu0oN6LnprG0vneSst/8Rv89YPJQaJgfp59Ohv5GqIOCAuJ7SEqbJQ36FmgIeq6YVLhI790FpKxdcLshJAbkCx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755706817; c=relaxed/simple;
	bh=gL67sHEGhjPMav1OMdECVo+v2HaO/4DlrUx4vXwOTXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QO9c1KaIuw7EXSNKvwliSRGlh38IbuaBWE6V1oYFDpvDjgcOMlig/ztK1EfPjYwa0C6BjiSZrSPPJDn5bX8BU3wcLLDJf99BGUdrpy4E8TcADvgWzfh43tBiEuMeEDDa+k8BPU3F13W0F0KfrKjqYazcqMZTJsqEuP/Qy1Nb4l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dyxfkJnu; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dyxfkJnu"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-30cce83fb5fso85836fac.1
        for <iwd@lists.linux.dev>; Wed, 20 Aug 2025 09:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755706815; x=1756311615; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kDSxkrijfCWDJoY0/gci6b0A8pGGiKRG85YLX4eRAQY=;
        b=dyxfkJnu6N696nzGx6BDlFL9PZ8UXkZtB+UfTSy6wWjtXg9hYndqVx65XAKWQYLOkL
         yXJGgABLllRPU5kbwoCXJQYRGx5wLMuNZ63xBtzSPPT41WHpDbPNBZSjjVdGVsm/SFYV
         3eQ1eNtSFOcFI7111dJvj7deUeytotgnTu4ZUiRAE5+Ke34Q+wB9ak6SpST8GD3WdQlY
         wcAKhbV9BhHT3U5m8pta9BIls+vWFCTR6yMhbf+qQcRyJ9UwPO1nUfyMKFxrbBWAI0pl
         Bd7mSKPRncgeI2FNmALt0eZzzwwHxcUl+4Mk8YWv7TOhmz36WGZQ3foEqtVqI6gUrfcU
         A5zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755706815; x=1756311615;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kDSxkrijfCWDJoY0/gci6b0A8pGGiKRG85YLX4eRAQY=;
        b=rsaqSgDuimw8cM3S4m3UaRnLLJjd00Zd7JyZKPsLEFSQRBSEE7zGQOcZHDHXOozTNw
         fbfCgz4h/RaCftsEcZVdy5rhvsT9+WohD30+gTuVszltXjUHluzMBd8syF16gnodUiXx
         G+q2oW7XS12gD+yON5PrwmGSZCVXlT9rH+z5xpN3CCFY5I98aqVzLsqQXjV+5ELPIjxV
         b3qP/YObvAAq95qsuWsOvpseJ4lkZhxDz6W3OOiHzgO4I7SvV2qdtyMtCENDCXUoCmsP
         WTPVj9B1V3sThif/eNN7e1bm2eWhLNGQ2QX4USuA3imeLGC+GFfN/uaTHJddgZncwT9O
         reNg==
X-Forwarded-Encrypted: i=1; AJvYcCVVmZdC3hTZR9uBMvJyP/UCrMOFZxhlPv7zviAm2dlE6c+MFzYfUTJ6FzXUneeAlIQ8wZI=@lists.linux.dev
X-Gm-Message-State: AOJu0YzwJbnC00ud43EE0VaJ6PPmiVaFepHuT67haXPre4Sps+gJM9np
	YtGVdxkvgLvo20O5nk7TffIhefWeJPnVnHlaHZ9QX4aYftkSozl0h50u
X-Gm-Gg: ASbGncuvzb8CvQ37NpjQjg5C3MQ/yYh5iskopoUJ/Vbom2p/gio0x2vFZBWTXcAxMr8
	WATCiIKg60BnkQZJ9v4lCOEIjPRixcutGLw5++yaN6u4qhnviHrV30t4oTtUU/hJX34DZ9Mx/LL
	5mU0FViH+BZL04Nr/eIl801BVAWu8yiK+z2FJqllqEBaqtJOrqeSSXxdYTpa4MM6zwWDA0Ox7O8
	unkLWLoGtVhVWD5RATVjYhV2iPO8nLD/jxNFbIcGIG+47C+aFE7bVFjzCXjXzo0XKQJtTfUARuD
	ABH68RcrMc3eFepV0uxDFYoUH7rIAqUI9WWREoSR0+7XHx/uNnTmsCjnI2KIjpYFbr+i7onijoa
	7KELy5pcNqw7gT7OZ9L6Bv88uEjNkUIrsJdOWAqpRplDEJikuVrLiufZMD8QAC3fmJoLLXtRoFl
	8=
X-Google-Smtp-Source: AGHT+IHlq/OoQ5KMMelaXDRUkBrJLPQktrSkWMTA4WOuOfQlV9a/1e2dWuPUGHg4Hr1rWrQhxmGDmQ==
X-Received: by 2002:a05:6870:e070:b0:30b:aeca:d9b1 with SMTP id 586e51a60fabf-31122a56200mr1877024fac.38.1755706815045;
        Wed, 20 Aug 2025 09:20:15 -0700 (PDT)
Received: from [172.16.49.130] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-310abbb405asm4307373fac.30.2025.08.20.09.20.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Aug 2025 09:20:14 -0700 (PDT)
Message-ID: <efd97b52-0b85-4429-8760-01ae21b5d04f@gmail.com>
Date: Wed, 20 Aug 2025 11:20:13 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] netdev: check connected in channel switch event
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20250818143041.283887-1-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20250818143041.283887-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 8/18/25 9:30 AM, James Prestwood wrote:
> In an ideal world userspace should never be getting a channel switch
> event unless connected to an AP, but alas this has been seen at least
> with ath10k hardware. This causes IWD to crash since the logic
> assumes netdev->handshake is set.
> ---
>   src/netdev.c | 3 +++
>   1 file changed, 3 insertions(+)
> 

All applied, thanks.

Regards,
-Denis
