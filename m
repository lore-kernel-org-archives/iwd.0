Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA4D152534
	for <iwd@lists.linux.dev>; Tue,  7 May 2024 11:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715082073; cv=none; b=iIXMZJcMxUwo+uix6DkvE3sRQj/64AHaZsIJXI7OougzCw10Lmlsh9PyGnVlA/xmGFXR9tYUgWna9lAZlu/oHXDDUFd/s+p7pSmRPaw28QrwowZ2nhkPIrGSTSQ9vB+nDq9mRseamVlqHWYhkwfgoYLmDzyRhbCSDo5T1udaEow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715082073; c=relaxed/simple;
	bh=gRhgp21EZ1PoYgaGnzW32SKiNPEdxsKsaagdVAQAW7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lyrAf/TSeuuUgdppq0Fxv/OmfVm/TjtaynfFn4y8YKAALmZ+Gq/J0KEK+Xq5aL2OvP23DAd7+s+aSdl/XCZFlSLeyfNn2G7dWUgV+RDfGh7zjMqwhKbgz8tPxuleHkS/V2HBeBjUWrHwtbKlVhJXRJVeSJGA3uimv3SO4gVOW7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dvK5fIOt; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvK5fIOt"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dc6dcd9124bso2721089276.1
        for <iwd@lists.linux.dev>; Tue, 07 May 2024 04:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715082071; x=1715686871; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nmfh+Yuv5XzMZ/ZHUWUDxcxQ1EA3dgxtyZtPKR/OcYU=;
        b=dvK5fIOtSlH+6QdJK43zJ4bg5XpUrJ/tiOYpA1vCLH5qrin3N3eRuPHMaZW152d3hc
         eFpMZDjmD1wBo5oZ8heSQ2ys23MiDgZEqP2oMtaAiaYSFtkJB3PX/MPqspDNxg7kpaEp
         UIhw/EuzGaXxXza89TtXzf6D8AVeu95eLBph9yv7qkhpcQ1zhEanOQ9iMDOTxB1ytmf5
         6yd3QpzA72NEHRnJXzcT6AKyX4k/pLxYgZl4/fSQXnk5fpoYLCTNwOHcKxnbbX6SFUKf
         tl6q35RB3UWHg/5/6BmicVQWPn+RfAe4oQYq3+njoPrZ46/WuQ0L5e46cCmfYWfkFjV/
         FOww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715082071; x=1715686871;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nmfh+Yuv5XzMZ/ZHUWUDxcxQ1EA3dgxtyZtPKR/OcYU=;
        b=pmFl9ykA7berOo+RGBh76ovMso/aimQFQYEJ7HdN2g2N2MDlDFnafGAS+35Lai/Th5
         /fgj2pGdJo2hQwQ0GNwbCqjtRJX2/CQ50kYYRra2noHti4VoNRsXadjjjktd1dFVHcTU
         FcABhdZGtKo2jLQb5L4ie1nVI2JDgS84UevrJgAu6Ru37T5bMEicNK6R2hG/BQ7GO21d
         lt5+y8470V51XXoTNQNfGDyunsHsjPdrp+hFkzP/0epOzZdBEIKLsgLK5UtkOn1k49pD
         Gw3OFfEh1qT37X53GnL/VJ61vGdhtPmxQrZka3Yo6E68dyXM9fL2YuAsQr4lXJmwp5vF
         U8vQ==
X-Gm-Message-State: AOJu0YzXPm7LohAgaRvDTh/iG7YriDlJPYiJgOskFVz7i0gXjh7ys/no
	b9EOqMjEggN0VhZ6AilSRHs/NAukoK3Zfj2V5UBLfnDkjxjlO4l3+nkTnA==
X-Google-Smtp-Source: AGHT+IE4OVzedR93QghiBHBID4PfHTGSp30lpFi+ytPXKjygIRtsFf4G2yZfFFFAlVUqTY6N+WXgyw==
X-Received: by 2002:a5b:60e:0:b0:deb:3c92:9ae3 with SMTP id d14-20020a5b060e000000b00deb3c929ae3mr12414850ybq.44.1715082070731;
        Tue, 07 May 2024 04:41:10 -0700 (PDT)
