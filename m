Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A0B25D55C
	for <iwd@lists.linux.dev>; Tue,  4 Mar 2025 14:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741099476; cv=none; b=aJWBNiV41Xd8ndO/FyTcwCWevNnEywfUt3/e3GAAWIuJKA9e/gLeFNRxh2qJq6Ysjel9Dtgzmq79lXZqdwJEkI2ZlwWwlqz6yCFSHl/PMDiljQSwTabDfCMAfcY+zoOKAYyQ8rfDW7yk5/borWa1oqAfdBmKv9dSyZFqLj1DL7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741099476; c=relaxed/simple;
	bh=NjiMXUP66elQuW53Cu+Ca9Z1m5IAkGKQUW56YlXaFZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=i1L7T8W/6YmvPH7fuZTX9saVYxB8bKLon6zeXy4YIkuT2QC+WpABhN8+YANz0ZJMINEA8Qg8IqBAXVfl8l+5Z8rFKV6+eIo770/sGUydJlVsROXGfdcXLGgQ6c6alF+APGPUxMIdTXPLaI0NYaRDPTXhZ2PEjwOSKH4ruQiQIDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lAmX5SVw; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lAmX5SVw"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2c1c6547072so1232264fac.0
        for <iwd@lists.linux.dev>; Tue, 04 Mar 2025 06:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741099473; x=1741704273; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fbCXI+6AI6Z654EWDj3OWZT2ZY1myYSCmAk/0tusxzA=;
        b=lAmX5SVw9eDCFVVnUrze79Jux3+TDtexhoBeZXJIfcd20EdJHouzdgbn/5f4bkFPjk
         vj5u3e/FpwL70fCWj/vQohN86KS8Nsfek9mUsw2swbyRYNp/GDzQS+dGHaDDTz7qap1v
         DhxfC8EYLZcEIiFtzeyiniampYfk0mzPdckT7GwQnUt0po/lvwom/mbYxxRUOmsrCvB+
         DaYR5tlry/H0vo+uOmQoWKLvXEJZqud1jX18GF5oYrWgUfiYOsclfVlaGlZHvdl7jGlF
         gR7i+0MiZNorxJBORXk7SAlosdCMiDgjSPRYHSuB9r3kzSMZRjdlLo7Y7RjdGTZhe2Nu
         5PAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741099473; x=1741704273;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fbCXI+6AI6Z654EWDj3OWZT2ZY1myYSCmAk/0tusxzA=;
        b=vnLc96P17qHVdBSN4nY6BXkPA+eM/LRixsmtxg6D/Cvko17lOJaUqFG3HbbUAWpVN3
         YxFOZaCb03/ccxSURrUilebTJdFrtBOzHOtajGyLshDJO9mtYqRHcoz8Z68L9LlIXpz8
         PAZZG80IBGUoekry5V2UMnpyZit1xSHZZrSHogVL/mMqT6+tSxewixP2/iB48AbFfuQ9
         jFpfVHtwVEmKodzGXS8gShJ4Mnjcs1anYVJoNd85cgCO98F7SjXSuWvS4rDrQfWV2lPM
         CPYUQvojfBZsoQ9fXOgZqmYRokQEEfJBw77Gu8xtKoQmEaa2/Jl2z9Tg4uHpjWka38gY
         BNUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJvvT+S0lyRl4Z19YH/k3dos6vf9PK//pnh/S269znY2VvqStmF84xaBpd9XZNHAbP7Xk=@lists.linux.dev
X-Gm-Message-State: AOJu0YzJ/ku0L2/QWjwuByQmq8/peUsQbg5Qpdm03MndcG+mem5nDc8O
	5/1zhlR9iVaAe1o/s8ZSVd8v/bwczmqn/oYn+SqO5ONTXue8bq6Y
X-Gm-Gg: ASbGncvFg23scK5u7NeM/5cJI7ImQgV0lfGvHZnPKHbi2jUzoOeWC6lsVtXOvhHHDP3
	gdRUvsFw4PMFSKKIxLu0kA3pij1ebacgCFDrySU1oFlrUYeIthFhxev1qL8/BwgFPLitmY0NlHm
	qxH+Yan46P9GKD8DqbIV0s4K8mqoa/q9K+N3PTP7MLIT0RqReCuHODFp9Cm0mgM8q3zFd28I45M
	QPeQceRqkv+tn3xFxHQIfGS96bVwuXxRsxu50JrwupKeZ72qY4MrIFACpuCBZNMLG7/HJ3aA/87
	+f12qwzqyDMfSE5oTy8e61qA3xTayzRhBx3zb84bRnCuxwdTa14s2Ku6ndy1K+M1J2xBI3llXd7
	Req3QO3MfSA==
X-Google-Smtp-Source: AGHT+IGaBgMvPoQ1OmyJp6lwchzpoISqWd9oZV20Ckej8mrwW6PedYiUdnkNQwRP6fusylsb/QXvjw==
X-Received: by 2002:a05:6871:440e:b0:27b:55af:ca2b with SMTP id 586e51a60fabf-2c1783baabamr10723206fac.11.1741099473659;
        Tue, 04 Mar 2025 06:44:33 -0800 (PST)
Received: from [192.168.1.25] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-728afd76d9esm2134892a34.48.2025.03.04.06.44.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 06:44:33 -0800 (PST)
Message-ID: <82f2c314-0ef3-45ee-a7bc-3c371010ccc3@gmail.com>
Date: Tue, 4 Mar 2025 08:44:32 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: document how to disable blacklisting
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20250227152407.162387-1-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20250227152407.162387-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 2/27/25 9:24 AM, James Prestwood wrote:
> ---
>   src/iwd.config.rst | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 

Applied, thanks.

Regards,
-Denis
