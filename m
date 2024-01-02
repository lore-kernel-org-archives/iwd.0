Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F224FBE2
	for <iwd@lists.linux.dev>; Tue,  2 Jan 2024 13:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LAWk73Ri"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-67fdfed519dso61512606d6.2
        for <iwd@lists.linux.dev>; Tue, 02 Jan 2024 05:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704200502; x=1704805302; darn=lists.linux.dev;
        h=in-reply-to:from:content-language:references:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AiFQF721ktnax3+eyVDdYdF88QdsrbWIYckQFJn6cbc=;
        b=LAWk73RiqDY4AgUDZyB/FxzvOfpq7sEouu83vEbB9JWwFDqx+EYyhI4cNx+aRMeKDA
         ouFUSHOOSC5Z7O6tlomM6xAKgzJMCg4LLe4+d1fiMmP5tI4fSKzKVkAXKSm1kEW2VUpn
         5USxg/BquwD2Btl3PMl2uy4queRxU69QXa12l546RHTL41VvRDz48mUHdR2bkbrC9zTt
         mhyNuAEz05bPwJwrZceX2m05T+ts6C878e63kSKodtZz4RnAKIN5o0hkPZe9Gkg2ifCQ
         Yj0JWufvB0i2VovOrklnPMl/Ao/vKF66ukLo6NvqGhkgDPijIRzPKWkz2FKOvH9c3reF
         sdSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704200502; x=1704805302;
        h=in-reply-to:from:content-language:references:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AiFQF721ktnax3+eyVDdYdF88QdsrbWIYckQFJn6cbc=;
        b=euqBgpRCE3gz0k7VEHSZy+PcqRx8LAEOJwtd0yfnBLSeAu0KPDaHK39T/W9mEWu5wo
         9yg9AxQIOCaw3M2CpdzroKombHVeJNY/PJB3NWfKKGf5rumxTmRU2PoNOS8rzZVKtFKD
         yQFHEb6sUx4N5OkTRPjfmrio0On2hI3OZJHNmmAGLr8nV1tvobNVQ8KysPhwR/QBS9R0
         5lWQ3Ga+8nj0jD5FccPp5XWcVeyL7/EYhm6M6Oby34Ic1D20HsU+ATbEomqk108Xk7/t
         WZZMQt3tX4nkR6h59bRiwoc/45E5vsdNLVArSnrAyZoWFsUZEHsqI+mkof3exSpyw5nZ
         eG3w==
X-Gm-Message-State: AOJu0YxYRw610F4Gd3Vp8MhfwJQF6W+hMW2zc18qZ02+suZ5qJDwExQc
	8iTvcKcvyGUjyG42oudJ4nLFlshrZW0=
X-Google-Smtp-Source: AGHT+IEQm5DeFUOjB0DJ01jBbGT8J+oKFacG1xoCre6QhJmOcL5IcXXJboIGoKCrqlU9+ZlqpC8BVA==
X-Received: by 2002:a05:6214:1049:b0:67f:b7ae:7c04 with SMTP id l9-20020a056214104900b0067fb7ae7c04mr18790430qvr.114.1704200502122;
        Tue, 02 Jan 2024 05:01:42 -0800 (PST)
Received: from [10.102.4.159] ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id s24-20020a05621412d800b006805bd3058asm5094136qvv.75.2024.01.02.05.01.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jan 2024 05:01:41 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------Z7dI91bJczBjzi6cp60zdO3T"
Message-ID: <b3c259af-ee4f-488c-ad81-a734302fc6d6@gmail.com>
Date: Tue, 2 Jan 2024 05:01:39 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Setup help request
To: Mauro Condarelli <mc5686@mclink.it>, iwd@lists.linux.dev
References: <5b97b06f-5047-4a1e-958d-27a6185ba504@mclink.it>
 <a345fe93-149b-46d6-bc00-ac35bb302858@gmail.com>
 <f477c1f4-4585-4b76-95a6-d0d31532e401@mclink.it>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <f477c1f4-4585-4b76-95a6-d0d31532e401@mclink.it>

This is a multi-part message in MIME format.
--------------Z7dI91bJczBjzi6cp60zdO3T
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Mauro,

