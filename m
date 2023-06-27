Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3392C12B66
	for <iwd@lists.linux.dev>; Tue, 27 Jun 2023 14:29:46 +0000 (UTC)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-635dbfa710dso19198446d6.0
        for <iwd@lists.linux.dev>; Tue, 27 Jun 2023 07:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687876186; x=1690468186;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3AJ+GoYxigCqJBnSSdFX7cNLKwQxkPbj3yTJ4pdDrB4=;
        b=j76fAhVgat5X8Nn01pm8KhbwihcwFGtwSFAoduoIYCf6CDcZkl9T/KEM0wK/SIxTdo
         s3Rk+bsjsoJPl/f8hSApJEXZesZ7jfVhLxRaLS2qf4RKoYWtSew7akd4h8KZB8eVIs1E
         5Nwcrw8iz6L5Nr9T63qBg7xAqFVNrHoROloE0DeIg/y2d+3bsWOIrkC3ViN76dYtFrmP
         Knytae+3fJ0E7hLfTMyRPKRkfur/La2DKTDmUWNij1oYZq2pyTqBTvJhStX2GADA/8oh
         ODKLf6IpGQnIF4hrwbYg+J8n+BuLkl1KApSZShR+373joFmRN/wTrCsuYev2tYZhMeuV
         ZoDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687876186; x=1690468186;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3AJ+GoYxigCqJBnSSdFX7cNLKwQxkPbj3yTJ4pdDrB4=;
        b=jzYJGQgYXgrCGrI2Y0w25YoSaSCXsBQbKkTABZq0gjEeGOUHarihBNu5A1PdZ6pwhm
         69JQbOw1jeqOxvJ91K9FRVSYLxleWb0DMbCLr5JYVjtzauunTivIhdDZaljttP5rknRa
         82q60Bva/0cWSKuUaL1XF1kDj2dXavbIFR4y+AQ9/hPmdmPJJzhJpMOfiynOLSgaQxQp
         alY+/E2KaOUrurctSSBivQMdBM6fAicCNzWL5dzDEIwq9PdOa8bj17Dq2c8SksOFsW8X
         PEnv3ZsXeXOvEeyLaHTau/fNLG+L3BlZUMaErxxfhDUspCfgRj+9dYWbbq6ThW9hflIA
         uOcA==
X-Gm-Message-State: AC+VfDzeh2X/1Yc/o8rD5zjsNJ8HnffoyjFtnTPH8a5wa/5pE2u/ymVH
	J/9pyDKbnrtY5bH4IKQlPZbcAUum5mY=
X-Google-Smtp-Source: ACHHUZ6phWbShc646dCvVi/Q0mv2MUdnVUdErWx/e1IUAH8eAYV/LvMG0EAhiaw6U78BSx3t6EP/Aw==
X-Received: by 2002:ad4:5761:0:b0:62f:ff00:f8fa with SMTP id r1-20020ad45761000000b0062fff00f8famr44529144qvx.63.1687876185769;
        Tue, 27 Jun 2023 07:29:45 -0700 (PDT)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id ev14-20020a0562140a8e00b006301ec0d178sm4608612qvb.5.2023.06.27.07.29.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 07:29:45 -0700 (PDT)
Message-ID: <c341680a-01b6-cd2a-1826-ba868a02d4f3@gmail.com>
Date: Tue, 27 Jun 2023 07:29:42 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: iwd forgets network
Content-Language: en-US
To: Martin Petzold <martin.petzold@tavla.de>, iwd@lists.linux.dev
References: <7794c62a-56d2-d34a-06e9-0b17edb235f7@tavla.de>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <7794c62a-56d2-d34a-06e9-0b17edb235f7@tavla.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Martin,

On 6/27/23 12:58 AM, Martin Petzold wrote:
> Hi,
> 
> I have a critical issue with iwd and kindly ask for feedback.
> 
> We have an embedded device (no desktop) running Debian bullseye with 
> custom 5.10.52 kernel (NXP patches; own configuration).
> 
> We are using iwd 1.27-1~bpo11+1 from bullseye backports together with 
> systemd from bullseye main.
> 
> We use a bind mount to move the iwd state to a separate partition, 
> because we do rootfs upgrades and want to keep the state.
> 
> Yesterday and also once before our platform forgot a network (the *.psk 
> file was gone). We did not call any command for this. As far as we can 
> re-call we did not reboot the platform. Some time before this issue, we 
> pulled the power of our router and the network was of course gone - back 
> a few minutes later. I have no idea if this could be related or just 
> co-incidence.

The only way IWD removes a network profile is via "Forget()". You could 
add a debug print inside src/storage.c:storage_network_remove() if you 
were suspicious but I highly doubt that has anything to do with it.

I would guess it more has something to do with the bind mount. Are you 
sure nothing touched /system/var/lib/iwd ?

> 
> Here are our configuration files:
> 
> ########## /etc/systemd/network/20-wlan0.network
> 
> [Match]
> Name=wlan0
> 
> [Network]
> DHCP=yes
> 
> IgnoreCarrierLoss=3s
> 
> [DHCPv4]
> RouteMetric=20
> 
> ########## /etc/iwd/main.conf
> 
> [General]
> UseDefaultInterface=true
> 
> [Network]
> NameResolvingService=systemd
> 
> ########## /usr/lib/systemd/system/var-lib-iwd.mount
> 
> [Unit]
> Description=Mount IWD state
> 
> [Mount]
> What=/system/var/lib/iwd
> Where=/var/lib/iwd
> Type=none
> Options=bind
> 
> [Install]
> WantedBy=local-fs.target
> 
> ##########
> 
> Thanks,
> 
> Martin
> 
> 
