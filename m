Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130EA2E40E
	for <iwd@lists.linux.dev>; Wed,  7 May 2025 14:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746628053; cv=none; b=YojkSsGwm0dTHUyB8KvstROJ//EorrgkcRsZLHQdHOIXqFXwrCenS72lUM6R19no1dTf6BAUfrYputKQdLj74a93ubHKi3b+sP32YhgQaRLFH015X9UHT53fqNy6L19BbsjUmXhxct1v6gmtA9TZ5NkEMJy7PEQuLZW5OmAGw4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746628053; c=relaxed/simple;
	bh=bsdAaIe5s4rYuFVDWhItIygQFxvUXMkuW90/RpvFRf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iWr8Db2tqCJFghKCZ2aBRATusI5WbToc0FTmr1+B0hacH32YUquevgaOCKbq+AJccnqFjQ6Lbzui4+IpOOive1K3vGe27u+4iVdQBx/lmFB3NYAvpH8CpE+4jHJpV2wQ2ghmA2ROFYvmt8NbugeUfUE0uywSzkGigNRxDPG7ee8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WWjS1o99; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WWjS1o99"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22e7eff58a0so3041485ad.3
        for <iwd@lists.linux.dev>; Wed, 07 May 2025 07:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1746628051; x=1747232851; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZL+HNGCQu82h0e60TjEm67iOYVCmglB/dmQMQxbeh+0=;
        b=WWjS1o99QKYx+GuvcUjGmXGEvlxNPDovPp8MT77yUaAZGv0TjcUlP1emOpkIZ4C0GI
         LD0iDP/NG/ll4ED2noJ5AYRrxL5VPVhG+rBoEqKBHZzTPvhOSlegGVqLFHhCKo8qhfM/
         ILDweGXzUdnydbxKn5WAQCWH4virsq89dzG8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746628051; x=1747232851;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZL+HNGCQu82h0e60TjEm67iOYVCmglB/dmQMQxbeh+0=;
        b=c3yrrkOh+Y4yAq/I3pn9MJrRLrQyFWF+ythEs+eu6zflGzF/i3A9jJC4P7DMnXMIz4
         PSvxnlEBpNiEYnjKuGH4yBxW26UYhcW+7zTskjPlo58t3CYRZqotOv0GFCezWwYbIXil
         M28tDPIM3PMc2b/Nf1ERLpe2rhdTGZm2GWO7kesUu2xpAZUcvWYCwm/kRboeb/EEmkeV
         b7fc5spukPAIOisMyuvHKx0I2HJTLV1OT4A2qXGSCgLlfyTa9VV83r6uAUE82a36DKYd
         TaRAM+yoDd6qC0UlcVUdPHezFgiZAkrkMQlC4YRdDIeSKoBfNoMEhVo4lgvUEUPaM3vB
         2J7w==
X-Forwarded-Encrypted: i=1; AJvYcCXXdlBU1jiziuCtIIbvGsLRQL3UqHSjgBOIrD997dOsQZzzXJ0ucq70Vlfnt24sMHtcOeQ=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw/G1us22++GDN8BHEhaAeZ8ylgCV1UD/l1rN8dq6T6F4XLqh3j
	H9jGHbFvjn78exSYnBZKyoAeE8hAQQZAma7psklye16JFx7e3gLHzbPVhWBSrQ==
X-Gm-Gg: ASbGnctSAg0AsLIwFMOJ2bhrnnCJLLO48t7NvHZvEfg8g9iIIWiHoVr2YJTQEFosDqK
	BsKw79lAOLtInqxca/w3D1sCjigeAcsyBuDyF7ZwHouAjeFqNZC+R1nfTtUSURbrcp+at2LA7JE
	BnFQXw6hVv45buCzZPegKJPtv9TRlJcGCwawVQlLCAYU6tGDoHgSrLQwj8BbGZCi6+6L83oNpjS
	aYybk6Fs2OeQ7J9kdTc9kZaiNDwnXpsb6kvPI1iVwsSx46b83VzuyB1AnYUxqaKUjaApQKGxboo
	LyLWglb+z6alN4Crhk4wVO+h6JHwL/n+t+bK0vMPNDHrbpv13dAA+F6cx+Jrnq5Dmblnj1/tMxS
	lTuB7R9Q48Gr3pUZ2
X-Google-Smtp-Source: AGHT+IE0aKLmcSPr+GBP5MXroawxsX5pQTzErxfzyHH5X5aJcslDEu2Zl8R6HNQpilG1PfrRD0ifmg==
X-Received: by 2002:a17:902:cf01:b0:224:a74:28c2 with SMTP id d9443c01a7336-22e5ecb099emr53946795ad.29.1746628051148;
        Wed, 07 May 2025 07:27:31 -0700 (PDT)
