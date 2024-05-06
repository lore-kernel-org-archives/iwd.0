Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E0A15ADAE
	for <iwd@lists.linux.dev>; Mon,  6 May 2024 20:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715026533; cv=none; b=Q/cLtMGQ1xk42UTZahzx2ABEsh7s5bUA0pta+lEbfaZDc5UJW1O4jhxPt5Ei2qWvRs8woxGuwVna5jQQQ5lmCr7ZOFELyprF7TagelXKhH7kAN5tHQ6dksNkIw9LKeo7ZI1hzFUgA1BZyKTwG3E/r20TGJmjnvTzegRVGCOSxe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715026533; c=relaxed/simple;
	bh=ig0YE7uSlluHflsf4fkavJTBNzaMWa6A3y0WtCKePUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OBs3VbQI4zea2b13v2mK7g60jJupdwZkAxRw2y5csYlDid0O6T1UWx/bk/5dqYdxvxyOsEDkOMPeDhtG4S8rZTbjLlIw4F44QCoJJffTI3pF8FKh0dQZIyTCx6D836x10c3f5FVTcyA6iStn8J5ULgN8uFu6kiPep5thNdxy0dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F/lkk3lC; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/lkk3lC"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1ed904c2280so13339875ad.2
        for <iwd@lists.linux.dev>; Mon, 06 May 2024 13:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715026531; x=1715631331; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HeYAXCRN5oZ+N5WSNcVhzRooMa6MGg00TJZFYwTcC4c=;
        b=F/lkk3lCh0oRJXtjmdvEb2JsSSTEyg1Yiny8cUIXi22h8HLMDJRFGCe17yt92RTuun
         Xxkuvw8TQzBv1qo0XWJ0NXdipVSmV82wmI2tMAPjfjLtWd8zP7aAVMUR1NSm9DYWYNbk
         aW4hyI7IrgxvbRVHnPK4ifa3qZjVzMqdC6U9EEtCgOvcnIkWCZcOM6jWy8V+SMlKWcpZ
         pxcCncBVMKzPphQsvtlVPap0uvsfPsZ9cWPKIVYQaNtFHiN7n4KUXaOqYIepL6bwCDVn
         prda3zLHGRgC6ILq+FB3K4LG3IVZ3lKuTMhgMZITw+ZqBMgE5SCmEMMFZunO2fVC2Ozl
         yYPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715026531; x=1715631331;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HeYAXCRN5oZ+N5WSNcVhzRooMa6MGg00TJZFYwTcC4c=;
        b=OYElY2ngPZyCksPWCSqtUY+jFKPXYEL5f/E74WDWYysjbcwvAnPQtTBlZlROyANtzp
         CN3FiPyOVlfXsj7kZqhxbjpfdDj8LCymbBHVgsULsd6S2e1d4vJqVAXMpKe+xmzm2SZX
         ounubl1BmlGrLUoI/4RSBZu9TATg3P8RJFBH1FeRh5KzV8JVI7P25f++zJ1Gb0tBnpv+
         VSuim8+5m1K5OosjKb79DZw+igrnDSWF8vG+xsBk4k4o22C4wCS07YjM6mybC12ytbRW
         +kVkfPN+rw8zPhrneyujsZXy/DloORkycEV8yTzhFJO1kSveDiNap93+gX6lazD92iS4
         /UWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUA4CgtO4Mo2GDy9/Pk3OZWJJP9ChgmHI5sidRSdWFbEMpRsvCyhU3LC/4R5tO9DmIbW5UqKOvENWtEaHipbRo51xbG
X-Gm-Message-State: AOJu0YxNePH9tcO8UG8ugEYSu3+AMcl5y3i5fqOdiA9zI3xwNEQtLGCB
	/zX2WctU5DSjZj4DF6sU9n5+NWt+ztt+DS98ko2LxBFwdcR5rXG38rvFAA==
X-Google-Smtp-Source: AGHT+IHdB0xS65UPPOcd6uWobCssGx70vFYV42gy2QtAy4yTJg1yiEb6KjPAriwKhOdjnCiyW0kntA==
X-Received: by 2002:a17:902:e807:b0:1e5:556:60e2 with SMTP id u7-20020a170902e80700b001e5055660e2mr12862053plg.5.1715026531000;
        Mon, 06 May 2024 13:15:31 -0700 (PDT)
