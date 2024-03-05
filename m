Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C4B5A4DC
	for <iwd@lists.linux.dev>; Tue,  5 Mar 2024 12:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709640674; cv=none; b=nGK3ygObuY5DtyvgFlA99yFkpOuZ3Ocx+l0eJbfI6sJ86f7Q/oDu9DBlLyVcYDnqZp0OzDRXlK+f+kYkl1OW84+QhJ2P47HZOjhqhdzZ+JP1i16rvibKGYulPixkReETEWz6BDDzRLheBN2S6VauLWdPnkpuW72Ud1mlk8SpoWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709640674; c=relaxed/simple;
	bh=yuh3vdEHf0e05tP8l8wYt+sKJu1HEoszodq/cj/aN7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NmSS+zzRRhdvuFIobp3FIWqyXr6t003ZtzET+o8tWxDIDP3MJPU6a0w5FHaoFOtGTR4tkdrHPWoeEpXWoOwzsNozekS+/hVa1yb1HM9bLB9W9Daz3v+RURnH49YlY/Dv60syh17Da3B48VlwutETVk2piRvUJ+sAmFrz+R6UtXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bdtfUzLW; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdtfUzLW"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5cddc5455aeso4587010a12.1
        for <iwd@lists.linux.dev>; Tue, 05 Mar 2024 04:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709640672; x=1710245472; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0tcYzktJaApHfKhZKZ7O20vonVYnAC+k9JxI62I2Elw=;
        b=bdtfUzLWaDTMrGYqF5s/EVMvivnJE01Cbnuca4KH9hAf6RjsT4ssmIcFv1o2pnj4zW
         ZRRqiwE91gXuQour0P5huPB+zE8WWVz3WCaVId0fbzTM+I6VhmlA85KgCVVbCa5HjuvV
         WQ/oeEVYrMWJ2mjURLUbUtRIsVvMvj9u25hl3Exknb4ssoxy+0ogAzhgD4y51JuzVaR7
         MSRFW4s52ReZsI3uEdLf5qBEpvu4v9mIN+rgYbRDgnwsgjnqxI4Jv1avCfMLBwuSWs7f
         Mz5bJPmRhuaW9/z0K+YK71zBxa5uw53TM4jOyunQrhyabQqbyLAvKXQ49FVvvKn7Cbzu
         qgKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709640672; x=1710245472;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0tcYzktJaApHfKhZKZ7O20vonVYnAC+k9JxI62I2Elw=;
        b=RZL7CT9IR7oD+33LQl4ORS6m1jkyPSTR706F77XiZZOvfZLmZfN0cyWcoYh+Q0cW93
         C5sFm0Op/kvKvWXK9HLd8Xu2muE4Ry9Fs9v0Vv7cvWxjKHngLK0tdUZewdQKNJvWq3ew
         gkvwmNOuWyFNQ5/lBTmRRf8qSBdJvT1ajJ4U6jZ19KJtJS1Muj2d2KBgrnQa3aurgn3J
         FX7qYb/2kBxiqjXnjORqhqrCsfg3mPxw6b3arNZ4ZDySeBM/Jj8skm7LuqrPYId7HuTW
         93oRuVGUnc+dkswonvnmjzVNd66U8a2zz3uZ5UUdZ4lMuT/Etde6pHLWN+xGauGIqAyv
         tNpQ==
X-Gm-Message-State: AOJu0Yyd5H+LtZoUbLDgoTKmc/M4tKDX1u+wajPeLYn4gHuSTjrHAj2z
	cp55eJBXHzpNCEwKTI4dXkamHd/g4ZSylX/6bIiAb3TFMBuZCJEzD6G41Y7j
X-Google-Smtp-Source: AGHT+IEvT0reM2mlCUxGkm+0u1sI1O1n555uo27V+y/QlzbXoP09IABUHH03AgzTJMAJBPsHRpdJ1Q==
X-Received: by 2002:a17:90b:4ece:b0:29b:34fc:e94c with SMTP id ta14-20020a17090b4ece00b0029b34fce94cmr5470279pjb.27.1709640671555;
        Tue, 05 Mar 2024 04:11:11 -0800 (PST)
Received: from [192.168.254.87] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id e60-20020a17090a6fc200b0029969cc66f2sm10366909pjk.48.2024.03.05.04.11.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 04:11:11 -0800 (PST)
Message-ID: <0f64f742-4fbc-4493-9fd8-bd0afdc9f4a7@gmail.com>
Date: Tue, 5 Mar 2024 04:11:10 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: How to connect specifying the BSSID?
To: Kentaro Yamaguchi <kentaro.y@gmail.com>
Cc: iwd@lists.linux.dev
References: <CAKbf6axbkp5E1M8Pvm1SbPOQFtzxX8Cdwj9YjbYNy0aekHDHzw@mail.gmail.com>
 <1aebf48a-0ed4-4605-a03b-5f6e0706ed71@gmail.com>
 <CAKbf6aw-So-y=NuHTo-GqTRmjPR7pN1j8UOmHOvvRETBM-3XoA@mail.gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CAKbf6aw-So-y=NuHTo-GqTRmjPR7pN1j8UOmHOvvRETBM-3XoA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 3/5/24 2:20 AM, Kentaro Yamaguchi wrote:
> Hi James,
> Thank you for answering.
> I tried it right away, but unfortunately I couldn't connect to the
> desired BSSID.
> Even if you specify the BSSID, if the same SSID exists, it seems that
> the connection will be made according to the RANK.
>
> When I specified the BSSID on the 2GHz side below and connected, it
> connected to the BSSID on the 5GHz side.
> I tried it 3 times and got the same result all three times.

