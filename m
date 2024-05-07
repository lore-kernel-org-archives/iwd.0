Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C057462
	for <iwd@lists.linux.dev>; Tue,  7 May 2024 17:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715104221; cv=none; b=pVMq7CBqRqWAPchLve0s9efTkYzOpCyxZYckE05vfihF+qmBPWIt4hCwTiJ9oWoC+LOpBjnZgR62bOOHE5l7JvuInYGYWLJtzuL3fLj1lC8bZXddpc1PGSRbBDRTaLdEf6shf2Ri3SwknLVK9JT47WcCt3IKi6OZxvy5UdADwSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715104221; c=relaxed/simple;
	bh=DsIlPhBuUh3IofTgkCV9e+2yh85u+6O7ngQqb7vj3bE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oiJU18yebBIBV7JG8hBZgg9otm5AI0hUGlhQoONS1aS6m8dJxXSVdXoLWvQfZa3W4cAZU+VlFbK16Qlfic6PYw0H95W7vQiNzw4s9YpEs/hYHghlffKImDE6if85k8+KG3HU62JW6zuwA+xzp+XYIM/NBUPQnj238DaZeGSwQak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dC8fnlCe; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dC8fnlCe"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-23d23a6123eso1487405fac.1
        for <iwd@lists.linux.dev>; Tue, 07 May 2024 10:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715104219; x=1715709019; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wuda6iQoK/P6xmHomji51F5Hd2znTUeeVO+mSry7Eic=;
        b=dC8fnlCepqgkOMY4b9I7el5AgkSvkKYeeR6mj1mWKKKkCMTGGv3EOszyLcnkER8mTp
         0SakRnuuDDHg98BB8bLQP9faUmP9IhJudBE7LgOB4Ig3rgAeQ7WimKYTZucwL5YS+zX2
         QpV0V1oulxqXWjtr8mk+Fw/AoMrioHYiNNvbsNyQ8QkvwE0cij5/Xrf6End/jCfUea6l
         4gai/JSfBqJU94rQLPcuX3uB8BCmSuSOgb1yCqZEmG9ObbrHrSqQiAzz25eVstRcs4tM
         IIzjJ2Y0wH9H/AAOLdWQrxVs7borxD5ECTs0KsEgiIkJgQsRRVGhuhMh37tDmyAQ6Wzy
         gHBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715104219; x=1715709019;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wuda6iQoK/P6xmHomji51F5Hd2znTUeeVO+mSry7Eic=;
        b=fggEyyb6vvpkSNERi8zrzoNBlZU5r6l0FTHlYecgLFJFxjiFAi8nkH3CFCG5qLjnhY
         9PzB4tmcyVB7VGQ77thgR51lmhS2xSRPpV01bw4I+Vqq7lET8DeW7VK11AaeUmt6wiLs
         L61IuodcPemUX5P5/80mTsz4VuA7KwKfdKH2kxEf7w09M0eE7WnRP8gk3pItP8sPShH3
         JUjqkv6oFtYx5woIIBIobUZxhpIY1vbzm2rDLXIuFMQqBx6S0Mi5VXxz4wUCDsqqLCZ0
         nOJEfQwXU9XXDP/S/nh8eujAVEVa09HLK6qllWN3Z4fa+gnFYPMlXTTpLBpF18Eb8qp8
         Z8QQ==
X-Gm-Message-State: AOJu0Yz2KKhUeidfC0UY99jZV+LIC9ALn+KOB7GP121DauAcsLXYl81l
	ZhmURAbAQT4AotC2QthuzfjEY5gp48Sn9iVEWgj/j1J4aHWU4PXQ
X-Google-Smtp-Source: AGHT+IHU2A1gTEj74hGdIYvAmdrNzlBbRipDomCoHhtvyPnywvLbkDgeddSZ9fTrX0iExoMRR3A/cg==
X-Received: by 2002:a05:6870:32cf:b0:23d:b443:b5ba with SMTP id 586e51a60fabf-2409890f5f1mr360894fac.20.1715104218597;
        Tue, 07 May 2024 10:50:18 -0700 (PDT)
Received: from [10.102.4.159] ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id ay42-20020a05620a17aa00b007928ad101fbsm3394737qkb.101.2024.05.07.10.50.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 10:50:18 -0700 (PDT)
Message-ID: <8b2156c0-7b98-4bc8-ab1a-5009389e5e83@gmail.com>
Date: Tue, 7 May 2024 10:50:16 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: NetworkManager connection gets stuck in pending state when
 bringing up AP mode connection with IWD backend
