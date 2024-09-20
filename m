Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E798B17BB38
	for <iwd@lists.linux.dev>; Fri, 20 Sep 2024 15:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726846052; cv=none; b=sZ7nMjJaRxYFCwyfKgl7ZMWh/mCdToiZD08og/4VuFKBvEu4ZZ1+4EaguHpKAgscCuUVpSrAW0JwKwHTh6yFTwv3a8sCQcgQyFokJEZgrb0dGwy2N03q7pSUqtCYzFgxq7uBmMxknbg2OAm5XJnwd5AMXNvKe/amYZnnP3QYv8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726846052; c=relaxed/simple;
	bh=8D8bx4BQe7UnV9FrwZw7KtCAA0d9JtxYWmD60UM8MbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=vFuwroZ5lv7fsW8Uq/9ESJpcjdk/jxWAxm9fbE9CO/fFbh6Qq4D75QahtK3H7zJs8IxG1kXCvkQ/Acg+ihXH/ZsQYF4WPPGd9wsbnQMCzYtQQSQpburpsbey8X0Nm0+l5BNYP/GrTjO/P/qX9LOI2//dgSidwvJzsvmwd54vdyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fAUYPigV; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fAUYPigV"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-712422564aaso1527094a34.0
        for <iwd@lists.linux.dev>; Fri, 20 Sep 2024 08:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726846050; x=1727450850; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I56OU/gN4W9zeuNeRJJ1NNtnO0vRPKOKe6lTqFgYxzY=;
        b=fAUYPigVl4sY6+ED756jxteF4h5qH+2cwRa2wJTlODE/sSM7zlETpmzheDp0lS/3Yn
         5SzYgL3Vvh1/X3Hp6NPoQZiXzOPyw569TqVwc+OWCJTpff0YWU5DmmUc4JYwmJavVwsP
         9Q8RlYwL+aSH3vT+hR0kfU6kpv6s3/r/HCKvi1NNA+DjmYt6C7dx5aqyOSlGFc7qDkYL
         Ju5wv42jwyIoYuSh1QCwFZVSjFsJBeXM4/K6gDAVDvsXlXs+NJsM0gQ+44IpaLZWH2QE
         mSbejltxTpN5jgQ6OEarGij2AXiIZ/KC3wgMJAlyyokAKkgJLP6fTwA0ZdtroypP1Dm5
         uvHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726846050; x=1727450850;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I56OU/gN4W9zeuNeRJJ1NNtnO0vRPKOKe6lTqFgYxzY=;
        b=EMTBgNNttSCs/tbvutDgVEL2WBrp0fwQ4QLXT1HhulGZVhnVC+iQcqwVyMXCm+x/XN
         RfxhybP2hoc1DawLX9mY34HgD0DydWgfXzq+uu+iyGSqX7QIPHNWGr9VJxVGa998vMj4
         1egS22F1dbpBt7LSPfg90iOwke4VI+FjZzpiCj9TIyuJa5xb5cgWBJxnZNUmpPiGFZua
         31dtXuRHeHJZHDtHVBTuoAUkbMfu1owwU3oHZq+24EzuHn7L6A2l6VLugx0u8ue+gEqo
         +IhG8ST7WHGGKK/ReXKb0ipXw4DeJAVIK3mqIBdP65xpzThnUnz6poutSNF6m/jMmMLo
         iM9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWOPmDDEADiRJUQDM1JODb3eD7XKgj7jrRxLFdKvXuliodYk9D51e2nk2Jkc035m/vWunc=@lists.linux.dev
X-Gm-Message-State: AOJu0YzcAZPF+z8K7I1gp5pl5JidvCOeWDtIgcjwGX6PJ88CyWb968Ld
	XjtnABuqjD1ZsTDNHFSh+YIa2KrytygmF0C+UkJgWuZSMyt82QDd
X-Google-Smtp-Source: AGHT+IF+flmeTs9NiCBa+7NgMmFzxrfV8Hgdgg3foNfhQnn4X2wrCJxlF9nM+YHQRj2YKQZQ7N13mQ==
X-Received: by 2002:a05:6870:64a3:b0:278:a71:2659 with SMTP id 586e51a60fabf-28038b9ab61mr1813230fac.14.1726846049843;
        Fri, 20 Sep 2024 08:27:29 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-27d0b45f210sm1057636fac.29.2024.09.20.08.27.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2024 08:27:29 -0700 (PDT)
Message-ID: <c3863d99-9e7c-4232-8d5d-39034b8ab5ae@gmail.com>
Date: Fri, 20 Sep 2024 10:27:27 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] netdev: allow empty TX/RX bitrate attributes
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240920135536.203657-1-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240920135536.203657-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 9/20/24 8:55 AM, James Prestwood wrote:
> The TX or RX bitrate attributes can contain zero nested attributes.
> This causes netdev_parse_bitrate() to fail, but this shouldn't then
> cause the overall parsing to fail (we just don't have those values).
> 
> Fix this by continuing to parse attributes if either the TX/RX
> bitrates fail to parse.
> ---
>   src/netdev.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> v2:
>   * Retain the other "return false" lines as these do indicate some
>     kind of kernel bug if the lengths don't match up to expected.
> 

Applied, thanks.

Regards,
-Denis

