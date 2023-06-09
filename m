Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C0823403
	for <iwd@lists.linux.dev>; Fri,  9 Jun 2023 22:07:57 +0000 (UTC)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6261a61b38cso16391336d6.1
        for <iwd@lists.linux.dev>; Fri, 09 Jun 2023 15:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686348477; x=1688940477;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E1QG1d/ivXi0Q0ytZJVuNa0qMRB+ClG+t3/HS9nBQZY=;
        b=Pt3ZAd6ACjxodXY+eb9hxzlJhltCCcTiOZGl90GMFJr3Rut/ZitNoKMJGbw38AMTgY
         ebOtuSlDpVrU3Mr0Kc22LbZBYqL/A/ThylSrPZMkjGXqefRWdP0aiJtqk3czzTCEGRai
         89N9regQoPbqvnbawdGI+1h9Q0fgainJ7GAS6g/X29lcPGdZfNdJQYbU3/2pQahtJpeC
         TJYmTr/nkVh9s68GQf+7gUha3jG2NaxgDFj5t/EuUpQ/nqQNWxeqajBYJ09UB+EyIPRT
         lWs+lW+AnQH7jYtIAdFrwo3qxpf1L5oY15Xr+T4qRJy1u4RAAw1xl/POunIOkU3XHkLm
         rBww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686348477; x=1688940477;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E1QG1d/ivXi0Q0ytZJVuNa0qMRB+ClG+t3/HS9nBQZY=;
        b=Z/o/QFwxm7My/pq3e14pHmoU3YYtq2yTl9SqRsHGdF6fyrwCt22E6/9uaOj6k99uzt
         93NslPUMEZHEIaDXREF73wApKj7q7VzI2gDto/ztInh1D2uACKfdxeuj/duGkwNcxVUX
         k8cx1nxMzTJLTvuBkxDvkKmNnj1R26aJh//yuao3Fd1FpU5V2xYDmPCHiorfLIzDMXJ7
         Ztnp1BxUNjc6Uv1Vqz7gJDPKfRVY9+wyMLjQUZ9Ib+Q4nDjNo5nb7z4f1e/W1/9uCLEe
         3wXRSgXvs3NmWwcUJBzYDrXWOgBI3/ub3Ak+UdgHfdqQDYEYSc4xZjFoPigg9Wfw2mSY
         i1Iw==
X-Gm-Message-State: AC+VfDzK+Isov4mkiqVR868JrL31dkuv3e+1Md5rRnJvZSdCP4ikypx5
	Iw0QlHVy6+nh0YQycZk0ozZ4OMYkt1s=
X-Google-Smtp-Source: ACHHUZ7emBbPQvwQUxiD47LLKWjcNJHwuBtrOhmJXlP9A4ZeEfU0C202L04/Ouyzr4/UF28BlMoBSg==
X-Received: by 2002:a05:6214:250e:b0:626:3a98:95f with SMTP id gf14-20020a056214250e00b006263a98095fmr3526445qvb.65.1686348476716;
        Fri, 09 Jun 2023 15:07:56 -0700 (PDT)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id w10-20020a0ce10a000000b006261c80d76dsm1436852qvk.71.2023.06.09.15.07.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 15:07:56 -0700 (PDT)
Message-ID: <772f5654-5232-6aa1-5ef1-601585d408f0@gmail.com>
Date: Fri, 9 Jun 2023 15:07:53 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
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

Hi,

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

After looking into power save more I decided to revisit this sooner than 
later. I initially thought you could get a persistent PS setting by a 
script that runs at boot but the way IWD works deleting the default 
interface actually blows away any PS setting because its tied to the 
interface. So you would actually have to wait for IWD to start and 
create interfaces, then set PS off, which is problematic if you don't 
have a daemon monitoring IWD's state. It would be convenient for IWD to 
set it once it creates the interface.

So now I'm trying to come up with a clean way of making driver quirks 
like this configurable via main.conf. I think we should keep this static 
list for known offenders and tack it onto the end of a dynamic list that 
gets generated at runtime based on any driver quirks in main.conf

The configuration format is where it gets kinda nasty. I'm thinking of 
having a "DriverQuirks" group where each key corresponds to a driver 
flag, and each value is a comma-separated list of glob matches:

[DriverQuirks]
DefaultInterface=rtl81*,rtl87*,rtl88*,brcmfmac
PowerSaveOff=ath10k,iwlwifi,rl*
ForcePae=drv1,drv2,etc

One downside here is you may have duplicates between each quirk. Using 
driver names as the keys would remove duplication, but loses the ability 
to glob match since '*' is not a valid key character (maybe this is fine 
though).

I'm open to suggestions here. Trying to find a happy medium between 
readability and parse-ability.

Thanks,
James

> 
> Regards
> 
> Marcel
> 
