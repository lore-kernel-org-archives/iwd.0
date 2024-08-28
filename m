Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9083722334
	for <iwd@lists.linux.dev>; Wed, 28 Aug 2024 02:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724811859; cv=none; b=hG9oPpWQwfOBrzOozXrhPkWC4j323O6JNB7HVUoGVq260LHL1RnGwW7LyuFer4TmFgTwv/vlCLpLv+j8YtFSIgzG7wfL6f6p1K7jTs2Rw1gYzLVM2L6kRYx1xB1sdYMJ9CQWxeEv/nVEOZCOGJ5iqzuY1EXG++56Ay7DaxxWd1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724811859; c=relaxed/simple;
	bh=ASxvP3jQUygZodp/zZ+Whm80j6LNFFdBeGICHg71diY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=U7nI9JINTyKpPqbZSj/qhD6IPtVzz4PKQAKix/EcWK4tfuh8VFrc5X0ujEYXu2jxa0L8+agS0xX2U3gLxED0MReyvKcbn8bUx1/WZo7Cz2E1xcZwluOjWDv3Me07DFJbQ181F/m8pZzPguPcr1zO5kDbUiweRP0eBqbRVpCzq7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M84Zh7yX; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M84Zh7yX"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5d5f9d68805so4406895eaf.3
        for <iwd@lists.linux.dev>; Tue, 27 Aug 2024 19:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724811856; x=1725416656; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f8wLXphs/jUm5bt8hjrtw22Mj68Pi6ZQi+MZUQYof+A=;
        b=M84Zh7yXK9wR2QXqjSAJnPm/fCOSqFcuB0L2GQJmlm6oZpj0+bhm8OORUSGUTpSBNi
         CE9eixdPIaEgW0pKYzNkpq8r68oeHD7IXwjVV9q7q5D25X6HCTgNaUOJuUua5dauwSip
         IcBYB2tng5kVIY2yy3XRhmXoV9SXIegp9g83utBbYtS820uze2zEfmGj+Y91izyYa8F9
         YgkK/yJ6O2ch/Lr5Ckgpq5z4Q/FnGEYf2q+APKQIVosWoLg5ITDAOi4WBNjzNB6iMVk1
         CNkS5ZijR4YmWs5P+R/JtvPyj6biPnojPRU9e7/A7uUuJuw/kNfJz2sfWyYAl6AUl/4/
         Dl7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724811856; x=1725416656;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f8wLXphs/jUm5bt8hjrtw22Mj68Pi6ZQi+MZUQYof+A=;
        b=UKrhGcHWmdQtJYI/sEcCL8JblfO3TDjnZNO10x/i00vLcoPsSqBZHxZL9iXMhHZsx4
         a7uEUClkldblHAjsM3Szl6Ln9CyVicSOpGxuyI8S2vWkCEm1RBSKDGWvfl+ICwBbN7Hf
         CCdIgyAn0T0Z069IjZQ+oIClafT84mgJxB3NTYpnntyk3iowR1V+XCHHOHKPiW9ezYpW
         pC07hPyPJbLwQQUms2IyZux83jKSyuqOE3eA4/fAJ4IaTC/hvVtAj94bmUs8voZ9ztTN
         TIhDdQCkbzAoeQkwbzne4dkapCFOYh5uZbq4I99HS+GpgIxUXRVnxyD7V5p0h5M2oPmv
         mRXw==
X-Forwarded-Encrypted: i=1; AJvYcCVKWSRJHtgnBb3s+9mqRuq1gFlAqzRDH8tDTr4E/KhH4hz+qL3Vy9qsv6LMpqyCNAcO6QA=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx2ZA7fJ75PFbfzb2Ruxq0k/W1Brg5s0NieQK9+A0PrP2K4wdv6
	QTPJIwSnkx6LiCYDPMwhsLbKqvcqbNiC0KD2ADPu+ZCo0yN3Kkrx
X-Google-Smtp-Source: AGHT+IGizoDltgNzGccZWuMsKWupALm5wKo2SyK5WXKl05/jawWx7Ia6mjHlOhoTBwfJ+d6LPbdCuA==
X-Received: by 2002:a05:6820:823:b0:5da:a06b:c405 with SMTP id 006d021491bc7-5df865f3074mr635686eaf.0.1724811856686;
        Tue, 27 Aug 2024 19:24:16 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-5dcb5bd9d27sm2819021eaf.6.2024.08.27.19.24.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 19:24:16 -0700 (PDT)
Message-ID: <7995c8f4-ece2-4147-90f4-8ba3d672d4b6@gmail.com>
Date: Tue, 27 Aug 2024 21:24:15 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scan: remove legacy "Ghz" band modifier settings
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240827142048.750995-1-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240827142048.750995-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 8/27/24 9:20 AM, James Prestwood wrote:
> ---
>   src/scan.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
> 

Applied, thanks.

Regards,
-Denis

