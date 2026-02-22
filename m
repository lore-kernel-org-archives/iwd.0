Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D802D221726
	for <iwd@lists.linux.dev>; Sun, 22 Feb 2026 22:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771799839; cv=pass; b=nyJlZu0r9TCVekrj2pPwIRD/I/ykGWl3dvyGWbiPB26gjJ06cz4Ke5vQoQIrPHETWec5WEsbVAj8cQsSC2ewDCH1rZayOpq7m80wlrhRR5+NnDRxnMEz+0L6c020LaTXoaTMo2QCSDt9yM6MUYa3dxC1iObNV3iyCiLOS69fmD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771799839; c=relaxed/simple;
	bh=eV1DAss89Aexlrxrw+tR2lrIp6wB3yS5IJbBHnv46qo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=iXL1nABTGalhEGFT0Yr4afuN4uw2xcqA0bcrPj7rip49QZS8mQqxPYdujSWncYvty9BQp6dzde0GvA5/A1opNVR7SdpZw5Yw6ksbU4tKThcnbsLNnPoRNYXb0c/9CpM2BdH6UlLfANHfnnQjWWdSN09DZ1yUffaHNkoW3aYA7gU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nkj7QewO; arc=pass smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nkj7QewO"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-40ede943bf0so2254054fac.2
        for <iwd@lists.linux.dev>; Sun, 22 Feb 2026 14:37:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771799837; cv=none;
        d=google.com; s=arc-20240605;
        b=RcTUEGk1oWPWZ6YsYaQVZWsuX49DPDCY3VQOvDkTpPlnF2xPLQ0y3nJW4sS9Yi80ta
         abAPlk1BsCqOMOe6RjUCtwxFelJnriN98x95itrjAl5ZkctcLqiBoM5Xw5ULnMq67o+1
         AOIETRSlNQ6R+ZuNbl90uXx1//zisnhYMFAVG92T2RpTFOAX4r2EHSdfGB9vpFOP+u/Z
         GWQ0VSsKRj8aiEQk8A4F/uWsjv565wuDl+7HxvJKqyPETixyJJZqtjL0+6INlR8bGsml
         JGbI6rm2PFNR3qbD2Ni2VhvgUXg5CcSjxX0kG7VZDEIpMvsnjN1UETitDkO4aOyZ+JQZ
         /v+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=2Wm8XRqWSvqPVCt/Fog8b/n3C4YAyu+t7H5IRIwfOoQ=;
        fh=LVwSdJJT2poHpWJpvI73c3fFqaJVA08Td3ZAiex6+kI=;
        b=eCb2iy75QauALdv/xznAFZWIal4nWvmkdY4o6uQ9IRH0mpDA2f/N++v4OFDtNVjFvA
         XIAqK9B6izuYdn9hmr24GLIuiN7hAeJgesKM4tExcX5l2QCw4fXclnGB9VYI2JhuRy3Y
         tsBtF7r5w9t96J8W7aIsWKTni5ikoDykoxPX9e8tkDTQU6+g4oi9CEX33m3pC81clVLd
         I+ZHF8wz963XPXiMweOVtEQK2FewgC2bZPe9cfGSN6xhhw9FiB5pDeSaK+dsPVZSB9hx
         f/18i7DTSViqBMDA1BainX0LIPv9aVM8ewZ8gwVb2kyvkM3VThkqKKYZ4prwHp1RaUU6
         F1AA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771799837; x=1772404637; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2Wm8XRqWSvqPVCt/Fog8b/n3C4YAyu+t7H5IRIwfOoQ=;
        b=nkj7QewOpLCEyOACkTMJpX0MbPXuCODmi+sxkDkWwXn13mF2PjjUWsIgXHUwxe+1gz
         Ndnmm6pAO5uQEsU7ULGpQP9MsgLfHbZPrJCPXv5Dj0nRglTxnO+wSH8emVgKAsCnclh1
         xz0Fh4ZnFcOwprnZ8ncN7Y64CLTRj8Yp99jjyWRbdUCHIquNP7GZOKUnB47DQlj5YAbQ
         YK6GKwtrQA439wmErvQ0b0zZ5z3eNrZBq5FGQn97AKiW3lBfS8w0bdJfoFwrdvXQLfsK
         fCJBmxfnE97k4NFjzQcKQ5Ta/ObEpviVsZXLLG8/hmMC2jArnj1gEHvscKZxeBvMdHIf
         wolg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771799837; x=1772404637;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Wm8XRqWSvqPVCt/Fog8b/n3C4YAyu+t7H5IRIwfOoQ=;
        b=spj/Faq4lhChwWQm4B1o42tWJrSoIn/x+oykKxPGZ6DYXlIEKcQa63eL9DzD9TxpuI
         fs/r34t8A+iZ3Yh9TvU3XTRYnW54A9Hmkw19QXOX9ExZjTCYHYV92wRBSkHD3Y/fi4BW
         A5U1DuA/Lc5QcTIjnoxxmgkdjbUbeix9riIeelqUJnK/RXTEX3jj5PmvjiApkqhZfbHd
         /ZpQhCk3wHQc3tTpr/r7gae4tmbi6q5woisQJODM3mHodkXekvTJXGo9VkgCuoqJGu+j
         ZtcDVGylhzBzSPqi3V8nTAzde8x6FdgRn5bI0ISSKWouLLe0k01LCQCyv9U0USNtDKJw
         g5zA==
