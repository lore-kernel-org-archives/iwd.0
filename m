Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CF61EDA2C
	for <iwd@lists.linux.dev>; Mon, 23 Feb 2026 13:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771853783; cv=none; b=gSehqOEfjVyh6BSR5oGUFZF9altMY28eET+qQm9R44Vn60gUrda5+pkpuYBCCvHCgBnHX+rnsxHD7GfTNmUboI4wqO+Iyi+mi77PSDrCrotBHkUnKUxJDsNl7L2y0+RTlkfYar0XBY3477+4/m8GUXsI0sSm2r0snp9F5Z7YqWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771853783; c=relaxed/simple;
	bh=V6Fu0qydcGGXOHoDa386yhIArKX/ebQ7n5rJjRB4hMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CxdtVv94mK7Jf9m6iiwJ289PaQqJV2GZ+I1gNxT+Uuk4ZY4oASf2r7f7qu2pyRwssV+lxs6Ih7kqI9JobrLo19saz+jbsZmcsuCjcLFtcLaJ+rfO6arcQU0XD3GafS5GwwF8RXzGYuIGbvFa+9okOqaHNyxQBIS6F7jq/lgDE/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I2RG8a9r; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2RG8a9r"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-824a829f9bbso2237269b3a.0
        for <iwd@lists.linux.dev>; Mon, 23 Feb 2026 05:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771853781; x=1772458581; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9EykrKwapiUU3jsqJHDs5bMuBQYkJrbF3WWMHJ3gqa0=;
        b=I2RG8a9rUM/lRkPcuRoLRPkCzd9pdBlgUDdF2W7DGmktTYNKdt1O7bLN9SNDSLXkOD
         4ehLF1VdDrEeSFgP5rZouOGMmBrs5xkRHXjc9m4e6EwGrve9U0v1OFhBwNQfEvUDjZTw
         DaNKAH5gsEJ1KfT0epBwbHv4mkeOBYQM3xyDD0DbYKXAIwt4KxBnOSpZjB3ecHRRqWZX
         XLEdpQlzCSKLk66QsZU/xUjBTt1RHSnvEzv5AuDB09wA4IeRprAM41V5cLeG62x/hFa8
         +Ui+N1y8z0vdxkgghb6+Xo4E9lXq4farZcwZeqZl6W514QTxzWcb8U8/BvqvZGjZAGBZ
         DK3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771853781; x=1772458581;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9EykrKwapiUU3jsqJHDs5bMuBQYkJrbF3WWMHJ3gqa0=;
        b=WzKuAcW0XXu3DPgZnkkj3AyGeD+ZdBp131ttNeu+DGyi9pE4JL4px0fzQubHVL8lB+
         M8vlptIXI9yppGODa+u4e2UPxmVWuUEQnnOwUPJ/uTLoAbwrHtfqvMw/xBI4wdiTA2Dg
         xylsDGtmF2M+TFLhlqDfwQvnfjMaP+qSGSVho6Jq7X5I/tc1aoGuwI6CEHxx20B1EYX3
         JZ3U+qP1yWRy0Iw61R0QfxQQqYJL8MZ0noDadM5hzKa0LZjsJMVUH+up8SH4UQwdpP30
         XTxTp2p2CTnZ+Xp6i7/jNcExxa4VSXwkoODrQPQnTo67RZugHBx303tCTdQweyKrcxcN
         A4ew==
X-Forwarded-Encrypted: i=1; AJvYcCUTvWId230OygO8b6faB3Ymm344wo389HG32/pDhLCVcA1vpDkJgjda6EbjXqPTNwmaIyg=@lists.linux.dev
X-Gm-Message-State: AOJu0YxM0ebrrGY5f58FjWU8BLhQeDnVHvsxeCpQjd9qbFS3QNZdrD9w
	IK9pY2yX6OHgjuhYWFOE1cIWIwQjtBbfsd8dNmQ8VLppuwLnGNeQ/Qpa
