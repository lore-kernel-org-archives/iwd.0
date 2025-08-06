Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A92828C5D1
	for <iwd@lists.linux.dev>; Wed,  6 Aug 2025 14:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754490959; cv=none; b=CrHlA5qOgpb04Z9wzIv8K6ZM3T10sH/jK5lEQLyJJ9eCoCWcJqa5XIDkThdQbLKwwgEHKct5Bzwx9qegPbiKLpM1N2hiteyxzdtYAafS9ZWWzlTq84T5jpD7gxu5fqsV3FO1uTxFsqJIwxsoeHUgSRoXYJVe81Z//Onajjh9iWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754490959; c=relaxed/simple;
	bh=AmqS8lr4nDPZ76yK4bETv6rq0zWfzppeM0KRpavFXB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ApLDI4UQncxVj+DbCfUS6pxJ7YKBwUJ3z2s0eCUqUfwoaDRuNzHlMqt9kaYDi3+JvjyS9qHe5T1Ot0Ohoe6yMEm5KRIVrPyKvn5bJDTM6Ao/UyuPthTm74WwQ6A291MwtE6MbvejQtMC9CdcaN+1CqrGCC4Rtv4iadYinNV44fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mxf0IEm6; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxf0IEm6"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2ebb468cbb4so263fac.2
        for <iwd@lists.linux.dev>; Wed, 06 Aug 2025 07:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754490957; x=1755095757; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=juEcV1e7lqi12PswNjjdpdbHzXV8hXoR7HqXa0u/Nds=;
        b=mxf0IEm61+5k6FsY1LNFRi/D3GJ/N5f/SK1vv3E2zC5vNVIDUqk9JpbDqQQloBpnUG
         j9INkWdchJabLOy18ZfnBJqSaox0g/uRLK+jC4qd70xx3BGXwkgp5HVVKFCSDxx/gj9u
         o4pgkI1fuE9WAmICRsUwmNH+3/GZAh/lLglutIPwozzS7tqkHcVK6P8j42MOy8RS3U+c
         OJzIpSPZsW/5jtnAaaaZXBqXJ1MgqxYC2BWf/Ymh7541c79FU5j3IunSx9w2p5u1O9zc
         Cvp7px9IbKkf0EqiPP45mrhDroK+gdU+r9gMJ45+x+A5UolRWv18a6bga3L8kWhboeBa
         /cEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754490957; x=1755095757;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=juEcV1e7lqi12PswNjjdpdbHzXV8hXoR7HqXa0u/Nds=;
        b=MxBGdQtVwY3Fqg7FyEZjFZHJDX15eVp6Xubp0NnCXvAJTh/RS3+b91+lSHu1tNmULJ
         UEhs8lXSi0GbS+1YfUVyVRFK/N4iTaG/cG+ivPe9+qWJV5TXkUqzpvM58s+e/BDtFWBB
         y5hrKp2AorYm9wLOtGTdBcL662V+46J/wQKc26ZDqKbH036Q7OAFpjieiLXZlOB2pzpn
         JxQ5o0ktPseC8wjJR+fHPiieCAZyLIulcG9yYHIrrL/lssv1YFnbV+m28kWipnkgW/dQ
         KkuuXEkJj8plwj3fP6KWpAFGIACXH2sPoIuZ/ygLsJQlcbUdC4hRpuwsdQ1kynLdoA77
         5GQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLQKLMG6GGA28tRFr3xmhRHmPRB5Gd/j+sj1I/vZSLOKP0xlEzF7EH9DC8hYDDBdvKa3M=@lists.linux.dev
X-Gm-Message-State: AOJu0Ywu4MiE1ctGBaK3qBA+RNwm8DJEKrYT+rGarHyJ5U4u+1I9cw+J
	UlhTGpd6QoW90FR4gUDhivEhHSkg8SL50jRJcjiQmo18M6xNEREMoaG5g2DHcw==
X-Gm-Gg: ASbGncs5C9sjG4P/LDvhAtZuUlpOxbWiH1NUGl5ER+u7QrA58mKtQWtxVEku+ztsOcW
	k29wbt64bn5cBCeqhc95GdXYku1bVSTqxRyrfb8cKdQVDC3yWEJxNLkFUW98dM0x4Fucw9L7Z8x
	TUaeqja1cRBUN4US5f2Fe7xiaPU63U/qqE/Pp5kjpXlJdbOkK0U2VFIkzDyydD8pZ3XZrKhNJgv
	4YWO/AScq7Tc9K5pv1xKLrfpKQKgsF9l+YgfSZqKDA6DpVLIjc3+aKjLl8LU6ylGwxTGST5xz/p
	6DPsHPehWtY3hruBrrUH91gR56xeCIreMcAkj1a4WibuElvafIoU7T5fKLb7VTKLixQVhb+w00R
	oJqf42E1E9rqDVNGYlvE/DCdAIROtvRSYfnmSQ3sxQZAdiGM/SAYxuHzQNzP6nuRoRpTUaVgaX7
	Q=
X-Google-Smtp-Source: AGHT+IFLcbDtoTzFIKWWk1TqhOxg8HwDXaaoZikhYesK9o+RZbrpRgcwQPdadQ7atEHwyKm50rKIKQ==
X-Received: by 2002:a05:6870:f624:b0:2d5:ba2d:80ed with SMTP id 586e51a60fabf-30be6079f5amr1515826fac.25.1754490957341;
        Wed, 06 Aug 2025 07:35:57 -0700 (PDT)
Received: from [172.16.49.130] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-307a740deefsm4204330fac.29.2025.08.06.07.35.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 07:35:56 -0700 (PDT)
Message-ID: <586befbc-4be5-4036-ac15-f2c24bd40fae@gmail.com>
Date: Wed, 6 Aug 2025 09:35:55 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] netdev: parse INACTIVE_TIME and CONNECTED_TIME in
 netdev_get_station
To: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>, iwd@lists.linux.dev
Cc: wlan-kernel-dev-list@infineon.com
References: <20250806091625.1277-1-gokulkumar.sivakumar@infineon.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20250806091625.1277-1-gokulkumar.sivakumar@infineon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Gokul,

On 8/6/25 4:16 AM, Gokul Sivakumar wrote:
> These two newly parsed station info params "inactive time" and the
> "connected time" would be helpful to track the duration (in ms) for
> which the station was last inactive and the total duration (in s) for
> which the station is currently connected to the AP.
> 
> When the wlan device is in STA mode, these fields represent the info
> of this station device. And when wlan device is in AP mode, then these
> fields repesents the stations that are connected to this AP device.
> ---
>   client/diagnostic.c |  2 ++
>   src/diagnostic.c    |  8 ++++++++
>   src/diagnostic.h    |  5 +++++
>   src/netdev.c        | 17 ++++++++++++++++-
>   4 files changed, 31 insertions(+), 1 deletion(-)
> 

Applied, thanks!

Could you also update doc/station-diagnostic-api.txt and 
doc/access-point-diagnostic-api.txt to reflect these as well?

Regards,
-Denis
