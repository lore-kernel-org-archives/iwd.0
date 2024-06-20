Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8241B14E6
	for <iwd@lists.linux.dev>; Thu, 20 Jun 2024 16:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718899450; cv=none; b=RJpfU8A7ygAyd9gdhC8pkdIBDb8pbG0WN30CPTCFvfNRid0WFulxpR/9dmy+vIS5itTP+S+ZJqmNzQNf+cjGkPeh6MfjZaq7zZrMFmk/t0TBNXQuzZbkclgoRUM6EPxROfG/99nic7DD7f27SsVbFctnuXPENs+s+4OTOcnBP54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718899450; c=relaxed/simple;
	bh=SkHg6HEVPsIgVMoqLkCkKSFLoofw6Ft0AmEyRMKkFG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MzjnF6r6mV0nJSanG74YfUqRa5YbBUWfy3S7Sfj/o4cV7H5iPOvPUF5s5kcr4uJg1WjCkBOubQrM1uIwjTTMcBFDqA5G7Dpm/ZGBPZig5anl2etTKZemnpbZ9JdHLD/Wg1pPkX1EvgSKcBu/BOwyzH6EZ0KpACoTXsEqifsz6zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QBbgyya4; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBbgyya4"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1f9bf484d9fso9418055ad.1
        for <iwd@lists.linux.dev>; Thu, 20 Jun 2024 09:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718899448; x=1719504248; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OEZvHTwmF0tJiKbkKZBK/4TzwtbcqCMhHWp7KbrcYoE=;
        b=QBbgyya4ADwNuh/aPAWuD7e9h9jTd1ta2S57Ld2s1ecSw5PJQruTu0UTo+o5uzXfIj
         AZOgh+npPibF43y4wpN6+XDoYMgCyUOF/LxVjGwE5JTjZa0SHQiXaXpM5UikA49WKkEZ
         MQRxM506sYPMVtpIjc0lxgxCStP3cukwL2Do6exjoFv9K6gJkz7NNviu+rXfQH8SNeTj
         VhJcUbTlbEjjtE/oPo+kOWWYDrS+gI4WhlxT1Sk7zq36qK936jZYHnB667WbzMk0guhx
         8qiFLquyAfR7Rxsp3Bdcy9dCz0OyHWY6cyXsxMXmd0XDR/hEFLQgmns8dKvRXqtkB5kc
         ZarA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718899448; x=1719504248;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OEZvHTwmF0tJiKbkKZBK/4TzwtbcqCMhHWp7KbrcYoE=;
        b=qBUjlcfRugrAEcnsX2bVw4JPHG8aSIN3Q/Kr9vFIFdAyYvhCC4diz+dVyRCLXo0it9
         GZp/6lgpQ9WSsaF6WVQPeN8f3DM30v/1uhIv03sTAjqlvaPU+rShK8S/YiTBQUo3YBWT
         kltZuHFrUHEY5NeauEJz6DDizjNZZjbzT3m55+7bvO/kdYrCbVkK0mKK9/WACPAVy3DK
         1AX2KHM/Uf3CBNO5GS8P5SNjn9u8wWbpQ+AO597GylssC9uC+fBJOKQq57Mwa7qzsUfR
         W0dvgNsuHAM1CP544/XmCMMqJ1v5cVHMdlMA0bUHy380bhWKI39EZMtCU9H+mJU2Tmdy
         Co5A==
X-Forwarded-Encrypted: i=1; AJvYcCXZGJ+7T8j1B9ugXCkxSKCSFrxGEfRMJpcYvdnPZC6JejOJCm1+D4ycptW0PdFlfWVPSv8lpkhej0C157l0CvplhjXh
X-Gm-Message-State: AOJu0YyrlGaJlujyWm4sSqXDRTCdNYe88+bFvzocJ8FmJke5vqcxMT3V
	SVTydQs6av2HZUvStLxMXe2X1KS1Q8bCKa3405QgK1pbMrcC3loNPeUHQQ==
X-Google-Smtp-Source: AGHT+IG5dV9zoWqDKGzUCHxbcpUDXiRXpZPLPGNXnSfp3roC1axpCuSwQacLXpXN9TzhMo8dRel/xw==
X-Received: by 2002:a17:90a:d911:b0:2c3:2f5a:17d4 with SMTP id 98e67ed59e1d1-2c7b3aa6398mr8371656a91.4.1718899448292;
        Thu, 20 Jun 2024 09:04:08 -0700 (PDT)
Received: from [10.102.4.159] ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c7e4ff97eesm1892167a91.3.2024.06.20.09.04.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 09:04:07 -0700 (PDT)
Message-ID: <2e66dd82-bcfe-4bcc-9eb7-13c9532e6581@gmail.com>
Date: Thu, 20 Jun 2024 09:04:04 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: SAE/WPA3 in AP mode config question
To: KeithG <ys3al35l@gmail.com>, iwd@lists.linux.dev
References: <CAG17S_P52iGw9j12MrP0OwL7ZxENH6gj17er1vXR58R3qRS3Kw@mail.gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CAG17S_P52iGw9j12MrP0OwL7ZxENH6gj17er1vXR58R3qRS3Kw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Keith,

On 6/20/24 8:58 AM, KeithG wrote:
> Group,
>
> This page shows how to set up a simple ap config:
> https://iwd.wiki.kernel.org/ap_mode
>
> The AP using this is set up with wpa2, I believe.
>
> How do we tell iwd to use SAE/WPA3 authentication in such a config
> file? I also did not see a flag in the help on setting it while using
> iwctl interactively.

There isn't support yet in IWD. There was some prep work done [1] but 
the actual support for the AP to enable it has not been merged.

[1] 
https://lore.kernel.org/iwd/b2fa3788-dce9-4ce5-81a9-b4fd7e4acaf3@gmail.com/T/#t


>
> Regards,
>
> Keith
>
