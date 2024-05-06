Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611CE56B76
	for <iwd@lists.linux.dev>; Mon,  6 May 2024 20:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715028541; cv=none; b=u+G7WxutioWvc/jBFubpgbsD+Y+NfMks2ndJEA82MUmGaAYwMbj62Q8ckgb2wSW73ELQhRXVRz067jQ2O9aR/Yd6/j84S/G+YVHf5p6vMSxw0ScZ6e3EKeLQtx748EZUrs7v00DO2vp2EdU+EaOjQv4OqlajV9DshHlBsCO0F4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715028541; c=relaxed/simple;
	bh=S+aPCNaHNCfuF9o9BDVe8dJjAvUPRoiCj9nrcsVfLJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HfySeA9Ni+YJ9jQ/Z1dEEfiVqWkeB4S3vwW7aGIW8qdYJsgxgR13KhZidexTuP8UZFah3SLd5QYx/CzvyjQ0XRrTdLd/bB/OaaS1UdVzY1CxcxUBd1+ydPPxAYuScAkTi+j4s7ZzggcLT54GBgTlkBj6KsVG8M41WuBXv9arlLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mX9IFqVK; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mX9IFqVK"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5cdbc4334edso1133785a12.3
        for <iwd@lists.linux.dev>; Mon, 06 May 2024 13:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715028540; x=1715633340; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bN2I+YiKuTRhNZaYJLEg99ixVRtpEJpCD+eT0wCmW9Q=;
        b=mX9IFqVKqOB35T2Y2rcENcua/SXEwzQ6Lrs7iBxVqptzSAbF5glXqvzRWx2sPUIaaH
         E8NTVrsFc5kxAJkdmdtZ3FCeqS/uF8xK49AxxpuNB78PL5ft2Xs7RSr8j7WEsjpE1S8T
         DQRqpLr+nWHT9arIK3Lxl4gQPqBQUxWInOdmc4ahOuk00PB0IE+Xpn4DEnN80aqdijDv
         oMn84Ih/e2+6DPD2pOXd7PK59Cr0xxP5t0+DNACrmqqM2avql7kCVkBTpLtFPcO6omLD
         uQhHQtX+yakiUaqQhGVJ0bcYMcdLtk5cAvqnJjXMSFV3LOEeY+EqmVe8KBDzswjwtRQ4
         de2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715028540; x=1715633340;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bN2I+YiKuTRhNZaYJLEg99ixVRtpEJpCD+eT0wCmW9Q=;
        b=Bivwq5fxdFg/WcIT+xUMq6wLYqtZ+iZE5ZB/PQuyZPf8Oh4Hk4en82A/wuIKtsqg5o
         j/5Sm7B/CmGlgqKh8eGN/sNCs+kyAnUrMY1iM6cU5Tk1oYEx/J/Kl+ul2IbbUxi9OCzO
         dQFuI4DNdtYDQTMQBQOZcryNAGhoVCL1XBmCrd9TeH+RUuF7jZ4bOABIz9p96fhLxJEL
         Fa25uzNOeijyAeBIXo65Ivwd79jdWBtttdQRz9gLm4OQYvSelzp0TehNILHRhn86Cabv
         dq8qXvyODoMb5UasJpULsvPa8uJ3BX0CAWG4JsqLgCGtWnlc9ThrnRWPzZ/o+qyTIhjC
         eKtg==
X-Gm-Message-State: AOJu0YwxeBTRPVrCSmwh7gA6T/bCd1rGDK22014dp5J+KqAyZwABTh55
	44CW1n0DZ3n8QcIf9TZZdJNkHYX8gxUoFetp8Fs48JKpt29DZxtR
X-Google-Smtp-Source: AGHT+IHn6U9MK9dPxNcRziwxVD/dC/+jfv+8x4Wme/gQXIWwPemCjoy/ZKHI+kJYo9PdOSaE5oZPSw==
X-Received: by 2002:a17:90a:e60f:b0:2b3:28be:ddfa with SMTP id j15-20020a17090ae60f00b002b328beddfamr10913145pjy.38.1715028539449;
        Mon, 06 May 2024 13:48:59 -0700 (PDT)
