Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB92F9D7
	for <iwd@lists.linux.dev>; Thu, 28 Dec 2023 18:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gvXQ7BBL"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6d9a7233133so1454604b3a.0
        for <iwd@lists.linux.dev>; Thu, 28 Dec 2023 10:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703787611; x=1704392411; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Uvdo4jUFekC9wj/4bChi/1KCYJO5hLi6geugtY03j5U=;
        b=gvXQ7BBLfhL2S03HtujtOVkhqW1R3W0SKuDS12Bt3TEVM+BLHPINybWv83A8Ci4ZGO
         KBy0kJR3nMLO9rtmVfvHF0epUyyD9ANud1RDFZz1TXXXzv/7jZ3IVgZZ1JHKwzNBx/9o
         J2e470dHAzMbqrBYHHEw47P2Alq8mlzsGM+KipyoVu0qviGdsfpsI5NE4tUrcYK2DtTY
         G9esNetSzNruuYlM8Lvk3mXG9CNP9dRWEDlme+yQIH4G+FiU7tYOUk0RIXnqwHh98IVl
         TOLSNOLEZGj4Q7jPfUdm+LlU9AEpWe2AklOkbcZbuEKowT2qbw4WqeSdkZ7dg428bd5o
         stFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703787611; x=1704392411;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Uvdo4jUFekC9wj/4bChi/1KCYJO5hLi6geugtY03j5U=;
        b=MQxUgurGoZJ+Vhp4pi0Yg3EfSaHPTEo+PYISJ08aCWvs/ejCklYOyf1O7cTmaj3XCO
         4IEnXmULuM7P4w5bSAisQ4vV7ofJKC4vf+Afql/XKGK66j2SAL7V93FrIOF2IdIB2MgL
         QCuN9/uWPmME4cnSbN4QKaswvUvbOqdq5gWQkBqjPqmkL62WwPhATR/BcUv+FkGP3tFb
         ZFjNvD3NDUp6FqZSg9i/hmvlqFM8mo5ZOwdR7BReSYX6R0EYLjCDxypH0q2VtZJ9tNJ6
         xI3bK4Ql0NohuYgwQRtca6O/gc2ZGiTGM1HnMpXqBWUr+zFlnkTqRtQILk/Nmysll7/W
         FL6w==
X-Gm-Message-State: AOJu0YxjHAfHL2L0gG4FlDfirvMFCIykOMy4HIGc7aRpbVnPgjDysFvV
	mGVHDQR7GJM5BxO8Lloy0N41bEjAgu+/UH+Xw5qIOy33OY0=
X-Google-Smtp-Source: AGHT+IGDjD5t0kdAMj4D7zTYJuUAdMK4ae6PrB2fS194bwQPKtAHASlzOJW1e0xL5KHwDCH3oE2m3pG6/rFfJMIGR9s=
X-Received: by 2002:a05:6a20:728b:b0:196:3b76:9880 with SMTP id
 o11-20020a056a20728b00b001963b769880mr1717572pzk.56.1703787610547; Thu, 28
 Dec 2023 10:20:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: KeithG <ys3al35l@gmail.com>
Date: Thu, 28 Dec 2023 12:19:59 -0600
Message-ID: <CAG17S_MXzqBrOrCuRYuwx0tfQT2V9Qe0MyD9c+hckZ+a7TMBHA@mail.gmail.com>
Subject: disconnects when in AP mode
To: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Group,

I finally gave up on getting connman to manage scanning when iwd is in
AP mode. What I have done is listen to James who posted this a long
time ago and I just finally figured out what he was saying.

I am doing what is outlined here:
https://lore.kernel.org/linux-wireless/87k0dhdg0d.fsf@bang-olufsen.dk/

I am running this on RPis all with the brcmfmac adapters. I can get it
all working, but when connected to the RPi on its advertised AP, I can
get a connection for a bit then it disconnects, requiring a reconnect.
I am running a freshly built iwd version 2.11 with ell 0.61 on RPiOS
fully up to date on Bookworm

I get tons of this in the log: "wiphy_estimate_data_rate() failed" and
a few others but it does not seem like this is what triggers it to
disconnect. I have not been able to pinpoint anything in the log where
it disconnects.

Any help appreciated.

