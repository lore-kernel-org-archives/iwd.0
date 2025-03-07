Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C683321D3CC
	for <iwd@lists.linux.dev>; Fri,  7 Mar 2025 16:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741364986; cv=none; b=uV5lGlDkK9+GbLKnZlWIJzUgz6odEXp1poVzRyMEG1HfXsNSvBFwrOOpTHuhDXYbMYgjEdm2OXNPY3YVVJbVRLtKxc6BkpBXu08kYEAM2YJlOEfdv1aEIo/Ri54c1lSXew+4xr1FGHmSFuSuhQKTtZGzWB5YhUhKLNZbmqwDjy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741364986; c=relaxed/simple;
	bh=4u6bgADV+LUqVjida7OGY9ciV01UEjr4DqD7Qurgczg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hpA6OgKyA+LewQ1LVYs2yHmuWZjRgRd+g5kRhvWlLZN+i/BFVxVTqNEKwlPewWO1gib6rvwJVllAx3cB2cxZLqqIKdUUtpqcsV5sXDX3ggpuUdGHCq2vuJMsuDbQEZUBKi+n+qzdAH8LmlBmfcznVhB3xuMqAo21ljJo1VP6Q6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FHdumiGK; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHdumiGK"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2c1c9b7bd9aso859068fac.0
        for <iwd@lists.linux.dev>; Fri, 07 Mar 2025 08:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741364984; x=1741969784; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8/zkvmMmeSEHkKQPuge2eBOWMD51h0/xSOwmXiN/eEA=;
        b=FHdumiGKIQE/CRa2DNiejmwafo3xOM9ktzNlGotMTlaA8OMOKyT9QnbHU3tMI84+PE
         LSZq/kcxbZRnzB/3qkT8goSo8dCEygmPtf34pJJ7a4q04xr5IBH5D6CKY67zz60d4sZa
         ZM0JCdqOaGAXxaRHQa8oVmyEeFbYvpAQJokjL1b0C2S3CmBmeWD20/OJkNQ9sf8OULcY
         GGSFa1N+veP9jPLFY4nNxVyq/btJ48jbw3lQ3RrM9BF11DD36BJYVJL8q7f2foPcUz0l
         O4SdDqSfDNAdiNmbjQnWLX8IIFU6ofnX37gjqvWyqQZuCa6RJH6HI3+8mcqD7hZl/HA5
         t0EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741364984; x=1741969784;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8/zkvmMmeSEHkKQPuge2eBOWMD51h0/xSOwmXiN/eEA=;
        b=pFu38FufZYmcGQv/2PAd8W9x5pGPVsA7GTbdF8X57CGrmhybfBT7khCo5vAxuDFgo3
         bZma8YEWDFMJsOvpzKSwduT2Z4sZfhalzmYXrlZSVSzG2MTImefbpIuy9b5oMMqbXiRK
         j3t9T2j1K4excapchz8R+r523u7/qjHmQbkP2wT+LsqX4kpQmVF8yXCc29r/M3kkydz2
         AsldIsOVpw/Q+RVe8cN66QgnoTT62jHluCnMBcVXw5WfReD9tQHei9DWz1s5zO5bcvXY
         lgdFAzpYNTf26hg0aUgI0qjQe4GgeT4sadi5d73wnuyR+4gg+b1EXTo79kwPOQxCaT+1
         QjCA==
X-Forwarded-Encrypted: i=1; AJvYcCXdXIjFOZ59ULjvnSuCXeff6nULPJp4jrkdLu/PXpmhlCLO3dWT0TNcrJbX4nkMe3x8Wi4=@lists.linux.dev
X-Gm-Message-State: AOJu0YyRA1fzjYcp/eYwHxliVoaW4QeM9o0/+du12FxYTbEPoG+vIIaJ
	ZK7LxFzspnESTmgIoj729sXaR1EO+SYX93pp0EBi8gejTsNzpvbR
X-Gm-Gg: ASbGnctUcQl0dCJcCK+3SOrOM70Lz476OQHgsgr8FuLeVVXXfEaI235on5s1AXC8HvH
	+ZCajb7DB2fH15L9MQ7rbEcNulayYc6ei9jnKsCrqcx44T0n+ShI/2AhkbDNINCyBD4MCpb86GK
	TSIGlNqyDUu4hdwH68FC9bWXjAMavtsO63issYBeHTIedbYWGK4n646FXbkHZi2Dk+7shJVLkFB
	tIXQwMht48AxWDUH7R66xrXVyMcLj9I+XSqd6Ji4Dopav+Rb2SnxDul//7cdlAjaiWhrae3PZI2
	y948XpX/Y1h7EqHJsWZM9q6D+3+CrqHm8UgGbmQM9hoDzqPfpUWiTQIfXx9XtI5Ra01HA7eyAuL
	ZN6J4JVc2/g==
X-Google-Smtp-Source: AGHT+IE297ucsh4DtYLts5mpv8CmKiNMCb+HlM+y9nskWe5Wl7/NcooRFnoIXXh6KldfHoS6tYdlug==
X-Received: by 2002:a05:6871:530d:b0:2b8:3c87:b491 with SMTP id 586e51a60fabf-2c2614313e3mr2310945fac.26.1741364983643;
        Fri, 07 Mar 2025 08:29:43 -0800 (PST)
Received: from [192.168.1.25] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-2c248d5acfesm733102fac.33.2025.03.07.08.29.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 08:29:42 -0800 (PST)
Message-ID: <530dbc5d-d49f-4508-9bcd-24dd4dbf6e49@gmail.com>
Date: Fri, 7 Mar 2025 10:29:41 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] auto-t: update scapy imports for newer version
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20250306185528.365677-1-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20250306185528.365677-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 3/6/25 12:55 PM, James Prestwood wrote:
> Something changed between scapy versions and now the modules
> being imported don't exist.
> ---
>   autotests/testFrameFuzzing/fake_ap.py |  6 +++++-
>   autotests/util/hwsim.py               | 17 +++++++++++++----
>   2 files changed, 18 insertions(+), 5 deletions(-)
> 

Applied, thanks.

Regards,
-Denis
