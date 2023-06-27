Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0FB19501
	for <iwd@lists.linux.dev>; Tue, 27 Jun 2023 15:20:39 +0000 (UTC)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-666683eb028so2376953b3a.0
        for <iwd@lists.linux.dev>; Tue, 27 Jun 2023 08:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687879239; x=1690471239;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YEGRkLvlt2iX551NsNL6IS8n94lBwwtrR+pGbZBe0rI=;
        b=shZ7mpZ+Cgv6n4Nu/yc4RKWjA9lkDih2As4brkcPiey0/Gj8vmO30rXKT4GLT5omuT
         C+k6GvWMl/iFrcoJxOFSeYh5e+PNHMIWfoqKNtpJ8W8UzvHwFBTlz+Z3yONyB2/LAiLV
         9VRN4YbRwvuByUIFtd3JT3Qi/83KGrSMIDa/KSPtSC6AdrjAX9crruyoJpaMz3GtNKMj
         sz9DL/cmHaUgc65AmMXjYj55Cg1xVtkuPVtvWIBMv1TJAFgBo12yVXGDlp2Z8USrpJSx
         sd0sDUh4wAdn+sOcX4RgP0QZBi8jzo1NkwpU3qer7Janrogl5+2Cc96VdU9b8aNCdcdm
         Zd2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687879239; x=1690471239;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YEGRkLvlt2iX551NsNL6IS8n94lBwwtrR+pGbZBe0rI=;
        b=h6AxCMjUI3b7nNVgt+LIlMtgVKKYrJIaiOc5kMVcugnpvgraMimV1LckyjyDDZZju8
         N/abn9+lhuBRvFXrVm8DBW+ZD8H6bIEyJSFfe/QfljdpxlWvax+4k7MJexSryqQ4C3lp
         JXWvzDZcrLOAHRRVDimTpY09eN8Qh6QzVi7eQPQc2AhcQwAqf7a5c0ba71YgeQUh9Hk4
         rGbBNQ30+fTfXPsvwJmW5WhWmxsfFVNk5kaoi2THNml4uqm95xRr/DIbQ1Zh31naHvqh
         /mw372Xmx2oWBN7kSO0RG4gAqZtozb3hi5nrUDRmj8vDcVdkhoQ442qDkVdx7lOd6tGN
         xqcw==
X-Gm-Message-State: AC+VfDwhlEUqahqXa/MT4zmPeQRrpCAqS0mR/pUvaIg5q5LwVlIvJ/ko
	CVQzWNJmU4i9kH4loecWSAA=
X-Google-Smtp-Source: ACHHUZ6luxGmSF6j+M/mspfroiOoQXIu7kmHcG38MU/pXuoSY+eGOBh78uMsGP0sHBJmj36dmAEATA==
X-Received: by 2002:a17:903:1205:b0:1b1:9d43:ad4c with SMTP id l5-20020a170903120500b001b19d43ad4cmr7944301plh.40.1687879238766;
        Tue, 27 Jun 2023 08:20:38 -0700 (PDT)
Received: from [192.168.254.84] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id o23-20020a170902779700b001b6740207d2sm721378pll.215.2023.06.27.08.20.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 08:20:38 -0700 (PDT)
Message-ID: <c89da10b-da9e-3503-05a4-299030ff5489@gmail.com>
Date: Tue, 27 Jun 2023 08:20:37 -0700
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
 <c341680a-01b6-cd2a-1826-ba868a02d4f3@gmail.com>
 <ca4ec1b7-b503-633c-bea8-dc2f3a8a50c3@tavla.de>
 <9182d9a0-4d77-fc23-ee46-cf995e0499e3@gmail.com>
 <f959d408-4476-6092-8ab1-880ccdc78e8e@tavla.de>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <f959d408-4476-6092-8ab1-880ccdc78e8e@tavla.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Martin,