# uname -a
Linux runeaudio 6.1.0-rpi7-rpi-v8 #1 SMP PREEMPT Debian
1:6.1.63-1+rpt1 (2023-11-24) aarch64 GNU/Linux

this is what shows at bootup
Dec 28 11:50:45 runeaudio kernel: brcmfmac: F1 signature read
@0x18000000=0x15264345
Dec 28 11:50:45 runeaudio kernel: brcmfmac: brcmf_fw_alloc_request:
using brcm/brcmfmac43455-sdio for chip BCM4345/6
Dec 28 11:50:45 runeaudio kernel: usbcore: registered new interface
driver brcmfmac
Dec 28 11:50:45 runeaudio kernel: Bluetooth: hci0: BCM4345C0
'brcm/BCM4345C0.raspberrypi,3-model-b-plus.hcd' Patch
Dec 28 11:50:45 runeaudio kernel: brcmfmac: brcmf_c_preinit_dcmds:
Firmware: BCM4345/6 wl0: Nov  1 2021 00:37:25 version 7.45.241
(1a2f2fa CY) FWID 01-703fd60
Dec 28 11:50:48 runeaudio kernel: brcmfmac:
brcmf_cfg80211_set_power_mgmt: power save enabled
Dec 28 11:50:55 runeaudio kernel: brcmfmac:
brcmf_cfg80211_set_power_mgmt: power save disabled
Dec 28 11:51:30 runeaudio kernel: brcmfmac:
brcmf_cfg80211_set_power_mgmt: power save disabled
Dec 28 11:51:31 runeaudio kernel: brcmfmac:
brcmf_cfg80211_set_power_mgmt: power save disabled
Dec 28 11:51:40 runeaudio kernel: ieee80211 phy0: brcmf_escan_timeout:
timer expired

