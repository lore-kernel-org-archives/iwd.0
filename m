Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44F34A0D
	for <iwd@lists.linux.dev>; Wed, 31 Aug 2022 16:04:37 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id x19so12999938pfr.1
        for <iwd@lists.linux.dev>; Wed, 31 Aug 2022 09:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date;
        bh=SgJFevBzmtr3Cf8h/Wu8mu1XQDq+55MsACMgixBJr+M=;
        b=CsyhzIL0yPuZUPH+e3N010JCVWhS2I9olc1wOYW8rgH26dqY9qSg0K8HEuVKfwMgAa
         JhAWdW2fMUFIAYTyYKlhTS9h/0oEQdDNhpi8FezA11HOgE8hg2S6jsswrPJqd/60zBLc
         UKcXZs0wStKRJn2JD28XILO2w41TnS/8ObszOOjM+qVH9/n06Xeo8wwkQ5w/LO6uD15g
         UMD+XdZhgv3TTObZwN63c1VpE93P3bcc0Elf9KuO8kZsZk+k/hsuoA46Y/z+wGbqbUUb
         t8x2vod9JxCNlkSYI137mtcZpDTFeCPy0wS/x7EvE3R30lYwrIfpeIMiz2b7uo3twY+Q
         L03A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date;
        bh=SgJFevBzmtr3Cf8h/Wu8mu1XQDq+55MsACMgixBJr+M=;
        b=3Y63/7J8bksBUKAFsCryVsACIJB1oXplGt21zk22KwgXJ33FsCUmzI22jgzWjDXhr3
         tpIWZsnehni5qnC2JoJ0eX9m4HsD18nP7tA+QOQ/4X1V3gzSt2Zvs901Jz+7NLyICmv+
         nm+MMthoZJ0KoSctXiNBgk7FoW92o2dz/odvxy8s6NBXqAJ2t156QohUzYohUHR4ZJ/P
         /YEv3aiuK6gX/9ntTTez1tBeIBk6A6lNLV3+d0A0GOL+N1RCzuESZ5oGxLDLGJUYqEIg
         bMr7oRRMdHCsNvp0u6wWdeCXIG4nNX1crA9I2TVgjtp1FYde+CykBr0nn/ldHJFNYnLP
         wPcA==
X-Gm-Message-State: ACgBeo1uZz4m/2YVOMZRDwNpEmOCQScCk/lvJUbYWh3hfcqlTyxcm8Dv
	0iqWPQ2CZ6jjTYtpIJnd/ds=
X-Google-Smtp-Source: AA6agR5ji/c4lfGwxyysK9QMKIzS102CL/WR4/IJlwTXRjLq/eBRR1cg9ktgG60mEPp3qHK84wffig==
X-Received: by 2002:aa7:9242:0:b0:536:f215:4f4f with SMTP id 2-20020aa79242000000b00536f2154f4fmr26907575pfp.45.1661961877080;
        Wed, 31 Aug 2022 09:04:37 -0700 (PDT)
Received: from [192.168.254.16] ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id n7-20020a170903110700b0017441330392sm11681175plh.63.2022.08.31.09.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 09:04:36 -0700 (PDT)
Message-ID: <e5c70eecaa96e951176b6f99912822cb2ef5b3a9.camel@gmail.com>
Subject: Re: Cannot turn on AP mode without any error message
From: James Prestwood <prestwoj@gmail.com>
To: Chang Liu <goduck777@gmail.com>, iwd@lists.linux.dev
Date: Wed, 31 Aug 2022 09:04:36 -0700
In-Reply-To: <7fc91799-e030-fe90-44e9-c6490fbb6bb8@gmail.com>
References: <2031ff9c-0fff-18f7-2ad7-860e2b51ee22@gmail.com>
	 <f66462932dacecb2231bf356770165309c49beab.camel@gmail.com>
	 <7fc91799-e030-fe90-44e9-c6490fbb6bb8@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