Received: from [192.168.254.36] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id v1-20020a17090a00c100b002acf260e82bsm9385827pjd.57.2024.05.06.13.48.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 May 2024 13:48:59 -0700 (PDT)
Message-ID: <73d7295e-44e1-42ff-9d45-9effa65a0698@gmail.com>
Date: Mon, 6 May 2024 13:48:57 -0700
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
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CADvTj4pHyYewHzSUF+546JPO6Y0Co+QfFcBbJEctNWQBNJmb=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 5/6/24 1:34 PM, James Hilliard wrote:
> On Mon, May 6, 2024 at 2:15 PM James Prestwood <prestwoj@gmail.com> wrote:
>> Hi James,
>>
>> On 5/6/24 12:11 PM, James Hilliard wrote:
>>> It's a bit unclear if this is a NetworkManager bug or an IWD bug but
>>> I'm unable to successfully bring up AP mode connection in
>>> NetworkManager when using the IWD backend.
>>>
>>> It appears that NetworkManager fails to recognize that IWD has brought
>>> up the AP successfully for some reason even though the AP is
>>> active(i.e. devices can connect to the AP). This results in
>>> NetworkManager failing to appropriately configure the routes needed
>>> for the AP.
>>>
>>> Logs from NetworkManager:
>>> <debug> [1709938743.1640] device[e4bcd76bde98e8a1] (wlan0):
>>> Activation: (wifi) Called Start('APSSID').
>>> <debug> [1709938743.1641] device[e4bcd76bde98e8a1] (wlan0):
>>> Activation: (wifi) IWD Device.Mode set successfully
>>> <debug> [1709938743.1644] device[e4bcd76bde98e8a1] (wlan0):
>>> remove_pending_action (1): 'recheck-available'
>>> <trace> [1709938743.2594] platform: (wlan0) emit signal
>>> ip4-address-changed added: 192.168.45.129/28 brd 0.0.0.0 lft forever
>>> pref forever lifetime 1235-0[4294967295,4294967295] dev 5 flags
>>> permanent src kernel
>>> <debug> [1709938743.2595] platform: (wlan0) signal: address 4   added:
>>> 192.168.45.129/28 brd 0.0.0.0 lft forever pref forever lifetime
>>> 1235-0[4294967295,4294967295] dev 5 flags permanent src kernel
>>> <trace> [1709938743.2598] platform: (wlan0) emit signal
>>> ip4-route-changed added: type local table 255 192.168.45.129/32 dev 5
>>> metric 0 mss 0 rt-src rt-kernel scope host pref-src 192.168.45.129
>>> <debug> [1709938743.2599] platform: (wlan0) signal: route   4   added:
>>> type local table 255 192.168.45.129/32 dev 5 metric 0 mss 0 rt-src
>>> rt-kernel scope host pref-src 192.168.45.129
>>> <trace> [1709938743.2602] platform: (wlan0) emit signal
>>> ip4-route-changed added: type unicast 192.168.45.128/28 dev 5 metric 0
>>> mss 0 rt-src rt-kernel rtm_flags linkdown scope link pref-src
>>> 192.168.45.129
>>> <debug> [1709938743.2602] platform: (wlan0) signal: route   4   added:
>>> type unicast 192.168.45.128/28 dev 5 metric 0 mss 0 rt-src rt-kernel
>>> rtm_flags linkdown scope link pref-src 192.168.45.129
>>> <trace> [1709938743.2609] platform: (wlan0) emit signal link-changed
>>> changed: 5: wlan0 <UP,LOWER_UP;broadcast,multicast,up,running,lowerup>
>>> mtu 1500 arp 1 wifi? init addrgenmode none addr BC:25:F0:1D:6A:03
>>> permaddr BC:25:F0:1D:6A:03 brd FF:FF:FF:FF:FF:FF driver rtl8821ae
>>> tx-queue-len 1000 gso-max-size 65536 gso-max-segs 65535 gro-max-size
>>> 65536 rx:443,42144 tx:563,224232
>>> <debug> [1709938743.2610] platform: (wlan0) signal: link changed: 5:
>>> wlan0 <UP,LOWER_UP;broadcast,multicast,up,running,lowerup> mtu 1500
>>> arp 1 wifi? init addrgenmode none addr BC:25:F0:1D:6A:03 permaddr
>>> BC:25:F0:1D:6A:03 brd FF:FF:FF:FF:FF:FF driver rtl8821ae tx-queue-len
>>> 1000 gso-max-size 65536 gso-max-segs 65535 gro-max-size 65536
>>> rx:443,42144 tx:563,224232
>>> <debug> [1709938743.2611] device[e4bcd76bde98e8a1] (wlan0): queued
>>> link change for ifindex 5
>>> <info>  [1709938743.2657] device (wlan0): Activation: (wifi) Stage 2
>>> of 5 (Device Configure) successful.  Started 'APSSID'.
>>> <debug> [1709938743.2658] device[e4bcd76bde98e8a1] (wlan0):
>>> activation-stage: schedule activate_stage3_ip_config
>>> <debug> [1709938743.2659] device[e4bcd76bde98e8a1] (wlan0):
>>> activation-stage: invoke activate_stage3_ip_config
>>> <debug> [1709938743.2660] device[e4bcd76bde98e8a1] (wlan0):
>>> activation-stage: synchronously invoke activate_stage3_ip_config
>>> <debug> [1709938743.2661] device[e4bcd76bde98e8a1] (wlan0): ip4:
>>> required-timeout: disabled
>>> <debug> [1709938743.2661] device[e4bcd76bde98e8a1] (wlan0): ip6:
>>> required-timeout: disabled
>>> <debug> [1709938743.2662] active-connection[c8d123b3d4d3f96d]: set
>>> state-flags layer2-ready (was none)
>>> <info>  [1709938743.2664] device (wlan0): state change: config ->
>>> ip-config (reason 'none', sys-iface-state: 'managed')
>>> <debug> [1709938743.2699] device[e4bcd76bde98e8a1] (wlan0):
>>> add_pending_action (2): 'in-state-change'
>>> <debug> [1709938743.2704] device[e4bcd76bde98e8a1] (wlan0):
>>> remove_pending_action (1): 'in-state-change'
>>> <info>  [1709938743.2709] device (wlan0): IWD AP/AdHoc state is now Started
>>> <trace> [1709938743.2710] device[e4bcd76bde98e8a1] (wlan0): ip4:
>>> check-state: state pending => pending, is_failed=0, is_pending=0,
>>> is_started=0 temp_na=0, may-fail-4=1, may-fail-6=1;;;
>>> <trace> [1709938743.2710] device[e4bcd76bde98e8a1] (wlan0): ip:
>>> check-state: (combined) state pending => pending
>>> <trace> [1709938743.2711] device[e4bcd76bde98e8a1] (wlan0): ip6:
>>> check-state: state pending => pending, is_failed=0, is_pending=0,
>>> is_started=0 temp_na=0, may-fail-4=1, may-fail-6=1;;;
>>> <trace> [1709938743.2711] device[e4bcd76bde98e8a1] (wlan0): ip:
>>> check-state: (combined) state pending => pending
>>>
>>> NetworkManager bug report with some more details:
>>> https://gitlab.freedesktop.org/NetworkManager/NetworkManager/-/issues/1498
>> This does seem like an NM bug if your able to connect to the AP. That
>> means IWD is doing its part. Fwiw I just tried using NM 1.36.6 and IWD
>> 2.16 and was able to connect with my phone, saw it had an IP etc.
> Yeah, it does get an IP for me as well, but routes are not configured so
> no internet for the connecting device. What's unclear is how NM is supposed
> to detect this state change, does it do that over dbus or something?
>
> Does NM also report a pending state for you?

