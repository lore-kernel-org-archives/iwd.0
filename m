Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80C119B5BE
	for <iwd@lists.linux.dev>; Thu, 25 Jul 2024 16:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721925716; cv=none; b=h1E2Yy/IXiHvCSdi7cRaNGhfI3W7rDfjhPujEEr9O49lbTkuVqSeJPqMrbxOBaT1Fsi4h/REXLP4o9MJu8kK9GhSamjVai7vRH2ykiHtO1OTHDUTMehTIq3ZBN69JwCovYKBV1uAedX/q+ZBq07EYqC8LbBxm6ZPT2A8PNvUxCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721925716; c=relaxed/simple;
	bh=IT3rd8CcmEIDs/dktBsenjDxO+c6LmH+tqPXFTQpR68=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mwoL/6BdzGIOZg5ZfcCoEyJcB2BMnUIoX7rtH+nIS1gwbEDlecia8r5KIUWpXviMzwjvERCFp3fKkEeR0Dp2pRvNf0b5W/MAtql4KX0Jk7432Z6qU1vNtoQy+rRwzqAVlsTbEOQM47g1UsblxaU3Uo12mpZKwA43t9SddqYI8vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xh4uYbnJ; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xh4uYbnJ"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-708bf659898so38096a34.2
        for <iwd@lists.linux.dev>; Thu, 25 Jul 2024 09:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721925714; x=1722530514; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sGT+xWaMTtlnN3JvrTbsyaoLWa7VBbcyv4hOLFBvp9Y=;
        b=Xh4uYbnJcC13XM5D5VQD8erd/Q4H1ba18tvNg/Ezl3lQFYlT2gAoZmn52T4MvLgjmy
         +z4fv+Hwo3P/NbsLNlHhRTNmUWENxh8v63+kTXbw9B0gZRdC85p86F4ldbYkbtcGf6tS
         IdLEvfE9X8G2QrcQx7cTWgjToJ7XJ2Ke5y0BX/Jzn8u7ezbYvSjWVVUIGEa5vE4j6++t
         oQQz5zHrvukpuiyPCoOmq7tSGCyHaoqueaHQvQJRONN3k0fnHXnTGs8/ztGDXVxCRAnf
         fuaOHPXCuNEjF63QaEWm57EXYIMKg3L0qbYoshO+Bwk2p3AjySQDwDllUPsuDdWzNkC/
         ud+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721925714; x=1722530514;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sGT+xWaMTtlnN3JvrTbsyaoLWa7VBbcyv4hOLFBvp9Y=;
        b=p640vy+NbK61hH260r4LYrVKHdJyYEFS99B7hAYzz6b5byL7205JN9VjoEzHbzT3Hq
         T9K94eNrqUtdc7KALY3XCrKs0/pXL4wW1jxharr3+OlGrWxFeeeMdTxfL+fc6dqs6jlh
         yuuJEz1SQi/quPJ5rxhilZ3/A7rbTSuEXQfPTpMVsCJbSueEAyojaolQoRFAO4NC/y8t
         Pjyiwv5ZBwdE1uZRwLMkGUwicKfBe7zH++d1P8LsfaPwYYFcGU+7dpOrlh3wfYUmGIGt
         jFRHJI/8el3QfRD06rhCBmLDsFDp7MfuSI5uL4Pj+S6w+MWlT3xRTPfIfuIIhCQOWGkX
         xCYA==
X-Forwarded-Encrypted: i=1; AJvYcCWDFN8JCbvh1TOWFlMgknTocmLSaaMYaHSm48wAATVwoYPDxfWNVKl4fsVJWOoVmXFAuzAB/Im0cR8JGofsLavAnyGY
X-Gm-Message-State: AOJu0YziGNwxnCes1H34ntKHywdKyIh5ed4Fv8yxsJ9suH2mFV2eqczZ
	CpR/c90miBT5cfDTP9wpfsbRTC6pi9ZgaCzELgZLy8v9C77ovxNWHvFYYA==
