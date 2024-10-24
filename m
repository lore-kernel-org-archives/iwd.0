Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF751FAF01
	for <iwd@lists.linux.dev>; Thu, 24 Oct 2024 17:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729790009; cv=none; b=ARrE4DWNpBHNKGVcpCF2FtPMfk0URFv0gfS7lhnep8okMIeyOcC8CEQts6QYuIFK9SZnCi/pGdSmxFmmYy+lEkOsZ8L/dwvmFDEdN4jKyviXvvRhXSVtrIeu3GcNidRkm8C5meUFPNdsku1yNyOgZTuhCtSaZXfpLMy1N3/M0J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729790009; c=relaxed/simple;
	bh=j+iVzB6vyVOGmEfXt5aXi8N93wiwA/TDUJTj3mfMfFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Tp5EZc50waOZxeDn2IqHcH8t5HJXe+7ZqWTcE7oLcEhnadGPB5iOMPtzZevO7haevdwRaGdL1jH/OSu2bFTiK5E3UPkCtfFO9KVYyFGHGqXgBJMQDGyLFpxA1/riU+tToLxCw5qzFSJT7tRuyh4j1B7bwueELOmiYic4TNr9DIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H5e2qcE4; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5e2qcE4"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3e5f86e59f1so709414b6e.1
        for <iwd@lists.linux.dev>; Thu, 24 Oct 2024 10:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729790007; x=1730394807; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0tkznxfYIWQIqfaIdC/OokdMv+X6/jrzwZ87nhbsMxU=;
        b=H5e2qcE4mS1G4nHklWZyl/ik+68F8XJSLEhqw/Im08Dp/EVecIHRdcp9zCmDzkdmih
         HnK/jJNkjTEePAv1eEUad7abpFZPOFKmsd4X71QIRY6hZQGvaWtdT4Hh7V9Oq47bZaCX
         3LodlSXWs2cmiPWM+ZhivdOV5iE2u4IsxMI+4D2SDKtWVfZxXe681EATg2Uarp994/vb
         iH9mgfC6DsHCKm1m6LIKjSAZmEWokeVIlWY5HNDRXxBMXTz9u0vlpkEcMQRKZ8CPaXHH
         XSKGWiAFUdSpGhsq2QRGjFmh2o4Ud7k04KEUkUprSzis7y/lHULhv6voIEueooiJp/Ur
         DJ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729790007; x=1730394807;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0tkznxfYIWQIqfaIdC/OokdMv+X6/jrzwZ87nhbsMxU=;
        b=BHhkWQ3IXU5AMMSSn9nUplKhgMQacF2R35TJYSuRL7TAmu9EEjLKHLNhroHiaHcYlm
         7prccC+3nA6ajz+auIeawvAi48ZNedUwWhHT1PRp34CuNsltmWdehTRYCMVb1Vtyd4O/
         HNYBkHgmD3wL+BCqVliKDbNWd9Wa713pGTwi/AUg0RK1jJDl9tcpq4KoewASGNohp4DD
         CuG5B7SKx7oOMYVQe4bjaw/qyilN9+O9oDBI45d3XFkI/Tp8NgMnTWCsJkMdA0HIzCvF
         zVwPM8tP+F/g+3YXlQbDjz0/mOr/+w1UzSe1hwz3NURzRMeY+uZ+furVkcUrClgETehS
         W2XA==
X-Forwarded-Encrypted: i=1; AJvYcCUQXax2c60V9S2QpYmGEbyiXa+x3n/fvQdKjvhhs2hN5kEPTTt8DMS0akh1FNJBQO9DCfA=@lists.linux.dev
X-Gm-Message-State: AOJu0YykcGLspo7o9yMYYiGSPJiH/yMy7Tpuseiy0xoYC5iyKef+Xnw6
	br+0AJTtnueMAABtJerGGrafko4OS4prp02xY5SWgOzgSMt+cMiz
X-Google-Smtp-Source: AGHT+IG3Zciz78imUozdPkuQgIsx8t/55bn8C05uZ35z+8Ak5hxZCTLqhjOWC1xLpQvNr9NRxm+Xcw==
X-Received: by 2002:a05:6808:3a13:b0:3e6:2772:2a53 with SMTP id 5614622812f47-3e627722ddfmr6271344b6e.16.1729790006700;
        Thu, 24 Oct 2024 10:13:26 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-3e61035fc2dsm2311741b6e.52.2024.10.24.10.13.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 10:13:26 -0700 (PDT)
Message-ID: <804b48c1-cb5d-4d16-a579-e32fd930228b@gmail.com>
Date: Thu, 24 Oct 2024 12:13:25 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] scan: warn on zero frequency when adding to request
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20241024164635.176631-1-prestwoj@gmail.com>
 <20241024164635.176631-4-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20241024164635.176631-4-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 10/24/24 11:46 AM, James Prestwood wrote:
> This shouldn't ever happen, but if it does we want to alert the user.
> ---
>   src/scan.c | 3 +++
>   1 file changed, 3 insertions(+)
> 

This patch was redundant due to patch 5, so I dropped this.  The rest applied, 
thanks.

Regards,
-Denis