I get this in the log:
Dec 28 11:51:30 runeaudio iwd[1306]: No Diffie-Hellman support found,
WPS will not be available
Dec 28 11:51:30 runeaudio iwd[1306]: The following options are missing
in the kernel:
Dec 28 11:51:30 runeaudio iwd[1306]:         CONFIG_KEY_DH_OPERATIONS
Dec 28 11:51:30 runeaudio iwd[1306]: Wireless daemon version 2.11
Dec 28 11:51:30 runeaudio iwd[1306]: Loaded configuration from
/etc/iwd/main.conf
Dec 28 11:51:30 runeaudio systemd[1]: Started iwd.service - Wireless service.
Dec 28 11:51:30 runeaudio iwd[1306]: Wiphy: 0, Name: phy0
Dec 28 11:51:30 runeaudio iwd[1306]:         Permanent Address:
b8:27:eb:52:cc:d0
Dec 28 11:51:30 runeaudio iwd[1306]:         2.4GHz Band:
Dec 28 11:51:30 runeaudio iwd[1306]:                 Bitrates (non-HT):
Dec 28 11:51:30 runeaudio iwd[1306]:                          1.0 Mbps
Dec 28 11:51:30 runeaudio iwd[1306]:                          2.0 Mbps
Dec 28 11:51:30 runeaudio iwd[1306]:                          5.5 Mbps
Dec 28 11:51:30 runeaudio iwd[1306]:                         11.0 Mbps
Dec 28 11:51:30 runeaudio iwd[1306]:                          6.0 Mbps
Dec 28 11:51:30 runeaudio iwd[1306]:                          9.0 Mbps
Dec 28 11:51:30 runeaudio iwd[1306]:                         12.0 Mbps
Dec 28 11:51:30 runeaudio iwd[1306]:                         18.0 Mbps
Dec 28 11:51:30 runeaudio iwd[1306]:                         24.0 Mbps
Dec 28 11:51:30 runeaudio iwd[1306]:                         36.0 Mbps
Dec 28 11:51:30 runeaudio iwd[1306]:                         48.0 Mbps
Dec 28 11:51:30 runeaudio iwd[1306]:                         54.0 Mbps
Dec 28 11:51:30 runeaudio iwd[1306]:                 HT Capabilities:
Dec 28 11:51:30 runeaudio iwd[1306]:                         HT40
Dec 28 11:51:30 runeaudio iwd[1306]:                         Short GI for 20Mhz
Dec 28 11:51:30 runeaudio iwd[1306]:                 HT RX MCS indexes:
Dec 28 11:51:30 runeaudio iwd[1306]:                         0-7
Dec 28 11:51:30 runeaudio iwd[1306]:         5GHz Band:
Dec 28 11:51:30 runeaudio iwd[1306]:                 Bitrates (non-HT):
Dec 28 11:51:30 runeaudio iwd[1306]:                          6.0 Mbps
Dec 28 11:51:30 runeaudio iwd[1306]:                          9.0 Mbps
Dec 28 11:51:30 runeaudio iwd[1306]:                         12.0 Mbps
Dec 28 11:51:30 runeaudio iwd[1306]:                         18.0 Mbps
Dec 28 11:51:30 runeaudio iwd[1306]:                         24.0 Mbps
Dec 28 11:51:30 runeaudio iwd[1306]:                         36.0 Mbps
Dec 28 11:51:30 runeaudio iwd[1306]:                         48.0 Mbps
Dec 28 11:51:30 runeaudio iwd[1306]:                         54.0 Mbps
Dec 28 11:51:30 runeaudio iwd[1306]:                 HT Capabilities:
Dec 28 11:51:30 runeaudio iwd[1306]:                         HT40
Dec 28 11:51:30 runeaudio iwd[1306]:                         Short GI for 20Mhz
Dec 28 11:51:30 runeaudio iwd[1306]:                         Short GI for 40Mhz
Dec 28 11:51:30 runeaudio iwd[1306]:                 HT RX MCS indexes:
Dec 28 11:51:30 runeaudio iwd[1306]:                         0-7
Dec 28 11:51:30 runeaudio iwd[1306]:                 VHT Capabilities:
Dec 28 11:51:30 runeaudio iwd[1306]:                         Short GI for 80Mhz
Dec 28 11:51:30 runeaudio iwd[1306]:                         Max RX
MCS: 0-9 for NSS: 1
Dec 28 11:51:30 runeaudio iwd[1306]:                         Max TX
MCS: 0-9 for NSS: 1
Dec 28 11:51:30 runeaudio iwd[1306]:         Ciphers: BIP-CMAC-128 CCMP-128 TKIP
Dec 28 11:51:30 runeaudio iwd[1306]:         Supported iftypes: ad-hoc
station ap p2p-client p2p-go p2p-device
Dec 28 11:51:30 runeaudio iwd[1306]:         Driver Flags: DefaultInterface
Dec 28 11:51:30 runeaudio iwd[1306]: Wiphy phy0 will only use the
default interface
Dec 28 11:51:30 runeaudio iwd[1306]: Could not register frame watch
type 00b0: -22
Dec 28 11:51:46 runeaudio iwd[1306]: wiphy_estimate_data_rate() failed
Dec 28 11:51:56 runeaudio iwd[1306]: wiphy_estimate_data_rate() failed
Dec 28 11:52:22 runeaudio iwd[1306]: wiphy_estimate_data_rate() failed
Dec 28 11:52:22 runeaudio iwd[1306]: wiphy_estimate_data_rate() failed
Dec 28 11:52:29 runeaudio iwd[1306]: KEY_SEQ not returned in GET_KEY reply
Dec 28 11:52:29 runeaudio iwd[1306]: 4-Way handshake failed for
ifindex: 4, reason: 15
Dec 28 11:52:39 runeaudio iwd[1306]: KEY_SEQ not returned in GET_KEY reply
Dec 28 11:52:40 runeaudio iwd[1306]: 4-Way handshake failed for
ifindex: 4, reason: 15
Dec 28 11:52:49 runeaudio iwd[1306]: KEY_SEQ not returned in GET_KEY reply
Dec 28 11:52:49 runeaudio iwd[1306]: 4-Way handshake failed for
ifindex: 4, reason: 15
Dec 28 11:53:07 runeaudio iwd[1306]: wiphy_estimate_data_rate() failed
Dec 28 11:53:35 runeaudio iwd[1306]: KEY_SEQ not returned in GET_KEY reply
Dec 28 11:54:33 runeaudio iwd[1306]: wiphy_estimate_data_rate() failed
Dec 28 11:54:33 runeaudio iwd[1306]: wiphy_estimate_data_rate() failed