X-Gm-Gg: ATEYQzxh62OV1YHDCT+f98/khvYK4FX9bm2N+4w+4AxF2r2QiT3unz0zHYn89H+Wy3I
	cqo/NK2iOUTWe9begl6cnLkCfIvnhZ4cR8Iyv1E2JFVFlzj/Jo4QkyTiyW0gT1zlYYSU899EHrO
	zEkoQ6BqpwtH8JE9E/Tu5VAbangM1rOSfzqTRFqW6SfuAzJWVDEoxW/C5aO68aRXwF/+Z15Pzuq
	0npybnUtJsu2FyxvP2Biu9Kw52yU2LjArGxO86FQlePGs/TW2+1KhGrw+Yh/K8NkvF1hIIwXgUs
	O9hRFyVehZSpKswV3EIVJKQ33u4IwFPviWxdBvFoC4U5mUFxaM6Sj464ZGlIf6mxoyyUKysW7Ag
	yKvS0YQJcFF0ScLVI3Myl0CI3iRwtpFppo+1p+X2fWGOCkFHr+i0bzUZZa0BOhmLR9mLxRqcQTU
	IZ47UzX1/uqwD3jSbgSu30s0sBVt/081OINAHvQdNz5jeTQyVMQUIGkQEswyW307Lk9K51MFAsD
	IacuST9gZeI+aOSAkw8KKo+HwZTRorV0EiX
X-Received: by 2002:a05:6a00:14cf:b0:81f:8084:7ea0 with SMTP id d2e1a72fcca58-826da8dd8e9mr7754232b3a.7.1771853780964;
        Mon, 23 Feb 2026 05:36:20 -0800 (PST)