On 1/1/24 4:34 PM, Mauro Condarelli wrote:
> Hi James,
> Thanks for the fast reply.
>
> Comments inline below.
>
> On 1/2/24 00:03, James Prestwood wrote:
>> Hi Mauro,
>>
>> On 1/1/24 11:26 AM, Mauro Condarelli wrote:
>>> Hi,
>>> I just installed `IWD version 2.3` on a small MiniPC (Beelink, if it 
>>> matters) sporting a
>>> `Intel Corporation Wireless 3165 (rev 81)` PCI Wireless adapter.
>>> O.S. is a fairly up-to-date "Debian GNU/Linux 12 (bookworm)"
>>> Installation was done via standard Debian package (`apt install iwd`)
>>> I am trying to use it as Access Point (infrastructure).
>>> I have in my config:
>>> ---------------------------------
>>> root@lxd:~# cat /etc/iwd/main.conf
>>> [General]
>>> EnableNetworkConfiguration=true
>>> #AddressRandomization=network
>>> #RoamThreshold=-70
>>> #RoamThreshold5G=-76
>>> [Network]
>>> #NameResolvingService=resolvconf
>>> #
>>> #EnableIPv6=true
>>> ---------------------------------
>>> root@lxd:~# cat /var/lib/iwd/ap/beelink.ap
>>> [Security]
>>> Passphrase=****************
>>>
>>> [IPv4]
>>> Address=192.168.250.1
>>> Gateway=192.168.250.1
>>> Netmask=255.255.255.0
>>> DNSList=8.8.8.8
>>> LeaseTime=3600
>>> IPRange=192.168.250.200,192.168.250.209
>>> root@lxd:~#
>>> ---------------------------------
>>>
>>> I am testing manually so I did:
>>>
>>> ---------------------------------
>>> root@lxd:/etc/systemd/network# /usr/libexec/iwd -d >/tmp/iwd.log 2>&1 &
>>> [1] 112842
>>> root@lxd:/etc/systemd/network# iwctl
>>> NetworkConfigurationEnabled: enabled
>>> StateDirectory: /var/lib/iwd
>>> Version: 2.3
>>> [iwd]# device list
>>> Devices                                   *
>>> -------------------------------------------------------------------------------- 
>>>
>>>   Name                  Address               Powered Adapter Mode
>>> -------------------------------------------------------------------------------- 
>>>
>>>   wlan0                 84:c5:a6:4c:ff:31     on phy0 ap
>>>
>>> [iwd]# device wlan0 set-property Mode ap
>>> [iwd]# ap wlan0 start-profile beelink
>>> [iwd]# ap wlan0 show
>>>                              Access Point Interface
>>> -------------------------------------------------------------------------------- 
>>>
>>>   Settable  Property              Value
>>> -------------------------------------------------------------------------------- 
>>>
>>>             Started               yes
>>>             Name                  beelink
>>>             Scanning              no
>>>             Frequency             2437
>>>             PairwiseCiphers
>>>             GroupCipher           CCMP-128
>>> [iwd]#
>>>
>>> [iwd]#
>>>
>>> root@lxd:/etc/systemd/network#
>>> ---------------------------------
>>>
>>> Sometimes I can see a "beelink" SSID with Fritz sniffer app
>>> or even from my desktop, but I was never able to connect.
>>
>> In the logs you see "Frame didn't validate as MMPDU". This means 
>> there was a malformed packet, or at least IWD thinks it was 
>> malformed. Could you get an iwmon capture while IWD is running and 
>> you attempt to connect with a client device? Also, have you tried 
>> connecting with several client devices (laptop, phone, etc)? That 
>> would tell us if its a specific client sending a bad frame, or a bug 
>> processing the frame. More info on how to do that here:
>>
>> https://iwd.wiki.kernel.org/debugging
>>
>> Note the capture will contain your devices MAC/SSID/PSK so if your 
>> worried about privacy you can send it just to me, or use a dummy 
>> passphrase just for the test, up to you.
> I used the following script to reproducibly start IWD and friends:
> ---------------------------------
> root@lxd:~# cat ./start_iwd.sh
> #!/bin/bash
>
> /usr/libexec/iwd -d >/tmp/iwd.log 2>&1 &
> IWD_PID=$!
>
> sleep 5
> iwctl device list
> iwctl device wlan0 set-property Mode ap
> iwctl ap wlan0 start-profile beelink
> iwctl ap wlan0 show
>
> iwmon --write /tmp/iwmon.pcap >/tmp/iwmon.log 2>&1 &
> IWMON_PID=$!
>
> mc
>
> kill $IWMON_PID
> kill $IWD_PID
> ---------------------------------
>
> While shell was active I:
> - opened Fritz! `WLAN` app
>   - it took ~30s to see a `beelink` network apparently spanning 
> several channels
> - tried to connect from my desktop
>   - it did see a `beelink` AP a long time (>2m) after `WLAN` app saw it.
>   - it tried several times to connect.
>   - it never succeeded.
>   - it didn't even ask for a passphrase.
> - tried to connect using my Android Phone (the ssame running `WLAN`.
>   - it never saw a `beelink` AP to attempt connection.
>
> I attach all logs I took.
> I changed password to "temp-password" so it can be shared as needed.

I think there is more going on but for starters it appears whatever app 
your using to scan is sending an invalid probe request frame. This 
causes IWD to ignore it which seems like the reason you cant even see 
the AP in the scans. I've attached a patch you can test, but I'm not 
sure this is something we can really upstream since its out of spec. The 
concerning IE is Extended capabilities, this is something IWD actually 
uses and parses, so the fact there is a duplicate and each one is 
different makes it impossible to know which one we should use. The probe 
request is including multiple entries for "Extended Capabilities" and 
"FILS Request Parameters (tag 258)". With the patch applied, and some 
other modifications to iwmon you can see two entries for these IEs:

                     Extended Capabilities: len 10
                         Capability: bit  2: Extended channel switching
                         Capability: bit 17: WNM-Sleep mode
                         Capability: bit 19: BSS transition
                         Capability: bit 25: SSID list
                         Capability: bit 46: WNM- Notification
                         Capability: bit 62: Opmode Notification
                         04 00 0a 02 00 40 00 40 80 
01                    .....@.@..
                     Tag 258: len 2
                         00 
12                                            ..
                     Extended Capabilities: len 10
                         Capability: bit 17: WNM-Sleep mode
                         Capability: bit 19: BSS transition
                         Capability: bit 25: SSID list
                         Capability: bit 46: WNM- Notification
                         00 00 0a 02 00 40 00 00 00 
01                    .....@....
                     Tag 258: len 2
                         00 ff

If this patch doesn't resolve the issue could you re-run the test and 
start iwmon at the very beginning, prior to starting IWD?

>
>>
>>>
>>> I attach logs I am unable to interpret.
>>>
>>> Any hint about what to check/change would be very welcome as
>>> I'm completely out of my depth here.
>>>
>>> Target would be to have (if at all possible, of course) a dual band 
>>> (2.4G/5G)
>>> bridged Access Point.
>>
>> Just a side note here, for a dual band access point you will actually 
>> need two separate adapters.
> Is this an IWD limitation or is it general?
> This adapter seems to have two independent radio channels.
> In `WLAN` app I see the `beelink` AP only in the 2.4GHz band.

This isn't IWD specific. If the card only has a single radio (phy) its 
limited to utilizing a single channel at a time. So you won't be able to 
simultaneously use 2.4 and 5GHz. Some modern cards do have multiple 
physical adapters within a single package, but they aren't generally 
what you find in consumer grade hardware. You would see two "Whiphy 
phyX" entries in "iw list" if this was the case for you.

Thanks,

James

>
>>
>>>
>>> Many Thanks in Advance.
>>> Mauro
>
> Thanks
> Mauro
--------------Z7dI91bJczBjzi6cp60zdO3T
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-TESTING-add-extended-capabilities-FILS-request-to-du.patch"
Content-Disposition: attachment;
 filename*0="0001-TESTING-add-extended-capabilities-FILS-request-to-du.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA1MDNhNTAyOTMxZGNjNzM3NDMwYTI1MjE4NmI4NDc4N2U4YTcyMGUxIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKYW1lcyBQcmVzdHdvb2QgPHByZXN0d29qQGdtYWls
LmNvbT4KRGF0ZTogVHVlLCAyIEphbiAyMDI0IDA0OjUwOjIxIC0wODAwClN1YmplY3Q6IFtQ
QVRDSF0gVEVTVElORzogYWRkIGV4dGVuZGVkIGNhcGFiaWxpdGllcy9GSUxTIHJlcXVlc3Qg
dG8gZHVwbGljYXRlCiBJRXMKCi0tLQogc3JjL21wZHUuYyB8IDQgKysrLQogMSBmaWxlIGNo
YW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL3Ny
Yy9tcGR1LmMgYi9zcmMvbXBkdS5jCmluZGV4IDlkMDQwOWQyLi5kYmI1MmMwYiAxMDA2NDQK
LS0tIGEvc3JjL21wZHUuYworKysgYi9zcmMvbXBkdS5jCkBAIC0zOTMsNyArMzkzLDkgQEAg
c3RhdGljIGJvb2wgdmFsaWRhdGVfbWdtdF9pZXMoY29uc3QgdWludDhfdCAqaWVzLCBzaXpl
X3QgaWVzX2xlbiwKIAkJCQl0YWcgIT0gSUVfVFlQRV9NVUxUSVBMRV9CU1NJRCAmJgogCQkJ
CXRhZyAhPSBJRV9UWVBFX05FSUdIQk9SX1JFUE9SVCAmJgogCQkJCXRhZyAhPSBJRV9UWVBF
X1FVSUVUX0NIQU5ORUwgJiYKLQkJCQl0YWcgIT0gSUVfVFlQRV9GSUxTX0hMUF9DT05UQUlO
RVIpIHsKKwkJCQl0YWcgIT0gSUVfVFlQRV9GSUxTX0hMUF9DT05UQUlORVIgJiYKKwkJCQl0
YWcgIT0gSUVfVFlQRV9FWFRFTkRFRF9DQVBBQklMSVRJRVMgJiYKKwkJCQl0YWcgIT0gSUVf
VFlQRV9GSUxTX1JFUVVFU1RfUEFSQU1FVEVSUykgewogCQkJc3RydWN0IGllX3Rsdl9pdGVy
IGNsb25lOwogCiAJCQltZW1jcHkoJmNsb25lLCAmaXRlciwgc2l6ZW9mKGNsb25lKSk7Ci0t
IAoyLjM0LjEKCg==

--------------Z7dI91bJczBjzi6cp60zdO3T--