X-Gm-Message-State: AOJu0YxxxxOciDFXXYvx2Pz9ambbHDw4LPlkMJTWHqKT9Pw8k8iiMrpQ
	cKhRvq4PiEwXMG4e64nN/4+3ecLP7GD2mtw7wuTC51jzFdAriLsO3oNfdQxstkv+MPjJDsXXcC8
	lvq+PZGv1kqWTYNtdMVyyD9oHGoKyw2e9A9Bx
X-Gm-Gg: AZuq6aL5kM89WspffV/FRv9lfIGponWQ8pFOChYKgk2pMDk4OyBOw0qJ6h9fXtbUQWw
	VJqwebXMEKW+IG9H9yqLng/AiK1mp4Ocp23tSgub/W35EF9O10gPlD2qybVViGDpQQxaXe1qBFZ
	9fiHteUJ/sbh6MvDHH5yxQTItE+7mX3T91aUhB7T5V9Bk5od8IF4D0HHaZRANx9W3payfs/P9Zj
	HRn8MtJ8T3kIkCX+mPnbUp1IZvav9xjkJ3EjyCRKHlzASXAZHTIFrY8M+Z3u6F8DuP+7VR4DNPS
	wPkq9wo+uD2BgoN+74aV
X-Received: by 2002:a05:6870:f615:b0:3f9:f6ca:738b with SMTP id
 586e51a60fabf-4157ad91558mr3783231fac.19.1771799836741; Sun, 22 Feb 2026
 14:37:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: =?UTF-8?B?Um9tYW4gxb1pbGth?= <roman.zilka@gmail.com>
Date: Sun, 22 Feb 2026 23:37:06 +0100
X-Gm-Features: AaiRm50cX2mcgKk_BlSqe1_x8Xh4vwlm4fCBq2654OfTjSQ6qNRUv579Qxv_3P0
Message-ID: <CANZiGuEaFwDLHD8jGk4-POxfnJAWeER1ss7COtur8b0ohEi3Fw@mail.gmail.com>
Subject: systemd-networkd MAC address randomization stops working when iwd restarts
To: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi,

there's a bug in iwd which may prevent udev from anonymizing the MAC
address of a wlan interface.

Setup: systemd 258.3, iwd 3.8 or 3.11, a wlan iface, which has
"MACAddressPolicy=random", "Anonymize=yes", "ActivationPolicy=manual",
"NamePolicy=kernel path" in systemd and
"EnableNetworkConfiguration=false" and no address randomization in
iwd.

After system boot:

# systemctl start iwd
# networkctl status wlp9s0
(...)
          Hardware Address: a2:ed:29:33:92:3b
Permanent Hardware Address: <physical MAC address, different from address above>
(...)
                   Address: 192.168.0.31 (DHCPv4 via 192.168.0.1)
                   Gateway: 192.168.0.1
                       DNS: 192.168.0.1
(...)
          DHCPv4 Client ID: a2:ed:29:33:92:3b

Everything is working, a random MAC address has been generated. If iwd
is restarted then (daemon crash, systemctl, ...), I expect udev to
continue using the random MAC address or generate a new one. However:

# systemctl stop iwd
# systemctl start iwd
# networkctl status wlp9s0
(...)
        Hardware Address: <physical MAC address>
(...)
                 Address: 192.168.0.244 (DHCPv4 via 192.168.0.1)
                 Gateway: 192.168.0.1
                     DNS: 192.168.0.1
(...)
        DHCPv4 Client ID: <physical MAC address>