X-Google-Smtp-Source: AGHT+IHepwDmNZM122HpCLZ7DIV4bjqL5d7HXXZri83zCHtRzTSl6uYXAcR76QRhFBaIGVZ4Z+7EKw==
X-Received: by 2002:a05:6830:4709:b0:703:7051:4018 with SMTP id 46e09a7af769-7092e737370mr4180026a34.28.1721925713905;
        Thu, 25 Jul 2024 09:41:53 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d746247asm98608985a.133.2024.07.25.09.41.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 09:41:53 -0700 (PDT)
Message-ID: <444d59ad-9a07-4d2c-922b-e6c43b7d8cb0@gmail.com>
Date: Thu, 25 Jul 2024 09:41:51 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: IWD CMD_SET_CQM failed: Operation not supported
To: daniel antoine <univac55@gmail.com>, iwd@lists.linux.dev
References: <CA+iibzCB-6wXch6yFu-4V9dKgz0sJRopsd7wXchccptT5hNB-A@mail.gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CA+iibzCB-6wXch6yFu-4V9dKgz0sJRopsd7wXchccptT5hNB-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Daniel,

On 7/25/24 9:15 AM, daniel antoine wrote:
> Hi
>
> I always have this error when iwd connect. It's not a problem, it
> works perfectly. How to get rid of it.
>
> juil. 25 17:35:05 grat-os1 iwd[530]: Wireless daemon version 2.19
> juil. 25 17:35:05 grat-os1 iwd[530]: station: Network configuration is disabled.
> juil. 25 17:35:05 grat-os1 iwd[530]: Wiphy: 0, Name: phy0
> juil. 25 17:35:05 grat-os1 iwd[530]:         Permanent Address:
> 50:c2:e8:0b:58:bd
> juil. 25 17:35:05 grat-os1 iwd[530]:         2.4GHz Band:
> juil. 25 17:35:05 grat-os1 iwd[530]:                 Bitrates (non-HT):
> juil. 25 17:35:05 grat-os1 iwd[530]:                          1.0 Mbps
> juil. 25 17:35:05 grat-os1 iwd[530]:                          2.0 Mbps
> juil. 25 17:35:05 grat-os1 iwd[530]:                          5.5 Mbps
> juil. 25 17:35:05 grat-os1 iwd[530]:                         11.0 Mbps
> juil. 25 17:35:05 grat-os1 iwd[530]:                          6.0 Mbps
> juil. 25 17:35:05 grat-os1 iwd[530]:                          9.0 Mbps
> juil. 25 17:35:05 grat-os1 iwd[530]:                         12.0 Mbps
> juil. 25 17:35:05 grat-os1 iwd[530]:                         18.0 Mbps
> juil. 25 17:35:05 grat-os1 iwd[530]:                         24.0 Mbps
> juil. 25 17:35:05 grat-os1 iwd[530]:                         36.0 Mbps
> juil. 25 17:35:05 grat-os1 iwd[530]:                         48.0 Mbps
> juil. 25 17:35:05 grat-os1 iwd[530]:                         54.0 Mbps
> juil. 25 17:35:05 grat-os1 iwd[530]:                 HT Capabilities:
> juil. 25 17:35:05 grat-os1 iwd[530]:                         HT40
> juil. 25 17:35:05 grat-os1 iwd[530]:                         Short GI for 20Mhz
> juil. 25 17:35:05 grat-os1 iwd[530]:                         Short GI for 40Mhz
> juil. 25 17:35:05 grat-os1 iwd[530]:                 HT RX MCS indexes:
> juil. 25 17:35:05 grat-os1 iwd[530]:                         0-15
> juil. 25 17:35:05 grat-os1 iwd[530]:                 HE Capabilities
> juil. 25 17:35:05 grat-os1 iwd[530]:                         Interface Types: ap
> juil. 25 17:35:05 grat-os1 iwd[530]:                         Max HE RX
> <= 80MHz MCS: 0-11 for NSS: 2
> juil. 25 17:35:05 grat-os1 iwd[530]:                         Max HE TX
> <= 80MHz MCS: 0-11 for NSS: 2
> juil. 25 17:35:05 grat-os1 iwd[530]:                         Interface
> Types: station
> juil. 25 17:35:05 grat-os1 iwd[530]:                         Max HE RX
> <= 80MHz MCS: 0-11 for NSS: 2
> juil. 25 17:35:05 grat-os1 iwd[530]:                         Max HE TX
> <= 80MHz MCS: 0-11 for NSS: 2
> juil. 25 17:35:05 grat-os1 iwd[530]:         5GHz Band:
> juil. 25 17:35:05 grat-os1 iwd[530]:                 Bitrates (non-HT):
> juil. 25 17:35:05 grat-os1 iwd[530]:                          6.0 Mbps
> juil. 25 17:35:05 grat-os1 iwd[530]:                          9.0 Mbps
> juil. 25 17:35:05 grat-os1 iwd[530]:                         12.0 Mbps
> juil. 25 17:35:05 grat-os1 iwd[530]:                         18.0 Mbps
> juil. 25 17:35:05 grat-os1 iwd[530]:                         24.0 Mbps
> juil. 25 17:35:05 grat-os1 iwd[530]:                         36.0 Mbps
> juil. 25 17:35:05 grat-os1 iwd[530]:                         48.0 Mbps
> juil. 25 17:35:05 grat-os1 iwd[530]:                         54.0 Mbps
> juil. 25 17:35:05 grat-os1 iwd[530]:                 HT Capabilities:
> juil. 25 17:35:05 grat-os1 iwd[530]:                         HT40
> juil. 25 17:35:05 grat-os1 iwd[530]:                         Short GI for 20Mhz
> juil. 25 17:35:05 grat-os1 iwd[530]:                         Short GI for 40Mhz
> juil. 25 17:35:05 grat-os1 iwd[530]:                 HT RX MCS indexes:
> juil. 25 17:35:05 grat-os1 iwd[530]:                         0-15
> juil. 25 17:35:05 grat-os1 iwd[530]:                 VHT Capabilities:
> juil. 25 17:35:05 grat-os1 iwd[530]:                         Short GI for 80Mhz
> juil. 25 17:35:05 grat-os1 iwd[530]:                         Max RX
> MCS: 0-9 for NSS: 2
> juil. 25 17:35:05 grat-os1 iwd[530]:                         Max TX
> MCS: 0-9 for NSS: 2
> juil. 25 17:35:05 grat-os1 iwd[530]:                 HE Capabilities
> juil. 25 17:35:05 grat-os1 iwd[530]:                         Interface Types: ap
> juil. 25 17:35:05 grat-os1 iwd[530]:                         Max HE RX
> <= 80MHz MCS: 0-11 for NSS: 2
> juil. 25 17:35:05 grat-os1 iwd[530]:                         Max HE TX
> <= 80MHz MCS: 0-11 for NSS: 2
> juil. 25 17:35:05 grat-os1 iwd[530]:                         Interface
> Types: station
> juil. 25 17:35:05 grat-os1 iwd[530]:                         Max HE RX
> <= 80MHz MCS: 0-11 for NSS: 2
> juil. 25 17:35:05 grat-os1 iwd[530]:                         Max HE TX
> <= 80MHz MCS: 0-11 for NSS: 2
> juil. 25 17:35:05 grat-os1 iwd[530]:         6GHz Band:
> juil. 25 17:35:05 grat-os1 iwd[530]:                 Bitrates (non-HT):
> juil. 25 17:35:05 grat-os1 iwd[530]:                          6.0 Mbps
> juil. 25 17:35:05 grat-os1 iwd[530]:                          9.0 Mbps
> juil. 25 17:35:05 grat-os1 iwd[530]:                         12.0 Mbps
> juil. 25 17:35:05 grat-os1 iwd[530]:                         18.0 Mbps
> juil. 25 17:35:05 grat-os1 iwd[530]:                         24.0 Mbps
> juil. 25 17:35:05 grat-os1 iwd[530]:                         36.0 Mbps
> juil. 25 17:35:05 grat-os1 iwd[530]:                         48.0 Mbps
> juil. 25 17:35:05 grat-os1 iwd[530]:                         54.0 Mbps
> juil. 25 17:35:05 grat-os1 iwd[530]:                 HE Capabilities
> juil. 25 17:35:05 grat-os1 iwd[530]:                         Interface Types: ap
> juil. 25 17:35:05 grat-os1 iwd[530]:                         Max HE RX
> <= 80MHz MCS: 0-11 for NSS: 2
> juil. 25 17:35:05 grat-os1 iwd[530]:                         Max HE TX
> <= 80MHz MCS: 0-11 for NSS: 2
> juil. 25 17:35:05 grat-os1 iwd[530]:                         Interface
> Types: station
> juil. 25 17:35:05 grat-os1 iwd[530]:                         Max HE RX
> <= 80MHz MCS: 0-11 for NSS: 2
> juil. 25 17:35:05 grat-os1 iwd[530]:                         Max HE TX
> <= 80MHz MCS: 0-11 for NSS: 2
> juil. 25 17:35:05 grat-os1 iwd[530]:         Ciphers: BIP-CMAC-256
> BIP-GMAC-256 BIP-GMAC-128 CCMP-256
> juil. 25 17:35:05 grat-os1 iwd[530]:                  GCMP-256
> GCMP-128 BIP-CMAC-128 CCMP-128
> juil. 25 17:35:05 grat-os1 iwd[530]:                  TKIP
> juil. 25 17:35:05 grat-os1 iwd[530]:         Supported iftypes: station ap
> juil. 25 17:35:05 grat-os1 iwd[530]: udev interface=wlan0 ifindex=3
> juil. 25 17:35:05 grat-os1 iwd[530]: udev interface=virbr0 ifindex=4
> juil. 25 17:35:06 grat-os1 iwd[530]: event: state, old: disconnected,
> new: autoconnect_quick
> juil. 25 17:35:06 grat-os1 iwd[530]: udev interface=wlan0 ifindex=5
> juil. 25 17:35:06 grat-os1 iwd[530]: event: state, old:
> autoconnect_quick, new: autoconnect_full
> juil. 25 17:35:06 grat-os1 iwd[530]: event: connect-info, ssid:
> Livebox-XXXX xx.xx.xx.xx.xx.xx, signal: -45, load: 6/255
> juil. 25 17:35:06 grat-os1 iwd[530]: event: state, old:
> autoconnect_full, new: connecting
> juil. 25 17:35:06 grat-os1 iwd[530]: CMD_SET_CQM failed: Operation not supported
> juil. 25 17:35:10 grat-os1 iwd[530]: event: state, old: connecting,
> new: connected
> juil. 25 17:35:10 grat-os1 iwd[530]: event: roam-scan,
> juil. 25 17:35:12 grat-os1 iwd[530]: event: roam-info, bss:
> yy:yy:yy:yy:yy:yy, signal: -49, load: 1/255
> juil. 25 17:35:12 grat-os1 iwd[530]: event: state, old: connected, new: roaming
> juil. 25 17:35:12 grat-os1 iwd[530]: CMD_SET_CQM failed: Operation not supported
> juil. 25 17:35:13 grat-os1 iwd[530]: event: state, old: roaming, new: connected
>
> I have found one commit referring to CMD_SET_CQM it's the commit
> 2dc785982d29ebd72b7cc6ed5548454f386ce222  netdev: Check
> EXT_FEATURE_CQM_RSSI_LIST before sending CMD_SET_CQM

There is that extended feature for RSSI lists, but most likely that's 
not the reason because IWD will only use a single threshold unless your 
using a signal agent, which I assume your not. Looking at the kernel I 
did find one case where driver support is checked, and if that fails it 
returns not supported:

net/mac80211/cfg.c: ieee80211_set_cqm_rssi_config()

if (sdata->vif.driver_flags & IEEE80211_VIF_BEACON_FILTER &&
         !(sdata->vif.driver_flags & IEEE80211_VIF_SUPPORTS_CQM_RSSI))
         return -EOPNOTSUPP;

What hardware are you using? Also could you enable debugging because it 
would appear that CQM is still working as you are able to roam, so this 
error may be related to something else.

Thanks,

James

>
> Best regards
>
> Daniel
>
