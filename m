Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C0917EB87
	for <iwd@lists.linux.dev>; Tue, 14 May 2024 15:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715700327; cv=none; b=o2mdOHCJ7vIH0JDVKib5+7atcdNv22uSmLIU0F8NfsQW/4io/UL4c5KG7EiAWeMDMQQSPp6L/QMfoVOmbchmwKEpQEJ+J2YIue1vbqd4e2MVddeUA6kCTJ/KPfumWI9yGXX72KIR1w8w8IX4z5FX2btUMWiG5V5nGVLdl7hawfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715700327; c=relaxed/simple;
	bh=JKwN5wMkz4RR7lpRVeIjpdxQ3uU0FQvOOl8WCBAZBys=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qgkAuKVLytpgY3oOzJ/oR5bzb6iMZtairStDiqzChIMujS+2dS9mtn7WP4YwFUutzHTEr3/QF3R16ApCs7KRTTUPidGMSWsToRi+lY2BnbMmVA/NqWZoADigaPaZHpHml/yQHRivrzhzu2YKC7ArFFbZjKBuMT77mfBcfWL7Ars=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OkiHshU2; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OkiHshU2"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6f0f5645c68so1861467a34.1
        for <iwd@lists.linux.dev>; Tue, 14 May 2024 08:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715700325; x=1716305125; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MLGcMkgplKbd41tknoT8bj/x+XZ6vCluQP6GY+pSPkE=;
        b=OkiHshU2nn6znNgu0yfrf7St5VKjkqtejxKk0utMBmyfdjTsTVVdePgf0quVIdJ0KH
         QgMtL8PSi7723UleU68i9oOFxcBvFpC68dxwg2ZPYkxy6q1NbSeOUBHF+0l+i+FhgBZn
         weiB8Hm/7uIlnT9e8XcYMIPoY1+eFafial6/djhpGZdvv5MbBGzQ5BwSRuan/iYZ+yf/
         Y5qwZbH9SF4ojB2cYb86Nif/P9DMUyvs9OBQnUbO/zKS1zYx1k9YtxTbp324IphjUgC2
         duLXeMqfMvnUKgB3C/pcKXMzZAei8Fh7SD8XlkHjSXgr6o9YNDKZDEXEivo+bgQJj+AO
         8sCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715700325; x=1716305125;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MLGcMkgplKbd41tknoT8bj/x+XZ6vCluQP6GY+pSPkE=;
        b=VogtMyb9GF8tLCElKHye8DAO+SaUHFoVljoaYN3Pqdy5dflXXtwzKQm8lY5GEp6zjw
         rBm5GbhC3hY0q6cA1jnSiBH8//oosdaeIGMVcyJjyqOcylx0tlIWmenCDxcDMxfiE2zj
         QHUbliSFmkm4Dt+Dob5vRdpQHHlafGj7hSGj1sbluMckzMZIVz8R3oSt9V3ijfOTpMip
         Gfw8mSpXR/XUfgcJyiG1hny3pVUfgk3X7JWKgF1ZOMAZlLgNpG0uJUdblIv7+ArtwKEn
         79bJXumDQIejxnZahAKg2Yblw+kODZJtVPC8PsOTiMc5KEQdmoMqUqA5X6zjj8AY99ST
         +mXg==
X-Forwarded-Encrypted: i=1; AJvYcCVYyMnsT0QZjCukazPF07BDNYO01M+7OVRpo6zdkD7HV9OG/Mnbu7pLluFQ1Y6S1blYocEOcihTETeYPyVT5rDRoCor
X-Gm-Message-State: AOJu0Yx/UwmS3SpKTPPrHkm9nRG6RQHbMDEvG+yI9dbZd6kNWRAyEdzT
	hvfcbObdVEPp9XczWD0CTkG4sNuJOrRCroEJDX4RV4hnUk1GbfSF
X-Google-Smtp-Source: AGHT+IEHCzOgYiQMDE8YJKTfSAEp992QUvGY+xrHtG3d9lYVCiQDbXyD/haU4K/2inMzKCRX6GUmNA==
X-Received: by 2002:a05:6870:b48f:b0:22a:4c05:2efd with SMTP id 586e51a60fabf-24172a3ddecmr15683745fac.10.1715700325219;
        Tue, 14 May 2024 08:25:25 -0700 (PDT)
Received: from [192.168.1.21] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-2412ac757b1sm2574403fac.42.2024.05.14.08.25.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 May 2024 08:25:24 -0700 (PDT)
Message-ID: <da529510-2e6d-4490-906a-ba924a531690@gmail.com>
Date: Tue, 14 May 2024 10:25:23 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] build: Create ell directory for ell/ell.h target
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240229195654.1579749-1-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240229195654.1579749-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 2/29/24 1:56 PM, James Prestwood wrote:
> Both ell/shared and ell/internal targets first create the ell/
> directory within IWD. This apparently was just luck that one of
> these always finished first in parallel builds. On my system at
> least when building using dpkg-buildpackage IWD fails to build
> due to the ell/ directory missing. From the logs it appears that
> both the shared/internal targets were started but didn't complete
> (or at least create the directory) before the ell/ell.h target:
> 
> make[1]: Entering directory '/home/jprestwood/tmp/iwd'
> /usr/bin/mkdir -p ell
> /usr/bin/mkdir -p ell
> echo -n > ell/ell.h
> /usr/bin/mkdir -p src
> /bin/bash: line 1: ell/ell.h: No such file or directory
> make[1]: *** [Makefile:4028: ell/ell.h] Error 1
> 
> Creating the ell/ directory within the ell/ell.h target solve
> the issue. For reference this is the configure command dpkg
> is using:
> 
> ./configure --build=x86_64-linux-gnu \
> 	--prefix=/usr \
> 	--includedir=/usr/include \
> 	--mandir=/usr/share/man \
> 	--infodir=/usr/share/info \
> 	--sysconfdir=/etc \
> 	--localstatedir=/var \
> 	--disable-option-checking \
> 	--disable-silent-rules \
> 	--libdir=/usr/lib/x86_64-linux-gnu \
> 	--runstatedir=/run \
> 	--disable-maintainer-mode \
> 	--disable-dependency-tracking \
> 	--enable-tools \
> 	--enable-dbus-policy
> ---
>   Makefile.am | 1 +
>   1 file changed, 1 insertion(+)
> 

Applied, thanks.

Regards,
-Denis

