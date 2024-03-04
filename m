Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E34C612E2
	for <iwd@lists.linux.dev>; Mon,  4 Mar 2024 17:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709574344; cv=none; b=iLPAhps6cB0z0IcYRnxmTiaf3FO6mxS8roTcEtKcJV9u0a75cqezRxIVBzhBJh57VyNEzRB1Rk0uar71WWaTznxb4gj+ylUl2mqEmhKTtlp/osFl8yTgrRz4rcBrE16BnrcYoJvZPCu4GBmIzYArg9G/f+Pj7/Wlm6fdwRvEhyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709574344; c=relaxed/simple;
	bh=zCVJ4v/pypRXPqJ/Rgd+Patyq2XIn8J9rqbeEaZiRng=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Nfj9uqsU3lVORwmh9L6JMfrGo35aJBlulgXWTVvh8H7nWXc5DKm2DJkIcL1Zot4wXR0hPCt0uyKj+ViwlOWw8/+ulj8vPFi4gsdfBuml1Y696vghm9wfUsDEn2F71AA6WuLQaw1pyPOzv0tWXbhVjzZeOK2euv5LYFsrC6brFCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VkXJaTgv; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VkXJaTgv"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3c1e80e447dso910542b6e.0
        for <iwd@lists.linux.dev>; Mon, 04 Mar 2024 09:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709574340; x=1710179140; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dEbpwNlzM6nzkFQivfXnTHpbvy3mePkfS9b/hiFl3Og=;
        b=VkXJaTgv8RHctu+huMnUz3TPP7d6a0toqXHzCBmu0barhKapsTfLdEK+ePGwRnkyvF
         Z4JG61KNi8iu3VfZi7mFEVWKRBRFf3kbUYlOXkXiaJsoESk8Uv2uZRJZo2iLPsX2qI+D
         UTPLePhbmanhv+UaW+IVMrwUB4YaoY6B0X7IjL5APy+pwz1+hBlXuIWaATzstXorykei
         wo1qmpTcdHa69yI6cOZpXDNu/QER5wlZC7mf+HI0AnebFdYPG8kl2AAI2YMgsPpmLtVz
         96Yk9r0+Wc7P5TsNplsA8x4Ka1FM6Mcn7eywLYYGodJ+ioHa3Jgu5fjZYu9QLJzWMVJM
         KqgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709574340; x=1710179140;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dEbpwNlzM6nzkFQivfXnTHpbvy3mePkfS9b/hiFl3Og=;
        b=MwfsRdrRKKjNHYn5el4FxLx0KxGfgNa+IW5N417WWdb6DjBwsTI5THKyPoch/I/dX+
         b2hrgnXIhA9WjdubVyn+NUUqmYSQHWViLWUguKR6pqFxryt/C/1dSCUGAOQ6XRwyuU4j
         ZlTN2O5Z2EA6xEuPL8lJZuGsZJC37lap/dtB7/ZZhcZ0FlKpdm23abTz5Lz2rPM+D+F+
         xqTLaezpIbT92bHk1EJVI/5z2juzBkT7h1CHu4/VlFDz1I/hwCRKV7eH8y3XyicNflVM
         omxYqiJEWHIigREH/C3Er7tjEiAM84z6IrsXSbTi+p58G+EN7MzVGhu2LmY19Z09Z+ly
         QJCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBbB8aGKWmAlot4l6TTI78LrP3veVEoquAWA/bbWWJzCRA2Wi655M0XsgHJLyYW5R5FP2H5JExEuA/5LQW2JlUThYH
X-Gm-Message-State: AOJu0YxXOIQ8eLRRDne4BjLhXgV8lrFTYOcrHlSduKDv2YKR/HC/oYax
	41QBTWhMS9rL5JbinChvE5OkSxyNqt+BZtrV8vfkmDM1xhmcrjE6
X-Google-Smtp-Source: AGHT+IEgqAj3Ld2KhcIe4S/n1ykqW2gZqq1EHOe9YwtvbPbOXcIu6oFWVN9t/ZgyuudBIY4FlMdcUA==
X-Received: by 2002:a05:6808:6391:b0:3c1:ec3d:77da with SMTP id ec17-20020a056808639100b003c1ec3d77damr3816620oib.51.1709574340415;
        Mon, 04 Mar 2024 09:45:40 -0800 (PST)
Received: from [192.168.1.22] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id bk1-20020a0568081a0100b003c1e577140asm694089oib.25.2024.03.04.09.45.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 09:45:40 -0800 (PST)
Message-ID: <35abca9b-7c28-46fc-9309-d7a5625279b4@gmail.com>
Date: Mon, 4 Mar 2024 11:45:38 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] client: remove unneeded initialization
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240304164846.1783148-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240304164846.1783148-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 3/4/24 10:48, James Prestwood wrote:
> ---
>   client/display.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

All applied, thanks.

Regards,
-Denis

