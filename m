Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5281BE570
	for <iwd@lists.linux.dev>; Tue,  7 May 2024 17:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715103421; cv=none; b=RhmPzW8POjn2bZBD1f8sETMtoUkTfKC6EhAJFJGZzJAFcsktXgd4AIGCJE44rlfKJiD6zYGPbKLAf4R740RgAYbK3lotfk2NKbL1/E84ZjPWqGvNBrwIvr5H+uQis2NmHuhLmf4sbVguuP8fCEUS0uCNIyFRblTdqUchrTKK1Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715103421; c=relaxed/simple;
	bh=jAruYle0S65mniTP09mD3FbBU2gXaGa8rHdItp+UaN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KfNGCBdmP0Vx4h9EgLI23L8zWlQ+UdDc0c8u8xPJi/kcRkb58YqAszsPEPFlzdm4TatqezP/+oOkLNBHzyYoR7UaGof1X69Y/3BMdRXqhRliYZs7NQe6B2hr0dMNhOlvSrAVCjZak6HNmE2x1tj7qLHIlmkhk+x+/h6i0E9/Z1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V/82RVpV; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/82RVpV"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-de5ea7edb90so3522865276.1
        for <iwd@lists.linux.dev>; Tue, 07 May 2024 10:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715103418; x=1715708218; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tiqM80nh315UCL64IVqq8ycR92RmhJ/6rPpgs86PLGY=;
        b=V/82RVpV1BtZVCdCuPcFlIaOxGvlKxUR5EnyuoqTanOyl7w/afMoTAZCy0vWqV21JL
         BIYPMuk023yqbhsyzllU2Wk1gARgmY4C3UUCIjpEV2fULIIJICTBbvp0W/kOtYKawTIR
         yX9xg9ui2DLg3zLvt3vEsYWkR4gaCbRi5nmOqquqG02iGLY1reGsokznEyWthUFr60kq
         whzOpg+MLjSzf6UhSbnbDlM/lU/XpG+qM+H7TtVUSgSdvOct2wNVeQ4X5URB7phySbhm
         hUirkYVWtgK4WPPPWLP8CXS3gMszeJflDUfTZxh5b2XpYR+aRPmKIlQO7SJxkYdhCTKe
         KKyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715103418; x=1715708218;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tiqM80nh315UCL64IVqq8ycR92RmhJ/6rPpgs86PLGY=;
        b=wU9/UNueyDD+4rUUfWRyRINOGI+0LpUeUxdDP5Hi9cKA6DSDQJLsYq9DMYgHw6Jt0c
         8tC1HoyKC/fBAFIXAJ0+2nQHSQDhnv5A04dssuNkOap3ZEErOSxZ0iPQhNGU2qLRK5M1
         pP4tiqa0KM+ruyaFRDHJBtaEtYT4pQPZaA9JYKQ9yKUHwqOtO7DyXx3K4W0YREQ3zwIr
         ogwGdKU822VSYeWWbGDJaiLKfxOT461cl2WpIci7tKXRdHe4LsuNPQsRvPAKrc0JdBci
         eRLWfHghpeZNCK6EfxammbB1vn5M67iqYvSy6YxLuB2BwBdcNr4Qc1bo7OqVV2oS806j
         PV4w==
X-Gm-Message-State: AOJu0YwGf0N6xVUP9QugouebkDxeN3iJTtrD1lML4n5QgfLXNCrFFbey
	1CSKU/8jvFGNEcvWdKYwI2YWAF6o6bVbuA2LkwF0jSt27qfTAfYUlASLQg==
X-Google-Smtp-Source: AGHT+IH11lMROG07inALsZKoscLXXxmksK9Ukwqf5ZB+aiKanRN7SCPsE/kBwW21HDtbALpZ+kDKYg==
X-Received: by 2002:a05:6902:2206:b0:de5:d2d5:ab3b with SMTP id 3f1490d57ef6-debb9e4d5e0mr385996276.57.1715103417997;
        Tue, 07 May 2024 10:36:57 -0700 (PDT)
