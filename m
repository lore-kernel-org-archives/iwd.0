Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304356AB9F
	for <iwd@lists.linux.dev>; Thu, 14 Dec 2023 20:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6Bqg5Kw"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-67f06da0b15so7974446d6.2
        for <iwd@lists.linux.dev>; Thu, 14 Dec 2023 12:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702584558; x=1703189358; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bq9HFkkr3kUp/0ZYQT9QKj7Jnr66Kd8opyZLxk2WMOc=;
        b=V6Bqg5Kwy6AU/5J07sPR16BgJ1uvoAMBnHzJTW5zykph+K8hike6rhS9M6yupMuHI2
         Md4CbdcSKKuGg5Nahk2rXJ0+AV8VQkVYjAKB2Hl+/12gLCDbUGZ8ZvUO1dDKCxa5UTn/
         2kj180ZQPO0MWqszv4N/ft49dQfWmMzZT4wC44h7VDOQLumF5DIrp7qxo5M9iAD3u5ba
         RX69bOG5zL8/IlhglOrYW6wHnN1kof56+YwuLjQwczehF/dH/+/aVtf5EuU4sFkvQ3A2
         djUPau4Ia9KQgQnMtGKVUkCg0BODcbnTeAknxbi9lpyRUUYi5a+tybLpY7A///hxrGrP
         oqKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702584558; x=1703189358;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bq9HFkkr3kUp/0ZYQT9QKj7Jnr66Kd8opyZLxk2WMOc=;
        b=Q7RX5c9ex6FdYzQCf8Mi/z8/6hqMUWZeu2UlRa523rIdn6UXJoyMQa7bsqsBhCuoYz
         L0bTxVM5mxd83G0bPzLvkDpupSThaxQREd8gsKFtwrtXXcv68767B9TbWDpoNIpmGJ7G
         lBNh/P0nZfUSBWwrrok303H2h1U1UbI9LPrFs8JF/WVYoE3WhfJ3aNgr4U5ueDsPER10
         1V8kKwWod8TTujPCH9OupUUgAdJ6qOja3Lq/L3JLREEXrWAfNhuergK0seBbEazT2a4q
         lVbrYQke6YmL2LIUFIwBC26Az+hVQxPB9uEFOXSn7mplgWH1plKduHKHuHm4NH7p8kBZ
         Zvyg==
X-Gm-Message-State: AOJu0YyFVVpMHkhDRVq7g0mTuxZqR678ireYRRN4sU5dMVwyYNbwdi/+
	KhmvfMrQH0IG1AFipITPlq6OCxt6jHA=
X-Google-Smtp-Source: AGHT+IEXCIdXrZ8P2obaY0R45yfQ+xOGQngG9bM/hM2/umTMJz8i+W+qi74ENkA0BY4qNPIL90Xu5w==
X-Received: by 2002:a05:6214:f27:b0:67f:f92:29fd with SMTP id iw7-20020a0562140f2700b0067f0f9229fdmr1482881qvb.115.1702584558408;
        Thu, 14 Dec 2023 12:09:18 -0800 (PST)
Received: from [10.102.4.159] ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id b2-20020a0cbf42000000b0067ec8702d1dsm4458611qvj.137.2023.12.14.12.09.17
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 12:09:18 -0800 (PST)
Message-ID: <33212132-591c-4845-92e2-6ad39068601b@gmail.com>
Date: Thu, 14 Dec 2023 12:09:16 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] Retry when ifup fails
Content-Language: en-US
To: iwd@lists.linux.dev
References: <20231214190340.133011-1-prestwoj@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <20231214190340.133011-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/14/23 11:03, James Prestwood wrote:
> For some background, at its core this is a driver issue. The problem
> seemed to happen much more frequently when power save was disabled
> while the interface was down (this was reordered in a prior patch)
> but I've received two reports of this happening now even after
> that change was made. The driver logs are the same in both cases.
> It appears to be some race between bringing the interface down and
> up quickly.
>
> This issue seems to have cropped up somewhat recently, in the last
> few months (or nobody was reporting it). This specific code path
> hasn't changed in a long time so I suspect other IWD changes, or gcc
> variations slightly altered timing/scheduling and exposed this ath10k
> bug.
>
> After applying this patch I did see it happen again and the retry
> was able to bring the interface back up successufully so to me this
> seems like a viable option until the driver is fixed (if it ever is).
>
> I do have an open thread with some ath10k engineers about this.
>
> The one occurrence I've seen since the workaround was applied:
>
> iwd[1571924]: src/manager.c:manager_new_p2p_interface_cb()
> iwd[1571924]: src/p2p.c:p2p_device_update_from_genl() Created P2P device 15
> kernel: ath10k_pci 0000:02:00.0: wmi service ready event not received
> iwd[1571924]: Error bringing interface 14 up: Connection timed out, retrying in 1s
> kernel: ath10k_pci 0000:02:00.0: Could not init core: -110
> iwd[1571924]: src/netdev.c:netdev_link_notify() event 16 on ifindex 14
> iwd[1571924]: src/netdev.c:netdev_set_4addr() netdev: 14 use_4addr: 0
> iwd[1571924]: src/netdev.c:netdev_initial_up_cb() Interface 14 initialized
> iwd[1571924]: src/netconfig.c:netconfig_new() Creating netconfig for interface: 14
> iwd[1571924]: src/station.c:station_enter_state() Old State: disconnected, new state: autoconnect_quick

After closer inspection, while the ifup succeeded, the driver still 
seemed to be in a bad state. Probably better to hold off until more is 
known. I suspect the interface needs to be completely removed and 
created again in order to get the driver working when this happens.

Reported on linux-wireless:

https://lore.kernel.org/linux-wireless/abbb7874-7f7f-423b-b67c-6ef850ae5bd6@gmail.com/T/#u

>
> James Prestwood (1):
>    netdev: retry on failed ifup
>
>   src/netdev.c | 41 ++++++++++++++++++++++++++++++++++-------
>   1 file changed, 34 insertions(+), 7 deletions(-)
>
