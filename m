Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDA6243956
	for <iwd@lists.linux.dev>; Tue, 28 Jul 2026 13:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785246023; cv=none; b=dtO/c+j+xZWJ0M3EDiMHszXB7osRSsA6tPv3cT7RbM5k+YbSlv0CyhpgtxA7s1ertoHrxl1dI7Gn0ZtV1y2sV4xxNzysWTkkgQ3dzLJoqYc6U8WsGfSNaTppeWDIzDBFXcDvvoJA/L4nlSLolS6VsYhc+5gRZ358lCTcsYWykbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785246023; c=relaxed/simple;
	bh=BH9XmdglSUDvOfXpVnzxtWeXkOTL5+mkIwwJfjwH8Ck=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=Qq6O65WHCAV9/F6SuZhzZLoI19hwDiDhrrtXRQ3NU2rqAQJLmOuxnG2LlVMdOzxsjrJloISDYzvpYC6KWTGc29os/Bh9wE4TFJvO33YuQ3Bbzw9n3yPbGN/4WcC+933Bv98dwekwiY0eoCq6bQ0c3R/cYtRd1aJhoU6vESSrEOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NzGkxGub; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NzGkxGub"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cf41bab353so56232465ad.0
        for <iwd@lists.linux.dev>; Tue, 28 Jul 2026 06:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785246021; x=1785850821; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from:cc
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=q/SuUeuASOtfNot/cOOLQb6plk3pRgeDv1vKIXI1bOs=;
        b=NzGkxGubPrYM4INSzfqM45RIjGcAIiLThSQwyzBlq7VVM13W9efiNqbGsm3bU1dULp
         OLOrzY80K79PeVCMJOgqEHvM5KSr4aoKIPM2XLnLzGtlx47xUQgKaXR5nw+i1JdtgUaT
         gEPqRnr9si30U/8FAeFs5mpBrALsStWIF5ZAe0EzlvRoaMG8dFUbjj1W/G257UyxY1z8
         0c3Q7eSDo48nBe0TCKkrrkR05x0dg1VkB9IMElxI9KRXq1m4tvN6bW+QSKsqmhgs7y26
         bzdG/MyMmXSrD1p+gmwN95ze9ZxPH63N4C4iaaj4NQr4MwkuD3hfOHQHCtyS9qNmGqJC
         RNKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785246021; x=1785850821;
        h=content-transfer-encoding:content-type:in-reply-to:from:cc
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q/SuUeuASOtfNot/cOOLQb6plk3pRgeDv1vKIXI1bOs=;
        b=M5UrTR9x27KZ2wc/jRXKLYA3Ayhb+f76OdFsYA0h/aeXudUWSNCyaZwzH+jMttQj6F
         giQrmn2Y+893z0KI9/Wu1/YH+SLb7x90sTiGjb1dpB0TWXS/ZH8UGsq70hLwioNUqpDR
         CH1eE1VdaS/1jMZXJLw9gMcaABKB/RtUU7DpNsgqtVSY4PL4JsI59XKrgFhPepOHJEZl
         PjHZAxFVUyllhoVPXIL5SlGj0gY9uJv2RvMb/vtXrKFih9ykFzdlgALgltxqMoff2+rX
         OCtVaQL/o5mkDW0XBw3yTlhbodFzkP6O+qYLEbkQaWZFANnplPlg8xC1trnOvE41Kf/d
         hzdQ==
X-Forwarded-Encrypted: i=1; AHgh+RpBoO5j+72nI4tkq1luD46tHkGal3CCtmRAjfBHMBq/bRWd/WArAdUgWwabwNNdScE3Em8=@lists.linux.dev
X-Gm-Message-State: AOJu0YynxHAsOvpzKAqo6VKaGks4w+H6BEb7nZj6NMuPqRcU02Jvw8mS
	zAswLpR94X1qmeKNAv25jQNTZY2+pmU7auW6mXcYWR1RZtFLPzSvup4T
X-Gm-Gg: AR+sD12gQEslH54n0o1XsFzX0zawTNOgRFglBS4rB9wdKrXg+BP7Ggh/mFzKffk1aQF
	76S1Sa7t13Q7V4dGOjxy4sfMgBgJ3NFy6FALVIWlkHdJoy4gBjA8JU4z/f+bSOijdXC1t4NkqU6
	tpXta7KaY7WBEonZgsf+2x2pn755kGgThdYmfDFbmc+vZmTWHOL9aHVgpArUEoIexMjy+eQ41AA
	nXZkX6JWTgXanWP4+kJO7BZvGO0In/JX7TKjNLEhRsIWGqlpzKKWs3fn7KzgVTuBerB7BE1ZCtB
	KZiD0qd+ActWZcgkWQFFzo/48I24ETiRQbs3Xh5krz2oyTYmaVOt+2QTak/NF2p1NECqrWemto1
	lSxu6Um50iR2FcjLhhzR6cB4O1QOsUfom8z+N606+kh1a90NHzNEK2Stino9LZzF+L5gZ904SCe
	8HOpns1/2RAKYZxf49wNRrayR0Wa6akrL3EJYHAQ==
