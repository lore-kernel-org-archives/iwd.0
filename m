Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDD81CAAD
	for <iwd@lists.linux.dev>; Thu, 20 Jun 2024 15:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718898686; cv=none; b=TMHBMnbGANAXSMNDy72RO7sW5Fpw6/eE4F6F3cb/Ma8qU8bGlWEw+P3bkhtrJDD1CPtMgfbACZv+x7hZAybxVCqah//8gtxiUAq6jk9cRxmTGnTDM05SwPgcwjBm8Jr/Fk95QnCY66UNbaoOp2nr4SMtLWXNZXUnlkgtOJ8EWww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718898686; c=relaxed/simple;
	bh=JU0dHC6Nn75TKIaJSFvcE7QNw1G8wLzxqmTAcrruhfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EWujJbOh1Gu8Sc/pgwUFQI8HlAWFl8agyCu9xZfvh4rjIvwVVw14S8PZBJrvgP1ItZZRgX7fnWHn6VLmOe2fT+XRHM7OvJ8aYssoArScfVg0KbejOrRUhmzzSuOIMO/a2Gd0NMeBTlIIEmWK2OPE+uL9kyhrliJxPoIf4b1M2VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Go+7Uo/c; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Go+7Uo/c"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-254aec5a084so558419fac.3
        for <iwd@lists.linux.dev>; Thu, 20 Jun 2024 08:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718898684; x=1719503484; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PJsRHpyNp/4mNUvmfdP8zNKH/NM0n+tmdvdvUC9Iwoo=;
        b=Go+7Uo/c7gZYlgAU9uyCDJ7yUWtTUBx7cVikhaMChtYEDmBcscO80YtKxBafrLEwVx
         0zlVuJKeoC+xV8UB8zpso+wrpS4PFbjPbK7vWsFySevrQGu+jO3L4un73C7L28Wxj59z
         B/MaJkfGpbzOhE1gvwvbmGYtmIMgeMPquBO8FyYK1m0R7Dmn5OL74C6+NVl/rAk9giHO
         te23DL3XR0Owv8Q1kmdgpCto5NepR7h6Fsp+6Sn6BEkKR//fKkCXj5Lmd/3A10XdNGWP
         /sc/pcLw9+TCF+VsRvooMSgGodymXiQWFO+pK+EXSZ6P/7OpV7V0i6m4PO9uOw/nXLPk
         oZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718898684; x=1719503484;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PJsRHpyNp/4mNUvmfdP8zNKH/NM0n+tmdvdvUC9Iwoo=;
        b=FSIUKyISxhHuhqXjzcGUyw0vmQGmsJ9VugqBgmYwlJyDer4iPbR6bRGENPqms7KXPZ
         HucwEubjwN7sQJ4Fcxqv5hYs/60U4hQS03//iqj7TkWTM9o59QNOrOgOThcCT5Qn5cm9
         h9vj49jeSj1x7kOp4nY/BGQ5b/gqpzIO08ulrHRjR3AkemBlDtrmRTa7J/5U7N1G+71r
         udJHLjON+N5BYGltedjTijF0s37Awst30TWbxxPtybV9DnIUedE6L/QGTw7nr7onG5bB
         Cn1yjNNwMUVzgKemCF58PqRz5hmy4L+asaiYj7od/4g13zePFgkzCoiRr6sqg7XQQ+/W
         HbTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZPqQK7yt8xjCqToh5s5yTAWESaesntLJVyE9aUT4guQeRQ4i0KbMIT+J0QBxAyfzKJxwyiduW6BrKx84AikcC3gDr
X-Gm-Message-State: AOJu0Yw+djZzd5afsCvTPJ9aMzlE8DiCJGhdTM0m0c4esNPurLuSy8gH
	QMCFDZqGwL/IDPXgfL/tZkengsbUkQasb/ByV/e7X5bIfPPfMzBdvqg2Dg==
X-Google-Smtp-Source: AGHT+IHA+7C0hPi4vr4/rmJzcvb38kUq/sum6FP19ETmuUdphI/AhkoqyGNq1y9M8Z4Zs72b/DoG8g==
X-Received: by 2002:a05:6870:9706:b0:24f:cddc:ccfe with SMTP id 586e51a60fabf-25c9440bcd8mr6312024fac.0.1718898684558;
        Thu, 20 Jun 2024 08:51:24 -0700 (PDT)
Received: from [192.168.1.21] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-25ca25d6667sm870793fac.24.2024.06.20.08.51.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 08:51:24 -0700 (PDT)
Message-ID: <81e60b8e-485d-4d3c-9632-dbaf8c30283c@gmail.com>
Date: Thu, 20 Jun 2024 10:51:22 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] netdev: downgrade L_WARN_ON for
 ensure_eapol_registered
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240618165854.113598-1-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240618165854.113598-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 6/18/24 11:58 AM, James Prestwood wrote:
> This warning is guaranteed to happen for SAE networks where there are
> multiple netdev_authenticate_events. This should just be a check so
> we don't register eapol twice, not a warning.
> ---
>   src/netdev.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

All applied, thanks.

Regards,
-Denis

