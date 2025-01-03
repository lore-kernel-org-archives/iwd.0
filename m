Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB7433DF
	for <iwd@lists.linux.dev>; Fri,  3 Jan 2025 23:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735946753; cv=none; b=IIPGzTHx4o7dX8uxrmpKdRuK7xRUtjlhxx1c5r1HlHqVpOrnTxFdGIgY/0Q1Zz07EcdzjrVB5p8SnJ3YiDKFQvtJoyMw4JsVexCoOhUyxXFWWanXu1xgQ06CuMJAd8GiZyFFhAT0iXLRbXIxUxgyGpO30eO69CH7HiN8LNy5ni4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735946753; c=relaxed/simple;
	bh=OrJXXeE3hBgSzlw/EYslG2nrnCJrPnROqZDy1gc4FM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ht0wi0ElwUNA8FfrPrMTpB1a0dZ3U/HRZDJ/iTvDf6jCIvEuC22DUhPOSfKhq49KeUCvTqiyXQekSYqgTrDE5cNa/5yIhFS+VtyC+3Yy9JWAiE7TQWipDZH3eQks4pc+d9M6nucTzqjFc5DuTb9x/E8P6zExeaLcYGDkMr643sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nUfVFJNj; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nUfVFJNj"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7b6f53c12adso1035896585a.1
        for <iwd@lists.linux.dev>; Fri, 03 Jan 2025 15:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735946750; x=1736551550; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=INB96cDvNA9AU/I1x/yugaYMO9eu2Us7mL1UXbJbNY4=;
        b=nUfVFJNjjRwbiF0L7B8vsFaMessIT/F41IXBn/W0CulgTNIVXggLFH/0wHICaMlvY7
         1C93b5ohkZqpxe/DlLlrXBc63ek3QN53/yaLKW0exj6vJuR7wd+qKybl/3U1R/I8syXz
         eNA7YTO7NbHduv9wzRPLuBSkkpsrmEgL6/ORg7oAgQToGNDgVKY2sp1ztHbGCI4GE49l
         FfvlaImzshAMaj4cRfaSS+YU7Fu1yFN1IGjHcojYRhOQQ18Zym6U6q5AxOv+MbvNVlHi
         Tx+Vh3M5N0mKtxaI/2ndcpC0yuJveLAp9YU10uyJAc/R+X/CqP6SeoNpG+FnGk3To567
         4UMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735946750; x=1736551550;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=INB96cDvNA9AU/I1x/yugaYMO9eu2Us7mL1UXbJbNY4=;
        b=dSr9196serDeGNjLCil+Kh6AbQgkVnmJ3C9kq+exG4X7QG8X4qLb8McCYUZCY5s8EV
         RwXJnV1eD4dklu7AVBaEkyR5fbs9uglBxn4svmCe1B03M83h03d2H8r/Yt+mNJ0QdZhO
         a3kcrqqNsxbyk2WtwXN0litRn6I6iKK2BjI3JdxII9jnyfzE6BncH4r6qlduDAKO1Df7
         jGeAnrMyVQeAXu/kP1LeSJUT5fyTNSfmxVdZx9VvSkgPdYu1al3KK7xxXllyy/en5wyh
         NY67iBQKVAcI/BqF5tQypDddtkyqi4MEXjRQtU4hDX9CwgeOuYuG9Ltlf35HrcEaA5N/
         9Wgg==
X-Forwarded-Encrypted: i=1; AJvYcCU+jre6Q3y4dJB5m1w0DRYRq5ar7xfCC73IWmnYZ10YhpYS5XmIm31KKPW2wjSK9BgRAb4=@lists.linux.dev
X-Gm-Message-State: AOJu0YxSZMucIxK6BFkrswZLXopsINLzWflwW7Yz6uKUjryy5ad8WklT
	RJxeOAOgoIVP/HAPOabMdqY5KX5lfeue1OT3Y483Fi4tVu9C+IMmH/P9gg==