Received: from [10.102.4.159] ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id m6-20020a05622a054600b00436434cc3e4sm1995279qtx.89.2024.05.07.04.41.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 04:41:10 -0700 (PDT)
Message-ID: <3e5c8d35-b08c-4906-ae06-7a5d511d518a@gmail.com>
Date: Tue, 7 May 2024 04:41:08 -0700
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
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CADvTj4oH4PjcD=0QXYT6BTEpQhtONr6QsT1mp+nmcG4Uc10c+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 5/6/24 3:40 PM, James Hilliard wrote:
> On Mon, May 6, 2024 at 2:49 PM James Prestwood <prestwoj@gmail.com> wrote:
>> Hi,
>>
>> On 5/6/24 1:34 PM, James Hilliard wrote:
>>> On Mon, May 6, 2024 at 2:15 PM James Prestwood <prestwoj@gmail.com> wrote:
>>>> Hi James,
>>>>
>>>> On 5/6/24 12:11 PM, James Hilliard wrote:
>>>>> It's a bit unclear if this is a NetworkManager bug or an IWD bug but
>>>>> I'm unable to successfully bring up AP mode connection in
>>>>> NetworkManager when using the IWD backend.
>>>>>
>>>>> It appears that NetworkManager fails to recognize that IWD has brought
>>>>> up the AP successfully for some reason even though the AP is
>>>>> active(i.e. devices can connect to the AP). This results in
>>>>> NetworkManager failing to appropriately configure the routes needed
>>>>> for the AP.
>>>>>
>>>>> Logs from NetworkManager:
>>>>> <debug> [1709938743.1640] device[e4bcd76bde98e8a1] (wlan0):
>>>>> Activation: (wifi) Called Start('APSSID').
>>>>> <debug> [1709938743.1641] device[e4bcd76bde98e8a1] (wlan0):
>>>>> Activation: (wifi) IWD Device.Mode set successfully
>>>>> <debug> [1709938743.1644] device[e4bcd76bde98e8a1] (wlan0):
>>>>> remove_pending_action (1): 'recheck-available'
>>>>> <trace> [1709938743.2594] platform: (wlan0) emit signal
>>>>> ip4-address-changed added: 192.168.45.129/28 brd 0.0.0.0 lft forever
>>>>> pref forever lifetime 1235-0[4294967295,4294967295] dev 5 flags
>>>>> permanent src kernel
>>>>> <debug> [1709938743.2595] platform: (wlan0) signal: address 4   added:
>>>>> 192.168.45.129/28 brd 0.0.0.0 lft forever pref forever lifetime
>>>>> 1235-0[4294967295,4294967295] dev 5 flags permanent src kernel
>>>>> <trace> [1709938743.2598] platform: (wlan0) emit signal
>>>>> ip4-route-changed added: type local table 255 192.168.45.129/32 dev 5
>>>>> metric 0 mss 0 rt-src rt-kernel scope host pref-src 192.168.45.129
>>>>> <debug> [1709938743.2599] platform: (wlan0) signal: route   4   added:
>>>>> type local table 255 192.168.45.129/32 dev 5 metric 0 mss 0 rt-src
>>>>> rt-kernel scope host pref-src 192.168.45.129
>>>>> <trace> [1709938743.2602] platform: (wlan0) emit signal
>>>>> ip4-route-changed added: type unicast 192.168.45.128/28 dev 5 metric 0
>>>>> mss 0 rt-src rt-kernel rtm_flags linkdown scope link pref-src
>>>>> 192.168.45.129
>>>>> <debug> [1709938743.2602] platform: (wlan0) signal: route   4   added:
>>>>> type unicast 192.168.45.128/28 dev 5 metric 0 mss 0 rt-src rt-kernel
>>>>> rtm_flags linkdown scope link pref-src 192.168.45.129
>>>>> <trace> [1709938743.2609] platform: (wlan0) emit signal link-changed
>>>>> changed: 5: wlan0 <UP,LOWER_UP;broadcast,multicast,up,running,lowerup>
>>>>> mtu 1500 arp 1 wifi? init addrgenmode none addr BC:25:F0:1D:6A:03
>>>>> permaddr BC:25:F0:1D:6A:03 brd FF:FF:FF:FF:FF:FF driver rtl8821ae
>>>>> tx-queue-len 1000 gso-max-size 65536 gso-max-segs 65535 gro-max-size
>>>>> 65536 rx:443,42144 tx:563,224232
>>>>> <debug> [1709938743.2610] platform: (wlan0) signal: link changed: 5:
>>>>> wlan0 <UP,LOWER_UP;broadcast,multicast,up,running,lowerup> mtu 1500
>>>>> arp 1 wifi? init addrgenmode none addr BC:25:F0:1D:6A:03 permaddr
>>>>> BC:25:F0:1D:6A:03 brd FF:FF:FF:FF:FF:FF driver rtl8821ae tx-queue-len
>>>>> 1000 gso-max-size 65536 gso-max-segs 65535 gro-max-size 65536
>>>>> rx:443,42144 tx:563,224232
>>>>> <debug> [1709938743.2611] device[e4bcd76bde98e8a1] (wlan0): queued
>>>>> link change for ifindex 5
>>>>> <info>  [1709938743.2657] device (wlan0): Activation: (wifi) Stage 2
>>>>> of 5 (Device Configure) successful.  Started 'APSSID'.
>>>>> <debug> [1709938743.2658] device[e4bcd76bde98e8a1] (wlan0):
>>>>> activation-stage: schedule activate_stage3_ip_config
>>>>> <debug> [1709938743.2659] device[e4bcd76bde98e8a1] (wlan0):
>>>>> activation-stage: invoke activate_stage3_ip_config
>>>>> <debug> [1709938743.2660] device[e4bcd76bde98e8a1] (wlan0):
>>>>> activation-stage: synchronously invoke activate_stage3_ip_config
>>>>> <debug> [1709938743.2661] device[e4bcd76bde98e8a1] (wlan0): ip4:
>>>>> required-timeout: disabled
>>>>> <debug> [1709938743.2661] device[e4bcd76bde98e8a1] (wlan0): ip6:
>>>>> required-timeout: disabled
>>>>> <debug> [1709938743.2662] active-connection[c8d123b3d4d3f96d]: set
>>>>> state-flags layer2-ready (was none)
>>>>> <info>  [1709938743.2664] device (wlan0): state change: config ->
>>>>> ip-config (reason 'none', sys-iface-state: 'managed')
>>>>> <debug> [1709938743.2699] device[e4bcd76bde98e8a1] (wlan0):
>>>>> add_pending_action (2): 'in-state-change'
>>>>> <debug> [1709938743.2704] device[e4bcd76bde98e8a1] (wlan0):
>>>>> remove_pending_action (1): 'in-state-change'
>>>>> <info>  [1709938743.2709] device (wlan0): IWD AP/AdHoc state is now Started
>>>>> <trace> [1709938743.2710] device[e4bcd76bde98e8a1] (wlan0): ip4:
>>>>> check-state: state pending => pending, is_failed=0, is_pending=0,
>>>>> is_started=0 temp_na=0, may-fail-4=1, may-fail-6=1;;;
>>>>> <trace> [1709938743.2710] device[e4bcd76bde98e8a1] (wlan0): ip:
>>>>> check-state: (combined) state pending => pending
>>>>> <trace> [1709938743.2711] device[e4bcd76bde98e8a1] (wlan0): ip6:
>>>>> check-state: state pending => pending, is_failed=0, is_pending=0,
>>>>> is_started=0 temp_na=0, may-fail-4=1, may-fail-6=1;;;
>>>>> <trace> [1709938743.2711] device[e4bcd76bde98e8a1] (wlan0): ip:
>>>>> check-state: (combined) state pending => pending
>>>>>
>>>>> NetworkManager bug report with some more details:
>>>>> https://gitlab.freedesktop.org/NetworkManager/NetworkManager/-/issues/1498
>>>> This does seem like an NM bug if your able to connect to the AP. That
>>>> means IWD is doing its part. Fwiw I just tried using NM 1.36.6 and IWD
>>>> 2.16 and was able to connect with my phone, saw it had an IP etc.
>>> Yeah, it does get an IP for me as well, but routes are not configured so
>>> no internet for the connecting device. What's unclear is how NM is supposed
>>> to detect this state change, does it do that over dbus or something?
>>>
>>> Does NM also report a pending state for you?
>> I'm not very familiar with NM to be honest, but is this what your
>> looking for?
> Can you see what the NM logs show when bringing up the connection?
>
> I think you may need to enable trace logging like this or something:
> nmcli general logging level TRACE domains ALL
>
>> jprestwood@LOCLAP699:~$ nmcli device show wlan0
>> GENERAL.DEVICE:                       wlan0
>> GENERAL.TYPE:                           wifi
>> GENERAL.HWADDR:                    <MAC>
>> GENERAL.MTU:                           1500
>> GENERAL.STATE:                         100 (connected)
>> GENERAL.CONNECTION:             Hotspot
>> GENERAL.CON-PATH: /org/freedesktop/NetworkManager/ActiveConnection/12
>> IP4.ADDRESS[1]:                        10.42.0.1/24
>> IP4.ADDRESS[2]:                        192.168.135.17/28
>> IP4.GATEWAY:                              --
>> IP4.ROUTE[1]:                            dst = 10.42.0.0/24, nh =
>> 0.0.0.0, mt = 600
>> IP4.ROUTE[2]:                            dst = 169.254.0.0/16, nh =
>> 0.0.0.0, mt = 1000
>> IP4.ROUTE[3]:                            dst = 192.168.135.16/28, nh =
>> 0.0.0.0, mt = 0
>> IP6.ADDRESS[1]: fe80::ae2e:3bf6:3828:d928/64
>> IP6.GATEWAY:                             --
>> IP6.ROUTE[1]:                            dst = fe80::/64, nh = ::, mt = 1024
>>
>> My phone has a 192. address so I assume ROUTE[3] is the right route?
> Hmm, can it reach the internet or devices not on the 192 network?
I wasn't able to test this yesterday, but with my laptop now on eth I 
see the same behavior. I get not internet connection from the hotspot. 
Still, this does seem like a NM bug because in this context IWD isn't 
doing anything with IPs/routes. As far as wifi is concerned IWD is 
operating correctly. Does this work with wpa_supplicant for you?
>
>> Thanks,
>>
>> James
>>
>>>> Thanks,
>>>>
>>>> James
>>>>