X-Received: by 2002:a05:6a20:7fa5:b0:3c4:4272:b400 with SMTP id adf61e73a8af0-3c8aafda295mr3068933637.18.1785246020955;
        Tue, 28 Jul 2026 06:40:20 -0700 (PDT)
Received: from [10.100.120.121] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbbb6622e27sm4811450a12.11.2026.07.28.06.40.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2026 06:40:20 -0700 (PDT)
Message-ID: <f9cb0ba9-da64-48b1-a8a9-3fe5c463b568@gmail.com>
Date: Tue, 28 Jul 2026 06:40:17 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] dbus: expose per-BSS RSN capabilities
To: Aleksman4o <aleksman4o@gmail.com>, iwd@lists.linux.dev
References: <cover.1784062938.git.aleksman4o@gmail.com>
 <cover.1784069194.git.aleksman4o@gmail.com>
Content-Language: en-US
Cc: Denis Kenzior <denkenz@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <cover.1784069194.git.aleksman4o@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Aleks,

On 7/14/26 3:48 PM, Aleksman4o wrote:
> From: Aleks Man <aleksman4o@gmail.com>
>
> James, thanks for confirming that extending BasicServiceSet is a
> reasonable approach.
>
> Network.Type intentionally represents WPA2-Personal, WPA3-Personal, and
> transition networks as "psk".  This series exposes the RSN information
> that iwd already retains for each BSS so consumers can distinguish those
> networks without changing the existing Network API.
>
> The optional BasicServiceSet.RSN dictionary uses the same KeyMgmt,
> Pairwise, and Group fields and values as wpa_supplicant's BSS.RSN
> property.  NetworkManager can therefore reuse its existing parser rather
> than add another translation layer.  Older consumers ignore the optional
> property, and consumers can retain their Network.Type fallback for older
> iwd versions.
>
> A corresponding NetworkManager series reads and combines the per-BSS
> capabilities for its synthetic ESS access point.  It will be submitted
> separately after this API series.
>
> Validation:
>
>    - iwd builds successfully with make -j4.
>    - On a physical WPA2/WPA3 transition network, an initial PSK connection
>      was reported as WPA2.  After changing the saved profile to SAE, a
>      disconnect/reconnect through the stock Plasma applet completed without
>      a password prompt and was reported as WPA3-SAE.
>    - Cycling Wi-Fi subsequently auto-connected the SAE profile and kept it
>      visible as connected in the applet.
>    - The upstream CI auto-t runner passed the v2 series.
>
> Changes in v3:
>    - Shorten the auto-t filename so the generated patch metadata complies
>      with GitLint's 80-column limit.  There are no code changes.
>
> Changes in v2:
>    - Resend with git-send-email after the Gmail web client corrupted the
>      inline v1 patches.  There are no code changes.
>
> RFC:
> https://lore.kernel.org/iwd/CAMq8zouhDMRW4Q7qSpMCFftp21wCzuC%2BRaJKsKz0sUivGAQHXA@mail.gmail.com/
>
> Related NetworkManager issues:
> https://gitlab.freedesktop.org/NetworkManager/NetworkManager/-/issues/1489
> https://gitlab.freedesktop.org/NetworkManager/NetworkManager/-/issues/1693
>
> Aleks Man (3):
>    network: expose RSN capabilities on BSS
>    doc: document BasicServiceSet RSN property
>    auto-t: test BasicServiceSet RSN property
>
>   .../testBasicServiceSetRSN/bss_rsn_test.py    |  70 +++++++++++
>   autotests/testBasicServiceSetRSN/hw.conf      |   9 ++
>   autotests/testBasicServiceSetRSN/ssidSAE.conf |  11 ++
>   .../ssidTransition.conf                       |  12 ++
>   .../testBasicServiceSetRSN/ssidWPA2.conf      |   8 ++
>   doc/basic-service-set.txt                     |  23 ++++
>   src/network.c                                 | 110 ++++++++++++++++++
>   7 files changed, 243 insertions(+)
>   create mode 100644 autotests/testBasicServiceSetRSN/bss_rsn_test.py
>   create mode 100644 autotests/testBasicServiceSetRSN/hw.conf
>   create mode 100644 autotests/testBasicServiceSetRSN/ssidSAE.conf
>   create mode 100644 autotests/testBasicServiceSetRSN/ssidTransition.conf
>   create mode 100644 autotests/testBasicServiceSetRSN/ssidWPA2.conf
>
Overall this looks good. It would be nice to have some support in iwctl 
to see these fields. Those properties and getters/updaters can be 
implemented here if possible:

https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/client/bss.c

We will need to wait for Denis to comment/merge though.

Thanks,

James