Received: from [192.168.254.36] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id p23-20020a1709027ed700b001ec379d8167sm8806836plb.115.2024.05.06.13.15.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 May 2024 13:15:30 -0700 (PDT)
Message-ID: <7fd93025-1bb2-46a9-aefc-3e74942164b9@gmail.com>
Date: Mon, 6 May 2024 13:15:29 -0700
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
To: James Hilliard <james.hilliard1@gmail.com>, iwd@lists.linux.dev
References: <CADvTj4qmJm_Lyk5bR_WZE8TioVa5f0MHdtDghJdRX=9ZhivzjA@mail.gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CADvTj4qmJm_Lyk5bR_WZE8TioVa5f0MHdtDghJdRX=9ZhivzjA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 5/6/24 12:11 PM, James Hilliard wrote:
> It's a bit unclear if this is a NetworkManager bug or an IWD bug but
> I'm unable to successfully bring up AP mode connection in
> NetworkManager when using the IWD backend.
>
> It appears that NetworkManager fails to recognize that IWD has brought
> up the AP successfully for some reason even though the AP is
> active(i.e. devices can connect to the AP). This results in
> NetworkManager failing to appropriately configure the routes needed
> for the AP.
>
> Logs from NetworkManager:
> <debug> [1709938743.1640] device[e4bcd76bde98e8a1] (wlan0):
> Activation: (wifi) Called Start('APSSID').
> <debug> [1709938743.1641] device[e4bcd76bde98e8a1] (wlan0):
> Activation: (wifi) IWD Device.Mode set successfully
> <debug> [1709938743.1644] device[e4bcd76bde98e8a1] (wlan0):
> remove_pending_action (1): 'recheck-available'
> <trace> [1709938743.2594] platform: (wlan0) emit signal
> ip4-address-changed added: 192.168.45.129/28 brd 0.0.0.0 lft forever
> pref forever lifetime 1235-0[4294967295,4294967295] dev 5 flags
> permanent src kernel
> <debug> [1709938743.2595] platform: (wlan0) signal: address 4   added:
> 192.168.45.129/28 brd 0.0.0.0 lft forever pref forever lifetime
> 1235-0[4294967295,4294967295] dev 5 flags permanent src kernel
> <trace> [1709938743.2598] platform: (wlan0) emit signal
> ip4-route-changed added: type local table 255 192.168.45.129/32 dev 5
> metric 0 mss 0 rt-src rt-kernel scope host pref-src 192.168.45.129
> <debug> [1709938743.2599] platform: (wlan0) signal: route   4   added:
> type local table 255 192.168.45.129/32 dev 5 metric 0 mss 0 rt-src
> rt-kernel scope host pref-src 192.168.45.129
> <trace> [1709938743.2602] platform: (wlan0) emit signal
> ip4-route-changed added: type unicast 192.168.45.128/28 dev 5 metric 0
> mss 0 rt-src rt-kernel rtm_flags linkdown scope link pref-src
> 192.168.45.129
> <debug> [1709938743.2602] platform: (wlan0) signal: route   4   added:
> type unicast 192.168.45.128/28 dev 5 metric 0 mss 0 rt-src rt-kernel
> rtm_flags linkdown scope link pref-src 192.168.45.129
> <trace> [1709938743.2609] platform: (wlan0) emit signal link-changed
> changed: 5: wlan0 <UP,LOWER_UP;broadcast,multicast,up,running,lowerup>
> mtu 1500 arp 1 wifi? init addrgenmode none addr BC:25:F0:1D:6A:03
> permaddr BC:25:F0:1D:6A:03 brd FF:FF:FF:FF:FF:FF driver rtl8821ae
> tx-queue-len 1000 gso-max-size 65536 gso-max-segs 65535 gro-max-size
> 65536 rx:443,42144 tx:563,224232
> <debug> [1709938743.2610] platform: (wlan0) signal: link changed: 5:
> wlan0 <UP,LOWER_UP;broadcast,multicast,up,running,lowerup> mtu 1500
> arp 1 wifi? init addrgenmode none addr BC:25:F0:1D:6A:03 permaddr
> BC:25:F0:1D:6A:03 brd FF:FF:FF:FF:FF:FF driver rtl8821ae tx-queue-len
> 1000 gso-max-size 65536 gso-max-segs 65535 gro-max-size 65536
> rx:443,42144 tx:563,224232
> <debug> [1709938743.2611] device[e4bcd76bde98e8a1] (wlan0): queued
> link change for ifindex 5
> <info>  [1709938743.2657] device (wlan0): Activation: (wifi) Stage 2
> of 5 (Device Configure) successful.  Started 'APSSID'.
> <debug> [1709938743.2658] device[e4bcd76bde98e8a1] (wlan0):
> activation-stage: schedule activate_stage3_ip_config
> <debug> [1709938743.2659] device[e4bcd76bde98e8a1] (wlan0):
> activation-stage: invoke activate_stage3_ip_config
> <debug> [1709938743.2660] device[e4bcd76bde98e8a1] (wlan0):
> activation-stage: synchronously invoke activate_stage3_ip_config
> <debug> [1709938743.2661] device[e4bcd76bde98e8a1] (wlan0): ip4:
> required-timeout: disabled
> <debug> [1709938743.2661] device[e4bcd76bde98e8a1] (wlan0): ip6:
> required-timeout: disabled
> <debug> [1709938743.2662] active-connection[c8d123b3d4d3f96d]: set
> state-flags layer2-ready (was none)
> <info>  [1709938743.2664] device (wlan0): state change: config ->
> ip-config (reason 'none', sys-iface-state: 'managed')
> <debug> [1709938743.2699] device[e4bcd76bde98e8a1] (wlan0):
> add_pending_action (2): 'in-state-change'
> <debug> [1709938743.2704] device[e4bcd76bde98e8a1] (wlan0):
> remove_pending_action (1): 'in-state-change'
> <info>  [1709938743.2709] device (wlan0): IWD AP/AdHoc state is now Started
> <trace> [1709938743.2710] device[e4bcd76bde98e8a1] (wlan0): ip4:
> check-state: state pending => pending, is_failed=0, is_pending=0,
> is_started=0 temp_na=0, may-fail-4=1, may-fail-6=1;;;
> <trace> [1709938743.2710] device[e4bcd76bde98e8a1] (wlan0): ip:
> check-state: (combined) state pending => pending
> <trace> [1709938743.2711] device[e4bcd76bde98e8a1] (wlan0): ip6:
> check-state: state pending => pending, is_failed=0, is_pending=0,
> is_started=0 temp_na=0, may-fail-4=1, may-fail-6=1;;;
> <trace> [1709938743.2711] device[e4bcd76bde98e8a1] (wlan0): ip:
> check-state: (combined) state pending => pending
>
> NetworkManager bug report with some more details:
> https://gitlab.freedesktop.org/NetworkManager/NetworkManager/-/issues/1498

This does seem like an NM bug if your able to connect to the AP. That 
means IWD is doing its part. Fwiw I just tried using NM 1.36.6 and IWD 
2.16 and was able to connect with my phone, saw it had an IP etc.

Thanks,

James

