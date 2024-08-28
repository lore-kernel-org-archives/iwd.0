Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92857288B1
	for <iwd@lists.linux.dev>; Wed, 28 Aug 2024 02:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724812795; cv=none; b=udQE7B++Cjgv+q5g2PxSOpw2nkfhQomSbEMVx2u9sTnAVczIxenDRkJ0lFnpA0Ke3Cr99jmguQUWrx/RO/6OrexEgla/R7gQlp0QFBJc0e/Sfp28HePscAOFBfLuEHTMbZn3K8xwzzjfZdpbNYMd077gA1E5G4m1yX2Kl+UJbxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724812795; c=relaxed/simple;
	bh=Tp0qThecWrzVyLF18urUC0Z7zE56XqLblm+ABu6UzxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=i4x5l2dorO5+0QANaZ2wa0yVS05Q0QN+W1VvWf8RabeztAuMJQ7Da1Mh21jWruX//9RzDkUHHut3fYSSEc6iYcjqU7TxwNeUktCtwy8L8jJ5JKF3u7NkoDAuFRA4U1UaKtdAEkrDLIo7oRCyoBnAMYbRvQvnstnoWDUdgyztaQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E8mkMpTl; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E8mkMpTl"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2704d461058so4352928fac.0
        for <iwd@lists.linux.dev>; Tue, 27 Aug 2024 19:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724812792; x=1725417592; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PaTTWaE2vtEwnJIDCyeT8IBBkGMBsMUtpl0pO8xjZ2Q=;
        b=E8mkMpTllEXTajDTQQzyUXsehXkhX40kxeklItyUQQIOKvpMbO7N8u8qAspvHFX6Vb
         LYLGRC2iWJ7LtRd6PFCMC+O4e9JLhNMUO5Noay6k2/EHWTl3mwOsS7RmPRPnJZga36BK
         k/O2F8inOXMsmZ9elUXa+n2NSPZrq1WleKgN75QWDVmhyahRb7+CJ8++3hJQ3c85zS4a
         wMOcTyP2KPyoh3rN0C5yYvzms6zvo8Wdj6yqpMBmiV6vM3i9cIwfYPD24aNDkSIyq2XM
         R+TV7wMzbXJZuOLdRbbtIr3SDdZvkmZpLcffxdE2wnyCqG5bX0hrbCEWQZZg0bokTvKS
         e/yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724812792; x=1725417592;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PaTTWaE2vtEwnJIDCyeT8IBBkGMBsMUtpl0pO8xjZ2Q=;
        b=wRtW0g2Fue6gQa6X6gTfZ1kBHoEC1ezbI7EQgbicOATb5bGxZo8hCpBwRv4ZjdKcxN
         td6Zyf0q5oGtjeQgJFzAbhrR5liatVkIR5N+aDLZEqiuymghbNUb0DDx5aIsLX7WxeaT
         bl6qd6zebWzo/uIUfv4zCr46/zdBm1MB0KfviDjrQdjqywQ+yqdne2yYNH1vHF+WyITb
         zEoMlDyVpEDdhEfcaKxJd0ZQu7boIckTDO93tzwij+sjiZVrikg9U06uN8/E0y/I8r12
         yPAqIYrwNiwr35zV6gsABFoyu+88y/i1mHTZhGu3QKl9ZtYoHXHTJ+eV3wVc/o/NVPVU
         6s1g==
X-Forwarded-Encrypted: i=1; AJvYcCXiiDbyd2KkSOgRVeysMaWFPi/yqhDzFc1BrNSTUJaGmAKbfOvku2Gf1O7eynytQfuDDIU=@lists.linux.dev
X-Gm-Message-State: AOJu0YyYZO0WAwcwi2wH4FWVrPdq3Kh7EmrbMdQ3RxwsCpOT1WMgcBtt
	VGZyOEbqVqPrt9+7WTELKEVs6w7Xltta8uJBA0mprXd3kPsUk1uQ
X-Google-Smtp-Source: AGHT+IGivvPVWpjd2Fy0zWksv6OEgwgtZ/Ofd18EEeZzeGxplYrSo2jwRFeAsb5iDqVfVtUQIP1/eA==
X-Received: by 2002:a05:6870:15c5:b0:270:8dcc:30e2 with SMTP id 586e51a60fabf-273e63e6f0cmr16875868fac.2.1724812792652;
        Tue, 27 Aug 2024 19:39:52 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-273ce996b37sm3563881fac.3.2024.08.27.19.39.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 19:39:52 -0700 (PDT)
Message-ID: <65ee253c-690c-4dfb-ac2d-637266b01ac3@gmail.com>
Date: Tue, 27 Aug 2024 21:39:51 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/8] doc: Document station Affinities property
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240823222339.328006-1-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240823222339.328006-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

> diff --git a/src/iwd.config.rst b/src/iwd.config.rst
> index d9c94e01..2d1f6dcd 100644
> --- a/src/iwd.config.rst
> +++ b/src/iwd.config.rst
> @@ -130,6 +130,22 @@ The group ``[General]`` contains general settings.
>          This value can be used to control how aggressively **iwd** roams when
>          connected to a 5GHz access point.
>   
> +   * - CriticalRoamThreshold
> +     - Value: rssi dBm value, from -100 to 1, default: **-80**

-100 to -1?

> +
> +       The threshold (for 2.4GHz) at which IWD will roam regardless of the
> +       affinity set to the current BSS. If the connected BSS has affinity
> +       (set in Station's Affinities list) the roam threshold will be lowed to
> +       this value and IWD will not attempt to roam (or roam scan) until either
> +       the affinity is cleared, or the signal drops below this threshold.
> +
> +
> +   * - CriticalRoamThreshold5G
> +     - Value: rssi dBm value, from -100 to 1, default: **-82**
> +

as above?

> +       This has the same effect as ``CriticalRoamThreshold``, but for the 5GHz
> +       band.
> +
>      * - RoamRetryInterval
>        - Value: unsigned int value in seconds (default: **60**)
>   

Regards,
-Denis