On 6/27/23 8:15 AM, Martin Petzold wrote:
> Hi James,
> 
> Am 27.06.23 um 17:04 schrieb James Prestwood:
>> Hi Martin,
>>
>> On 6/27/23 7:38 AM, Martin Petzold wrote:
>>> Hi James,
>>>
>>> Am 27.06.23 um 16:29 schrieb James Prestwood:
>>>> Hi Martin,
>>>>
>>>> On 6/27/23 12:58 AM, Martin Petzold wrote:
>>>>> Hi,
>>>>>
>>>>> I have a critical issue with iwd and kindly ask for feedback.
>>>>>
>>>>> We have an embedded device (no desktop) running Debian bullseye 
>>>>> with custom 5.10.52 kernel (NXP patches; own configuration).
>>>>>
>>>>> We are using iwd 1.27-1~bpo11+1 from bullseye backports together 
>>>>> with systemd from bullseye main.
>>>>>
>>>>> We use a bind mount to move the iwd state to a separate partition, 
>>>>> because we do rootfs upgrades and want to keep the state.
>>>>>
>>>>> Yesterday and also once before our platform forgot a network (the 
>>>>> *.psk file was gone). We did not call any command for this. As far 
>>>>> as we can re-call we did not reboot the platform. Some time before 
>>>>> this issue, we pulled the power of our router and the network was 
>>>>> of course gone - back a few minutes later. I have no idea if this 
>>>>> could be related or just co-incidence.
>>>>
>>>> The only way IWD removes a network profile is via "Forget()". You 
>>>> could add a debug print inside 
>>>> src/storage.c:storage_network_remove() if you were suspicious but I 
>>>> highly doubt that has anything to do with it.
>>>>
>>>> I would guess it more has something to do with the bind mount. Are 
>>>> you sure nothing touched /system/var/lib/iwd ?
>>>
>>> We first tried symlinks, but iwd does not accept symlinks for the 
>>> state directory. I think it does not work because of the directory 
>>> monitoring?
>>>
>>> Could it be possible that directory monitoring and bind mounts are in 
>>> conflict?
>>
>> I just tested this and IWD properly sees changes in a bind mounted 
>> directory, and then connect to the network who's profile I dropped 
>> into my bind mount.
>>
>> But, if I run with network manager which disables autoconnect I just 
>> see IWD scanning and never try to connect. Presumably because network 
>> manager is never informed of the new network via its own profile. Are 
>> you using NM by chance?
> 
> No, we have switched to systemd-networkd only (see configuration below). 
> NetworkManager is not installed. We have our own custom debootstrap build.
> 
> The reason for using systemd-networkd is because of compatibility with 
> systemd-timesyncd. We had a critical issue with RTC wakeup using ntp 
> together with network manager. For that reason we also don't want to 
> switch back to NetworkManager.
> 
> In general IWD ist working as expected. However, we just started 
> intensive tests with network loss and re-connection. Then somehow the 
> configuration was gone.

Ok, I'd suggest adding additional debugging in storage.c and 
knownnetworks.c. If you can reproduce the issue and see IWD either not 
reacting to a new profile, deleting the profile, or something else I'd 
be happy to take another look.

Thanks,
James

> 
>>
>>>
>>> Does systemd somehow manipulate the state directory (as it sets the 
>>> environment variable $CONFIGURATION_DIRECTORY)?
>>>
>>>>
>>>>>
>>>>> Here are our configuration files:
>>>>>
>>>>> ########## /etc/systemd/network/20-wlan0.network
>>>>>
>>>>> [Match]
>>>>> Name=wlan0
>>>>>
>>>>> [Network]
>>>>> DHCP=yes
>>>>>
>>>>> IgnoreCarrierLoss=3s
>>>>>
>>>>> [DHCPv4]
>>>>> RouteMetric=20
>>>>>
>>>>> ########## /etc/iwd/main.conf
>>>>>
>>>>> [General]
>>>>> UseDefaultInterface=true
>>>>>
>>>>> [Network]
>>>>> NameResolvingService=systemd
>>>>>
>>>>> ########## /usr/lib/systemd/system/var-lib-iwd.mount
>>>>>
>>>>> [Unit]
>>>>> Description=Mount IWD state
>>>>>
>>>>> [Mount]
>>>>> What=/system/var/lib/iwd
>>>>> Where=/var/lib/iwd
>>>>> Type=none
>>>>> Options=bind
>>>>>
>>>>> [Install]
>>>>> WantedBy=local-fs.target
>>>>>
>>>>> ##########
>>>>>
>>>>> Thanks,
>>>>>
>>>>> Martin
>>>>>
>>>>>
