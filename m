Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3028B22092
	for <iwd@lists.linux.dev>; Sat, 24 Aug 2024 03:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724469703; cv=none; b=NJdPp6D2CHvGju884sCEVIeXRCgoHDw94g+EAsr21h7DoOeZPjAEJxD+k9qu+iFsMhEJNOhb3ZKcKlsM1MX4vXevzhonk8zqiPC1lHiT8hosp9Rpnq6emx5Ec/b/J6iGpexQ7KfT727fb7OFC9WQWxEB1wjoZWsjYivS95OHK9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724469703; c=relaxed/simple;
	bh=X7TcKL4ys7BtxU3C7t3ugsY8kBO76HUBmBEbovuIm8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FdzPK3rT31TvYV7T+eL34xjdbGcnZrP8ErbmvHQTuTijEjbjbcBWaTneobtFbzYLsR1P4XauYN9kEhlX4mq/IefF6LZ9cd13QyrJ5Je7tFDj3XvaN3SLQ2YnWI0+y183iFZqQQ8WjEWr5JqELQT/AWjYY0XpaUrO3zysqKmSoRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jdql2YpT; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jdql2YpT"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7093abb12edso2444621a34.3
        for <iwd@lists.linux.dev>; Fri, 23 Aug 2024 20:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724469701; x=1725074501; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TsCT+4DGWeYqKCEK/c2oZhTmQVdM6de5QdTEWJ4WjZ0=;
        b=Jdql2YpTHPvOxQZ2er6XBtGTzNclTQt/MYD70sjUMKImn4BO2Kah9Nb5YRXr04xYFI
         Ty7VNPkhYs493fafMjYtnRd68m0srITB6vdL0YBlBO6LRTkCN9FsbWMwEaOfCDSQUQnv
         6SVyUnIFYwub0qDB44prvE1bVvZxOPqdia65G4UFWMxGzjLNrlffEPXzDVZsGkUHRK80
         +5CnjKnIAEMub5tHKXxbV01pCpLRa7OSSKYnGg/DBj8qDGIFuOq1qMzPpaIr2GtrCHR+
         vQWrbV7yTsnuu8cb+7OMxqTyNWjKKcIEP/bqO4jMlV/D5ksjtkdQ2ueweztIAxPzfRL9
         WwPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724469701; x=1725074501;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TsCT+4DGWeYqKCEK/c2oZhTmQVdM6de5QdTEWJ4WjZ0=;
        b=nVqB7KrizANdPaE7V4QWeXWi/lzlIl6ygvfdQ6IXpx2SJoPlETarQWdIqS38dRNkGk
         N711jBR1MhjRgnd72Iz6JerOZIkDfPl23U9i/ZbEoQWAUUbTunt3AgkOfR18rqnjSJ4n
         9SCjoBLHvIt46XB09YaQhuM7aOuzmrpOjIFmRmiBoi8iwIGQegxtwrvo6I6dbTGq4LYM
         kNroaAfeSqUApzWh+nPrCY0LPS1Z0Iw0r0wWw7YkHleos0npRlO+v+iCYIsms2n+SYa5
         pUEj3dge06J01A1lCkHoUVkHsUzyOWySIejdni+kCXZgw54L3Oh1t91hW+Nku+enRCNJ
         RlgQ==
X-Gm-Message-State: AOJu0YznEdldO9O+yHnxcK6kO3F4btASy2wexJybk8IxliYfiBrWZ+qC
	Sth1MU4909A2Qw1wjTi8Rbi0rIys2Gw1nfT1iVM9GyBVFR8q35X3
X-Google-Smtp-Source: AGHT+IH4XYFByZUpvlKXD3vbKkkzfEEU4QHNColy677zuiNCwVx0dH56W5SqMfT43U/Lm30jclp9/A==
X-Received: by 2002:a05:6830:7318:b0:704:466b:15a2 with SMTP id 46e09a7af769-70e0eb64462mr4506472a34.20.1724469701045;
        Fri, 23 Aug 2024 20:21:41 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-70e03ac5ea1sm983627a34.43.2024.08.23.20.21.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 20:21:40 -0700 (PDT)
