Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5344369E00
	for <iwd@lists.linux.dev>; Tue, 30 Jan 2024 19:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706644749; cv=none; b=lzfSddcdmMAm6wGR4dSWpNQyNhmYmQMzvq0K8PQgmh6nKP0AwtkU4+y8PjwvQRTV9BNeA8wZlnJ62UgW9R5QkfnBIMBcII+iUNVEBvq3jh8opCogtEC+OskHA2zJrcEFQK7n/E2KURiwYsC5XD3gcbKWvGp8bYn1tuGJiBCdA+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706644749; c=relaxed/simple;
	bh=fpOVDd1MjQr8i1S1pqJpZpfVi1snYNYbmER65WsW444=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nQ7KjXsymOOrKRgswH+kCMRO97HTtHIREiIq9o/HJWkKQppHS4VosVj5WYD+15gK/Nwn06l67uKT96gbMhwHpNesZY9VO4jSQbYWmHZIo2P1R97vE2b0QvQHGLxTOAMY4F+YUdjRP/4aA3/HwlGcBGaVrjEbUPx38U0aJ/Itlwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFQmuk3k; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFQmuk3k"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6e1214ae9d4so1515743a34.3
        for <iwd@lists.linux.dev>; Tue, 30 Jan 2024 11:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706644747; x=1707249547; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+9LIBguMNC3GUf9kpBsG5IQxt+Gx1t3l3giZktBLQCM=;
        b=LFQmuk3kn3BikIbuHrZforiNXqXLbXpCjHnhIQT1n4TBLNAb9fr+b0/RJuRn1g4buF
         bUTnBUlVZeuPgJuPbPkKl5tPTJb9UyJkbep3pX136rTrBciYMp3bKM/lXpIrI84RULhS
         pFPK/e6mlznv7nexGDzctdKBEYuOCYr55RZnd/8xYnMiHUAHGa9GHltTXZpwJTd126IK
         /+aZl17KBuT+c1mBOdRIwmYsh/WrovLsjnKjV5qQCWwCvp0t9KHApU1+2jTtc2SBV3e3
         JOniJkGtzqb2hl23kOur0MiS+B8w8Rkkhb+MKW2qb+o3w7raaGGahzVe3JposIjl1PlV
         19tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706644747; x=1707249547;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+9LIBguMNC3GUf9kpBsG5IQxt+Gx1t3l3giZktBLQCM=;
        b=BG2L9h0YX2jFeCzEarnyTPfY7wGoZVjFD3XMtIef6vQOpO8cvVl9Tqak6nWlRQz3pN
         9XP9L5HlChX1jNKHfdZlWAFQ6Rzm+2lbgie8C0CGCngnDsA/IxDXIZ5REZIRysHVKnAg
         X/zSf9b9rLWj6Ny/m9C8GbcNNcpTeUp28jv8KKuyFKvMnCot0cIAYl2TUng29o/UfrLd
         23mHfGIXmPjRQr22hZpoe89/3R52Vjp88wgGGfstJbqfomAAYr9M4ooQUj0eki8xvk86
         LCfoh/aBWN9831M3z/iq4dlFjG6lCuIortYP7G2s/WU5z5yJ+c8QSpl+3aNRH1nFCIwd
         voPg==
X-Gm-Message-State: AOJu0YwGFlQALCAIYgd3WLkcI2LZC9hYmmhF9ev//HeDRjQ1L6cI8r6X
	8XFqRWBHbou54UBO2TdE/XVEdxNnh2OGlYgWgMY/BScb7PxPQGrc
X-Google-Smtp-Source: AGHT+IFIyy56Ymu2HF0QOSeU/5NjRrNKVJdVmrweW51hpjpMWS41Tq8Sh0KzPK7ZyhyZ0jr6kCHxPQ==
X-Received: by 2002:a05:6830:1408:b0:6dc:87c2:1cad with SMTP id v8-20020a056830140800b006dc87c21cadmr8353116otp.12.1706644747366;
        Tue, 30 Jan 2024 11:59:07 -0800 (PST)
Received: from [172.16.49.130] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id h13-20020a9d6f8d000000b006e117753d29sm1651682otq.69.2024.01.30.11.59.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 11:59:07 -0800 (PST)
Message-ID: <feaaade0-9553-4d98-ab23-3e76a218ae1a@gmail.com>
Date: Tue, 30 Jan 2024 13:59:05 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] netdev: fix setting a uint8_t with l_get_le16
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240130191352.85852-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240130191352.85852-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 1/30/24 13:13, James Prestwood wrote:
> ---
>   src/netdev.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

All applied, thanks.

Regards,
-Denis