Received: from [192.168.1.164] (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd68998bsm8591861b3a.16.2026.02.23.05.36.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Feb 2026 05:36:20 -0800 (PST)
Message-ID: <72a14187-ae0c-4de1-898c-c416de541e7f@gmail.com>
Date: Mon, 23 Feb 2026 05:36:19 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: systemd-networkd MAC address randomization stops working when iwd
 restarts
To: =?UTF-8?Q?Roman_=C5=BDilka?= <roman.zilka@gmail.com>, iwd@lists.linux.dev
References: <CANZiGuEaFwDLHD8jGk4-POxfnJAWeER1ss7COtur8b0ohEi3Fw@mail.gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CANZiGuEaFwDLHD8jGk4-POxfnJAWeER1ss7COtur8b0ohEi3Fw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Roman,

On 2/22/26 2:37 PM, Roman Žilka wrote:
> Hi,
>
> there's a bug in iwd which may prevent udev from anonymizing the MAC
> address of a wlan interface.
>
> Setup: systemd 258.3, iwd 3.8 or 3.11, a wlan iface, which has
> "MACAddressPolicy=random", "Anonymize=yes", "ActivationPolicy=manual",
> "NamePolicy=kernel path" in systemd and
> "EnableNetworkConfiguration=false" and no address randomization in
> iwd.
>
> After system boot:
>
> # systemctl start iwd
> # networkctl status wlp9s0
> (...)
>            Hardware Address: a2:ed:29:33:92:3b
> Permanent Hardware Address: <physical MAC address, different from address above>
> (...)
>                     Address: 192.168.0.31 (DHCPv4 via 192.168.0.1)
>                     Gateway: 192.168.0.1
>                         DNS: 192.168.0.1
> (...)
>            DHCPv4 Client ID: a2:ed:29:33:92:3b
>
> Everything is working, a random MAC address has been generated. If iwd
> is restarted then (daemon crash, systemctl, ...), I expect udev to
> continue using the random MAC address or generate a new one. However:
>
> # systemctl stop iwd
> # systemctl start iwd
> # networkctl status wlp9s0
> (...)
>          Hardware Address: <physical MAC address>
> (...)
>                   Address: 192.168.0.244 (DHCPv4 via 192.168.0.1)
>                   Gateway: 192.168.0.1
>                       DNS: 192.168.0.1
> (...)
>          DHCPv4 Client ID: <physical MAC address>
>
> IP connection has been re-established, but the MAC address used is no
> longer random. "Permanent Hardware Address" is missing from networkctl
> list. Following the start of iwd, this is appended to the journal:
>
> Feb 22 22:52:50 krb iwd[3522]: No Diffie-Hellman support found, WPS
> will not be available
> Feb 22 22:52:50 krb iwd[3522]: The following options are missing in the kernel:
> Feb 22 22:52:50 krb iwd[3522]:         CONFIG_KEY_DH_OPERATIONS
> Feb 22 22:52:50 krb iwd[3522]: Wireless daemon version 3.11
> Feb 22 22:52:50 krb iwd[3522]: Loaded configuration from /etc/iwd/main.conf
> Feb 22 22:52:50 krb systemd[1]: Started Wireless service.
> Feb 22 22:52:50 krb iwd[3522]: station: Network configuration is disabled.
> Feb 22 22:52:50 krb iwd[3522]: Wiphy: 0, Name: phy0
> (...)
> Feb 22 22:52:50 krb iwd[3522]: event: state, old: disconnected, new:
> autoconnect_quick
> Feb 22 22:52:50 krb systemd-networkd[2520]: wlan0: Link UP
> Feb 22 22:52:50 krb (udev-worker)[3535]: wlan0: Could not set Alias=,
> MACAddress=/MACAddressPolicy=, TransmitQueues=, ReceiveQueues=,
> TransmitQueueLength=, MTUBytes=, GenericSegmentOffloadMaxBytes= or
> GenericSegmentOffloadMaxSegments=, ignoring: Device or resource busy
> Feb 22 22:52:50 krb systemd-networkd[2520]: wlan0: Interface name
> change detected, renamed to wlp9s0.
> Feb 22 22:52:50 krb kernel: mt7921e 0000:09:00.0 wlp9s0: renamed from
> wlan0 (while UP)
> Feb 22 22:52:50 krb iwd[3522]: udev interface=wlp9s0 ifindex=5
> Feb 22 22:52:50 krb (udev-worker)[3537]: wlp9s0: Could not set Alias=,
> MACAddress=/MACAddressPolicy=, TransmitQueues=, ReceiveQueues=,
> TransmitQueueLength=, MTUBytes=, GenericSegmentOffloadMaxBytes= or
> GenericSegmentOffloadMaxSegments=, ignoring: Device or resource busy
> Feb 22 22:52:50 krb systemd-networkd[2520]: wlp9s0: Configuring with
> /etc/systemd/network/21-wlp9s0-dhcp.network.
> Feb 22 22:52:51 krb iwd[3522]: invalid HE capabilities for <MAC>
> Feb 22 22:52:51 krb iwd[3522]: event: connect-info, ssid: <SSID>, bss:
> <MAC>, signal: -63, load: 15/255
> Feb 22 22:52:51 krb iwd[3522]: event: state, old: autoconnect_quick,
> new: connecting (auto)
> Feb 22 22:52:51 krb kernel: wlp9s0: authenticate with <MAC> (local
> address=<physical MAC address>)
> Feb 22 22:52:51 krb kernel: wlp9s0: send auth to <MAC> (try 1/3)
> Feb 22 22:52:51 krb kernel: wlp9s0: send auth to <MAC> (try 2/3)
> Feb 22 22:52:51 krb kernel: wlp9s0: authenticated
> Feb 22 22:52:51 krb kernel: wlp9s0: associate with <MAC> (try 1/3)
> Feb 22 22:52:51 krb kernel: wlp9s0: RX AssocResp from <MAC>
> (capab=0x1411 status=0 aid=21)
> Feb 22 22:52:51 krb kernel: wlp9s0: associated
> Feb 22 22:52:51 krb systemd-networkd[2520]: wlp9s0: Connected WiFi
> access point: <SSID> (<MAC>)
> Feb 22 22:52:51 krb iwd[3522]: event: state, old: connecting (auto),
> new: connected
> Feb 22 22:52:51 krb systemd-networkd[2520]: wlp9s0: Gained carrier
> Feb 22 22:52:51 krb systemd-networkd[2520]: wlp9s0: DHCPv4 address
> 192.168.0.244/24, gateway 192.168.0.1 acquired from 192.168.0.1
>
> systemd has rejected the issue as not theirs and a developer has
> provided some background:
> https://github.com/systemd/systemd/issues/40787 My full .network and
> .link files are in there, too. main.conf:
>
> [General]
> EnableNetworkConfiguration=false
> DisableANQP=false
> DisableOCV=false
> Country=CZ
> DisablePMKSA=false
> [Network]
> EnableIPv6=false
> NameResolvingService=systemd
> [Scan]
> DisablePeriodicScan=true
>
> Thanks,
> Roman

Looks like the issue is in the configuration. IWD removes/creates a new 
fresh interface on startup, which conflicts with how you want to use 
randomization with systemd. If you want systemd to manage the interface 
you need to tell IWD to use the interface systemd/udev creates by using 
this option in main.conf:

[DriverQuirks]
DefaultInterface=<driver>

See man iwd.config for more info on that.

Alternatively you could just use address randomization in IWD, and 
disable it in systemd.

Thanks,

James

