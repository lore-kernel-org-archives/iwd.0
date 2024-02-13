Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C391634EB
	for <iwd@lists.linux.dev>; Tue, 13 Feb 2024 23:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707865762; cv=none; b=DDGdgOAz8FIj8LWmauB9riIHhbczbtDyhR9j1MbwztkFu5t2TnLKpPUy6l2cb0qyRb5MOAZUjCMQZCi/l4MJ6BPoaU1mLat0bwRibw4Mpc/JLPDJgpI8UbVz6zb9kGxWcUYi6fVeXggYbfz/yFV7Bz+Ndt2bOdQzvrmzN/WddU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707865762; c=relaxed/simple;
	bh=bry0Rrxd+WY4Xz0ZfjEEirW4Ow4J9GmOfHrvZQ76fys=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YnRWnc1fs7eUDIR4Sk86hUXWQUHppeD+qjbk8pDwLxVi39A7uqDmNVY4D5XBPtTxqB8FEocljWc/2Dfi4l6gqo4mhA21P48dZ9deeMICNi7ZiRQnSLieZHNDnWCO1E/41PtMgUYYC8aOuyGvUoBVVaEr7mTTTBP3PJtgOrElOcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e/ar47tE; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/ar47tE"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-216f774c827so2335094fac.2
        for <iwd@lists.linux.dev>; Tue, 13 Feb 2024 15:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707865760; x=1708470560; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YX97XQ9ig2HC94q3Kg8YQIDV+yDSzm1pA6BLyVae4ic=;
        b=e/ar47tE3oLUtxtYxgMoteMJwDK0VD/qhEuYp6x83M0N/Fz8gN84r0OVpUUrf9QPb5
         pE9/pKpUF9mA4JAJr2td9XPx6178FgJkZCwCj/sxtN9VmmoSNHiATHSKkTo7zA70caZf
         u3rFv02fuJz+8p6u5Ub79iZbp7h3IIGNyzJ9D3S4cUML0rfmAnzB0+9P1POHgasjOO6Q
         z82/RQhExeo1QXJf46lkHBLO8eFf7qAK6HYkNZgXeGNXQ1X9Jx+JE5TOIYzPt6Sq4kPC
         I1c/bZxxGrjacd0MQa/1fJNUTfuBVddLsfvKuk2nrymkHm30ZH1bVadnsYB3f5etvG94
         u9bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707865760; x=1708470560;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YX97XQ9ig2HC94q3Kg8YQIDV+yDSzm1pA6BLyVae4ic=;
        b=V7jqiItZqLaQ0PywShynxpzBzFWbAQHBWGlvK17JLkqd8wer1jzp5n6Yl4V2kONgLo
         LO81iACmUGiEhDGT/cMTfZeLC+Ks6UohF8NnxkiTGWNEhq8ryPYcOa8O+yo2rP2IFnKp
         RZpS8CCFSex9wuvtVsd+pP+/b8aR1j7VuQAFjnzz8QwDINX+Gqyi21N2vK/xruRU1vz7
         HEWvk1qeglEnMBUgfYM5+kcCxnKD7x/TGsuneWMIRY09y0Cm3U9zEYemYVobfgxOrIAH
         w5ciJgnIkKK4j/TLL33KgBZN3grGvB5vg4KmzUnpZgvU+WK8vK1IJKNRuLf7LrSms61T
         n9nA==
X-Forwarded-Encrypted: i=1; AJvYcCU3Bah38Od7lcnduQ4XRurzCH3HoBJ3Uk6RGBh+BkVBh0OtOUyt0EYUkF2v8skErpwEVGmRH2sct1MVcmwov3QKnMRA
X-Gm-Message-State: AOJu0YyAzsJtaU3kvZXDlPcnLQHFujmA3qwjUiKmFbQmFMEhoXjaBcVA
	C3CltQXU2vxaBrImRoms8r+W0CnnC6TGBCAapvMwnkL9wfnKmZcwMGFzWOqk
X-Google-Smtp-Source: AGHT+IHFzL1cfG17tn5vy+9TaTS3u+ElD7mUxyxrE7rtXP1eg5YpBRYm7EkX+t/nd3Ew6/xh8hcejg==
X-Received: by 2002:a05:6870:ed8a:b0:219:7746:d886 with SMTP id fz10-20020a056870ed8a00b002197746d886mr1004236oab.36.1707865760069;
        Tue, 13 Feb 2024 15:09:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXNniGozdcSL9T1auNjZe88OykrO/ytqfdybOHN+rs8hibSUJ8TDSpDvyk/vtRUilbSlwQWL/5sDBR3XtTLPIfFjSax
Received: from [172.16.49.130] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id nw14-20020a056870bb0e00b002199829a00fsm2064870oab.27.2024.02.13.15.09.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 15:09:19 -0800 (PST)
Message-ID: <8b02ff06-9c2b-4503-8fb8-9784c2628394@gmail.com>
Date: Tue, 13 Feb 2024 17:09:19 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wiphy: include libgen.h to fix implicit def. with musl
 libc
Content-Language: en-US
To: Clayton Craft <clayton@craftyguy.net>, iwd@lists.linux.dev
References: <20240212184747.30422-1-clayton@craftyguy.net>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240212184747.30422-1-clayton@craftyguy.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Clayton,

On 2/12/24 12:47, Clayton Craft wrote:
> This fixes a runtime segfault with musl libc and GCC13. musl dropped a
> basename prototype[1] in string.h, causing GCC to define it implicitly
> with the wrong function signature. The correct basename definition based
> on how wiphy uses it is in libgen.h.

Hmm, why did musl do that?  man 3 basename indicates that the libgen.h version 
implementation is free to scratch in the input argument, while the string.h one 
doesn't.

In this particular case it doesn't matter since driver_path is never used again. 
  Still, the string.h version is much more intuitive.

Maybe this should be re-implemented in missing.h or ell (say l_file_basename or 
l_dir_basename) instead?

> 
> For context, see:
> https://gitlab.alpinelinux.org/alpine/aports/-/issues/15622
> 
> 1. https://git.musl-libc.org/cgit/musl/commit/?id=725e17ed6dff4d0cd22487bb64470881e86a92e7
> ---
>   src/wiphy.c | 1 +
>   1 file changed, 1 insertion(+)
> 

Regards,
-Denis
