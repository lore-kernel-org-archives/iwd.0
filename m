Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E67C3C488
	for <iwd@lists.linux.dev>; Wed, 28 Aug 2024 02:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724813100; cv=none; b=rdWonPkkXz4xuNo9/O0qrDMB6xbfolMOxF2QqBexPf9niBM7Bp4KvE8CYncfQmdysxfhdBPbB2HRCncLmxWeGvaLwVJ4HJwvx9QUuDFbiT/W9ztQLZeIEUDbzXvFgdCybNRJydTnqilnGEHrhMSFV/HFm8T4Fi4NBjTIMYVSwLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724813100; c=relaxed/simple;
	bh=RXcgbWLVS2/GxyxaurEuJqaEUBjXWjpVLyMawQschG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=naF19G99fMa90D++n8PDyv4XODmldjsreHeIME8++2V3Lgw72rzg/T/I0HgV3tb2hWYpFlLMFKMx6X+akKiyHQgtN/Ij4gmJAHnDDjqUHiDCrJE8d3/GYUy9mKYBkiGLdsLLavgZp8eUc1yMmlRm3U8ZuILap+OdS5IJNjRlsHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d/+IwZz8; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/+IwZz8"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-70949118d26so5785565a34.0
        for <iwd@lists.linux.dev>; Tue, 27 Aug 2024 19:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724813098; x=1725417898; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d8ztePhKryZIv8tw5imD+uoTNpSRQIWSEM+e4SNXY90=;
        b=d/+IwZz8+rR7WRwgPZi0pqxuSqGKD5//Z3/CcraEBTQioIfQ+daDuQ5jB/gUSJec41
         EJ3i0kEqCroZs7drjCqYkLb3T4z7Fky9U4+vo3HZGMZ0xsLhlDKDNTE1nMh7KyfkaH6p
         VbP0vCsARp8R1cIVWRM2hq8m/qrLKt/SRwBaqz11n/TZxdOOMxcHOkI4zvpwTRiZQZys
         8Y8S4w0zUaA9cH/K+3KQKBgP6WaU/BtEm+gTEplSfr6/OY6v9Wt5InH/5Z+DgvRv4qah
         rqt60P5vF9qi/2Zp1l8GWgFX/WzUpswfCdwbK6sswibnNfXSzmE4TJTm8oX/HZtH6aF3
         +k3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724813098; x=1725417898;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d8ztePhKryZIv8tw5imD+uoTNpSRQIWSEM+e4SNXY90=;
        b=RILRNqJjcU04RGkPcof0VOHKxvLmvbkAZ19251TyWaZZ5UPF9Gv6hyIigjQDHvMdGJ
         tpv7uO3GdHCIFVkETXRDa+JZLHUqaE9XRP0hndTHDy2bBqREtQCAQuUpT7uiLPeyL2wf
         oz5oHYmxP0qDv1r+MLi0w1P7MZXsY4I1N0VkoBjw7lZk+Y0ss8wXVLFkpay/pe40Q26g
         wO0J9pJgNarpu2cjGjh+MpmcRBRJ6sNr1Vl/06fXQdtCxZnFasfX+rYKKNVXO6zIo7Ow
         ex1Ce4AP+2BOGye/kn10qky3nUhJWCO/fshiMgf8MnpdL14OrVfNaQoxsDMKntYKIWWH
         90oQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQWM0gloTfyI/Q1dZRILJGSX9EyjvIODW2Vx6Owmpysy/B9QI2QsTJDDd+hEdRdAZ9emA=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw+rNH2sul4bnn+lktTffuokkC76Ndw2ExjFvDh1AOPrRfNW8a4
	+MEE/5uY0l/ObqJJYoKb7QBYTKJYtjUFPjqB1I8uY3aYQAM2xX7BKbkN8w==
X-Google-Smtp-Source: AGHT+IGWQIZI0dckZw0WisQ5cy1XYxLl11CXolaQyWTCbsC0n0KUG3ZsrIK3utB35XIzKnXFywTYMw==
X-Received: by 2002:a05:6830:2705:b0:708:b344:fed8 with SMTP id 46e09a7af769-70f53b5df21mr569143a34.33.1724813098085;
        Tue, 27 Aug 2024 19:44:58 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-70e03a50c86sm2685370a34.10.2024.08.27.19.44.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 19:44:57 -0700 (PDT)
Message-ID: <dc2f6296-ceee-42ab-852a-c0e858b29e87@gmail.com>
Date: Tue, 27 Aug 2024 21:44:56 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/8] netdev: define netdev settings in netdev.h
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240823222339.328006-1-prestwoj@gmail.com>
 <20240823222339.328006-2-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240823222339.328006-2-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 8/23/24 5:23 PM, James Prestwood wrote:
> Following knownnetworks, this moves the settings into a header file
> which is easier to maintain/read.
> ---
>   src/netdev.c | 8 ++++----
>   src/netdev.h | 5 +++++
>   2 files changed, 9 insertions(+), 4 deletions(-)
> 
> v4:
>   * Fix typos
> 

Patches 2-4 applied, thanks.

Regards,
-Denis