I'm not very familiar with NM to be honest, but is this what your 
looking for?

jprestwood@LOCLAP699:~$ nmcli device show wlan0
GENERAL.DEVICE:                       wlan0
GENERAL.TYPE:                           wifi
GENERAL.HWADDR:                    <MAC>
GENERAL.MTU:                           1500
GENERAL.STATE:                         100 (connected)
GENERAL.CONNECTION:             Hotspot
GENERAL.CON-PATH: /org/freedesktop/NetworkManager/ActiveConnection/12
IP4.ADDRESS[1]:                        10.42.0.1/24
IP4.ADDRESS[2]:                        192.168.135.17/28
IP4.GATEWAY:                              --
IP4.ROUTE[1]:                            dst = 10.42.0.0/24, nh = 
0.0.0.0, mt = 600
IP4.ROUTE[2]:                            dst = 169.254.0.0/16, nh = 
0.0.0.0, mt = 1000
IP4.ROUTE[3]:                            dst = 192.168.135.16/28, nh = 
0.0.0.0, mt = 0
IP6.ADDRESS[1]: fe80::ae2e:3bf6:3828:d928/64
IP6.GATEWAY:                             --
IP6.ROUTE[1]:                            dst = fe80::/64, nh = ::, mt = 1024

My phone has a 192. address so I assume ROUTE[3] is the right route?

Thanks,

James

>
>> Thanks,
>>
>> James
>>
