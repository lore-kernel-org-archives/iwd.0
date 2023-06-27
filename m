Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E943E17FE5
	for <iwd@lists.linux.dev>; Tue, 27 Jun 2023 15:04:53 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1b7fb02edfaso22339275ad.3
        for <iwd@lists.linux.dev>; Tue, 27 Jun 2023 08:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687878293; x=1690470293;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fMWXK96QfAmSeMSbPQSeOWPdKw+RN16ZNQJEXRPGi2g=;
        b=YDFpbKVDfLuzlJCv4teycNoI7vufDnr2JNzeOJSPhyfZTsZNfm6P5jmD27GBdh6MAf
         ystwJ50+zS8gmBs0ncN8qUCbmQ91PqfrGqcusGOer+YSQ2sJaov8OGxupsh5FNvkpMIB
         BFXtK6tRYlIqqhtRdQEI7L3lkxq6gShnqpmFiiD49w6KFOCBV+5bjfipZZayJD2oVTyA
         eOjvEHdEFnYGFfXo1ymQWElyXQ7jHq9kYDukPYaU/7prTMNQ0CoJgedjusXhQamB6BnB
         OkiExXEarM4Yj8grNqTVLyxIuhPLEoKQGWcGK/gCC+ZGtXa9D9m8LnlMYDfMu4NZTKb7
         jXjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687878293; x=1690470293;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fMWXK96QfAmSeMSbPQSeOWPdKw+RN16ZNQJEXRPGi2g=;
        b=YrCVpZ1BLfBPfTfLaYZUqsCbjVop3TyqbYYcjWAk5bfvA/GZYxxP0WbpjVnVOhGzvS
         gydIB6fGKDDZpVbhSbZ28d7E/IeN41zhOxkNApbKYY3b1Jb/xz84AQtNuUzUHEIE6fSJ
         h5Ayzt/gUjvrp5Li7/heG7yvNOA6LELDCTbY3XoUgiyjXG3V1MOaeLNgXMSuQiNZV3fh
         b85x0L+ahf5YJnqzYMhf0kIDLjxzehmfZW0pNX5oMJYMECtcS3JDJJbSvlFm/9QMN2cN
         KVOs88NGGeHYaWsdCWBQiZ0TEjFHH/bMkFp+//gVqVtRyYxDYtkqji8tgPs9iMG3lbEL
         HA/A==
X-Gm-Message-State: AC+VfDyjaBFD+TcUFYemZmnMxof8CBWw+z1nJL6nRDi3fP6XH9qYnqgZ
	PZpjrfV8olBpDvv6oszyPyx2w7JAF7Y=
X-Google-Smtp-Source: ACHHUZ6T7rTsFr2+IlFyKNJpwBDA03lWz4ytNdS4K72jEu+P+EzPGr/O19VWxhRTLdEpQM+LIytHxA==
X-Received: by 2002:a17:902:e5ce:b0:1ae:8892:7d27 with SMTP id u14-20020a170902e5ce00b001ae88927d27mr11833543plf.42.1687878292984;
        Tue, 27 Jun 2023 08:04:52 -0700 (PDT)
Received: from [192.168.254.84] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id o1-20020a170902bcc100b001b042c0939fsm6090055pls.99.2023.06.27.08.04.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 08:04:52 -0700 (PDT)
Message-ID: <9182d9a0-4d77-fc23-ee46-cf995e0499e3@gmail.com>
Date: Tue, 27 Jun 2023 08:04:52 -0700
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
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <ca4ec1b7-b503-633c-bea8-dc2f3a8a50c3@tavla.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Martin,

On 6/27/23 7:38 AM, Martin Petzold wrote:
> Hi James,
> 
> Am 27.06.23 um 16:29 schrieb James Prestwood:
>> Hi Martin,
>>
>> On 6/27/23 12:58 AM, Martin Petzold wrote:
>>> Hi,
>>>
>>> I have a critical issue with iwd and kindly ask for feedback.
>>>
>>> We have an embedded device (no desktop) running Debian bullseye with 
>>> custom 5.10.52 kernel (NXP patches; own configuration).
>>>
>>> We are using iwd 1.27-1~bpo11+1 from bullseye backports together with 
>>> systemd from bullseye main.
>>>
>>> We use a bind mount to move the iwd state to a separate partition, 
>>> because we do rootfs upgrades and want to keep the state.
>>>
>>> Yesterday and also once before our platform forgot a network (the 
>>> *.psk file was gone). We did not call any command for this. As far as 
>>> we can re-call we did not reboot the platform. Some time before this 
>>> issue, we pulled the power of our router and the network was of 
>>> course gone - back a few minutes later. I have no idea if this could 
>>> be related or just co-incidence.
>>
>> The only way IWD removes a network profile is via "Forget()". You 
>> could add a debug print inside src/storage.c:storage_network_remove() 
>> if you were suspicious but I highly doubt that has anything to do with 
>> it.
>>
>> I would guess it more has something to do with the bind mount. Are you 
>> sure nothing touched /system/var/lib/iwd ?
> 
> We first tried symlinks, but iwd does not accept symlinks for the state 
> directory. I think it does not work because of the directory monitoring?
> 
> Could it be possible that directory monitoring and bind mounts are in 
> conflict?

I just tested this and IWD properly sees changes in a bind mounted 
directory, and then connect to the network who's profile I dropped into 
my bind mount.

But, if I run with network manager which disables autoconnect I just see 
IWD scanning and never try to connect. Presumably because network 
manager is never informed of the new network via its own profile. Are 
you using NM by chance?

> 
> Does systemd somehow manipulate the state directory (as it sets the 
> environment variable $CONFIGURATION_DIRECTORY)?
> 
>>
>>>
>>> Here are our configuration files:
>>>
>>> ########## /etc/systemd/network/20-wlan0.network
>>>
>>> [Match]
>>> Name=wlan0
>>>
>>> [Network]
>>> DHCP=yes
>>>
>>> IgnoreCarrierLoss=3s
>>>
>>> [DHCPv4]
>>> RouteMetric=20
>>>
>>> ########## /etc/iwd/main.conf
>>>
>>> [General]
>>> UseDefaultInterface=true
>>>
>>> [Network]
>>> NameResolvingService=systemd
>>>
>>> ########## /usr/lib/systemd/system/var-lib-iwd.mount
>>>
>>> [Unit]
>>> Description=Mount IWD state
>>>
>>> [Mount]
>>> What=/system/var/lib/iwd
>>> Where=/var/lib/iwd
>>> Type=none
>>> Options=bind
>>>
>>> [Install]
>>> WantedBy=local-fs.target
>>>
>>> ##########
>>>
>>> Thanks,
>>>
>>> Martin
>>>
>>>
