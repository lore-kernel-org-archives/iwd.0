Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EE73DB80
	for <iwd@lists.linux.dev>; Fri, 15 Dec 2023 16:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AgPBCMWF"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3ba00fe4e94so643854b6e.1
        for <iwd@lists.linux.dev>; Fri, 15 Dec 2023 08:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702657250; x=1703262050; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8zUFs6OiEIlFPFcCLOi4JPioB1IjjZK5pk0zUUcPUbM=;
        b=AgPBCMWF0OzPOCejhc9ZF4qBJ17YK8qoyszYAhuxz7Ek5ic7FSUBOmb8vJ/TP89Qek
         VovA2Mi9ZPmzg4uqJyEbZIRB8+LVEeYYqsp7pemddg3T9hP5CfMeSmq+VifbrDRbZmmi
         QJGzrUekHHnfNp5AOOEsiMmioj3xvHxjaofUOh2axUzIcRuy6b1J7598EDnYh1DJtJRl
         7BwL/VT+1385TUvvQ9Z6Rq73SkX8WLOSO7RaUfxiFMM/iRHbg+fdkUFHDUltqYsa0ReD
         rP/q7rF7/dmnNbUVLsfNZwLpJAytZAELtPLq9JE1Gk1bPIVGafZCRckbx7u65KPzUgII
         T3/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702657250; x=1703262050;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8zUFs6OiEIlFPFcCLOi4JPioB1IjjZK5pk0zUUcPUbM=;
        b=rJTKZGA4dC4tb83eYAEgNdxF2+3EYmky7Vfu3STyHI7GInXMdQruyomtTRQW2tFrhA
         iqUoW7331DsJzGxD559ZrU37LPX0tIWwHYUYqVOtBqeUfvqOivXP71BDy7bkXT4MpSRm
         gMs2Bm5mpxstgb0HqjVaiyPDgBV/HOiSSkhENGmRo2Ix39GX6UVK6jDmy7DoMv4qhVfE
         +oFq7OXwSW+T6JGEAfmBE1KP+pq+l8B2Ac3m9l+CEiJ0NCTpxkZzSqlB/6pO0EBk3Wt2
         JpUlnXQwPkWjOCq5R2Xy40hih7WW9PAFkBppourQd3ItaCCKyKqfe7TgOHaTJNH/AZeL
         Trpg==
X-Gm-Message-State: AOJu0Yy2VdYLMW9YTBzkbQOfycSvTrcqMDXSwjbOFOh9p9Y26ok27rQ1
	PYUDlKWDJe9P5UCI2I6KchA=
X-Google-Smtp-Source: AGHT+IFsDSQnP1aZzv1gl6TV+oG1nD2UzhCQeR+9Rgb1+dhGYhr0DfBDBnP5cIVhiRG0uUVySTSaYw==
X-Received: by 2002:a05:6808:13c3:b0:3b9:fc7c:b589 with SMTP id d3-20020a05680813c300b003b9fc7cb589mr12781362oiw.53.1702657249808;
        Fri, 15 Dec 2023 08:20:49 -0800 (PST)
Received: from [172.16.49.130] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 7-20020aca1207000000b003b2ef9778absm3810169ois.46.2023.12.15.08.20.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Dec 2023 08:20:49 -0800 (PST)
Message-ID: <1af0dc61-137e-454d-87c5-4e02f766d504@gmail.com>
Date: Fri, 15 Dec 2023 10:20:48 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] network: add support for SAE password identifiers
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231214123400.12924-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231214123400.12924-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 12/14/23 06:33, James Prestwood wrote:
> Adds a new network profile setting [Security].PasswordIdentifier.
> When set (and the BSS enables SAE password identifiers) the network
> and handshake object will read this and use it for the SAE
> exchange.
> 
> Building the handshake will fail if:
>   - there is no password identifier set and the BSS sets the
>     "exclusive" bit.
>   - there is a password identifier set and the BSS does not set
>     the "in-use" bit.
> ---
>   src/network.c | 37 ++++++++++++++++++++++++++++++++++++-
>   1 file changed, 36 insertions(+), 1 deletion(-)
> 
> v4:
>   * Moved the checks out of network_load_psk and into the
>     handshake setup function. This is more consistent to where
>     other BSS-specific checks are made.
> 

All applied, thanks.

Regards,
-Denis

