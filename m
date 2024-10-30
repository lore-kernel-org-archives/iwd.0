Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADEE1BD9D8
	for <iwd@lists.linux.dev>; Wed, 30 Oct 2024 20:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730318432; cv=none; b=e4KFE5WiR2TntGb8H+kYJVcIOrrEcG2EQUHHafMCwwFB/SOXC8Mnm2gS/9p3Ffb1fYonD8tT2D1u+8/CGtgwMQTjehh882ez3yty6LJACIPXzIlJL5WdL6n/jR3gxAZ4BxwqNh77p4TSc1+0UppNomfaWqmgZwRCw76BwLi0pTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730318432; c=relaxed/simple;
	bh=xzsXaVjcIyMNHFDgQrYRbVoOdh4QNTqB5x48yHqUN7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZM6jP8J/oyMo/5p2l24l0mf2F6rEQ07//EYnrXpiJVrnBM7yY1kchJuatw6a0zJWGLhIl6tf7Iffor3KYVYRGbfClZY87ZLz9e/XagFO+5w1LEjGW3KS1mdhm9mBh5/gHO6IK/dgL+XhpjFvcgLOMV2xAn8kFKrxyz/A4sVc2uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zsl4Aigd; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zsl4Aigd"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7206304f93aso181507b3a.0
        for <iwd@lists.linux.dev>; Wed, 30 Oct 2024 13:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730318430; x=1730923230; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y1XAzymLux01o5oAtYVyjGYTFR5PNDseMlAK+sANHGg=;
        b=Zsl4AigduiNnCTYZlkOsOCLolAjEqX8AmXZgkVNtGRJmdZPOngFSfqtE39RAD2W2Fn
         7QNeuaKOdWkS0UiUudGFapqL4iwi9AOsc+1CqoRE9LuSqVig7qBpOxGejX2UwhvAuVdz
         96tRhMLoQbkqCJf862C6HvMFEY34VdDps97u/LrfAC7xaghPhJahtatVI/4NH8aKy6de
         F4W3wtZ3Xw/gKo6SKq+Oq07fzld5FgFlt9stl/BDiljw1YDxjVK/PU+O1doyKRXi5Zgs
         lOClDjDSDyJ+xLfkRyp8ZpJl6KovIZsYFxHMH7+Lxq8ZkH046w+4u15WK4KZPsj7mHPn
         1w/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730318430; x=1730923230;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y1XAzymLux01o5oAtYVyjGYTFR5PNDseMlAK+sANHGg=;
        b=ZuAY9CzwNYrravef7rEbhLRNp1r8gSfwrln2wIUxc5pxTonLbF04M5xYduB/f6S4b1
         CbU9bcIBIEcKatcDMCVjU+j7wJWpDqrRq5ohlVAC8EcAEjLV5kcPmi01RfiuKmINmRNh
         eclpbbMRLJzmyZq4Hjc4FfC8EIyww4fGkENuoBtuYWQUXL0inYl7ot1opqjOpAyzxICZ
         trO8wvIz0bdQpxKmss/FjXtEjer+oIfZf13sNBGbXkBi4lAyA9omrsHXhWio3TluOUCN
         EMMFu9uOTlcwyIThKMbfISAOHYx9iEB/lnbHZRH+LPWUhPhO4mmTyoWM0l4nR78l0vs9
         Q+fQ==
X-Forwarded-Encrypted: i=1; AJvYcCWx4o+CU0vBQwbzAhUMXrgGG1tOLlpltHm9ZgVxiBzRWI4EGxKVpYwkQdKCiu6wYBkX1GY=@lists.linux.dev
X-Gm-Message-State: AOJu0YzmoVcZv5oTVwoUFUhGvHd/gyqFg3dH449aH+uNWkcg+n461+3D
	IkGasxBV3UAw4HhrrOIQM/ZDcm96gcuAOmoezZEHrIObH07agqzyzCTOfw==
X-Google-Smtp-Source: AGHT+IEX349X7wvJUjwpDA3GSGJ4JtxeKb4iS8+SoSMKLJsLeYoSPiicBMbqHJ6vxgwDJfYVRBHgAA==
X-Received: by 2002:a05:6a00:188e:b0:71d:eb7d:20e4 with SMTP id d2e1a72fcca58-72062f860f6mr23172374b3a.8.1730318429597;
        Wed, 30 Oct 2024 13:00:29 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a3a4e1sm9672963b3a.182.2024.10.30.13.00.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 13:00:29 -0700 (PDT)
Message-ID: <bc387186-dbd6-4ab3-adfa-2a8d0f7bcc71@gmail.com>
Date: Wed, 30 Oct 2024 13:00:25 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: How to disable power save (iwlwifi / brcmfmac)
To: Martin Petzold <martin.petzold@tavla.de>, iwd@lists.linux.dev
References: <3650c0e9-6d4e-45bb-ab44-ce5849d3ffe1@tavla.de>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <3650c0e9-6d4e-45bb-ab44-ce5849d3ffe1@tavla.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Martin,

On 10/30/24 12:54 PM, Martin Petzold wrote:
> Hi,
>
> to disable "power save" with NetworkManager I used:
>
> -----
>
> [connection]
> wifi.powersave = 2
>
> -----
>
> However, using IWD (with iwlwifi or brcmfmac) I don't know how to get 
> this set:
>
> A. "options iwlwifi power_save=0" in 
> "/etc/modprobe.d/wifi-power-save.conf" does not work
>
> B. "[DriverQuirks]" with parameter "PowerSaveDisable=iwlwifi" does not 
> work
>
> C. "[DriverQuirks]" with parameter "PowerSaveDisable=*" does not work

And you have this set in main.conf? This works for me, on iwlwifi. When 
you start IWD you should see:

Driver Flags: PowerSaveDisable

And for me iw wlan0 get power_save shows "off"

My setting in main.conf is:

[DriverQuirks]
PowerSaveDisable=iwlwifi

>
> I always get this output:
>
> -----
>
> tavla@tavla:~$ sudo iw wlan0 get power_save
> Power save: on
>
> -----
>
> Interestingly, this the following seems to work (but is not permanent):
>
> -----
>
> tavla@tavla:~$ sudo iw wlan0 set power_save off
> tavla@tavla:~$
> tavla@tavla:~$ sudo iw wlan0 get power_save
> Power save: off
>
> -----
>
> Thanks,
>
> Martin
>
>