Received: from [192.168.178.137] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e151e9452sm95255675ad.59.2025.05.07.07.27.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 May 2025 07:27:30 -0700 (PDT)
Message-ID: <38be0ddf-50ff-4ef9-bd98-748ffcfed2e1@broadcom.com>
Date: Wed, 7 May 2025 16:27:27 +0200
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: brcmfmac disconnects when iwd scans
To: KeithG <ys3al35l@gmail.com>
Cc: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev,
 James Prestwood <prestwoj@gmail.com>
References: <CAG17S_M4_+CR1uSsajyvHBjig6cfCuxegipnHREhk1sXjSyOsA@mail.gmail.com>
 <a0dcf03d-3bd3-43e5-9532-5a565d20930f@gmail.com>
 <CAG17S_MKZXf3vC0zgaK_MUrA1nqRzhGcPGUho873KU3jYVShXw@mail.gmail.com>
 <45bc2f1b-b037-4784-a2a9-7732a82b7391@gmail.com>
 <CAG17S_MqLBQV6ktjbWsoAv0e+2A0dnNN5+X7Pf+b-qDP3mrL1Q@mail.gmail.com>
 <19691dcb210.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CAG17S_MX3S9=EmiHBae8WsRnmsUGBJ5h4d8kCmgdxYZ2Zaeh8Q@mail.gmail.com>
 <1fb12821-1707-4478-941b-9fbc007c4e9a@broadcom.com>
 <CAG17S_M9_-TG4YnHAwx2+O2bJ6sbEE75X=V0y4Pbxy222O3ZJg@mail.gmail.com>
 <CAG17S_Njkt7rFTk4Tn-KnLVS8kzA61KJGyWgNQ9kqx5M=s7DnA@mail.gmail.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <CAG17S_Njkt7rFTk4Tn-KnLVS8kzA61KJGyWgNQ9kqx5M=s7DnA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/7/2025 3:54 PM, KeithG wrote:
> further information...
> 
> I tried this with 2 different pi4s and have been able to confirm
> wpa_supplicant/hostapd is stable on the Pi4 (will try others when I
> get a chance). I also tried both the 'shipping' brcmfmac43455 firmware
> and the 'latest'. It is only with the 'latest' that I get reliable
> connections. With the 'shipping' version, I can get connections for
> both wlan0 with wpa_suppolicant and ap0 with hostapd, but the ap0
> connection is flaky without any connection on wlan0. And I cannot
> sustain both connections at all. This 'latest' firmware is required
> for a sustainable, reliable ap0 with connection with hostapd.
> 
> this is the firmware required:
> [    3.658201] brcmfmac: brcmf_fw_alloc_request: using
> brcm/brcmfmac43455-sdio for chip BCM4345/6
> [    3.660643] usbcore: registered new interface driver brcmfmac
> [    4.041524] brcmfmac: brcmf_c_process_txcap_blob: no txcap_blob
> available (err=-2)
> [    4.042269] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4345/6
> wl0: Oct 28 2024 23:27:00 version 7.45.286 (be70ab3 CY) FWID
> 01-95efe7fa
> 
> The only annoyance I get is that the log fills up with failed scan messages:
> May 07 08:43:11 deskrune wpa_supplicant[604]: wlan0: Failed to
> initiate sched scan

The scheduled scan is basically a scan offload in which user-space tells 
the driver what to look for and how often (hence scheduled). The 
advantage of the scheduled scan is that the host (RPi) goes to sleep 
while the wifi chip is on the lookout for the ssid. No idea why it is 
failing though.

> the Pi still works and is scanning because when a known ssid appears,
> it immediately connects, so it is scanning, I just get this message.

What I recall from wpa_supplicant behavior is that it does a regular 
scan for a configured ssid and after a number of attempts it does try to 
setup a scheduled scan if the driver supports it. When it fails it 
simply continues with the regular scans. The brcmfmac driver supports 
scheduled scan so it seems like regression although apart from the log 
message the end-user is not really affected. I expect it will not make 
much noticable difference on the energy bill. ;-)

> Now that I have this working well with wpa_supplicant and know how to
> get it all 'up' and stable, I will start investigating what
> differences there are with iwd and why it is flaky. Please guide me as
> to the best way to do this.

Were you successful using nlmon. I suspect differences should show up 
between wpa_supplicant and iwd.

Regards,
Arend
