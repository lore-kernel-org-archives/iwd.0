Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9408C1BA87C
	for <iwd@lists.linux.dev>; Tue, 30 Jul 2024 15:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722354787; cv=none; b=stpFSi7d6sIZFygEplBjO6wdTe6SvZk5zafubADIalNKr0jFfglNtV08J6wBRJwQ+2JuTaFbjDf+DoDZdfxfUbWboMHiE6beNcXJD3U2j9SU5M1vTY63zWyWrhZcQwmvgt0WBcf4A8/QFW6IOa+nBXwSh4/IJ56PHPAyH4A82Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722354787; c=relaxed/simple;
	bh=mGX91gnTksrc7cafcA5ujdvZjmP0EcXoMaaMuEiSdVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=f871dkhAM0Kc9jieltrA5wzTZioSrB+BvVyvanzmp5gcYL2/JUcjdeN+l92XQ9M777Wb5Ts2I566XP7zJ4WF8q3Ky+0AJt2/BNn3BYg0RF2LaSwSyNgq5pzegKHX4QUn5hyLFHpjuE62eH+mw7iAJV3VzafLaB4h/K4qQJrFoUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V4RY6Ulf; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4RY6Ulf"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3db16a98d16so2991229b6e.0
        for <iwd@lists.linux.dev>; Tue, 30 Jul 2024 08:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722354784; x=1722959584; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1YA/uz8BI0zhXkMN7wghdbO3P3H5RIUnuYknrQso4MM=;
        b=V4RY6UlfA26n316hqeocbnTI6NwxhbTb3bxKGQhAXXCLp5fFKaieFdc8rk7X/HcAgt
         Ihtpj3k3lPy59O79E0K6nNAQ7CmQiSh0GNjjptQrGNUxg9Z3AfiithABWtcpDDEZ6MLP
         xKe3vgjJi74IAhPGgJz01GYQSGVkJrMTH70E0TW+OuW77F40q/7N1H9hr9zPMOb9kiZI
         LhMU7JcHdD4R8EIBxRLj+25xfoS/gk+uSXg0fvIKBCnGeAbvmW61z9zd/vok1U2+rbTQ
         Trhd6R5rqf2l0RZ/UaNhASaa/3GSUHw8GuTbh1AlNqnTzkPteqiGZHheOPmp2nhQqvNS
         JHlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722354784; x=1722959584;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1YA/uz8BI0zhXkMN7wghdbO3P3H5RIUnuYknrQso4MM=;
        b=f7hYwyB3gzP4UXunN4ji0vVoM9OWP5Q7nqUkMKQUgZyylpP36kXLHKaxuGqo4BJSgP
         boxPNCTjOAC5/hRDtu145yfwYT+QvllPwQ2nGSRlB3+W45URN174IqMbh21AhfVwq/+s
         gQ0+2CMi7RE8SouBePd3JM+wtg8osT3EE4HDR9AtyL26v4+rkF4gLbAzL3lFTrp7tf4P
         BKJFYrFO8PQO14Y7ufU+zCVvZ1zIMruSOhUyxSjvDmJnZ7xn1A44FpxTL2VPc5vp6H/o
         V4Mip9kNcerOkk+vRI0YAVoGwRdwiBq6RNq/do8hcMJ/sNLGotlVlJLLIpY/OaD8RlY1
         Q7YQ==
X-Gm-Message-State: AOJu0Yy5PQ4IwbXb3mrNNoDKR66RJ6ofDDBXS7/MZ4xVqLpa0LlC78jy
	w7Xnl3XCkc9TqErxO63PcfwMR+tkKW3ZqVDyxFdC7hLl4L4AbPTtC5C63A==
X-Google-Smtp-Source: AGHT+IECx4RicGZ0+tPosqzebzIsBeI3pW0REgq/TROc+COT5rUpS9XUdh/729yTEP6+69KG4Mx7Aw==
X-Received: by 2002:a05:6870:b625:b0:260:fb01:5651 with SMTP id 586e51a60fabf-267d4d2dc08mr13614265fac.12.1722354784315;
        Tue, 30 Jul 2024 08:53:04 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-265771e4907sm2284861fac.35.2024.07.30.08.53.03
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 08:53:04 -0700 (PDT)
Message-ID: <c0a0dc69-444f-44a2-b42f-52af59b95418@gmail.com>
Date: Tue, 30 Jul 2024 10:53:00 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] wired: Update to the new l_netlink_send API
To: iwd@lists.linux.dev
References: <20240726223754.159303-1-denkenz@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240726223754.159303-1-denkenz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/26/24 5:37 PM, Denis Kenzior wrote:
> ---
>   wired/ethdev.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 

All applied