> src/netdev.c:netdev_set_interface_event() Interface type changed from
> station to ap
> src/manager.c:manager_config_notify() Notification of command Set 
> Interface(6)
> src/netdev.c:netdev_link_notify() event 16 on ifindex 8
> src/netdev.c:netdev_link_notify() event 16 on ifindex 8
> src/netdev.c:netdev_link_notify() event 16 on ifindex 8
> src/netdev.c:netdev_link_notify() event 16 on ifindex 8
> Terminate
> 
> The output of iwmon is
> 
> < Request: Set Interface (0x06) len 16 [ack] 
> 1661908452.816568
>      Interface Index: 13 (0x0000000d)
>      Interface Type: 3 (0x00000003)
>  > Event: Set Interface (0x06) len 160 
> 1661908452.816674
>      Interface Index: 13 (0x0000000d)
>      Interface Name: wlan0
>      Wiphy: 0 (0x00000000)
>      Interface Type: 3 (0x00000003)
>      Wireless Device: 12 (0x000000000000000c)
>      MAC Address 9C:B6:D0:9A:5F:B7
>      Generation: 28 (0x0000001c)
>      4-Address: 0 (0x00)
>      Wiphy TX Power Level: 0 (0x00000000)
>      TXQ Stats: len 72
>          08 00 01 00 00 00 00 00 08 00 02 00 00 00 00 00 
> ................
>          08 00 03 00 00 00 00 00 08 00 04 00 00 00 00 00 
> ................
>          08 00 05 00 00 00 00 00 08 00 06 00 00 00 00 00 
> ................
>          08 00 08 00 00 00 00 00 08 00 09 00 00 00 00 00 
> ................
>          08 00 0a 00 00 00 00 00                          ........
>  > Response: Set Interface (0x06) len 4 [0x100] 
> 1661908452.816676
>      Status: Success (0)
> 

So we set to AP mode which is successful...

> < Request: Start AP (0x0f) len 224 [ack] 
> 1661908454.347354
>      Beacon Head: len 49
>          80 00 00 00 ff ff ff ff ff ff 9c b6 d0 9a 5f b7 
> .............._.
>          9c b6 d0 9a 5f b7 00 00 00 00 00 00 00 00 00 00 
> ...._...........
>          64 00 11 00 00 03 32 50 4c 01 03 82 0b 16 03 01 
> d.....2PL.......
>          06                                               .
>      Beacon Tail: len 48
>          30 14 01 00 00 0f ac 04 01 00 00 0f ac 04 01 00 
> 0...............
>          00 0f ac 02 00 00 dd 18 00 50 f2 04 10 4a 00 01 
> .........P...J..
>          10 10 44 00 01 02 10 49 00 06 00 37 2a 00 01 20 
> ..D....I...7*..
>      Information Elements: len 0
>      IE Probe Response: len 0
>      IE Assoc Response: len 0
>      Beacon Interval: 100 (0x00000064)
>      DTIM Period: 3 (0x00000003)
>      Interface Index: 13 (0x0000000d)
>      SSID: len 3
>          32 50 4c                                         2PL
>      Hidden SSID: 0 (0x00000000)
>      Cipher Suites Pairwise:
>          CCMP (00:0f:ac) suite  04
>      Cipher Suite Group: CCMP (00:0f:ac) suite  04
>      WPA Versions: 2 (0x00000002)
>      AKM Suites:
>          PSK; RSNA PSK (00:0f:ac) suite  02
>      Auth Type: 0 (0x00000000)
>      Wiphy Frequency: 2437 (0x00000985)
>      Channel Width: 1 (0x00000001)
>      Socket Owns Interface/Connection: true
>      Control Port over NL80211: true
>  > Response: Start AP (0x0f) len 4 [0x100] 
> 1661908454.437724
>      Status: Success (0)

Then start the AP which is successful...

>  > Event: Stop AP (0x10) len 28 
> 1661908457.014173
>      Wiphy: 0 (0x00000000)
>      Interface Index: 13 (0x0000000d)
>      Wireless Device: 12 (0x000000000000000c)

Then 3 seconds later the kernel sends STOP_AP...

So the kernel, for whatever reason, stopped the AP. Are you able to try
out hostapd (with iwmon running) and see if this works? That would tell
us if its a kernel problem, or if IWD is doing something unexpected for
this driver.

Thanks,
James