Content-Language: en-US
To: James Hilliard <james.hilliard1@gmail.com>
Cc: iwd@lists.linux.dev
References: <CADvTj4qmJm_Lyk5bR_WZE8TioVa5f0MHdtDghJdRX=9ZhivzjA@mail.gmail.com>
 <7fd93025-1bb2-46a9-aefc-3e74942164b9@gmail.com>
 <CADvTj4pHyYewHzSUF+546JPO6Y0Co+QfFcBbJEctNWQBNJmb=A@mail.gmail.com>
 <73d7295e-44e1-42ff-9d45-9effa65a0698@gmail.com>
 <CADvTj4oH4PjcD=0QXYT6BTEpQhtONr6QsT1mp+nmcG4Uc10c+g@mail.gmail.com>
 <3e5c8d35-b08c-4906-ae06-7a5d511d518a@gmail.com>
 <CADvTj4qvEniwLnox8dZeqsDRbrBZfiqbKoCPxgRRNVu8sDBWBA@mail.gmail.com>
 <82696cf2-9bad-4cc6-a302-f3797efc6d1e@gmail.com>
 <CADvTj4rOr3p80nTg3ACqQMzse6HFWfijFQYwKj+eonyCLz_V2Q@mail.gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CADvTj4rOr3p80nTg3ACqQMzse6HFWfijFQYwKj+eonyCLz_V2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 5/7/24 10:47 AM, James Hilliard wrote:
