Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE4EEACE
	for <iwd@lists.linux.dev>; Mon, 25 Nov 2024 17:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732556899; cv=none; b=eYDbEPa5Tv251LneksNLPyZkOi1c+gpCFkY3M7RU1jFTOxXc77KX1DXaYz1e8ZOv6EEBXo+osSVdYebdHnzvl4sNSAA4/7Yh80pHK/WUxIMGg5v0nQMnQiEPNdnWk6QvInde+StWIz6OlM7D1165rhEDQboT7zuDSTP+dBF5Dec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732556899; c=relaxed/simple;
	bh=82rsToba9PWuEE39mKE8idyZq6TUhNzUcZmWElKNdcE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=r6NTP/26wWQxDJ+Kz2KzmOSE+AaeGdM+wvVDTytXWZwa/XIRDQu+Nuk4PMD3fVfMeUnaohrtMbwmZap2RvX5BA6bZ0PsZX3KMncNWnCL6b9VATsxeYmXvyE9LRHocxIxiVyEyalHU6g+dzSiouWDu5jZtcnhqjL/5NlrjP82cN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ybe6x18f; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ybe6x18f"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3e5f6e44727so2700717b6e.0
        for <iwd@lists.linux.dev>; Mon, 25 Nov 2024 09:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732556896; x=1733161696; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kYgY7XAD9j9fsGd/5ShB8tYD9YJnqNlMGOS26RfLY/s=;
        b=Ybe6x18fBbuN1bOy1Ur2gQuBjnv4eAojbAInyKNBRO3jA2GcpeL69Mii3y+wosiHg2
         xWJ/sS+RYfvu4eFs62f0T+rd4ALQJ5oEQeEiUXy1VQu2QwCblCSChzSOu7VcJAgSQPAN
         89tzbdb/hIK235L/Jedgqol+m0SLrCdhCr38d06qTlFBLtHlP/fDyNI6Kqm6X9bKLoQa
         Ghewpas4/EE4MBGpQMu7zGVzUIJ443ILn0NFW1HMh2P9vDBt2aDENzosqh+C1PEkBOPl
         im+L4MVYrH+359mO9jPFe/em7Js6Vo2PKhqyfw/6KiXdMK+oSq763gvwZ2nyxnIwomcb
         ofVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732556896; x=1733161696;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kYgY7XAD9j9fsGd/5ShB8tYD9YJnqNlMGOS26RfLY/s=;
        b=sPQ5Fp8pr4uuvCLTVT8WNoDPs/zaNPIsBzJtDwCEWpUZbQvPy8B1af5mZK5MrkeqZx
         ZHGFmBs8BYC8vab8P1qHy/tyEXAJBE/yxStv5Bnor0hgjljCixBHdklgtN/mQT/kd/h5
         PqUPVNTh5lE5LLwbjQZPdYQSoFW2j3Tc7LI71jKDnpixlfzWAoUF4UY0nhZPpI25AYGP
         NhJyoIam+kBQZHjeS3yyRDme+zTXPaxyr1YNuiInFUSS2Wefo1rzulg4UTJrYHIfHt76
         hXiQpub6Y4p6Kfl7ALhq/8o9k0I0sAKwpmnJFpO0O7i7ZsxNpNilrBT0LtCcr9u7XH1k
         J/PA==
X-Forwarded-Encrypted: i=1; AJvYcCVrV/p3dYP0YszBkrWnJt0SmYJQYbH5i+BV1yMs1I9052LgKFNwWPNrbL6wRFvU/ijFOOA=@lists.linux.dev
X-Gm-Message-State: AOJu0YzazDgpp1WSGNd/CuQ3E7WAuFrk3NRPqalOx8TfnWb/b7il2Pbn
	VBX7TT+PD4tqcuaEkwpZS6/SWtUK2fq4ms02IG85E1RXX9Mpk9rg
X-Gm-Gg: ASbGncsfymWRsGdMBJ0XDNJVq8UBvcahKg5YSo3Ara0PwDEZJm9hwU0PtbhdQdWYeF3
	f//T3gf74StS3Zb9D5MUD0V5C/pbHyufxixzP9vgkiaXPFDANPU7h9q7reg4nM8KYzklcaUWc/3
	uUMf0+QimG7YMfeHYL0PGySpq/6GN8Hnr+baTZT5po3dUPPTlajnmTxgmnxesfuhLeZ3nx4J4yD
	wtpqWKCQr7TXDYWyAtu1L5NEtbnrdDp7EWTWp3DLJ0OhvS0wcUTbzrBQldncPNFO1MLxvudPBdu
	YdjiSUhcFaLGNss=
X-Google-Smtp-Source: AGHT+IHyZrllhKUJ51LMM7w/fTXzY4RWPQsqJ4v8gQYokeKdEbcSwJJJgD0YQA8iJt0NiISCGmauHA==
X-Received: by 2002:a05:6808:2007:b0:3e7:60bd:8b06 with SMTP id 5614622812f47-3e915823f38mr12054431b6e.16.1732556895880;
        Mon, 25 Nov 2024 09:48:15 -0800 (PST)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-3ea55d17002sm155507b6e.30.2024.11.25.09.48.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 09:48:15 -0800 (PST)
Message-ID: <778363dc-248c-48e9-bd9a-d52b0dc0d7cd@gmail.com>
Date: Mon, 25 Nov 2024 11:48:14 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] wiphy: make "wiphy" const in wiphy_has_ext_feature
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20241125150623.1014890-1-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20241125150623.1014890-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 11/25/24 9:06 AM, James Prestwood wrote:
> ---
>   src/wiphy.c | 2 +-
>   src/wiphy.h | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 

All applied, thanks.

Regards,
-Denis
