Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0417E768
	for <iwd@lists.linux.dev>; Mon, 22 Jan 2024 15:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936206; cv=none; b=aLV54O777cGCzSKE+382w+nbJx4+UQ8kEvyrRZ9JpmBxkgpg9+VGxALS0PeqEzcY1A/hJPo2FhyEKy8B8s5Cx4Njok11KOOnG1hZ7qfTbuM/REAIGCLH47vfAYW4WyZqWlfvHA4bIHJlETBBdGzIdqlS6b4Cx8C02GfCrnHUgyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936206; c=relaxed/simple;
	bh=M4DFseToxCC/KWMZ5hOuqZdqpljuSdQBpWnU4Fa/+6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=S1FyN0T7FH9SpyJPEtX23hqfnZQzbgcBifnGRgrSvzuj+AUyuzY0h5xrwaFWcQyXQBd0FInOq8mBYhTXhZ1kBC68V2UX2LTkEOC6qUfX4cvSMAgemqU2UvGA7lZRnvjFJlFFyMR0Z3tCtGvPAGdQYsVXNzQVYrde9wKhnxMj5gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nsyE74DM; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nsyE74DM"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3bd6581bc66so2599619b6e.1
        for <iwd@lists.linux.dev>; Mon, 22 Jan 2024 07:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705936204; x=1706541004; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tte9jBUI3Nl2kfa7woXZyG6jJpdFEK10oIGhFiAVt6Q=;
        b=nsyE74DMFGJP/p8zKQHck/3nSmpJ2PR9bit+7jXCIHBDCjIfdyz6ylmOEs3P6xQcco
         cw3QLTREF0EC95d/BSm+lNua+UwYgEKT3fTAJ4SXUbjFXb0YtjkI7iXNJ7M2rnGfo+CK
         vkKj4YLX21K2aS7VE5h4DmeeTaywKUfTj/OtNeseUeJMDpjAhUx+u47TosZ+ow0R8n4L
         My5AKlM/8TYT+CPc5VDmjvPUgIHn0rtP0Hb3kj1mDI6pnz63hvuwAoc7LmR9v8DidwV0
         ySEHEcivWWSyWiLNzZlB+HmuDs83ULpQpK1KEHCGcg52KxLuxnLN9s1MTTXJIa4SPBr2
         BQFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705936204; x=1706541004;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tte9jBUI3Nl2kfa7woXZyG6jJpdFEK10oIGhFiAVt6Q=;
        b=KErgGM7YritSIvsHsyQ9zH/gHzxzJ6/PfA98lSUDdqjJarF0Gmu/k9Ti2uaX0kxOE7
         wQk/nqHkU+ntWWsJEhcCj4VZdOqfak91O40SRU2uDhpW1tsG0lxzNYdVyFvJR9iWiJcc
         NqK7+U+g2svssJnoyHrvgbJjtlCuNL6Lv2UCuyWhwe4TJGj/WP8Z1iHw/Yc6r2RcfbTK
         0eW7kqLe2j+HbMwxrwQjDmQQeV+QAnJoB2qVZ+PE+rnEsHDBPBRpID1Kjnr7H4VjhBh0
         XglBhpSJ7pUvN4cVqSEtZ4d/AVKyW7dxQZ51dUZyyLVdqUy6mYNBQM8Y8k2lSFGq9xUx
         l/uA==
X-Gm-Message-State: AOJu0Ywzvs0KR2UYUARWJPEN16chi647M9Cv0FYY8Bzjd7R/EJoqIdMB
	XFUTh7mZRHRsquVB9zzUI0QGhZvx6+MpNR7JlK39oXRaJOiUWyot4lHCWuA8
X-Google-Smtp-Source: AGHT+IGNH28hKTHMZb4FjWRMhwmhecVKGW5Pd2QJm9vjiXTy6eIQKMhmIrhvSpgHPS/9sBfU39bmhg==
X-Received: by 2002:a05:6808:3a09:b0:3bd:9091:6576 with SMTP id gr9-20020a0568083a0900b003bd90916576mr7413214oib.58.1705936204510;
        Mon, 22 Jan 2024 07:10:04 -0800 (PST)
Received: from [172.16.49.130] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id n26-20020a05680803ba00b003bd8a7953a5sm1751925oie.19.2024.01.22.07.10.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 07:10:04 -0800 (PST)
Message-ID: <ca3f8c89-d11f-4017-b76e-eb30101d2e78@gmail.com>
Date: Mon, 22 Jan 2024 09:10:03 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: test failure with LTO still present
Content-Language: en-US
To: Andreas Radke <andyrtr@archlinux.org>, iwd@lists.linux.dev
References: <20240122104541.74f1a697@workstation64.local>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240122104541.74f1a697@workstation64.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andreas,

On 1/22/24 03:45, Andreas Radke wrote:
> When building the Arch Linux package with lto enabled we are still
> getting this old failure here:
> 
> PASS: unit/test-eap-sim
>    CC       unit/test-sae.o
>    CCLD     unit/test-sae
> /usr/bin/ld: /tmp/cc7oo1S0.ltrans0.ltrans.o: in function `sae_choose_next_group':
> /usr/src/debug/iwd/iwd-2.13/src/sae.c:153:(.text+0xb9b): undefined reference to `__wrap_l_ecc_supported_ike_groups'
> /usr/bin/ld: /tmp/cc7oo1S0.ltrans0.ltrans.o: in function `sae_rx_authenticate':
> /usr/src/debug/iwd/iwd-2.13/src/sae.c:197:(.text+0x2e21): undefined reference to `__wrap_l_ecc_supported_ike_groups'
> /usr/bin/ld: /tmp/cc7oo1S0.ltrans0.ltrans.o: in function `handshake_state_free':
> /usr/src/debug/iwd/iwd-2.13/src/handshake.c:49:(.text+0x3455): undefined reference to `__wrap_l_ecc_supported_ike_groups'
> /usr/bin/ld: /tmp/cc7oo1S0.ltrans0.ltrans.o:/usr/src/debug/iwd/iwd-2.13/src/handshake.c:49:(.text+0x3491): undefined reference to `__wrap_l_ecc_supported_ike_groups'
> collect2: error: ld returned 1 exit status
> make[3]: *** [Makefile:2279: unit/test-sae] Error 1
> make[2]: *** [Makefile:3016: check-TESTS] Error 2
> make[1]: *** [Makefile:3366: check-am] Error 2
> make: *** [Makefile:3368: check] Error 2
> 
> 
> This seems to be the same error reported to the iwd list here:
> https://lore.kernel.org/iwd/c4b50311-84ab-236a-e3cd-49371a9d7eb4@gmail.com/T/#mbe4525effbbcde51a291ece026da1a25ecbfcbc4
> 
> and also Debian and Gentoo seems to be affected as well:
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1015432
> https://bugs.gentoo.org/877755
> 
> Is there any way to solve this other than to disable lto?
> 

We hack into and overload ell's l_ecc_supported_ike_groups() for the purposes of 
this test.  This solution is non-invasive to ell and works great on non-LTO 
builds, but doesn't work with LTO.  Short of introducing private methods into 
ell for overriding default behavior, I'm not sure what the solution is.

[1] https://git.kernel.org/pub/scm/libs/ell/ell.git/tree/ell/ecc.c#n98
[2] https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/unit/test-sae.c#n41

Regards,
-Denis
