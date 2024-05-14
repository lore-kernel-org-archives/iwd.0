Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B4A17EB87
	for <iwd@lists.linux.dev>; Tue, 14 May 2024 15:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715700440; cv=none; b=dvRKh3cd7pdG2oRHlB0C5f9dflteepU8Yz3iCJ99dUeHTyEOVvMOLbzqeTZqxTZyx+Z+JPsYd+cPHpdNv0AW2PHKzQhbfvvlxtYZwabeLQRzh+aQ9GABXVj+DoNBVHWI/em8N9zrNkfcJIYy077h0uUBhXNtASOAh6/gvm/MfbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715700440; c=relaxed/simple;
	bh=wOYG3Omb1Gb8Fsdher+iA5DAG3FeX305A0tslhsRJYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VIME9aoNoZwwzp6eHvYZo4ehGXZbetlk49U4Z404NjqNYve+RM8wok49r4azsNc04fLtks4LDLhrPiBsI8Xsb+qt/QXMEhHlUBUzveX5JdCIAvXTHhrnP0Eh1pvHKThOTs1sAfePSTA1P3Jt5z3AoxRk+8Di7UXWu34PYgE9w7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GsrTmanS; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GsrTmanS"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1edc696df2bso49616425ad.0
        for <iwd@lists.linux.dev>; Tue, 14 May 2024 08:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715700438; x=1716305238; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KeL3BpUVPWWvuszrcw2n97GildLCoNaY1ETCNgzLMyE=;
        b=GsrTmanSLS/vp666b4l+i3F8L+fewCi7XckSUqsQTr4OXaAe3ftGxFDtkeA4U1nRRk
         f8PsTunQ8wnmfZJ/FQaz/ZWAreAKY49JJwsnMFt2DRzImSj2feugHlohWqInUqACjzaZ
         m8iqmK4HfikzVzAu9WLkPcryqyCnbjUwHFeHfuAO4BgWJaqAuGBN4Wq+uZiL56+Wa3Kz
         cn8R/7PPmMag5Ec3LhbLRtvYTt2RQdeeGIDFoGlDWRjSUVrBMcHajTnAdGjQsx+p5nV7
         782AA9+Lm9XaO56Pxrt7JjFhpBDH6V33u2A1cHfHyXibjNSU2dQzuPVJ5ynsmCpCiuFV
         D/KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715700438; x=1716305238;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KeL3BpUVPWWvuszrcw2n97GildLCoNaY1ETCNgzLMyE=;
        b=ZjApgo8l5jHlXRID5W69euLqZAwqJX0FspDWTHnHITBkUXeIIfZYQINrqQyi53YXlD
         dN3dIsQrRgTRKOqvougxsWTjH+S4ErLn64JScMbN24q/aPciI9srUGN3qJn+EULeX/wD
         V96l476t/VKu5xKWZyuW3EeB/Rctdvy7harpKaTjIckDupOtZmykcEFMfJiEthN2n0Sk
         kAywBfxjRUxI7tkRCjjgI8MAE9XUeQaWzGopArZyAevut35tHoR4McVoqbJpF3LyTRg5
         EZKJ0iVa2fL9y/fwvtJNsNLPYDrh/M0Rxen7fBa69Dx22WoKaBF7pwD3rxKP7vTSjdGg
         Gmrw==
X-Forwarded-Encrypted: i=1; AJvYcCWUzqirLx1hUCxN0D/DSny3/YEm2ePemJvnOl1AACInBPIZi1SKNJPmpxOMV26Bl6g0iHTv1PZxXL1t1skzmjIWa6vs
X-Gm-Message-State: AOJu0Yyu9NkbQgvf0e+Ulo3jOTRV3Q3gsvSEIfbrrNW8E7UMoBM1QChp
	wgt12v8o2Bx3kBWrKhiZKn3d3kAnHSnpD2AAaKwziQGLwuz7ZiUp
X-Google-Smtp-Source: AGHT+IGz+OgazXPwtMcLoYIIIlMF50FfgcxS1azDqSeot5V9apwy5L09/Ciclafjt0WiDBAqbh0PlA==
X-Received: by 2002:a17:903:245:b0:1eb:7aeb:54f0 with SMTP id d9443c01a7336-1ef43d16eebmr173016945ad.5.1715700438471;
        Tue, 14 May 2024 08:27:18 -0700 (PDT)
Received: from [192.168.1.21] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1ef0b1b1d13sm99053305ad.0.2024.05.14.08.27.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 May 2024 08:27:18 -0700 (PDT)
Message-ID: <63d79b11-3f93-4d48-94c1-28145f774371@gmail.com>
Date: Tue, 14 May 2024 10:27:16 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] scan: remove force_default_sae_group from scan_bss
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240513180042.257401-1-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240513180042.257401-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 5/13/24 1:00 PM, James Prestwood wrote:
> This was added to support a single buggy AP model that failed to
> negotiate the SAE group correctly. This may still be a problem but
> since then the [Network].UseDefaultEccGroup option has been added
> which accomplishes the same thing.
> 
> Remove the special handling for this specific OUI and rely on the
> user setting the new option if they have problems.
> ---
>   src/network.c | 3 +--
>   src/scan.c    | 3 ---
>   src/scan.h    | 1 -
>   3 files changed, 1 insertion(+), 6 deletions(-)
> 

All applied, thanks.

Regards,
-Denis