> On Tue, May 7, 2024 at 11:36 AM James Prestwood <prestwoj@gmail.com> wrote:
>>
>> On 5/7/24 10:15 AM, James Hilliard wrote:
>>> On Tue, May 7, 2024 at 5:41 AM James Prestwood <prestwoj@gmail.com> wrote:
>>>> On 5/6/24 3:40 PM, James Hilliard wrote:
>>>>> On Mon, May 6, 2024 at 2:49 PM James Prestwood <prestwoj@gmail.com> wrote:
>>>>>> Hi,
>>>>>>
>>>>>> On 5/6/24 1:34 PM, James Hilliard wrote:
>>>>>>> On Mon, May 6, 2024 at 2:15 PM James Prestwood <prestwoj@gmail.com> wrote:
>>>>>>>> Hi James,
>>>>>>>>
>>>>>>>> On 5/6/24 12:11 PM, James Hilliard wrote:
>>>>>>>>> It's a bit unclear if this is a NetworkManager bug or an IWD bug but
>>>>>>>>> I'm unable to successfully bring up AP mode connection in
>>>>>>>>> NetworkManager when using the IWD backend.
>>>>>>>>>
>>>>>>>>> It appears that NetworkManager fails to recognize that IWD has brought
>>>>>>>>> up the AP successfully for some reason even though the AP is
>>>>>>>>> active(i.e. devices can connect to the AP). This results in
>>>>>>>>> NetworkManager failing to appropriately configure the routes needed
>>>>>>>>> for the AP.
>>>>>>>>>
>>>>>>>>> Logs from NetworkManager:
>>>>>>>>> <debug> [1709938743.1640] device[e4bcd76bde98e8a1] (wlan0):
>>>>>>>>> Activation: (wifi) Called Start('APSSID').
>>>>>>>>> <debug> [1709938743.1641] device[e4bcd76bde98e8a1] (wlan0):
>>>>>>>>> Activation: (wifi) IWD Device.Mode set successfully
>>>>>>>>> <debug> [1709938743.1644] device[e4bcd76bde98e8a1] (wlan0):
>>>>>>>>> remove_pending_action (1): 'recheck-available'
>>>>>>>>> <trace> [1709938743.2594] platform: (wlan0) emit signal
>>>>>>>>> ip4-address-changed added: 192.168.45.129/28 brd 0.0.0.0 lft forever
>>>>>>>>> pref forever lifetime 1235-0[4294967295,4294967295] dev 5 flags
>>>>>>>>> permanent src kernel
>>>>>>>>> <debug> [1709938743.2595] platform: (wlan0) signal: address 4   added:
>>>>>>>>> 192.168.45.129/28 brd 0.0.0.0 lft forever pref forever lifetime
>>>>>>>>> 1235-0[4294967295,4294967295] dev 5 flags permanent src kernel
>>>>>>>>> <trace> [1709938743.2598] platform: (wlan0) emit signal
>>>>>>>>> ip4-route-changed added: type local table 255 192.168.45.129/32 dev 5
>>>>>>>>> metric 0 mss 0 rt-src rt-kernel scope host pref-src 192.168.45.129
>>>>>>>>> <debug> [1709938743.2599] platform: (wlan0) signal: route   4   added:
>>>>>>>>> type local table 255 192.168.45.129/32 dev 5 metric 0 mss 0 rt-src
>>>>>>>>> rt-kernel scope host pref-src 192.168.45.129
>>>>>>>>> <trace> [1709938743.2602] platform: (wlan0) emit signal
>>>>>>>>> ip4-route-changed added: type unicast 192.168.45.128/28 dev 5 metric 0
>>>>>>>>> mss 0 rt-src rt-kernel rtm_flags linkdown scope link pref-src
>>>>>>>>> 192.168.45.129
>>>>>>>>> <debug> [1709938743.2602] platform: (wlan0) signal: route   4   added:
>>>>>>>>> type unicast 192.168.45.128/28 dev 5 metric 0 mss 0 rt-src rt-kernel
>>>>>>>>> rtm_flags linkdown scope link pref-src 192.168.45.129
>>>>>>>>> <trace> [1709938743.2609] platform: (wlan0) emit signal link-changed
>>>>>>>>> changed: 5: wlan0 <UP,LOWER_UP;broadcast,multicast,up,running,lowerup>
>>>>>>>>> mtu 1500 arp 1 wifi? init addrgenmode none addr BC:25:F0:1D:6A:03
>>>>>>>>> permaddr BC:25:F0:1D:6A:03 brd FF:FF:FF:FF:FF:FF driver rtl8821ae
>>>>>>>>> tx-queue-len 1000 gso-max-size 65536 gso-max-segs 65535 gro-max-size
>>>>>>>>> 65536 rx:443,42144 tx:563,224232
>>>>>>>>> <debug> [1709938743.2610] platform: (wlan0) signal: link changed: 5:
>>>>>>>>> wlan0 <UP,LOWER_UP;broadcast,multicast,up,running,lowerup> mtu 1500
>>>>>>>>> arp 1 wifi? init addrgenmode none addr BC:25:F0:1D:6A:03 permaddr
>>>>>>>>> BC:25:F0:1D:6A:03 brd FF:FF:FF:FF:FF:FF driver rtl8821ae tx-queue-len
>>>>>>>>> 1000 gso-max-size 65536 gso-max-segs 65535 gro-max-size 65536
>>>>>>>>> rx:443,42144 tx:563,224232
>>>>>>>>> <debug> [1709938743.2611] device[e4bcd76bde98e8a1] (wlan0): queued
>>>>>>>>> link change for ifindex 5
>>>>>>>>> <info>  [1709938743.2657] device (wlan0): Activation: (wifi) Stage 2
>>>>>>>>> of 5 (Device Configure) successful.  Started 'APSSID'.
>>>>>>>>> <debug> [1709938743.2658] device[e4bcd76bde98e8a1] (wlan0):
>>>>>>>>> activation-stage: schedule activate_stage3_ip_config
>>>>>>>>> <debug> [1709938743.2659] device[e4bcd76bde98e8a1] (wlan0):
>>>>>>>>> activation-stage: invoke activate_stage3_ip_config
>>>>>>>>> <debug> [1709938743.2660] device[e4bcd76bde98e8a1] (wlan0):
>>>>>>>>> activation-stage: synchronously invoke activate_stage3_ip_config
>>>>>>>>> <debug> [1709938743.2661] device[e4bcd76bde98e8a1] (wlan0): ip4:
>>>>>>>>> required-timeout: disabled
>>>>>>>>> <debug> [1709938743.2661] device[e4bcd76bde98e8a1] (wlan0): ip6:
>>>>>>>>> required-timeout: disabled
>>>>>>>>> <debug> [1709938743.2662] active-connection[c8d123b3d4d3f96d]: set
>>>>>>>>> state-flags layer2-ready (was none)
>>>>>>>>> <info>  [1709938743.2664] device (wlan0): state change: config ->
>>>>>>>>> ip-config (reason 'none', sys-iface-state: 'managed')
>>>>>>>>> <debug> [1709938743.2699] device[e4bcd76bde98e8a1] (wlan0):
>>>>>>>>> add_pending_action (2): 'in-state-change'
>>>>>>>>> <debug> [1709938743.2704] device[e4bcd76bde98e8a1] (wlan0):
>>>>>>>>> remove_pending_action (1): 'in-state-change'
>>>>>>>>> <info>  [1709938743.2709] device (wlan0): IWD AP/AdHoc state is now Started
>>>>>>>>> <trace> [1709938743.2710] device[e4bcd76bde98e8a1] (wlan0): ip4:
>>>>>>>>> check-state: state pending => pending, is_failed=0, is_pending=0,
>>>>>>>>> is_started=0 temp_na=0, may-fail-4=1, may-fail-6=1;;;
>>>>>>>>> <trace> [1709938743.2710] device[e4bcd76bde98e8a1] (wlan0): ip:
>>>>>>>>> check-state: (combined) state pending => pending
>>>>>>>>> <trace> [1709938743.2711] device[e4bcd76bde98e8a1] (wlan0): ip6:
>>>>>>>>> check-state: state pending => pending, is_failed=0, is_pending=0,
>>>>>>>>> is_started=0 temp_na=0, may-fail-4=1, may-fail-6=1;;;
>>>>>>>>> <trace> [1709938743.2711] device[e4bcd76bde98e8a1] (wlan0): ip:
>>>>>>>>> check-state: (combined) state pending => pending
>>>>>>>>>
>>>>>>>>> NetworkManager bug report with some more details:
>>>>>>>>> https://gitlab.freedesktop.org/NetworkManager/NetworkManager/-/issues/1498
>>>>>>>> This does seem like an NM bug if your able to connect to the AP. That
>>>>>>>> means IWD is doing its part. Fwiw I just tried using NM 1.36.6 and IWD
>>>>>>>> 2.16 and was able to connect with my phone, saw it had an IP etc.
>>>>>>> Yeah, it does get an IP for me as well, but routes are not configured so
>>>>>>> no internet for the connecting device. What's unclear is how NM is supposed
>>>>>>> to detect this state change, does it do that over dbus or something?
>>>>>>>
>>>>>>> Does NM also report a pending state for you?
>>>>>> I'm not very familiar with NM to be honest, but is this what your
>>>>>> looking for?
>>>>> Can you see what the NM logs show when bringing up the connection?
>>>>>
>>>>> I think you may need to enable trace logging like this or something:
>>>>> nmcli general logging level TRACE domains ALL
>>>>>
>>>>>> jprestwood@LOCLAP699:~$ nmcli device show wlan0
>>>>>> GENERAL.DEVICE:                       wlan0
>>>>>> GENERAL.TYPE:                           wifi
>>>>>> GENERAL.HWADDR:                    <MAC>
>>>>>> GENERAL.MTU:                           1500
>>>>>> GENERAL.STATE:                         100 (connected)
>>>>>> GENERAL.CONNECTION:             Hotspot
>>>>>> GENERAL.CON-PATH: /org/freedesktop/NetworkManager/ActiveConnection/12
>>>>>> IP4.ADDRESS[1]:                        10.42.0.1/24
>>>>>> IP4.ADDRESS[2]:                        192.168.135.17/28
>>>>>> IP4.GATEWAY:                              --
>>>>>> IP4.ROUTE[1]:                            dst = 10.42.0.0/24, nh =
>>>>>> 0.0.0.0, mt = 600
>>>>>> IP4.ROUTE[2]:                            dst = 169.254.0.0/16, nh =
>>>>>> 0.0.0.0, mt = 1000
>>>>>> IP4.ROUTE[3]:                            dst = 192.168.135.16/28, nh =
>>>>>> 0.0.0.0, mt = 0
>>>>>> IP6.ADDRESS[1]: fe80::ae2e:3bf6:3828:d928/64
>>>>>> IP6.GATEWAY:                             --
>>>>>> IP6.ROUTE[1]:                            dst = fe80::/64, nh = ::, mt = 1024
>>>>>>
>>>>>> My phone has a 192. address so I assume ROUTE[3] is the right route?
>>>>> Hmm, can it reach the internet or devices not on the 192 network?
>>>> I wasn't able to test this yesterday, but with my laptop now on eth I
>>>> see the same behavior. I get not internet connection from the hotspot.
>>>> Still, this does seem like a NM bug because in this context IWD isn't
>>>> doing anything with IPs/routes. As far as wifi is concerned IWD is
>>>> operating correctly. Does this work with wpa_supplicant for you?
>>> Yeah, I suspect it's a NM bug but I'm thinking it could in theory be an IWD
>>> issue if NM is expecting some sort of notification from IWD that IWD isn't
>>> sending correctly(I don't really understand how the applications interface
>>> with each other well enough however to say one way or another with any
>>> reasonable degree of confidence).
>> Yeah perhaps. The only notification IWD provides is after it starts the
>> AP, just via the DBus reply. From what I could see the route did exist
>> when I tested it maybe it just wasn't set up correctly.
>>> I've tested with wpa_supplication which does not have this issue, although
>>> I've seen an unrelated issue with wpa_supplication(encryption doesn't work)
>>> but when creating an unencrypted AP network everything seems to work ok
>>> with wpa_supplicant as the routes do get set up there.
>> Hmm, its probably a NM/IWD interaction issue then. I'd have to take a
>> look at the NM code, but from what I could see it seemed to be acting
>> like IWD was working. Said the hotspot was running and everything...
> Is there any detailed documentation/references on how the DBus API
> interface between NM/IWD is supposed to work?

NM is just using:

https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/doc/access-point-api.txt

Should only be using the Start(ssid, psk) method. Its really that simple 
so I don't see how it could really get anything wrong as far as being 
notified. But again, I'm not too familiar with NM.

>
>>>>>> Thanks,
>>>>>>
>>>>>> James
>>>>>>
>>>>>>>> Thanks,
>>>>>>>>
>>>>>>>> James
>>>>>>>>