X-Gm-Gg: ASbGncs2OZnDAr8O1xv9bSrWgCuAiN2Ng1W7hEGSSlLtVCn86dvpZDqo3axlOBQ5lCY
	vHZT49nBhyEXYr7vruXOothAW3cgXUtO8sxWTMYTvyxp8DNmWawazsT9LUiwll1HO8Nevo7DbsP
	EmorrKRzoyAfLZmCaCM6VJqdYUH0uMnQjETzyieS1KoFNt28JTfy7sDn27QeB+CPrQegaIYk1Hs
	7YkFI3/tWzwnXaX7dO3UThOsy7qgtb3M8CVygNKJIPC+Txqwew/wI/hdujC
X-Google-Smtp-Source: AGHT+IG9OQ0BLMhBA1Jr3TI5sV+DnJtVF48O59xsTpVaUOsyPsZUvYSrWr8v/CzAllECFtafdJuq1A==
X-Received: by 2002:ad4:4eac:0:b0:6d8:959b:c307 with SMTP id 6a1803df08f44-6dd2330835emr790205126d6.10.1735946750418;
        Fri, 03 Jan 2025 15:25:50 -0800 (PST)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3eb5cacfsm149600181cf.89.2025.01.03.15.25.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jan 2025 15:25:49 -0800 (PST)
