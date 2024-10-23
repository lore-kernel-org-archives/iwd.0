Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177751ABEAC
	for <iwd@lists.linux.dev>; Wed, 23 Oct 2024 12:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729685633; cv=none; b=kDxwacQa0xJifbZt3CBq/L1AYUm/kUHn0+sPf0rVTRDh9B1xE784219wjEXneJ10ujltWVWc3AgopjbrpOSXV7QCunvBXEHra1qGFj2BQjUszn+BJA7tsG2WVF0TObOOT3X+rtBVdNsrgSB5g//Oe6qetbw/brbnlzXLXBFZeRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729685633; c=relaxed/simple;
	bh=3Z9C+q1sBxJukSnXyXCM5wt5uml78+8bigsYEMC3uIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b1U1HK+haBJyZRzIzhTW9XzlecNNkFClPgmT2m+wz3mJ4hNk14fJv4d+nxNZofi/PMnv5vIBSFwYc8/WChcQacsuYLAO5EnfuKVSxviPgqDbMbvyhMYLkIGSE4W1FJh0k/ExQ27dex2YGdMGyOG2p+3TEAo9ocxhg0LeXB7me+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FHdnJzZM; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHdnJzZM"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20cf6eea3c0so55234545ad.0
        for <iwd@lists.linux.dev>; Wed, 23 Oct 2024 05:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729685631; x=1730290431; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BZ52wPMGnRIU4BanumP6ClQbUjUQ64+p0BROa/ypNdM=;
        b=FHdnJzZMYoaGBwGEkkh4gR4j/BfqmFygtxL7aK/FKhWI1fyEzs8WBeusN/F6qMSzdV
         lwztzaxYnMn2IemPpT2Grtx4ftWcRg21O36rBkqSz+4Sf5pzcGICohAlFlI2B0gPGzIb
         1c/jlx1FW1s6SGpGwnfX6dvEZjhHgMa1qf3GpxoL/1u0mTN8stDRF+TCgDxINPJ4YIYn
         c+4ejRUqUwRsRlFu5ExXGAN7x6a9bewKaK7H9G2TMi6lAUV5mMib65a0biRtPY+Z6nGs
         QYWmAXo3nY7GDB/o/3DDPann+ApDAHsdqbYQAQ8HukukV/AAPdsTNTvqsCP85ULZB1dG
         Tgdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729685631; x=1730290431;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BZ52wPMGnRIU4BanumP6ClQbUjUQ64+p0BROa/ypNdM=;
        b=Cz8eE9Gqi5XzUuMrXNGBtrse1NOm/cDzjRKAJIgSNEnRtId7F/gbXA2KgpjKiLGLYR
         JAVzUZBdOK8uOBov+EE7bCvOY4MNvrEneF5JosI2nvsSsgOo0IoBAiQmQXmY70bT5i8E
         pbWOW6Tuu3ZXrpxCtPR6ztCB9+OXHZuaXTQUMlYvs43bCuXzH+mSmZ8XAj9QWnfVAyxu
         vpAU7C2yizmYmoUfWZ3yk3LmhGj/pIi3NDzys7XAVes2yZokgD/f2Z6xjQBZZ+SH7LTj
         CGl1fFMhPdoXVfzLHepT9aBQbL4p3roqM0UgJ86hTiEiL3xhaywfp4985cera6FnbmMK
         eRmQ==
X-Gm-Message-State: AOJu0YxDzbwvuuMVSngDkQEfAjmNKeiWfrk4XFMe7VL5A3gYBlpg0KoS
	r/srX2CBEoTlP8/EF1wuVovrdpb+vKlrJFecgzgLzSO+XPVC7sUL
X-Google-Smtp-Source: AGHT+IFyf1MXGZYp/hq63dbEYiQf2OTnDJG5BJpbpiLU5mNPZtdyv96U4zPNNUAYuIyLJElpmrPW3w==
X-Received: by 2002:a17:902:e745:b0:20c:d18c:1704 with SMTP id d9443c01a7336-20fa9e4aeffmr30455685ad.23.1729685631115;
        Wed, 23 Oct 2024 05:13:51 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20faecdb456sm8288025ad.9.2024.10.23.05.13.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 05:13:50 -0700 (PDT)
Message-ID: <77fc14d0-96bc-465c-b425-111ba4310c86@gmail.com>
Date: Wed, 23 Oct 2024 05:13:48 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: IWD 1.27 with brcmfmac not working for roaming
To: Martin Petzold <martin.petzold@tavla.de>,
 Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: iwd@lists.linux.dev, Denis Kenzior <denkenz@gmail.com>
