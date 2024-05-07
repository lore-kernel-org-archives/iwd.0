Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A5C15E1E2
	for <iwd@lists.linux.dev>; Tue,  7 May 2024 15:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715097122; cv=none; b=BoP6rE41Ub48eejiLH1ydNy+gRUC8h5UQ8gj1DhqJDioRqlR54pYoTCbDCtIGHqs4lwpSsxYuRrqITiv0qguxHA81cazctoJo5DKzAolce3iinFfp1n5JYcs1L78zRFb6HYIjN/wBtZ+Xp9OQgpC082NBEycMPYA0KadX+SVENg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715097122; c=relaxed/simple;
	bh=7O11iaLR2glLOIgbUfIB7zMufPl+C3lV6U+BVEQF2Ww=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=N0X2nWLKhpKgc+QqDI03famtXI+DVAXx0N8BFUhHTomr47IyYuEpJIQ6Ch3Qrs4MIzlmiMmLKL6tAmQJ0GU2S05KqfCsTSSA+Bu484LfhFix34BtN4XFQHvn4nParssG4JqNhky+NHD14cX7s9ri5vYR2Ark/QEvlNoBHCTeqTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mVxMEpGc; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mVxMEpGc"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6f0794fdb95so1165143a34.2
        for <iwd@lists.linux.dev>; Tue, 07 May 2024 08:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715097120; x=1715701920; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B8a+YGSAndfcRZ3COkFWp4kWjvyzQ88J54DqUwRxCPc=;
        b=mVxMEpGcVaKkpydal8+h1E3CRRfKZpQIxOyYUgzGCS9WTNmJE0xR9YFFe8OqY6F1wg
         4gOHtSx61pLbwhKWhiMNuQ0M9/rFwSd1a9QYOmTXkCMpGSaHubIjpcQNHbjsOGQBQSXp
         GhvR9jUP5SsqQ/+HMg4J3Vc+NKEkQUX/eTN/cKr5hFO35V7wUsRMuiQVAZ9WATdkxIgK
         ct0pWuh1t00D84CcxD5I3SYPmBHLxiQXgda2BN9bS4UC/4HFZZSKsigdgLlRb/ZaqcE/
         j5/lZ9cRzW/Wel9/Fv1802tKUwpgNtwFPHV5iW+Y1yGGho4qQjG0yGWLqShi3JG1JhOt
         9yBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715097120; x=1715701920;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B8a+YGSAndfcRZ3COkFWp4kWjvyzQ88J54DqUwRxCPc=;
        b=SYv5y/O/TzCXpoef072S0TbGVFClRJQRFS5XMI15M7fynSu1Wqdpi09rc+yWrzZUAz
         ExpWzI7tflyKxaa+8Z8Zajmz+bpL42parrhqpX5G0SO6rKABxADrAD/S0pC/DZ3DmeKQ
         9JY7s7lIe3Ynk/6+Zly0gVR7hlg2TvskiUtEC2iFF8Q/NKTsahFvqJNKRn1zOGpwuJm0
         Ik2qWmMfxZTza+h+leTimHR3DgDk950tPpyrOp3sYNCweYKmg9yN8WPvmKdmW1fiDHWx
         gEDS97k5IvSSt1PQKAKzNgwvjUljWmib9hdqyaK7Y3m6ryKWi1wOwlOgUk3pjeM9KpsN
         /frg==
X-Forwarded-Encrypted: i=1; AJvYcCXB58hAnxUSQI0JvqxisMYS6ogEO0Tb0ttnyRE0KGnIIXpM/AMZ+fjuRRcR9lhNPtJgcCbj11GYJ3Mvy5Bg/ns0tXcS
X-Gm-Message-State: AOJu0Yy3+483AMpF3BZk6t1uWc6A5g4QfocZiMTXR7zKz+FDeEZKc2EY
	8CM9N6+w3nVeWYuiaI0OCYwUV8CNcb0rMovXFPFHYXfpdSjberj3
X-Google-Smtp-Source: AGHT+IGQfCU7YlVKMHDJ84mrUFa+59aSWL+d9v9F8TIXXu5Ep4UC1DcEiipLaiQq/r5tHZobmHjkkQ==
X-Received: by 2002:a05:6830:1e4c:b0:6f0:478b:3e08 with SMTP id e12-20020a0568301e4c00b006f0478b3e08mr7234050otj.34.1715097120144;
        Tue, 07 May 2024 08:52:00 -0700 (PDT)
Received: from [192.168.1.20] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id bl5-20020a056830370500b006ef9ac4599asm2568752otb.47.2024.05.07.08.51.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 08:51:59 -0700 (PDT)
Message-ID: <d227d1ae-3fec-4261-a419-9e5ef0033462@gmail.com>
Date: Tue, 7 May 2024 10:51:59 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/18] sae: support reception of Confirm frame by AP
To: John Brandt <brandtwjohn@gmail.com>, iwd@lists.linux.dev
References: <20240506003518.320176-1-brandtwjohn@gmail.com>
 <20240506003518.320176-9-brandtwjohn@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240506003518.320176-9-brandtwjohn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi John,

On 5/5/24 7:30 PM, John Brandt wrote:
> Experimental AP-mode support for receiving a Confirm frame when in the
> COMMITTED state. The AP will reply with a Confirm frame.
> 
> Note that when acting as an AP, on reception of a Commit frame, the AP
> only replies with a Commit frame. The protocols allows to also already
> send the Confirm frame, but older clients may not support simultaneously
> receiving a Commit and Confirm frame.
> ---
>   src/sae.c | 48 +++++++++++++++++++++++++++++++++++-------------
>   1 file changed, 35 insertions(+), 13 deletions(-)
> 

I went ahead and applied this patch as well after re-flowing some lines that 
were > 80 characters.

Regards,
-Denis
