Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDC012D758
	for <iwd@lists.linux.dev>; Tue, 30 Apr 2024 11:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714475846; cv=none; b=hxFuseY2S5MhYDp2BR2sZausvkX8ivxzbbDLbHmWvzm4JAkxzKg4yJBURVSNSjHt9N79wpDLKK/X6ww8J42Y33DQB2qcTZKTJB9H8bkKU/PoH/5phAzqVq7mrp3jefdA5FDWOk7tZxphyB6dDC9cIOJLSdLJbqInwTmqPsJlHYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714475846; c=relaxed/simple;
	bh=2CBicZdGpeIo+EZCYD0BoBwyXPk6E8nWPxSQM7aJUsc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kmy2c1J9TrlcZWf8hTdrgzwsUaU68CsTVQ2knTYBpax4Q2ghGKK1ooBe9X4Pw0T5iWLRSqim++hfnWkMy9wt8jWJQuAlmb3UCw0JHxpMfeZ5JTXSm9TeFYGpOdo98jb3yAaoWShcezi1NTN/GNk4iy0xoFEgq8NC0WzDrTbyzhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N1FSgaQU; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1FSgaQU"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1eac92f7c74so43544115ad.3
        for <iwd@lists.linux.dev>; Tue, 30 Apr 2024 04:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714475845; x=1715080645; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b7CSlh7f1/YMsNxMc6Y8emvmMw75lnS0ZxSnlSWxbis=;
        b=N1FSgaQUndz32MhVD2QjXc2krFqBD+nIPaiLUn5cWipwlhuhIEi/b0jw7CfAPAYNzq
         a6hpcoCJ3ZQreO9RSWG3tSTD/cyFoTtGCoxTlzWS4XpgnHwWhiflHNC10jnS+FOcA3VT
         fbz8RDD0OZcsX0M2e7s6L7hTTzsAcENnlMc39S0uG7+Js5sid9eLQS5FSXk+R3+1x5B0
         UoUcc8RDAxHsTdahvCO8y/lcGyhVKbXaWH4uDmYbCJAGpwjALBb8H07GeSLLg77ZhetH
         kaaJJP0CPcpb7wZlfiuTicwPcnwGiNJzDWUMl953q9MJ//nKa3NwrNV4vdZGIadVnEGJ
         hvqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714475845; x=1715080645;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b7CSlh7f1/YMsNxMc6Y8emvmMw75lnS0ZxSnlSWxbis=;
        b=mXkAazQkKsbGxnmMsRezeDm9E0tLOPjitBi+jLtKn5ZiXh2WW8VlR15zXfgemsIZ1Q
         bgYdjIouCwCR/KT2SK6CPmFJOJ/sv9OYQDr87trguTktxuu87KJzJRLn5QZ328Bl5aPf
         n6/dnU+VZ36RkgJTTBEoqotTzk4xJY1Xw0VEtqLj7RP6IfxBW8jNWG+WevOPPMpJSiik
         dBwD7z1agU4tB2gVzwKnZXJhsEHc0HgqPrNwKf+GMKL1QJV4RUt245IbECZpjuHeNfof
         30NiRIYV3QM/osagVIr5f07BTp+jHrixP7UuuiPrmcLDOcNeJBo93rCVsHwQfEVJAas3
         aAWw==
X-Forwarded-Encrypted: i=1; AJvYcCUTSObzvuOHR31RLGevr2Oe7OSAdIJ0L8GwX+bZAUW++GKBvrVRO7Pfxe9uM/Zo/n4t90Vh4ws2UFlaIm2CvmMThQ8l
X-Gm-Message-State: AOJu0YyMJ/ROOd4QM/qpNTtZ8x52Kq2mWrsa4fhMOhpWTmNTsnwDNXi/
	JahDHNE3p97eo7xfe3qlD7ZPs4hYrecwYDWUyuSkhTGQmmW7OF6L
X-Google-Smtp-Source: AGHT+IFzsaI5nbI8SMCDc5Q0ojakGUPMuu5MDv8sJf7yzkvCZqRifWxg6wWY/I9VmygljAQ38QMQwg==
X-Received: by 2002:a17:902:cecd:b0:1eb:6a67:47ea with SMTP id d13-20020a170902cecd00b001eb6a6747eamr3073242plg.31.1714475844509;
        Tue, 30 Apr 2024 04:17:24 -0700 (PDT)
