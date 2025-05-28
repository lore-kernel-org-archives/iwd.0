Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3803F7FBA2
	for <iwd@lists.linux.dev>; Wed, 28 May 2025 14:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748443338; cv=none; b=iuwosHC6rHsENKxVEFn002PADcbKK60B1oxxLXZaDtevlUyBAB6rGq8tNsGGv/mTUk0ye/SZNlnLhZtZjMOBNiQOOMvBT04K0MhTBVqXnQmJ1RIujzDHZ78ASnKrbvgKNcV7OFgexdURkSAJMHN8CNeQVCMKbANO0CuJKdfDFTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748443338; c=relaxed/simple;
	bh=tYZGSUqG79nfD+/p9OpawQaoeqgbLG1EN37AeBb+sHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LdZCExMUPBC+YakdP89D0pqERv/16j+6qByCBO3Dnrr7ulkxkEUlw4OyDBkePGWrcq54un3tfegfzmVKkGggDCrUg6sCKNL2XAhAJCUIJrMr/VfaGdt81aSC/u7iItjc5JQmnSyE4gQmTkklPDpAHRPrigXLr8GMd+myeempY2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XL1dLJF5; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XL1dLJF5"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6f0cfbe2042so10611546d6.1
        for <iwd@lists.linux.dev>; Wed, 28 May 2025 07:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748443335; x=1749048135; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ufGX+bFYWQunrth5ExhFknKxff6BU87SbhZbPFgnGJE=;
        b=XL1dLJF5UQHEL28xuKA7c6tkXqPaa+GXu9OMQjX7EPR+xcbt21g9cqVhX3+SZ1sHW2
         XRnLwVf0oHBEa9LJIjU5u8VO+/QeRUmL2TGSELv217PZss/llD/8492uJ7cnALwwPPxo
         XWBNvk0uDWVkXaNDKh46QA2Yz/SwAOwhb5SI3dKjKSf4L7eD6pV26D5rzdtRGsYNoXRW
         HU4s+c82GkEuvYbr7NnHQflKljjpu0XfCAKGjNA05DIg88V+ezQ8Aan1hMn0rG3+2DQA
         8nIWrMFKE9oXVGsRTc+0xr+k01Ls0v+tkWZKoEpQm7pJLCP2xFL2t8zRbmMNheR+s3DF
         Xj3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748443335; x=1749048135;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ufGX+bFYWQunrth5ExhFknKxff6BU87SbhZbPFgnGJE=;
        b=Wx4Hh+w8RAPYlkgp1M3o+IuWbd2fMIOGTcFlfpwGRWPqIMiBsTQYpDp9ejCQAauQa5
         55fzBt5Miy78XbEPdJjq/K9P0Kd+mNyThjpme7MQCKR37QYowBSONtPQg/mA6z01N2qC
         3Zud7oSPXkxWsyfao9IIyGL0UIKvkstZh3nVHee8Bi9ZvKBACdr7UoBgZnCtqt6u4SYD
         u/bWT8miub2TbpCWEm09lzRhV0ZiqTrGHpTDvEARf730lQ4R0iqTY6O2ALwthU2wsg00
         T3K3QbyxPgnrZnZLH6sJPmIvrK+xfjNTI1UoehJ8g1iVVImeEki5rf5M9cJL32FaJgIb
         h/rQ==
X-Gm-Message-State: AOJu0YyIkiEmMCalXVO4iJgCtG1iLZCglbi+kbS/bbRoacLY9VgP1mMf
	06Unh2yvWARtp3zCkovfauX5F2zkKVXkDllghJ2Zk4DHpRZXnTR0wyHY
X-Gm-Gg: ASbGnctK9lwvMnAHPAHc8iC6uDY8hoX53l95IVRixcE7VwTEdVATPdU/tMM8XEfYvXR
	2jUL80LmCD70aI3bzO8e1lTGUarlDV1+Dvt/QQ5LY8kDM/Emjex7SScVVmbD++tA0T2zDmx5h+B
	Ld/yx+Z4G6mmdxCuqg65HAh0KZzyfb2oqnxg03wBoEH2v08XcxoMvmoBLDvVI4WMfBEiSe961OS
	2EIj21v8+ewL8KYZmOkeuOS3SaSAz3P2ybEa8OjAPwCHRxMGriuWuWq37xBYruN0Esrgcauwc7/
	ujl7U10Mkg32ukRbR6t4y/CA5HNCodRvZrd6yz8jXMVMQBQHFvQeoIk=
X-Google-Smtp-Source: AGHT+IHK4N+V+fH1AojJlC5p649xxdL6/z5nJ5gdWTnGpfTRVwGGhK5NjcNI9UpTQJAA5cymdPxinA==
X-Received: by 2002:a05:6214:248a:b0:6fa:9909:12ec with SMTP id 6a1803df08f44-6fab9e7f129mr76049696d6.2.1748443334955;
        Wed, 28 May 2025 07:42:14 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fac0bdf0e5sm7017476d6.124.2025.05.28.07.42.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 07:42:14 -0700 (PDT)
Message-ID: <b2dcce6e-4b3c-497c-8709-68322055514c@gmail.com>
Date: Wed, 28 May 2025 07:42:12 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] auto-t: update serveral tests to work with netconfig
 refactor
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: iwd@lists.linux.dev
References: <20250528142750.498252-1-prestwoj@gmail.com>
 <20250528142750.498252-3-prestwoj@gmail.com>
 <c3f204f1-e457-4f80-b7b7-031da065e4b0@molgen.mpg.de>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <c3f204f1-e457-4f80-b7b7-031da065e4b0@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Paul,

On 5/28/25 7:40 AM, Paul Menzel wrote:
> Dear James,
>
>
> Am 28.05.25 um 16:27 schrieb James Prestwood:
>
> […]
>
> Just a small typo in the summary/title: several.

Thanks for noticing this. I'll either fix it up in v2 or Denis can on 
the merge.


>
>
> Kind regards,
>
> Paul