References: <a99e0ef1-8f97-4c1d-9aa5-5a07c87782a5@tavla.de>
 <d91f33df-e9d7-430a-b1ca-13cd1dee973a@gmail.com>
 <c5e790a5-2854-47a6-9431-e02a0f9e6676@tavla.de>
 <5efc11fc-9c21-44a0-b282-5d41bfb96a8c@gmail.com>
 <f496ad63-e2a6-46cb-b7d6-1a084523c7d9@broadcom.com>
 <1761198e-9f41-4e5a-b2b9-a1652732346d@gmail.com>
 <6898cd84-c7b9-4fa0-aeb5-c7a90d81b58b@tavla.de>
 <b0afc4f1-6496-48a4-a11c-789ee08368e4@tavla.de>
 <5a128900-432f-439e-9008-3b303ee72eb1@gmail.com>
 <2dacc589-9927-40f7-85ed-5f6b2afbbd41@tavla.de>
 <192af85f1e0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <2ab8601e-1601-4d4f-b58d-e9f23877650f@gmail.com>
 <192b00cf460.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <54a62c50-5c9b-47c6-b8ab-f7369381fdf9@gmail.com>
 <c57706f6-2d5c-4e73-bc42-e2b7e4239a78@broadcom.com>
 <e5626359-2b7c-4161-9aa7-7fd7133ec390@tavla.de>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <e5626359-2b7c-4161-9aa7-7fd7133ec390@tavla.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Martin,

On 10/23/24 5:02 AM, Martin Petzold wrote:
> Hi Arend and James,
>
> Am 21.10.24 um 20:26 schrieb Arend van Spriel:
>> On 10/21/2024 7:40 PM, Denis Kenzior wrote:
>>> Hi Arend,
>>>
>>>>
>>>> I have not seen patches for OWE in brcmfmac. Looking at the 
>>>> supported ciphers:
>>>
>>> OWE is an AKM.  It still uses CCMP/CMAC underneath.
>>
>> My bad. Always confused by those concepts.
>>
>>>>
>>>> Supported Ciphers:
>>>>   * WEP40 (00-0f-ac:1)
>>>>   * WEP104 (00-0f-ac:5)
>>>>   * TKIP (00-0f-ac:2)
>>>>   * CCMP-128 (00-0f-ac:4)
>>>>   * CMAC (00-0f-ac:6)
>>>>
>>>> The error message seems to match with the above.
>>>
>>> I've never seen support for OWE in brcmfmac mentioned.  OWE requires 
>>> CMD_AUTHENTICATE / CMD_ASSOCIATE (or CMD_EXTERNAL_AUTH) to derive 
>>> the PMK, so iwd can't support it on FullMAC.
>>
>> I have never seen any mention of OWE either. Regarding 
>> CMD_EXTERNAL_AUTH support I recently posted patches on linux-wireless 
>> list as RFT. There has been zero feedback and so I assume also zero 
>> interest. In order to use CMD_EXTERNAL_AUTH the firmware needs to 
>> advertise "sae_ext" in fwcap debugfs file. So if Martin can check 
>> that, ie:
>>
>> $ grep sae_ext /sys/kernel/debug/ieee80211/phy0/fwcap
>>
>>
> @James: Could please check the logs (PATCH WAS APPLIED):
>
> A. Initial boot and connect (device remained connected)

On this run I'm seeing an agent connecting and issuing an explicit 
connect call rather than IWD autoconnecting. This is fine, and will 
create a new .open profile.

Okt 23 12:39:35 tavla iwd[383]: src/agent.c:agent_free() agent free 
0xaaaadbf376a0
Okt 23 12:39:35 tavla iwd[383]: src/agent.c:agent_register() agent 
register called
Okt 23 12:39:35 tavla iwd[383]: src/agent.c:agent_register() agent :1.69 
path /agent/1420
Okt 23 12:39:35 tavla iwd[383]: src/network.c:network_connect()

> B. Reboot -> device does NOT connect

This tells me you have no profile in /var/lib/iwd

>
> -----
>
> tavla@tavla:~$ sudo ls -l /system/var/lib/iwd/
> insgesamt 4
> -rw------- 1 root root    0 23. Okt 12:39 XYZ-Gast.open
> drwx------ 2 root root 4096  4. Apr 2024  hotspot
> tavla@tavla:~$ sudo cat /system/var/lib/iwd/XYZ-Gast.open
> tavla@tavla:~$

IWD is looking in /var/lib/iwd as seen by:

Okt 23 12:35:58 tavla iwd[383]: src/storage.c:storage_create_dirs() 
Using state directory /var/lib/iwd

Not sure if you have /system/var/lib/iwd mounted there or what, but it 
seems IWD cannot find that profile. IWD will not autoconnect to a random 
open network without a profile. On your first boot you are forcing a 
connection which should generate a profile, but on the second boot no 
profile exists. So that is where I could check, where is the profile 
going? can you "ls" that directory on the _second_ boot to see if it exists?

>
> -----
>
> @Arend: Here the requested output (debugging enabled; PATCHES ALREADY 
> APPLIED!).
>
> -----
>
> tavla@tavla:~$ sudo cat /sys/kernel/debug/ieee80211/phy0/fwcap
> ap
> sta
> wme
> 802.11d
> 802.11h
> rm
> cqa
> ccx
> cac
> dualband
> ampdu
> ampdu_tx
> ampdu_rx
> amsdurx
> amsdutx
> radio_pwrsave
> btamp
> p2p
> proptxstatus
> mchan
> vht-prop-rates
> p2po
> anqpo
> txpwrcache
> stbc-tx
> stbc-rx-1ss
>
> -----
>
> Best regards,
>
> Martin