Could you check the IWD logs as to why? I have a feeling the connection 
to ":7c" just failed so IWD moved onto another BSS?

>
> access point
> -------------------------------------------------------
>      SSID  BSSID              RSSI  Freq    Rank      MDE
> --------------------------------------------------------------------------------
>      tp-link_be85
>            4e:91:e3:xx:xx:70  -25   6135    16384     000000
>            5a:91:e3:xx:xx:7d  -25   5240    16384     000000
>            56:91:e3:xx:xx:7c  -6    2417    3912      000000
>
>
> connection
> -------------------------------------------------------
> Execute the commands in the following order.
>
> $ sudo /usr/libexec/iwd -E &
> $ sudo iwctl station wlp4s0 scan
> $ sudo iwctl debug wlp4s0 connect 56:91:e3:xx:xx:7c
> Type the network passphrase for tp-link_be85 psk.
> Passphrase: ********
>
>
> Check the connection destination
> -------------------------------------------------------
>
> $ iw dev wlp4s0 link
> Connected to 5a:91:e3:xx:xx:7d (on wlp4s0)
>          SSID: tp-link_be85
>          freq: 5240.0
>          RX: 7401 bytes (70 packets)
>          TX: 8867 bytes (77 packets)
>          signal: -19 dBm
>          rx bitrate: 1441.3 MBit/s 160MHz EHT-MCS 7 EHT-NSS 2 EHT-GI 0
>          tx bitrate: 576.4 MBit/s 160MHz EHT-MCS 3 EHT-NSS 2 EHT-GI 0
>          bss flags: short-slot-time
>          dtim period: 1
>          beacon int: 100
>
> Thanks,
>
> Kentaro Yamaguchi
>
> 2024年3月4日(月) 21:23 James Prestwood <prestwoj@gmail.com>:
>> Hi Kentaro,
>>
>> On 3/3/24 8:31 PM, Kentaro Yamaguchi wrote:
>>> Dear iwd users and developers,
>>>
>>> With mesh, I would like to check whether it is faster to connect
>>> directly to the child device or the parent device.
>>> Therefore, please tell me how to connect using iwd from the client and
>>> specifying the BSSID.
>>>
>>> According to the comment made 5 years ago at the link below, there is
>>> no way to connect by specifying the BSSID.
>>> This has been answered, but is the situation still the same?
>>> https://bbs.archlinux.org/viewtopic.php?id=237074&p=5
>> Yes IWD connections are SSID based and IWD chooses the best BSS based on
>> how it ranks.
>>
>> For testing IWD does have a "developer mode" which lets you connect to
>> BSSID's specifically but this mode isn't something meant for
>> general/production use. But if you only want to test one vs the other
>> you could use it:
>>
>> # Start IWD in developer mode (-E)
>> iwd -E
>> # Scan first (developer mode doesn't autoconnect)
>> iwctl station wlan0 scan
>> iwctl debug wlan0 get-networks
>> iwctl wlan0 connect <bssid>
>>
>> Thanks,
>>
>> James
>>
>>> I tried the following, but I was unable to connect due to an error.
>>> I know that using wpa_supplicant as the Network Manager backend will
>>> work. However, in that case I would like to use IWD because I have
>>> problems with 6GHz connectivity.
>>>
>>> 1. Specify iwd as wifi.backend of NetworkManager and restart.
>>> 2. nmcli device wifi connect [SSID] password [Password]
>>> 3. nmcli connection down [SSID]
>>> 4. nmcil connection modify [SSID] wifi.bssid [BSSID]
>>> 5. nmcli connection up [SSID]
>>>
>>> Error (from journal log)
>>> -------------------------------------
>>> Mar 01 16:38:48 livazplusNetworkManager[1408]: <info>
>>> [1709278728.5365] device (wlp4s0): Activation: starting connection
>>> 'Buf-MLO' (019cd427-8f11-4c84-9625-db03895b510b)
>>> Mar 01 16:38:48 livazplus NetworkManager[1408]: <info>
>>> [1709278728.5367] device (wlp4s0): state change: disconnected ->
>>> prepare (reason 'none', sys-iface-state: 'managed')
>>> Mar 01 16:38:48 livazplus NetworkManager[1408]: <info>
>>> [1709278728.5370] device (wlp4s0): state change: prepare -> failed
>>> (reason 'none', sys-iface-state: 'managed')
>>> Mar 01 16:38:48 livazplus NetworkManager[1408]: <warn>
>>> [1709278728.5374] device (wlp4s0): Activation: failed for connection
>>> 'Buf-MLO'
>>>
>>> My environment is below.
>>> --------------------------------------
>>> Lubuntu 23.10
>>> Kernel 6.7.6
>>> IWD 2.8
>>> NetworkManager 1.44.2
>>> Intel BE200
>>> [    5.297551] iwlwifi 0000:01:00.0: TLV_FW_FSEQ_VERSION: FSEQ
>>> Version: 0.0.4.125
>>> [    5.302086] iwlwifi 0000:01:00.0: loaded firmware version
>>> 86.fb5c9aeb.0 gl-c0-fm-c0-86.ucode op_mode iwlmvm
>>> [    5.764947] iwlwifi 0000:01:00.0: loaded PNVM version 8443a58d
>>> --------------------------------------
>>>
>>> Thanks in advance!
>>> Kentaro Yamaguchi
>>>
