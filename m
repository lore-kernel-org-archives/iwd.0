Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741C0482DC
	for <iwd@lists.linux.dev>; Wed, 10 Jan 2024 16:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A77QkJEH"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5962381efc4so2371694eaf.1
        for <iwd@lists.linux.dev>; Wed, 10 Jan 2024 08:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704905485; x=1705510285; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dTD0/XyMrPJ/Ux+sXG7kPNo0a0MppayZ1DyjtVN2iq4=;
        b=A77QkJEHa7X33PMQhPSXBq9O0Mp7HovQ27YHAjbhSlpaYAWDA566Vw6Evm+adwgIwC
         1KNoV9zH/b2XuTDT/j0QKygs+h/1DjmBOTRqflCXopSJ5ShYg4Q4YMbueCTaU61m6h4d
         2ZObT00fzGPdrtTnZ4o5fB1lccucgNJcEOObHNv2YZ8/DO9S8DrwWYthr33bZw0xV7Pu
         AnAY5754GdzHpKfuIi4543rcohCpQadHd6StWAnRPUFWL3FpOGQlbsfqb+vkdRWLjKax
         JIw+JE84XJs2+RC9Vopoo/I/6f75kK5PpZoI6ds5nRktfP3upKJtuvUdHOfAXk+0KmW/
         /Dsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704905485; x=1705510285;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dTD0/XyMrPJ/Ux+sXG7kPNo0a0MppayZ1DyjtVN2iq4=;
        b=tp2H68lStjhwcOcMFw+lABgR4v3soDwvvgejd3/yHIsbWYk4qeI5vBxfXqOvrTbiUf
         GhYC/1BZGgfhDVoYrVAFUTEG1cnzuhZNxgUUzRiKq5DE4b0uJuqL3bOxgR9j8zdfLlH2
         3n2JZIb8ST3U2csg0haG+1l19kodd/W0CjeZcWK5mWMmhCgxz/seXmerpQWZSv9rEHWi
         3KSbHn4EHmr7PM+sCcbOlEZcFXmAwX799/e3HJM1khWrkymiEqgtjTopQ1vYB23IwQWh
         aDKYPP2fovuqY0R7OTxSVGAmiAT93Jv5uFvFrqNNBGdx8ROZP3nOZCj8SUVYM+K8Qp4/
         fksA==
X-Gm-Message-State: AOJu0YzrWkggdb2JKRXDCzxMjUlEMd1F8IafKyaa/v/nA3E8wOHd+EeI
	w4fJpLYe0pmaQovyjKmTP/Q=
X-Google-Smtp-Source: AGHT+IG9nzgBxG6FUZ+JXAnufB9xQcXFC8nOOGc2TsTzx2vN97CHdRc3+EK1/Vn2jQXaW2POZJJl7Q==
X-Received: by 2002:a05:6820:513:b0:596:2b7a:ec9d with SMTP id m19-20020a056820051300b005962b7aec9dmr1403184ooj.7.1704905485479;
        Wed, 10 Jan 2024 08:51:25 -0800 (PST)
Received: from [172.16.49.130] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 190-20020a4a1dc7000000b00590ded91500sm878516oog.47.2024.01.10.08.51.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 08:51:25 -0800 (PST)
Message-ID: <ff6d26b2-4ed9-4ff2-9daf-dcf0151d383a@gmail.com>
Date: Wed, 10 Jan 2024 10:51:24 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Log falling back from SAE to WPA2
Content-Language: en-US
To: Fiona Klute <fiona.klute@gmx.de>, iwd@lists.linux.dev
References: <20240109095926.1541238-1-fiona.klute@gmx.de>
 <214422a4-25bc-4676-8a4a-8bf8d67c7ab9@gmail.com>
 <755dc5bf-1ac7-4eeb-ab16-8ded3aa6a25f@gmx.de>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <755dc5bf-1ac7-4eeb-ab16-8ded3aa6a25f@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Fiona,

> 
> It's the RTL8723CS chip used in Pinephone, the rtl8723cs driver
> unfortunately still isn't in mainline. You can find it in the staging
> directory of megi's tree:
> https://codeberg.org/megi/linux/src/commit/f45c45abc5325682d06cb51c06aba1f817fba462/drivers/staging/rtl8723cs
> 
> I suspect getting the chip properly supported in mainline would be the
> best way to get SAE working. If you have hints on how to get involved in

Well, CMD_EXTERNAL_AUTH is part of the official nl80211 API.  When we 
implemented SAE there were no hw/drivers that used it that we could find.  Hence 
it isn't supported by iwd.

> that I'm curious, so far my wireless driver experience is limited to
> "add USB ID for a new device with already supported chip". ;-)

For getting it into mainline, I would start a conversation on linux-wireless 
and/or submit the driver upstream.

> 
>> There's currently no way to force WPA3-only in iwd.  Either configure
>> the AP to be WPA3 only, or have the AP enforce transition-disable bit.
>> But this typically requires iwd to connect at least once with WPA3.  See
>> 'TransitionDisable' and 'DisabledTransitionModes' in man 5 iwd.network
> 
> Good point, it should be a task for NetworkManager to make that clear to
> the user (and possibly set those options, if the user wants to enforce
> WPA3-only).
> 

Right.  NM makes many assumptions in its WiFi implementation based on how wpa_s 
works.  Some of these assumptions do not hold with iwd.

Regards,
-Denis