Received: from [192.168.1.68] (h67-204-152-76.bendor.broadband.dynamic.tds.net. [67.204.152.76])
        by smtp.gmail.com with ESMTPSA id y22-20020a17090264d600b001ec6db9356bsm94487pli.204.2024.04.30.04.17.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 04:17:24 -0700 (PDT)
Message-ID: <25618c14-df5a-4980-9e62-dd5c96084455@gmail.com>
Date: Tue, 30 Apr 2024 04:17:17 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Raspberry Pi 5 and WPA3
Content-Language: en-US
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Harry ten Berge <htenberge@gmail.com>, iwd@lists.linux.dev
References: <CAN+yObo7O+c7x51maXYxUiSttAC6ZJkuNb9DJwjCuegbAgyLow@mail.gmail.com>
 <91648487-9c59-40f9-996d-dfad1f1adcbb@gmail.com>
 <38861D9C-F5F5-4149-99CD-0C59480986ED@holtmann.org>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <38861D9C-F5F5-4149-99CD-0C59480986ED@holtmann.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Marcel,

On 4/30/24 12:42 AM, Marcel Holtmann wrote:
> Hi James,
>
>>> I'm not sure this is the right place to ask for some assistance, but
>>> here we go...
>>>
>>> I'm the author for a small Raspberry Pi audio image that is
>>> specifically targeting Roon.
>>> If you're not familiair with Roon: it's an audio streaming platform
>>> targeting audiophiles ;-)
>>>
>>> Anyways, about a year ago I switched from wpa_supplicant to iwd, to
>>> full satisfaction.
>>> Better and easier integration, and overall a feel of me being in more control.
>>>
>>> Now, recently I'm having issues with WPA3 support. This is partly
>>> related to firmware (it's just so obfuscated how this all works with
>>> firmware from broadcom and firmware from cypress :-(
>>>
>>> And one of those things is that I can't get it to work on the new Pi
>>> 5. Specifically IWD reporting this:
>>>
>>> Apr 29 17:41:41 ropieee5 iwd[275]: src/wiphy.c:wiphy_select_akm()
>>> Network is WPA3-Personal...
>>> Apr 29 17:41:41 ropieee5 iwd[275]: SAE unsupported: brcmfmac needs
>>> CMD_EXTERNAL_AUTH for SAE
>>> Apr 29 17:41:41 ropieee5 iwd[275]: src/wiphy.c:wiphy_select_akm()
>>> Can't use SAE, trying WPA2
>>>
>>> Now, the Pi guys point me to the missing CMD_EXTERNAL_AUTH message and
>>> advise me to go back to wpa_supplicant. Which is not something I would
>>> like to do for various reasons...
>>>
>>> Do you have any advice for me on what I can do? is this
>>> CMD_EXTERNAL_AUTH really related to  this and are you planning on
>>> implementing this?
>> Unfortunately the external auth support is not yet implemented in IWD. The brcmfmac driver itself is rather unique being a fullmac driver. Depending on how you look at it, this on its own is "easier" to support. It handles connecting/roaming all on its own. But then, for some reason, someone didn't want to do SAE/WPA3 on the card itself so they came up with some one-off mechanism to offload that onto userspace. This is one of those things that got put upstream that is a pain for projects like IWD to support IMO. Its something we do need to support eventually, especially given the raspi 5 requires it.
> if the Broadcom firmware finally would be able to support external_auth,
> then it would be nice, but as seen on recent linux-wireless discussions,
> it is unclear who does what. Broadcom wanted to support external_auth,
> but then Infineon (the new owner) might be rather using SAE as part of
> the firmware. And actually the chip on the RPi5 marks itself as Cypress
> and so you it is an unclear story. I think that Raspberry Pi foundation
> should get their story straight. Until really recently they shipped a
> firmware that couldn’t do SAE and also their drivers couldn’t even do
> external_auth and you were stuck with WPA2 only.
>
> https://holtmann.dev/enabling-wpa3-on-raspberry-pi/
I was not aware that it didn't even support it correctly. I figured 
broadcom was who added it in the first place.
>
> You can use an upstream firmware from linux-firmware and make the RPi5
> support WPA3. And as of a few weeks ago, even RPi5 latest Debian was
> switching to the upstream firmware.
>
> On side note, there exists no wpa_supplicant release that really supports
> SAE offload properly. You need to back port a lot of patches or hope
> that your distro back ported them for you.
>
> We should actually check if nl80211 tells us that external_auth is
> supported by the driver. And if not (which is the case for the Broadcom
> upstream driver) send a proper message to users and not lead them into
> a wild goose chase.
>
> Regards
>
> Marcel
>