Received: from [10.104.2.88] ([104.247.52.110])
        by smtp.gmail.com with ESMTPSA id w3-20020a25ac03000000b00db41482d349sm2702832ybi.57.2024.05.07.10.36.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 10:36:57 -0700 (PDT)
Message-ID: <82696cf2-9bad-4cc6-a302-f3797efc6d1e@gmail.com>
Date: Tue, 7 May 2024 10:36:55 -0700
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
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CADvTj4qvEniwLnox8dZeqsDRbrBZfiqbKoCPxgRRNVu8sDBWBA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 5/7/24 10:15 AM, James Hilliard wrote:
> On Tue, May 7, 2024 at 5:41 AM James Prestwood <prestwoj@gmail.com> wrote:
>>
>> On 5/6/24 3:40 PM, James Hilliard wrote:
>>> On Mon, May 6, 2024 at 2:49 PM James Prestwood <prestwoj@gmail.com> wrote:
>>>> Hi,
>>>>
>>>> On 5/6/24 1:34 PM, James Hilliard wrote:
>>>>> On Mon, May 6, 2024 at 2:15 PM James Prestwood <prestwoj@gmail.com> wrote:
>>>>>> Hi James,
>>>>>>
>>>>>> On 5/6/24 12:11 PM, James Hilliard wrote:
>>>>>>> It's a bit unclear if this is a NetworkManager bug or an IWD bug but
>>>>>>> I'm unable to successfully bring up AP mode connection in
>>>>>>> NetworkManager when using the IWD backend.
>>>>>>>
>>>>>>> It appears that NetworkManager fails to recognize that IWD has brought
>>>>>>> up the AP successfully for some reason even though the AP is
>>>>>>> active(i.e. devices can connect to the AP). This results in
>>>>>>> NetworkManager failing to appropriately configure the routes needed
>>>>>>> for the AP.
>>>>>>>
>>>>>>> Logs from NetworkManager:
>>>>>>> <debug> [1709938743.1640] device[e4bcd76bde98e8a1] (wlan0):
>>>>>>> Activation: (wifi) Called Start('APSSID').
>>>>>>> <debug> [1709938743.1641] device[e4bcd76bde98e8a1] (wlan0):
>>>>>>> Activation: (wifi) IWD Device.Mode set successfully
>>>>>>> <debug> [1709938743.1644] device[e4bcd76bde98e8a1] (wlan0):
>>>>>>> remove_pending_action (1): 'recheck-available'
>>>>>>> <trace> [1709938743.2594] platform: (wlan0) emit signal
>>>>>>> ip4-address-changed added: 192.168.45.129/28 brd 0.0.0.0 lft forever
>>>>>>> pref forever lifetime 1235-0[4294967295,4294967295] dev 5 flags
>>>>>>> permanent src kernel
>>>>>>> <debug> [1709938743.2595] platform: (wlan0) signal: address 4   added:
>>>>>>> 192.168.45.129/28 brd 0.0.0.0 lft forever pref forever lifetime
>>>>>>> 1235-0[4294967295,4294967295] dev 5 flags permanent src kernel
>>>>>>> <trace> [1709938743.2598] platform: (wlan0) emit signal
>>>>>>> ip4-route-changed added: type local table 255 192.168.45.129/32 dev 5
>>>>>>> metric 0 mss 0 rt-src rt-kernel scope host pref-src 192.168.45.129
>>>>>>> <debug> [1709938743.2599] platform: (wlan0) signal: route   4   added:
>>>>>>> type local table 255 192.168.45.129/32 dev 5 metric 0 mss 0 rt-src
>>>>>>> rt-kernel scope host pref-src 192.168.45.129
>>>>>>> <trace> [1709938743.2602] platform: (wlan0) emit signal
>>>>>>> ip4-route-changed added: type unicast 192.168.45.128/28 dev 5 metric 0
>>>>>>> mss 0 rt-src rt-kernel rtm_flags linkdown scope link pref-src
>>>>>>> 192.168.45.129
>>>>>>> <debug> [1709938743.2602] platform: (wlan0) signal: route   4   added:
>>>>>>> type unicast 192.168.45.128/28 dev 5 metric 0 mss 0 rt-src rt-kernel
>>>>>>> rtm_flags linkdown scope link pref-src 192.168.45.129
>>>>>>> <trace> [1709938743.2609] platform: (wlan0) emit signal link-changed
>>>>>>> changed: 5: wlan0 <UP,LOWER_UP;broadcast,multicast,up,running,lowerup>
>>>>>>> mtu 1500 arp 1 wifi? init addrgenmode none addr BC:25:F0:1D:6A:03
>>>>>>> permaddr BC:25:F0:1D:6A:03 brd FF:FF:FF:FF:FF:FF driver rtl8821ae
>>>>>>> tx-queue-len 1000 gso-max-size 65536 gso-max-segs 65535 gro-max-size
>>>>>>> 65536 rx:443,42144 tx:563,224232
>>>>>>> <debug> [1709938743.2610] platform: (wlan0) signal: link changed: 5:
>>>>>>> wlan0 <UP,LOWER_UP;broadcast,multicast,up,running,lowerup> mtu 1500
>>>>>>> arp 1 wifi? init addrgenmode none addr BC:25:F0:1D:6A:03 permaddr
>>>>>>> BC:25:F0:1D:6A:03 brd FF:FF:FF:FF:FF:FF driver rtl8821ae tx-queue-len
>>>>>>> 1000 gso-max-size 65536 gso-max-segs 65535 gro-max-size 65536
>>>>>>> rx:443,42144 tx:563,224232
>>>>>>> <debug> [1709938743.2611] device[e4bcd76bde98e8a1] (wlan0): queued
>>>>>>> link change for ifindex 5
>>>>>>> <info>  [1709938743.2657] device (wlan0): Activation: (wifi) Stage 2
>>>>>>> of 5 (Device Configure) successful.  Started 'APSSID'.
>>>>>>> <debug> [1709938743.2658] device[e4bcd76bde98e8a1] (wlan0):
>>>>>>> activation-stage: schedule activate_stage3_ip_config
>>>>>>> <debug> [1709938743.2659] device[e4bcd76bde98e8a1] (wlan0):
>>>>>>> activation-stage: invoke activate_stage3_ip_config
>>>>>>> <debug> [1709938743.2660] device[e4bcd76bde98e8a1] (wlan0):
>>>>>>> activation-stage: synchronously invoke activate_stage3_ip_config
>>>>>>> <debug> [1709938743.2661] device[e4bcd76bde98e8a1] (wlan0): ip4:
>>>>>>> required-timeout: disabled
>>>>>>> <debug> [1709938743.2661] device[e4bcd76bde98e8a1] (wlan0): ip6:
>>>>>>> required-timeout: disabled
>>>>>>> <debug> [1709938743.2662] active-connection[c8d123b3d4d3f96d]: set
>>>>>>> state-flags layer2-ready (was none)
>>>>>>> <info>  [1709938743.2664] device (wlan0): state change: config ->
>>>>>>> ip-config (reason 'none', sys-iface-state: 'managed')
>>>>>>> <debug> [1709938743.2699] device[e4bcd76bde98e8a1] (wlan0):
>>>>>>> add_pending_action (2): 'in-state-change'
>>>>>>> <debug> [1709938743.2704] device[e4bcd76bde98e8a1] (wlan0):
>>>>>>> remove_pending_action (1): 'in-state-change'
>>>>>>> <info>  [1709938743.2709] device (wlan0): IWD AP/AdHoc state is now Started
>>>>>>> <trace> [1709938743.2710] device[e4bcd76bde98e8a1] (wlan0): ip4:
>>>>>>> check-state: state pending => pending, is_failed=0, is_pending=0,
>>>>>>> is_started=0 temp_na=0, may-fail-4=1, may-fail-6=1;;;
>>>>>>> <trace> [1709938743.2710] device[e4bcd76bde98e8a1] (wlan0): ip:
>>>>>>> check-state: (combined) state pending => pending
>>>>>>> <trace> [1709938743.2711] device[e4bcd76bde98e8a1] (wlan0): ip6:
>>>>>>> check-state: state pending => pending, is_failed=0, is_pending=0,
>>>>>>> is_started=0 temp_na=0, may-fail-4=1, may-fail-6=1;;;
>>>>>>> <trace> [1709938743.2711] device[e4bcd76bde98e8a1] (wlan0): ip:
>>>>>>> check-state: (combined) state pending => pending
>>>>>>>
>>>>>>> NetworkManager bug report with some more details:
>>>>>>> https://gitlab.freedesktop.org/NetworkManager/NetworkManager/-/issues/1498
>>>>>> This does seem like an NM bug if your able to connect to the AP. That
>>>>>> means IWD is doing its part. Fwiw I just tried using NM 1.36.6 and IWD
>>>>>> 2.16 and was able to connect with my phone, saw it had an IP etc.
>>>>> Yeah, it does get an IP for me as well, but routes are not configured so
>>>>> no internet for the connecting device. What's unclear is how NM is supposed
>>>>> to detect this state change, does it do that over dbus or something?
>>>>>
>>>>> Does NM also report a pending state for you?
>>>> I'm not very familiar with NM to be honest, but is this what your
>>>> looking for?
>>> Can you see what the NM logs show when bringing up the connection?
>>>
>>> I think you may need to enable trace logging like this or something:
>>> nmcli general logging level TRACE domains ALL
>>>
>>>> jprestwood@LOCLAP699:~$ nmcli device show wlan0
>>>> GENERAL.DEVICE:                       wlan0
>>>> GENERAL.TYPE:                           wifi
>>>> GENERAL.HWADDR:                    <MAC>
>>>> GENERAL.MTU:                           1500
>>>> GENERAL.STATE:                         100 (connected)
>>>> GENERAL.CONNECTION:             Hotspot
>>>> GENERAL.CON-PATH: /org/freedesktop/NetworkManager/ActiveConnection/12
>>>> IP4.ADDRESS[1]:                        10.42.0.1/24
>>>> IP4.ADDRESS[2]:                        192.168.135.17/28
>>>> IP4.GATEWAY:                              --
>>>> IP4.ROUTE[1]:                            dst = 10.42.0.0/24, nh =
>>>> 0.0.0.0, mt = 600
>>>> IP4.ROUTE[2]:                            dst = 169.254.0.0/16, nh =
>>>> 0.0.0.0, mt = 1000
>>>> IP4.ROUTE[3]:                            dst = 192.168.135.16/28, nh =
>>>> 0.0.0.0, mt = 0
>>>> IP6.ADDRESS[1]: fe80::ae2e:3bf6:3828:d928/64
>>>> IP6.GATEWAY:                             --
>>>> IP6.ROUTE[1]:                            dst = fe80::/64, nh = ::, mt = 1024
>>>>
>>>> My phone has a 192. address so I assume ROUTE[3] is the right route?
>>> Hmm, can it reach the internet or devices not on the 192 network?
>> I wasn't able to test this yesterday, but with my laptop now on eth I
>> see the same behavior. I get not internet connection from the hotspot.
>> Still, this does seem like a NM bug because in this context IWD isn't
>> doing anything with IPs/routes. As far as wifi is concerned IWD is
>> operating correctly. Does this work with wpa_supplicant for you?
> Yeah, I suspect it's a NM bug but I'm thinking it could in theory be an IWD
> issue if NM is expecting some sort of notification from IWD that IWD isn't
> sending correctly(I don't really understand how the applications interface
> with each other well enough however to say one way or another with any
> reasonable degree of confidence).
Yeah perhaps. The only notification IWD provides is after it starts the 
AP, just via the DBus reply. From what I could see the route did exist 
when I tested it maybe it just wasn't set up correctly.
> I've tested with wpa_supplication which does not have this issue, although
> I've seen an unrelated issue with wpa_supplication(encryption doesn't work)
> but when creating an unencrypted AP network everything seems to work ok
> with wpa_supplicant as the routes do get set up there.
Hmm, its probably a NM/IWD interaction issue then. I'd have to take a 
look at the NM code, but from what I could see it seemed to be acting 
like IWD was working. Said the hotspot was running and everything...
>
>>>> Thanks,
>>>>
>>>> James
>>>>
>>>>>> Thanks,
>>>>>>
>>>>>> James
>>>>>>
