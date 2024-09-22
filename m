Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D36E374F6
	for <iwd@lists.linux.dev>; Sun, 22 Sep 2024 04:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726979001; cv=none; b=E2TMkTpZNe4IPZS8Mfok9w+Dp10xwKzv6lNUOXstmNUGPo4T2KML/8oJ+aWzh6n/l/QvRcuhwjB3PNYUE/WxwrPc+1MwqdeIutigb0YAaIDcTSV7ADpbXpva983fMVhwZaJcz8MYU4VcaqUf+0CVNz42Y189MBO9HutgwhR9m0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726979001; c=relaxed/simple;
	bh=0KXNVXkSupFaqIPhG9LZPA6idTfWj/m/xNnNSyBdVVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ad9QqD1Ky9CALQ3+lujBRfS0GdhKcrqHjkXKyGCAlbarw9ZzaG9C+h5ho15Uxo7lzecMtLTtXX1h+pzyINhsBzbxNOb+JBLWdLT57RucorQvTsD7GQTo/tOFeiGKokOwp5qrTCeOx8fFai/q+YNuD5ErqZX06cTi4Kw4hdm2FCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kALfuCQI; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kALfuCQI"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5da686531d3so1941736eaf.3
        for <iwd@lists.linux.dev>; Sat, 21 Sep 2024 21:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726978999; x=1727583799; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8VRQJEfXRrNoz15zW+H0jGtrZkf7vfk5Jg5uYKEnHUY=;
        b=kALfuCQIHCICb3Ed+wnNaJHr0QzeVVGR+yd2wdR76ubtGD3bC/4XW1Y6s1B6OQvFx/
         rm6mG+2u9i5NYvp74uDuhTc+s+nK0XDol6RbAO681BDBUw6JUAjX/LeJ3DE32kFYDzFB
         uQfgLIoQBn/0gEvI+CuLGPYM13ngomUxUUPhU6G140GKihOQEjucs8GFxM2UuR2sWnp9
         yiIJpA3a4pMay5q1BzhM+K05F0uV1xftD0KsG8Oec+RwYPdBwDD6GmNob3hZk0GnUQ6K
         SIyDSQXlQtKwJKIIy5/ggsFn9NKRu6oEh5OhhZXyJcwYOim7vCltVUH1Vr501wwW0J9Q
         fY6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726978999; x=1727583799;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8VRQJEfXRrNoz15zW+H0jGtrZkf7vfk5Jg5uYKEnHUY=;
        b=MvQDnBXCFGQz+S+b3gzAwCPxOHgpElyA+VvoEngIdtuFhqgO9aIgv0nTh0vs92mnQu
         51IEgAS1lxSGEokG93Xn1B9PMBHJcP9EL2AOKLApL1WuSVZxMNKTcCJu2cLHJVH/L1Ji
         e4sNi/yCdE40gJAww53fLwzQ/Kf7bk69GeaibjHFo1GrRlypt0Yi/I0xL/MNHIE+ejX1
         8YHsK9+olv8DANuuM04oqp9nFk8dX3dMMtGuzyJ8LvZIG9zSYDLYUsZfIfkNI8Vqao7a
         r1bmEzCAh2KJKXuqafwoitvAELClyFMEd5Abyw+KwMxmzkPmkx5+I4Tk4zN8wp5v0NXz
         w8Gg==
X-Forwarded-Encrypted: i=1; AJvYcCVquzDUmEOLxN7jhz+4MGTMx4by6d+B6+DLVkIv+52jT8skxCXTX3L/HkDG9fPoqc6lKFY=@lists.linux.dev
X-Gm-Message-State: AOJu0Yxz/asBg+Fjy/bMDl1Sni2lARy4zpT/KpdHwnW3qvV7MXwyKjGE
	HPNJasPimtRGhDcln552mW86FhGzofvqDOkSldKRRCkkVgTd2fYU
X-Google-Smtp-Source: AGHT+IGm25mWmbwNYUisUyJ1o425yEjSQ5NWOmOuVU3b84C9CXQzVgosE1bpXtbxxlg/hmouJ7ySTQ==
X-Received: by 2002:a05:6870:470a:b0:26c:5312:a145 with SMTP id 586e51a60fabf-2803a5edeb3mr4915956fac.16.1726978999244;
        Sat, 21 Sep 2024 21:23:19 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-27d0b395427sm2144244fac.10.2024.09.21.21.23.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Sep 2024 21:23:18 -0700 (PDT)
Message-ID: <490a625e-a204-4505-877c-27494413a55e@gmail.com>
Date: Sat, 21 Sep 2024 23:23:17 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/2] External Auth support
To: KeithG <ys3al35l@gmail.com>
Cc: Yuxuan Shui <yshuiv7@gmail.com>, iwd@lists.linux.dev,
 Arend Van Spriel <arend.vanspriel@broadcom.com>,
 James Prestwood <prestwoj@gmail.com>
References: <20240823174220.498594-1-denkenz@gmail.com>
 <20240921185902.170612-1-yshuiv7@gmail.com>
 <ba78a253-de77-4427-85c3-d876ef9fdd8a@gmail.com>
 <CAG17S_NOs=rdUFsFRk4ZPsC=GER2J7nHikGEw=3AW0SBYHUEfg@mail.gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <CAG17S_NOs=rdUFsFRk4ZPsC=GER2J7nHikGEw=3AW0SBYHUEfg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Keith,

> 
> Just to be sure... Are you saying that both wpa_supplicant and iwd fail the same 
> way, but wpa_supplicant ignores the failure and still connects?

Pretty much.  But really more by accident than design.

What happens is:
   1. wpa_s completes the SAE handshake via external auth
   2. It then (without waiting for the connection succeeded event) uploads
      the resulting PMKSA into the kernel
   3. Tells the firmware that the handshake succeeded
   4. The firmware nopes out with error -52.
   5. wpa_s then times out / fails the current connection attempt
   6. Re-tries.  On the retry attempt the firmware picks the PMKSA cache
      entry and uses that, skipping SAE step entirely.

Regards,
-Denis
