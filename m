Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32C728F7
	for <iwd@lists.linux.dev>; Fri, 31 May 2024 21:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717190590; cv=none; b=CfWtzswkneeSMY6PmwgsS9R9WGMIuui82QWOSQXhVwAShLca7NC3RJvEMM3fCmecMzHwHMEKTsljMTxlLgHQ99KqX8j6n/s3XE7XI7PIm6VCYTGSiqWrDllK8YmaxDpjNhzcXVq3cJhQHOCwOI7FfrC0aFWxDPONo4t6YslP6D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717190590; c=relaxed/simple;
	bh=o13fjomuTf/4xeWCUszFmIikMC4yadEMytvkUK8/hgM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=B9al2lQNWrYuwZ2R0ORKT/r7GCIiJPFYPxc8/RJqGs7V7K7UALVplfBZOwQpImIHlXntAwewdV3/ieuZkBxJ2Hc4KZXh3cnKf6INXzziZlG1voEV0/ktWjSUdwa8SweMzAwM9yoX3NAPqUMB87iGuW7kI9QuT482i2kpMoV/v+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mDE3OxKj; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mDE3OxKj"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3cabac56b38so1393709b6e.3
        for <iwd@lists.linux.dev>; Fri, 31 May 2024 14:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717190588; x=1717795388; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ckO7tKdMygMFtN4p2N2wNWBzcA8Bv9h+lL1Nj+dcwNs=;
        b=mDE3OxKjuJ25B8AfFcfsiOwTPzBI0h66SBpVAL10gM+UWZm//9qbUjf5SLFNHMP0f6
         t6K9VxXq+0QjDeDYaBncgj5rK6XiO7jl80PN0IAKHOlN/ecTQIhR7cP+lpMPBAewpVFu
         9iW908eYUvOuBAfaTBrtEEqYwKLVUOHi8fxPnZ5/VdWpACFsPxCfk06gK2BMOcEWB+DE
         RWuRA3E0AKjOoox5oJxRSQRClhU1FP2lA1xXNtiZkeXKDZJZznMpC0rHxOc2h9KzSDtg
         bBvJaW5TypsyooZ4cdQ+5Ca4DdYFKQ7V+2cAn3R+zkwPcPyY3mcv9gsaAzjh0/fGuy1I
         T5JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717190588; x=1717795388;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ckO7tKdMygMFtN4p2N2wNWBzcA8Bv9h+lL1Nj+dcwNs=;
        b=oT/hBpEAz1SOPvX8U88QEg6B07ZKSMa8v2sq2ohR4cly4EAs++brtTfp1qMUM2JZBf
         EvG+899OJmT8EsN6sdzkzcWPcMSll9z7Ss6e4GB53vkZs+P38a8Eje0UhGDjynr+bh5r
         X8toxt8ju1qmHg7GKr/Jfr8eHNPFNK1JJZh/GN4PwUiKfW4OmPqX+gOKYKX92GkO0hqZ
         JSxP2oQdjPEjx/9qq/PwJsNQuQScvgRqoBFToSCnDSPKn/Uw0c6rnGQovaluQX0BQy+H
         JEHkoY68xDK1rQiC4tb4h/SYpi2XmF3xki/DrSrrg0c8uTM9b/Z7t4yT/zAxnOqFj5bg
         r2pA==
X-Gm-Message-State: AOJu0YxcALE2QjXtveK00ri9JzDF4jrLANZABwbdWiv7qXrTV8TzAM/v
	8s2MvExp9EsYotqUPQJcJ0mTUCXV9vH6D1J/BWbf4WC4TKRYvvFu4IjItw==
X-Google-Smtp-Source: AGHT+IE0sLdks/jhLDFmZQSqY8Ahz6cm5c+/CqHLgfA5vGxNuIDd3/Ea5hDAB3czMln5ADUkoMIoFA==
X-Received: by 2002:a05:6808:1591:b0:3d1:e1df:364d with SMTP id 5614622812f47-3d1e35b9c63mr3801981b6e.44.1717190587612;
        Fri, 31 May 2024 14:23:07 -0700 (PDT)
Received: from [192.168.1.21] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-3d1e1a4615csm485260b6e.42.2024.05.31.14.23.07
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 May 2024 14:23:07 -0700 (PDT)
Message-ID: <7dc6dcdd-edd0-4309-b3be-7eb797d23f66@gmail.com>
Date: Fri, 31 May 2024 16:23:06 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] build: Add notifylist.[ch] from ell
To: iwd@lists.linux.dev
References: <20240531204549.727842-1-denkenz@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240531204549.727842-1-denkenz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/31/24 3:45 PM, Denis Kenzior wrote:
> ---
>   Makefile.am | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 

Applied

