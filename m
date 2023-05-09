Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE06517FFC
	for <iwd@lists.linux.dev>; Tue,  9 May 2023 16:12:50 +0000 (UTC)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-64115eef620so43643886b3a.1
        for <iwd@lists.linux.dev>; Tue, 09 May 2023 09:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683648770; x=1686240770;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O0vd4IDEMKBo+nyTMqq2qV/qrqME10GywEng/OyaftQ=;
        b=OfCog6p/quYwz8TqEZ8z52t/cRWhIOnYbbzovfuhBTGLnJ6t3J5jB52HuA64C6MhkY
         hNXcTKewg5uaDVzoY6IjhNcCYcP6LbOojq8gDify7RMCU8GJmAqLuaCxdCtPgR2GDVlI
         phpdtXE79QA4TVy8gVlkBaENSZ1/O4EToRUBgiOvDcpo6RnsGTDxGNSvFY2W6Q6xkd2G
         s3aktwuXGYfAoH01lfXfKjWEXnbXO3z6C2rikdZKrcljb4pcDgX4E5wJJZujtoPEoYev
         3RFvl1M7TpdihVguY84ShgV/LMB4pduk1iTvr0m1PjrimwGMkqy3e1nz7dHlLYrXqiu3
         o3ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683648770; x=1686240770;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O0vd4IDEMKBo+nyTMqq2qV/qrqME10GywEng/OyaftQ=;
        b=A51WGacbefHpvLtSGXnFr8jJWf32To4JeZSXaEYF7Ctqz2dBu4ou1Pj/7e5/2g3uMN
         xDEPAaZoCppCkajQ75pQIksPbMHWi/3PFAMAYA0P2itKv1SRBfVNR+tKkgH82ghcLdQ+
         yM9baYG+fFnZRlekZP6nLzr9zCk3KA13J8sYD83Xl6I1waYj/qGarvWxGFRIKxWAQqj6
         zwV3jtihtI1s+fzKBsWTsJQJt8Bcv2nQkD77HqIL9fLuMriuH7cwbB9gkCAikdfdOyC9
         SRap0S8QoEgkQkWq6eqdsK78Wqgfj+hDXgBSRj69Ib4kpmu4owG5iCFkmrQRudzGSNyc
         6l8w==
X-Gm-Message-State: AC+VfDzZPUORr/CqFtK/4pmGVRi1PgisHIvmSBQhI3bYeEJXD2bRwfx9
	FUn1bq6PqWUOAz+o5NQo607GHzue8H3ZWQ==
X-Google-Smtp-Source: ACHHUZ7S0Dj4auZzQ+JVzHsXyl0DuV7wora6yDmCot7TftyuNBM5ojREvi77A6fwgzUtV9hXAx8Snw==
X-Received: by 2002:a17:902:e746:b0:1ac:4b76:29a1 with SMTP id p6-20020a170902e74600b001ac4b7629a1mr14415941plf.29.1683648770187;
        Tue, 09 May 2023 09:12:50 -0700 (PDT)
Received: from [192.168.254.76] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id j18-20020a170902da9200b001aaea7bdaa7sm1787178plx.50.2023.05.09.09.12.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 09:12:49 -0700 (PDT)
Message-ID: <c64e2e2d-50eb-6771-2c16-572c59f1a3d7@gmail.com>
Date: Tue, 9 May 2023 09:12:49 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: powersave support
Content-Language: en-US
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Mike Silva <mike.silva@mikesilva.com>, iwd@lists.linux.dev
References: <9EF567DC-15CC-40C0-9AF8-D69E27B81ACF@mikesilva.com>
 <f5ccf370-5197-c9a4-61b6-2a130c7242de@gmail.com>
 <4F32B57B-3517-46EA-97F6-2B5DC172B952@holtmann.org>
 <66b05814-cb78-40c7-929b-0e2ffa2027a6@gmail.com>
 <04BED22D-EBF1-47B8-AD51-01DCC2CA4138@holtmann.org>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <04BED22D-EBF1-47B8-AD51-01DCC2CA4138@holtmann.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Marcel,

On 5/9/23 9:09 AM, Marcel Holtmann wrote:
> Hi James,
> 
>>>>> Does IWD support disabling/enabling WiFi powersave/power management?
>>>>
>>>> No, currently it doesn't.
>>>>
>>>>> Perhaps, I’m failing in finding it in the documentation. It’s possible to do this as needed with ifconfig, iwconfig, or NetworkManager, or to permanently configure them to enable or disable it at boot..
>>>>> If IWD doesn’t support this, it would be nice enhancement if IWD could when managing the adapter/connection, as some drivers do a poor job of handling powersave being on.
>>>>
>>>> Yes, I've recently seen instances of drivers handling this poorly. Are you envisioning something like these other tools, where power save is just toggled on/off?
>>>>
>>>> I think this could be done, and actually we do this manually every boot using iwconfig in the software stack I work with. The tricky part is PS is done per-interface and IWD doesn't have any concept of per-interface configurations.
>>> if anybody uses iwconfig, then the problem is already there. iwconfig
>>> is an WEXT tool and deprecated. The driver is broken.
>>
>> It doesn't have much to do with the tool, its just an NL80211 API to toggle power save. But yes, the driver is broken if it can't handle this properly... but this is the world we live in.
>>
>> The reason I'm interested though is because there is no nice way to disable power save "automatically" unless you use NetworkManager. Apart from hooking in a script to disable it with iw/iwconfig (which we currently do). An option in IWD would be convenient.
>>
>>>> Denis might have preferences on this? but my initial thoughts would be something like:
>>>>
>>>> [General.wlan0]
>>>> PowerSave={on,off}
>>> You can't tie anything to interface names. Then can change and are
>>> basically random names. The most you can do is tie it to the phy
>>> and its mode of operation.
>>
>> True, it would have to be per-phy. But this too has the same problem if its a hotplug device...
>>
>> We do have this concept of driver_flags already, for interface removal, but I'm not sure if power save is something that EVERYONE will want to disable for a given driver. Maybe it works for some use cases but not others.
> 
> we already have this:
> 
> enum driver_flag {
>          DEFAULT_IF = 0x1,
>          FORCE_PAE = 0x2,
> };
> 
> struct driver_info {
>          const char *prefix;
>          unsigned int flags;
> };
> 
> /*
>   * The out-of-tree rtl88x2bu crashes the kernel hard if default interface is
>   * destroyed.  It seems many other drivers are built from the same source code
>   * so we set the DEFAULT_IF flag for all of them.  Unfortunately there are
>   * in-tree drivers that also match these names and may be fine.
>   */
> static const struct driver_info driver_infos[] = {
>          { "rtl81*",          DEFAULT_IF },
>          { "rtl87*",          DEFAULT_IF },
>          { "rtl88*",          DEFAULT_IF },
>          { "rtw_*",           DEFAULT_IF },
>          { "brcmfmac",        DEFAULT_IF },
>          { "bcmsdh_sdmmc",    DEFAULT_IF },
> };
> 
> It is hardcoded and obviously awful as that, but you could add a flag
> for power save mode. However I think this needs to move into a configuration
> file somewhere that can match and flag drivers and/or hardware.

Yeah, I'll see what I can come up with when I have some spare cycles.

> 
> Regards
> 
> Marcel
> 