Message-ID: <a24382ff-0756-45f2-8e5d-69da8993e3df@gmail.com>
Date: Fri, 3 Jan 2025 15:25:47 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Repeated Deauthentication event, reason: 4
To: Owen Garland <garland.owen@gmail.com>, iwd@lists.linux.dev
References: <CAPDaQ_wdXGvy7Sa=10bSC7eAbLut4Jw_CP16Xob7aVtqgCYxSg@mail.gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CAPDaQ_wdXGvy7Sa=10bSC7eAbLut4Jw_CP16Xob7aVtqgCYxSg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 1/3/25 2:16 PM, Owen Garland wrote:
> Hej all,
>
> I couldn't find an issue tracker so I am trying here. Essentially my
> problem is I get deauthenticated from AP's at seemingly random
> intervals, with `reason: 4`.
>
> iwd --version: 3.3
> OS: Arch-Linux 6.11.9-arch1-1
> Device: Dell XPS 9370
> Network controller: Intel Corporation Wireless 8265 / 8275 (rev 78)
>          Subsystem: Intel Corporation Device 8050
>          Kernel driver in use: iwlwifi
>          Kernel modules: iwlwifi
> iwconfig:
>    wlan0     IEEE 802.11  ESSID:"Tronx_Upper"
>             Mode:Managed  Frequency:2.422 GHz  Access Point: 22:D2:CC:07:9C:B5
>             Bit Rate=65 Mb/s   Tx-Power=22 dBm
>             Retry short limit:7   RTS thr:off   Fragment thr:off
>             Power Management:off
>             Link Quality=31/70  Signal level=-79 dBm
>             Rx invalid nwid:0  Rx invalid crypt:0  Rx invalid frag:0
>             Tx excessive retries:209  Invalid misc:664   Missed beacon:0
>
> The logs from `journactl -u iwd` show this:
>
> Jan 03 21:52:09 titanium systemd[1]: Starting Wireless service...
> Jan 03 21:52:09 titanium iwd[318201]: Wireless daemon version 3.3
> Jan 03 21:52:09 titanium iwd[318201]: Loaded configuration from
> /etc/iwd/main.conf
> Jan 03 21:52:09 titanium systemd[1]: Started Wireless service.
> Jan 03 21:52:09 titanium iwd[318201]: Wiphy: 0, Name: phy0
> Jan 03 21:52:09 titanium iwd[318201]:         Permanent Address:
> 64:5d:86:ed:80:5a
> Jan 03 21:52:09 titanium iwd[318201]:         2.4GHz Band:
> Jan 03 21:52:09 titanium iwd[318201]:                 Bitrates (non-HT):
> Jan 03 21:52:09 titanium iwd[318201]:                          1.0 Mbps
> Jan 03 21:52:09 titanium iwd[318201]:                          2.0 Mbps
> Jan 03 21:52:09 titanium iwd[318201]:                          5.5 Mbps
> Jan 03 21:52:09 titanium iwd[318201]:                         11.0 Mbps
> Jan 03 21:52:09 titanium iwd[318201]:                          6.0 Mbps
> Jan 03 21:52:09 titanium iwd[318201]:                          9.0 Mbps
> Jan 03 21:52:09 titanium iwd[318201]:                         12.0 Mbps
> Jan 03 21:52:09 titanium iwd[318201]:                         18.0 Mbps
> Jan 03 21:52:09 titanium iwd[318201]:                         24.0 Mbps
> Jan 03 21:52:09 titanium iwd[318201]:                         36.0 Mbps
> Jan 03 21:52:09 titanium iwd[318201]:                         48.0 Mbps
> Jan 03 21:52:09 titanium iwd[318201]:                         54.0 Mbps
> Jan 03 21:52:09 titanium iwd[318201]:                 HT Capabilities:
> Jan 03 21:52:09 titanium iwd[318201]:                         HT40
> Jan 03 21:52:09 titanium iwd[318201]:                         Short GI for 20Mhz
> Jan 03 21:52:09 titanium iwd[318201]:                         Short GI for 40Mhz
> Jan 03 21:52:09 titanium iwd[318201]:                 HT RX MCS indexes:
> Jan 03 21:52:09 titanium iwd[318201]:                         0-15
> Jan 03 21:52:09 titanium iwd[318201]:         5GHz Band:
> Jan 03 21:52:09 titanium iwd[318201]:                 Bitrates (non-HT):
> Jan 03 21:52:09 titanium iwd[318201]:                          6.0 Mbps
> Jan 03 21:52:09 titanium iwd[318201]:                          9.0 Mbps
> Jan 03 21:52:09 titanium iwd[318201]:                         12.0 Mbps
> Jan 03 21:52:09 titanium iwd[318201]:                         18.0 Mbps
> Jan 03 21:52:09 titanium iwd[318201]:                         24.0 Mbps
> Jan 03 21:52:09 titanium iwd[318201]:                         36.0 Mbps
> Jan 03 21:52:09 titanium iwd[318201]:                         48.0 Mbps
> Jan 03 21:52:09 titanium iwd[318201]:                         54.0 Mbps
> Jan 03 21:52:09 titanium iwd[318201]:                 HT Capabilities:
> Jan 03 21:52:09 titanium iwd[318201]:                         HT40
> Jan 03 21:52:09 titanium iwd[318201]:                         Short GI for 20Mhz
> Jan 03 21:52:09 titanium iwd[318201]:                         Short GI for 40Mhz
> Jan 03 21:52:09 titanium iwd[318201]:                 HT RX MCS indexes:
> Jan 03 21:52:09 titanium iwd[318201]:                         0-15
> Jan 03 21:52:09 titanium iwd[318201]:                 VHT Capabilities:
> Jan 03 21:52:09 titanium iwd[318201]:                         Short GI for 80Mhz
> Jan 03 21:52:09 titanium iwd[318201]:                         Max RX
> MCS: 0-9 for NSS: 2
> Jan 03 21:52:09 titanium iwd[318201]:                         Max TX
> MCS: 0-9 for NSS: 2
> Jan 03 21:52:09 titanium iwd[318201]:         Ciphers: BIP-CMAC-128
> CCMP-128 TKIP
> Jan 03 21:52:09 titanium iwd[318201]:         Supported iftypes:
> ad-hoc station ap p2p-client p2p-go p2p-device
> Jan 03 21:52:09 titanium iwd[318201]: event: state, old: disconnected,
> new: autoconnect_quick
> Jan 03 21:52:09 titanium iwd[318201]: udev interface=wlan0 ifindex=6
> Jan 03 21:52:10 titanium iwd[318201]: event: connect-info, ssid:
> Tronx_Upper, bss: 22:d2:cc:07:9c:b5, signal: -79, load: 0/255
> Jan 03 21:52:10 titanium iwd[318201]: event: state, old:
> autoconnect_quick, new: connecting (auto)
> Jan 03 21:52:10 titanium iwd[318201]: event: state, old: connecting
> (auto), new: connecting (netconfig)
> Jan 03 21:52:10 titanium iwd[318201]: event: state, old: connecting
> (netconfig), new: connected
> Jan 03 21:52:15 titanium iwd[318201]: event: roam-scan,
> <truncated>
> Jan 03 22:41:53 titanium iwd[318201]: Received Deauthentication event,
> reason: 4, from_ap: false
> Jan 03 22:41:53 titanium iwd[318201]: event: disconnect-info, reason: 4
> Jan 03 22:41:53 titanium iwd[318201]: event: state, old: connected,
> new: disconnected
> Jan 03 22:41:53 titanium iwd[318201]: event: state, old: disconnected,
> new: autoconnect_quick
> Jan 03 22:41:54 titanium iwd[318201]: event: state, old:
> autoconnect_quick, new: autoconnect_full
> Jan 03 22:42:13 titanium iwd[318201]: event: connect-info, ssid:
> Tronx_Upper, bss: 22:d2:cc:07:9c:b5, signal: -79, load: 0/255
> Jan 03 22:42:13 titanium iwd[318201]: event: state, old:
> autoconnect_full, new: connecting (auto)
> Jan 03 22:42:17 titanium iwd[318201]: event: state, old: connecting
> (auto), new: connecting (netconfig)
> Jan 03 22:42:18 titanium iwd[318201]: event: state, old: connecting
> (netconfig), new: connected
>
> This then appears to happen several times, and at seemingly random
> intervals. It can be fine for several hours, then there is one
> disconnect, or there may be a few disconnects in a short time. As an
> example the 28th had this:
>
>   Dec 28 15:40:49 titanium iwd[869]: Received Deauthentication event,
> reason: 4, from_ap: false
>   Dec 28 15:41:12 titanium iwd[869]: Received Deauthentication event,
> reason: 4, from_ap: false
>   Dec 28 16:02:27 titanium iwd[869]: Received Deauthentication event,
> reason: 4, from_ap: false
>   Dec 28 16:13:12 titanium iwd[869]: Received Deauthentication event,
> reason: 4, from_ap: false
>   Dec 28 16:13:27 titanium iwd[869]: Received Deauthentication event,
> reason: 4, from_ap: false
>   Dec 28 16:34:55 titanium iwd[869]: Received Deauthentication event,
> reason: 4, from_ap: false
>   Dec 28 17:02:41 titanium iwd[869]: Received Deauthentication event,
> reason: 4, from_ap: false
>   Dec 28 17:11:34 titanium iwd[869]: Received Deauthentication event,
> reason: 4, from_ap: false
>   Dec 28 17:16:38 titanium iwd[869]: Received Deauthentication event,
> reason: 4, from_ap: false
>   Dec 28 17:20:27 titanium iwd[869]: Received Deauthentication event,
> reason: 4, from_ap: false
>   Dec 28 17:25:01 titanium iwd[869]: Received Deauthentication event,
> reason: 4, from_ap: false
>   Dec 28 18:52:40 titanium iwd[869]: Received Deauthentication event,
> reason: 4, from_ap: false
>   Dec 28 20:21:20 titanium iwd[869]: Received Deauthentication event,
> reason: 4, from_ap: false
>   Dec 28 20:21:28 titanium iwd[869]: Received Deauthentication event,
> reason: 4, from_ap: false
>   Dec 28 20:21:46 titanium iwd[869]: Received Deauthentication event,
> reason: 4, from_ap: false
>   Dec 28 21:07:33 titanium iwd[869]: Received Deauthentication event,
> reason: 4, from_ap: false

Were there any additional kernel/IWD logs at those time? Its probably 
best to enable IWD debugging with the "-d" flag.

This reason code is "Disassociated due to inactivity" and a local 
disconnect, which we see in our deployments as well. Is your device 
operating in low RSSI conditions? I see when you connected the RSSI was 
-79 which is at or at least very quickly approaching unusable connection 
quality. I suspect this i

>
> My investigations haven't led to much, not having a publicly viewable
> issue tracker is certainly not helping. I have found a few other
> threads where people have had this issue, however none of the proposed
> remedies have made an impact. The one thing I did try was disabling
> powersaving by adding this to my config:
>
> ~ λ cat /etc/modprobe.d/iwlwifi.conf
> options iwlmvm power_scheme=1
> options iwlwifi power_save=0
>
>   Any suggestions on where to take this, and let me know if I can
> provide you with any further information.
>
> Thanks for making open source software <3
>
