Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C93617EB87
	for <iwd@lists.linux.dev>; Tue, 14 May 2024 15:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715700785; cv=none; b=RVyDOhEixuTBPCgwLheunyMKit/8CzZ3PzUHwjMBHMC7LjxHmwYUE4HSUcDI9bGjWI2CkpDeqTN0v8khZIM6gtq89tvP/rpjGxcU3kdniGHbhwBl6lc8STwXMi3Gz3YM81bT7ccnjZSmaxvCZMD3NkdW4WbLXgCDXNdFxowcBek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715700785; c=relaxed/simple;
	bh=pUyehukKzjlUhjWDhfwDUiKVCt5wU5dmPWOZY0G791s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=K32sy1NFkNlCRVHbOwLdxJ0Y3L1Pt3uYJcUwPPD1pgBhygB5K/vbh2qpRs0w/LF1AsVJpMBHgy0lc1+tCf2QE/cpoGFet5ggLkCJp999gsOL/ff6DqVLVIlVHRTQegWUuJRbzPQxT7YufWGVirpVSQO3Z6qJ6Ovgl+5Y+t2Yzt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e1rr+YzA; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1rr+YzA"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6f120ae1ca3so49022a34.1
        for <iwd@lists.linux.dev>; Tue, 14 May 2024 08:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715700783; x=1716305583; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4E2niCYSnZJtxZf3Gc9eeXEdiA654R+MZ8OoILmgeC4=;
        b=e1rr+YzAWFTNQ1jrI6v37c1t3f+v5Q//Kl1YCvWs5fb+0oWQyxBGZ9x0OB3SpGruai
         3Uzt5ziLE3PmvyPz4Fg2BYcxG6Us8YrVahbw7MjGklI/9GDyWnbWfxIYXXrQdjGrqIf/
         /0gyFI+gy2OsSKumv+kIyrQ3uC0o7iFyov/U/3tfrfo6OqkkPIw9SAPdXxtyJujvjKCF
         Jp59YP4Z+zDmpJ8ArF9cUKD86J8O1gsCmT0CzRClOkZT0prHOItN0cMLOOb1yN5WWtIY
         kulbazfbWmGIad5IjE6h3UEofhaTpxnyDNRtDPXpu3ql8nc8YJKK3oF+PaztjfBk+WN9
         r38A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715700783; x=1716305583;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4E2niCYSnZJtxZf3Gc9eeXEdiA654R+MZ8OoILmgeC4=;
        b=fAmzBPoqI7aE20ow0c+4xmmd2gquhGIFeSlkP6VZIi8DdKyZ0Yh97UjSBZvSB4kBEm
         dopFGmLJEq4EJh1nGX7DoviliibXLNS8H9nTnIWiDNtR1KVjW+zJKtZWjjV3t1dPuI6G
         yRp0LKMOa2SMUaIVQA/uDPi512JI++0WQ1pHji5jUbf3EfZmCX6OSatnqtmOdwgXWVAB
         9xegxg4MHo/73syLvL9SGgI1nUiDcHGAAXuqPBkNPIs+yIeUvSUNVq9imfC2jAgoS2V2
         IwAnOauZAjSOXT5nSfEFJ/ydHZ1NpeLRar1P3GYXMbhFrGmv2x1TZ++E+2D81aMIKakY
         fVXw==
X-Forwarded-Encrypted: i=1; AJvYcCVuFfbJoaO5jLgLPtc84XRuGZdtm0uI4GhMFFgs330cF6db/BYNa7VMHtMErWl9A23Fktu1XRq1Ymypp6LVPkFsaRA0
X-Gm-Message-State: AOJu0YyCgNgQVHSP2I+SAuaUrft79DP/+2/BXRsHgKkArxwVyzDlWTAt
	itxjXHzjoTJb4U8vqw0J7qMdaowyFDujYZIsxpWowAdY9c3mhi6ZVJQPjg==
X-Google-Smtp-Source: AGHT+IGTk2N7WcePAKJ+HpAkRRuBBg05APSe3lA5zcaKcaZboXUQU/+q10DgmNMkmlFu0v57HlaC9g==
X-Received: by 2002:a9d:7b45:0:b0:6ef:9d2b:2be1 with SMTP id 46e09a7af769-6f0e90f48d6mr15962085a34.3.1715700783681;
        Tue, 14 May 2024 08:33:03 -0700 (PDT)
Received: from [192.168.1.21] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-6f0e5e454basm1799803a34.25.2024.05.14.08.33.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 May 2024 08:33:03 -0700 (PDT)
Message-ID: <0bbc2b1b-2d34-4563-a1a7-d1e16789e25a@gmail.com>
Date: Tue, 14 May 2024 10:33:02 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] band: support band lookup fallback for buggy APs
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240514141923.291148-1-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240514141923.291148-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 5/14/24 9:19 AM, James Prestwood wrote:
> Its been seen that some vendors incorrectly set the 3rd byte of the
> country code which causes the band lookup to fail with the provided
> operating class. This isn't compliant with the spec, but its been
> seen out in the wild and it causes IWD to behave poorly, specifically
> with roaming since it cannot parse neighbor reports. This then
> requires IWD to do a full scan on each roam.
> 
> Instead of a hard rejection, IWD can instead attempt to determine
> the band by ignoring that 3rd byte and only use the alpha2 string.
> This makes IWD slightly less strict but at the advantage of not being
> crippled when exposed to poor AP configurations.
> ---
>   src/band.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 55 insertions(+), 3 deletions(-)
> 

Both applied, thanks.

Regards,
-Denis

