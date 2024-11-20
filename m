Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E017912BF02
	for <iwd@lists.linux.dev>; Wed, 20 Nov 2024 17:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732124175; cv=none; b=ez4M0BsZ8OPxIzh/UhrFpjzDUw1bseb2Dl+oqKh5M5Rr/xwclc8sqFvrbw4WQznZkjpXHLBMNHJQr6mikwK4BEmCepjlf1sJTGUaSvdCnIEZaufeKI0EkVAU6c+1x9698Z5j0fJUEfGKadQOyY5oPLoAyalDGiuYP1AVa0mjEuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732124175; c=relaxed/simple;
	bh=WVV+uJVbfjq+tMwm3D2Hh9gDxDVmb30r5w5jDIqEDNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tb8nSO2Sq/sKKF+ugrZrWeGLYUul1KhNCoqtprVxvpZ8v4veAzzI3NNX6DH/BtQ8r7nyFAXnZk0X1Niziz1vgEX9RRz0j7xobXAGXSO6h4YDvNkildgnLDmwaCXssFQRp0zkHlYC+8KsBL/m1IK4OQq9wFbKGb/Lf2PbNmxT3hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kPL5K84v; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kPL5K84v"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-71811707775so2393251a34.3
        for <iwd@lists.linux.dev>; Wed, 20 Nov 2024 09:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732124173; x=1732728973; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BMxAfuCcH2anX3nDf9BniSzYv0uaqx/moWUlawH4mtY=;
        b=kPL5K84vv17AQCgf9GBsu+rRqBoCwQf9yTOFMfJKHWyz6MjKJ/3CT7lOZTxZdxTKEQ
         FhcdXolkRJMq12/NNBPnzfO3+XMRAkyhhHC2zoWz1h6CMX2ALcA054rCWdVwjNdjZxeU
         3P0roINI68D5kZvGL3SG2ouFPRPsucN0J6vxgulAtm3YVkCp/5gPKR6VNqIRJPsLgygI
         u9gtoAs0Pzk7RAh4KNpcNr1kJQIxvIu8y1UzfELwHLytgyOV4Sz0ajxrMcAZkGh2yVs6
         1W53iyLMskKH+hP/iroNDq6KEMEAwaTSnvIDjDLn580w4lFw2y+N+7z211gKAkRPwRjA
         RC4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732124173; x=1732728973;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BMxAfuCcH2anX3nDf9BniSzYv0uaqx/moWUlawH4mtY=;
        b=YX/+Lhyy78yvxWkLl3B87e7+SvzPKjSP6VC08xqTDeIxTL8WztfvX4D1ZROi1QekkO
         fHNsd36CfZZDtMdFA80RNyuheTsQZKZV5cp4a4vlhUX/OWovamvbHkuVRbSCP+hikk5Q
         siA9W7peWFKRvkA0h0YoCjQBJoC0MYk6ZRoAdKqQmZLdLQhTA4/dfOGByYRuIXegM4HH
         RpAVLImAJ+B9TtFLBMiLJ3pELQ/4Xc8PSKqDNtfhPJMqI98kxW8weel2OnoL9ijPFG4D
         JJDlXgSbhgVSFSYD9srcHmk5egSuAobtA+KIbgz6D3IIEyEgtIam7+yh/ojayjI+UunY
         3gSg==
X-Forwarded-Encrypted: i=1; AJvYcCV+Q89Ck8LA8T25CCKQp9dtM5s78PdYOmRBcLZbcs72ldgP8OIusLobAq+sNYV6IF9UrJ4=@lists.linux.dev
X-Gm-Message-State: AOJu0YwFF1v+hKsVlHr3PCqwAXa85V3ClZM+MpWvyWz7VC02DCdPJlzu
	r+0IYPgCPGUdrmD0bjg2UTXHih+rs8QRMkMqvsJ4VOzJKsm0+CLY
X-Google-Smtp-Source: AGHT+IFPCgYk9I7jvEZK2bODgc7CKkHuve8/i3LmCMOkIc5pO1r8GyFnMzqnIi8+0d7S0J6ceEbZoA==
X-Received: by 2002:a05:6830:2a9e:b0:717:d5c6:d593 with SMTP id 46e09a7af769-71ab31c1033mr3990792a34.21.1732124172963;
        Wed, 20 Nov 2024 09:36:12 -0800 (PST)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-71a7822fa2csm4043140a34.73.2024.11.20.09.36.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 09:36:12 -0800 (PST)
Message-ID: <edaa7832-86b9-4ce7-8883-8e8c08c71cc1@gmail.com>
Date: Wed, 20 Nov 2024 11:36:11 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wired: fix -std=c23 build failure
To: Sergei Trofimovich <slyich@gmail.com>, iwd@lists.linux.dev
References: <20241119222846.784719-1-slyich@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20241119222846.784719-1-slyich@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sergei,

On 11/19/24 4:28 PM, Sergei Trofimovich wrote:
> gcc-15 switched to -std=c23 by default:
> 
>      https://gcc.gnu.org/git/?p=gcc.git;a=commitdiff;h=55e3bd376b2214e200fa76d12b67ff259b06c212
> 
> As a result `iwd` fails the build as:
> 
>      wired/ethdev.c: In function 'pae_open':
>      wired/ethdev.c:340:55:
>        error: passing argument 4 of 'l_io_set_read_handler'
>          from incompatible pointer type [-Wincompatible-pointer-types]
>        340 |         l_io_set_read_handler(pae_io, pae_read, NULL, pae_destroy);
>            |                                                       ^~~~~~~~~~~
>            |                                                       |
>            |                                                       void (*)(void)
>      In file included from ...-ell-0.70-dev/include/ell/ell.h:19,
>                       from wired/ethdev.c:38:
>      ...-ell-0.70-dev/include/ell/io.h:33:68:
>        note: expected 'l_io_destroy_cb_t' {aka 'void (*)(void *)'}
>          but argument is of type 'void (*)(void)'
>         33 |                                 void *user_data, l_io_destroy_cb_t destroy);
>            |                                                  ~~~~~~~~~~~~~~~~~~^~~~~~~
> 
> C23 changed the meaning of `void (*)()` from partially defined prototype
> to `void (*)(void)`.
> ---
>   wired/ethdev.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 

Applied, thanks.

Regards,
-Denis
