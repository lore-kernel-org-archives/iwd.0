Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8A7BA42
	for <iwd@lists.linux.dev>; Tue,  1 Apr 2025 16:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743524277; cv=none; b=izy4RACfrWflfGuEVzSXkeEc4A1D157mV0RnriOj32J7B0hrx4r8XBN/DSd4HehSKF8Alqqhyulf305WPa8UPPygyft1ZZQkfuOC56QPK9yMb9UBaWNCqVxm32I3M2x6IjnORqQn0c8EXTWxfgQ7ZOd4LaXnPcZI4bJzsnbOFMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743524277; c=relaxed/simple;
	bh=hgFZPCgIykXbr6gKTwSJ5VvCh2Uxgs08+NLCqNO+IOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QNojti1JPLnAZYiPKFgKX5ATTTG7Z+gMP5l4qdaL5T4fi0+oys8076ULSsfD/+sJOTy3FWcS41Wuvn/1YT4aoUfs/ZauK+9yACAtOTKDSPR9vm3+MpPUfmUOnb0kOZPYYvfU+0gJh1OBZUTjo/iqNEAoQsJj9v6FZN709qdZQRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZtbfaLfr; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZtbfaLfr"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-72bbc03d436so3546159a34.3
        for <iwd@lists.linux.dev>; Tue, 01 Apr 2025 09:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743524275; x=1744129075; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IHLw2mL3xIpU4Q6dCuzBIT7F2rgsqGvKL5QBHJfsMp8=;
        b=ZtbfaLfri6/m/+G4V1JsR5+PBHNAJmJEyxoZ7Wti/e0reLHXK0gh99xRuZChXze2cD
         V5T7r5h2Qf9eIMyE7N6oG553YtOjKYT6SDt3aVL/JcipuXkwMYPnV9ffMOum8C97GWGN
         ULM+EVAoBxp6bm6brj8hxgNMj/ikPKove8UXxHeyDCqrV22WAzrfdsy5Zu8Q/qcztiGk
         mt39YiLwOpaCLJ12djq74XpEYQ80DmsAz1H37OKaV/4tJ65UTuokuXSXbGDFHYXd+MX6
         DXqYoKPBHp8+hzyMe2BLxqSS47JF3X8CsQMh2PrUMRMhEcHBdXrElNbsZjG2oK71KjPT
         U8WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743524275; x=1744129075;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IHLw2mL3xIpU4Q6dCuzBIT7F2rgsqGvKL5QBHJfsMp8=;
        b=HNQ3F/R4ygvdGOCU96tBtVoHLPN61KiFTsgNt0hG3WY8bgllGAL2OW9nQXF+jt4bu0
         +nS9H3KZfvvZJiKtMjohnrrDrJjvP465BBzVu3OiTsz7XbvqE+y8p3rZNYZRmeqgPWrm
         mNf4elMS4gqPNts2tRw4aAhRf+GKvTCxO1cC9Tju7qxRF5KaXRaWQiElv/M18XeYd/1R
         UhtuAxjeexAm1cb+gaTOdxTF7o8OvBeAyfUXMNpqz1NRPgtU2W6BTddgpdseX8jK59aL
         373vh6926o3v1YEC8e4dgja624XWs66q4VjRbFg8u8H4cOyZu1siXPG7JgjPuUBQwPTs
         +avA==
X-Forwarded-Encrypted: i=1; AJvYcCUbCLP1NfKdGTt43LoCKeaLSTfbigAe4DOck96Kfq6GbTnDD9UkHeCLHxBiSIC2be1h+jk=@lists.linux.dev
X-Gm-Message-State: AOJu0YxoORikIyIDUw1IlR2xcb+qsUuYKb+rl9vmGhsqyQ+S6Hc6TKe1
	D6IpES+E6j5eqm7RvAM6oxjpwfItRKIrjzXCQ2Co2XrPbLykH2Dl
X-Gm-Gg: ASbGncuFnXZB5yTMVZZYkD2aE4gJdOk4jiQqbf5au8BN0bUxIGnq4oBWkb3fxQe8Kks
	7FHlqxaa7EsnApc38PLVpm42KRPBiM/QKbz/Y3WFHAhYm10zJhteOPzUwdcCUWG3HY/RYI9c04Z
	4/TnGoE5dyjIgq9XGaPXXmgt7/jznYHzKSCAbYaz9g4JvZMXW2FUF32CVHUnkJ/tak3pzLCBHyP
	AqlyKZBELS1dZ9woHz0u4jC5uOyYC9YRBGpeuU/J4HhrsDuf6JISx4Z8j6hRiTv7cnXRBrnOaJp
	eC1/01WPXq03i2DyG0ezV58FXLL2WRN6RFhUEUlPEGOowA0HpVyg0JVZOHYe5+DeO5eRRpi9awu
	rhQ9wRfoDWHzHVD6f55M0
X-Google-Smtp-Source: AGHT+IF9z1KEyk1iaWo7x5TcCuggF1RmVUdRUKUOLcEypdpDz57jrFuj2JYuwCPj4al9Ty/xFQGLBA==
X-Received: by 2002:a05:6830:2802:b0:72b:7d60:fda6 with SMTP id 46e09a7af769-72dae42e806mr2464427a34.0.1743524274994;
        Tue, 01 Apr 2025 09:17:54 -0700 (PDT)
Received: from [192.168.1.25] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-2c86a860267sm2383913fac.36.2025.04.01.09.17.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Apr 2025 09:17:54 -0700 (PDT)
Message-ID: <3614045a-7b0a-477a-b90b-7c1c130bb3a9@gmail.com>
Date: Tue, 1 Apr 2025 11:17:52 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] PMKSA support for fullmac drivers
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20250213201816.230112-1-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20250213201816.230112-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 2/13/25 2:18 PM, James Prestwood wrote:
> This set removes the need for the prior patch on the list:
> [RFC] netdev: avoid PMKSA for fullmac drivers
> 
> And instead implementes proper support for PMKSA as opposed to
> disabling it.
> 
> v2:
>   * Reworked patches to utilize a new driver callback concept within
>     the pmksa module. This avoids the need to expose any netdev APIs
>     and makes the removal within the kernel transparent to modules
>     using the PMKSA cache.
> 
> James Prestwood (5):
>    netdev: don't set CQM thresholds for fullmac cards
>    netdev: remove/update some iwd_notice logs
>    pmksa: add driver callbacks and pmksa_cache_free
>    handshake: use pmksa_cache_free
>    netdev: implement PMKSA for fullmac drivers
> 
>   src/handshake.c |   6 +--
>   src/netdev.c    | 133 +++++++++++++++++++++++++++++++++++++++++++++---
>   src/pmksa.c     |  38 +++++++++++++-
>   src/pmksa.h     |   9 ++++
>   4 files changed, 173 insertions(+), 13 deletions(-)
> 

I went ahead and applied this series as well.  Thanks!

Regards,
-Denis