Message-ID: <f36d03e4-e85a-438e-adef-b6c2da0c8f72@gmail.com>
Date: Fri, 23 Aug 2024 22:21:39 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/2] External Auth support
To: KeithG <ys3al35l@gmail.com>
Cc: iwd@lists.linux.dev, James Prestwood <prestwoj@gmail.com>
References: <20240823174220.498594-1-denkenz@gmail.com>
 <CAG17S_NjMwU4=qn_jJzUJwPEOTT1H-SPVb7Re0P4fyPNUg=WqA@mail.gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <CAG17S_NjMwU4=qn_jJzUJwPEOTT1H-SPVb7Re0P4fyPNUg=WqA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Keith,

On 8/23/24 7:38 PM, KeithG wrote:
> Denis,
> 
> 
> On Fri, Aug 23, 2024 at 12:42 PM Denis Kenzior <denkenz@gmail.com> wrote:
>>
>> This series implements External Auth support on Full MAC cards that do
>> not support SAE offload.  I have not been able to test this fully since
>> the brcmfmac firmware on the RPi 5 does not actually work properly.
>> Maybe some enterprising person can test it on a firmware that does work?
>>
>> Denis Kenzior (2):
>>    netdev: external auth support
>>    sae: Allow ability to force Group 19 / Hunt and Peck
>>
>>   src/netdev.c      | 258 +++++++++++++++++++++++++++++++++++++++++-----
>>   src/nl80211util.c |   4 +-
>>   src/sae.c         |  20 ++++
>>   src/sae.h         |   3 +
>>   src/wiphy.c       |  19 ++--
>>   5 files changed, 263 insertions(+), 41 deletions(-)
>>
>> --
>> 2.45.2
>>
>>
> I was watching for this. I built iwd from git and tried it on my Pi5.
> As you said, it did not work:
> 
> Aug 23 19:24:29 pi5 iwd[16297]: SAE unsupported: brcmfmac needs
> CMD_EXTERNAL_AUTH for SAE

I don't think you applied the patch correctly.  You should see:

+               /* Case 3 */
+               iwd_notice(IWD_NOTICE_CONNECT_INFO,
+                       "FullMAC driver: %s using SAE.  Expect EXTERNAL_AUTH",
                         wiphy->driver_str);

> Aug 23 19:24:29 pi5 iwd[16297]: src/wiphy.c:wiphy_select_akm() Can't
> use SAE, trying WPA2
> Aug 23 19:24:32 pi5 iwd[16297]: src/agent.c:agent_disconnect() agent
> :1.471 disconnected
> Aug 23 19:24:32 pi5 iwd[16297]: src/agent.c:agent_free() agent free
> 0x5555946ddaf0
> 
> I believe this is the latest firmware from Infineon for the RPi fmac cards:
> Firmware: BCM4345/6 wl0: Aug 29 2023 01:47:08 version 7.45.265
> (28bca26 CY) FWID 01-b677b91b
> Firmware: BCM43430/1 wl0: Jun 14 2023 07:27:45 version 7.45.96.s1
> (gf031a129) FWID 01-70bd2af7 es7
> 
> I know there are a number of fmac cards. Does the firmware on these
> work differently to other brcmfmac cards? Do all of them use
> CMD_EXTERNAL_AUTH?

No idea.  All other brcmfmac cards used SAE offload.  Cypress firmware seems to 
have gone with EXTERNAL_AUTH.  Not sure about other full mac cards.  I can see 
references to EXTERNAL_AUTH in two upstream drivers:

[denkenz@archdev linux]$ grep -R "cfg80211_external_auth_request" *
drivers/net/wireless/microchip/wilc1000/hif.c: 
cfg80211_external_auth_request(vif->ndev, &vif->auth,
drivers/net/wireless/quantenna/qtnfmac/event.c:	ret = 
cfg80211_external_auth_request(vif->netdev, &auth, GFP_KERNEL);

But the hardware seems to be unobtanium.  Maybe others can report what other 
solutions use EXTERNAL_AUTH?  Maybe Pinephone?

Regards,
-Denis
