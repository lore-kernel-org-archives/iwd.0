Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D3E55E4B
	for <iwd@lists.linux.dev>; Thu, 21 Dec 2023 16:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljRgZ4QO"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4277c62426fso5442381cf.1
        for <iwd@lists.linux.dev>; Thu, 21 Dec 2023 08:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703174923; x=1703779723; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cc0Q3R00Vk/uaQDGELU52hYZa4FSTDlsfqQhvy7/F5w=;
        b=ljRgZ4QOPHed6QsLHah1VVhx4S2HgsZ1EBs6Af55YByilc3Lueb/2+Yx4nI9o0joZT
         Z3L5mYf8jg8TSHjRlD6y8WE1c77FPpJP9VL0djpn0QpeyEns1u5CMBj8mwAmUgPm6dT5
         G3fTeSm0XhAP2IDI8WIlvJ64lBHKf1kSL8Z9YEIjI8Z/zOFWi4gGaYvG9QP01OTI5u2B
         Bo3RV/6/ElmnBvcYagWY31OUfrI8kaiF4ITuBN6tcOLdAnF4Nzn7S2es0MVDLf5uqGSc
         kWMNNGclD3riZrV51ceOxaUAUhxYV+G/VxZsDBtMlW3TGCb44in+6xZrUPVSR8CA8hWx
         T9YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703174923; x=1703779723;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cc0Q3R00Vk/uaQDGELU52hYZa4FSTDlsfqQhvy7/F5w=;
        b=QQg2wi16ubElJJ9Nz9uxygVE/6/8wT4xBxYDAEbv39KcWjHhg6/VQfvunXbPwfzuV1
         3FGQMsAQKsPFepxJAY343gXHICKbq9OArObQQT1abog/j7kogKYC3PAvDs0eNg08flHO
         xOOoIPNyAoNaJGby+/OT2Cl8JHU3sF/Qm2qQNnfAzMKaIp4E3YkMM3OrjSiBIVZMjFMY
         H82h9igwg00ACU+WIPilxkr8tUX+ZmK33MBuAs25Xv/Vh3zIf3T2W3gnyHAqifLiX/ZR
         RDYzGdtTZnB0vzujvSakBffgUk16OL43WbaqKccJjdoF8yP8PSfNEGvoAunrKIG+uDLh
         k8UQ==
X-Gm-Message-State: AOJu0YzFJu/2m0EYEeuQ0t9B97T0LgCxK62DTgI3enB0fjCMY1tdPQM6
	GyukaztOV9LCI33Kyy3DLMM=
X-Google-Smtp-Source: AGHT+IH0f2VZjemGGtElcIGsWmlZx+Pchp/c2/nLgiYRvmoQu95I2xZ5pn2y3ChfAz7HWg12u6kdPQ==
X-Received: by 2002:ac8:5cce:0:b0:427:8e6e:c4ea with SMTP id s14-20020ac85cce000000b004278e6ec4eamr2977696qta.39.1703174923325;
        Thu, 21 Dec 2023 08:08:43 -0800 (PST)
Received: from [10.102.4.159] ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id h18-20020ac85492000000b00423a3f5ea75sm938236qtq.21.2023.12.21.08.08.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Dec 2023 08:08:43 -0800 (PST)
Message-ID: <c11d1310-a0ca-46a2-b08e-d1e35351826a@gmail.com>
Date: Thu, 21 Dec 2023 08:08:41 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Iwd: unable to start AP with NXP 88W9098 chipset
Content-Language: en-US
To: Joao Marcos Costa <joaomarcos.costa@bootlin.com>, iwd@lists.linux.dev
Cc: gregory.clement@bootlin.com, Salahaldeen.Altous@leica-camera.com
References: <6c9b05a2-7474-4eed-bb74-6f5de1d433ba@bootlin.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <6c9b05a2-7474-4eed-bb74-6f5de1d433ba@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Joao,

On 12/21/23 7:46 AM, Joao Marcos Costa wrote:
> Hello,
>
> I hope this email finds you well.
>
> I'm currently facing what seems to be the very same bug reported at 
> https://lore.kernel.org/iwd/AM7PR01MB67244F63EBEAB9A65D965BEAADC69@AM7PR01MB6724.eurprd01.prod.exchangelabs.com/
>
> As for my own context, I'm using:
>
> - Ublox wifi module Jody-W377-00A
>
> - IWD v1.26 (from meta-openembedded)
This is quite an old version, there have been many changes to AP mode 
since then.
>
> - Linux v6.1.68 (x86_64)
>
> - NXP Wi-Fi driver for NXP 88W9098 chipset, from 
> github.com/nxp-imx/mwifiex (branch=lf-6.1.55_2.2.0)
>
> I followed the steps in https://iwd.wiki.kernel.org/ap_mode, and this 
> is the error I get in my iwctl console:
>
> # iwctl
> NetworkConfigurationEnabled: enabled
> StateDirectory: /var/lib/iwd
> Version: 1.26
> [iwd]# device muap0 set-property Mode ap
> [iwd]# device list
> Devices                                   *
> -------------------------------------------------------------------------------- 
>
>   Name                Address             Powered   Adapter Mode
> -------------------------------------------------------------------------------- 
>
>   uap0                62:09:c3:80:9b:1d   on        mwiphy0 ap
>   mlan0              60:09:c3:80:9a:1d   on        mwiphy0 station
>   muap0             62:09:c3:80:9b:1e   on        mwiphy1 ap
>   mmlan0           60:09:c3:80:9a:1e   on        mwiphy1 station
> [iwd]# ap list
>                           Devices in Access Point 
> Mode                        *
> -------------------------------------------------------------------------------- 
>
>   Name                Started
> -------------------------------------------------------------------------------- 
>
>   uap0                no
>   muap0             no
>
> [iwd]# ap muap0 start-profile testap
> [iwd]# [22444.663032] wlan: Starting AP
> [22444.668197] fw doesn't support 11ax
> [22444.674130] CMD_RESP: cmd 0xb1 error, result=0x1
> [22444.679286] IOCTL failed: 00000000ae152881 id=0x20000, 
> sub_id=0x20001 action=1, status_code=0x1
> [22444.689145] woal_cfg80211_add_beacon: start uap failed
> Operation failed
>
> My /var/lib/iwd/ap/testap.ap file is identical to the one provided in 
> the Wiki, and as for my main.conf:
>
> ---
>
> [General]
> EnableNetworkConfiguration=true
> UseDefaultInterface=true
>
> [Network]
>
> [Scan]
> DisablePeriodicScan=true
>
> ---
>
> I tried adding Country=FR and ControlPortOverNL80211=false, but 
> without any success.
>
> I also added DisableHT=true in the testap.ap file later on, but the 
> result was the same.
This is a more recent option. I have a feeling if you updated IWD and 
set DisableHT it would work.
>
> However, I was able to start the Access Point using hostapd, and it 
> worked fine.
>
> I can provide you with my hostapd.conf, if you find it pertinent.
>
>
> Since referencing the original thread, are there any updates?
>
> Has anyone else encountered a similar issue? Even if the chipset is 
> not precisely the same.
>
> Please feel free to ask for logs or other unmentioned details, and 
> thank you for your assistance.

When helping  Salahaldeen in the original thread I remember that 
hardware being extremely flaky. It would start sometimes and not others, 
and if it failed once it would need a full reboot to get it working 
again. Even with hostapd if I used an option it didn't like it required 
a full reboot to get it going again.

IIRC there was also some success on one of the interfaces but not the 
others. If you could provide some IWD debug logs too that would be 
great, and might as well show the hostapd configuration that works as well.

Thanks,

James