IP connection has been re-established, but the MAC address used is no
longer random. "Permanent Hardware Address" is missing from networkctl
list. Following the start of iwd, this is appended to the journal:

Feb 22 22:52:50 krb iwd[3522]: No Diffie-Hellman support found, WPS
will not be available
Feb 22 22:52:50 krb iwd[3522]: The following options are missing in the kernel:
Feb 22 22:52:50 krb iwd[3522]:         CONFIG_KEY_DH_OPERATIONS
Feb 22 22:52:50 krb iwd[3522]: Wireless daemon version 3.11
Feb 22 22:52:50 krb iwd[3522]: Loaded configuration from /etc/iwd/main.conf
Feb 22 22:52:50 krb systemd[1]: Started Wireless service.
Feb 22 22:52:50 krb iwd[3522]: station: Network configuration is disabled.
Feb 22 22:52:50 krb iwd[3522]: Wiphy: 0, Name: phy0
(...)
Feb 22 22:52:50 krb iwd[3522]: event: state, old: disconnected, new:
autoconnect_quick
Feb 22 22:52:50 krb systemd-networkd[2520]: wlan0: Link UP
Feb 22 22:52:50 krb (udev-worker)[3535]: wlan0: Could not set Alias=,
MACAddress=/MACAddressPolicy=, TransmitQueues=, ReceiveQueues=,
TransmitQueueLength=, MTUBytes=, GenericSegmentOffloadMaxBytes= or
GenericSegmentOffloadMaxSegments=, ignoring: Device or resource busy
Feb 22 22:52:50 krb systemd-networkd[2520]: wlan0: Interface name
change detected, renamed to wlp9s0.
Feb 22 22:52:50 krb kernel: mt7921e 0000:09:00.0 wlp9s0: renamed from
wlan0 (while UP)
Feb 22 22:52:50 krb iwd[3522]: udev interface=wlp9s0 ifindex=5
Feb 22 22:52:50 krb (udev-worker)[3537]: wlp9s0: Could not set Alias=,
MACAddress=/MACAddressPolicy=, TransmitQueues=, ReceiveQueues=,
TransmitQueueLength=, MTUBytes=, GenericSegmentOffloadMaxBytes= or
GenericSegmentOffloadMaxSegments=, ignoring: Device or resource busy
Feb 22 22:52:50 krb systemd-networkd[2520]: wlp9s0: Configuring with
/etc/systemd/network/21-wlp9s0-dhcp.network.
Feb 22 22:52:51 krb iwd[3522]: invalid HE capabilities for <MAC>
Feb 22 22:52:51 krb iwd[3522]: event: connect-info, ssid: <SSID>, bss:
<MAC>, signal: -63, load: 15/255
Feb 22 22:52:51 krb iwd[3522]: event: state, old: autoconnect_quick,
new: connecting (auto)
Feb 22 22:52:51 krb kernel: wlp9s0: authenticate with <MAC> (local
address=<physical MAC address>)
Feb 22 22:52:51 krb kernel: wlp9s0: send auth to <MAC> (try 1/3)
Feb 22 22:52:51 krb kernel: wlp9s0: send auth to <MAC> (try 2/3)
Feb 22 22:52:51 krb kernel: wlp9s0: authenticated
Feb 22 22:52:51 krb kernel: wlp9s0: associate with <MAC> (try 1/3)
Feb 22 22:52:51 krb kernel: wlp9s0: RX AssocResp from <MAC>
(capab=0x1411 status=0 aid=21)
Feb 22 22:52:51 krb kernel: wlp9s0: associated
Feb 22 22:52:51 krb systemd-networkd[2520]: wlp9s0: Connected WiFi
access point: <SSID> (<MAC>)
Feb 22 22:52:51 krb iwd[3522]: event: state, old: connecting (auto),
new: connected
Feb 22 22:52:51 krb systemd-networkd[2520]: wlp9s0: Gained carrier
Feb 22 22:52:51 krb systemd-networkd[2520]: wlp9s0: DHCPv4 address
192.168.0.244/24, gateway 192.168.0.1 acquired from 192.168.0.1

systemd has rejected the issue as not theirs and a developer has
provided some background:
https://github.com/systemd/systemd/issues/40787 My full .network and
.link files are in there, too. main.conf:

[General]
EnableNetworkConfiguration=false
DisableANQP=false
DisableOCV=false
Country=CZ
DisablePMKSA=false
[Network]
EnableIPv6=false
NameResolvingService=systemd
[Scan]
DisablePeriodicScan=true

Thanks,
Roman
