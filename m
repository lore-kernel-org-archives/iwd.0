Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6803A3D577
	for <iwd@lists.linux.dev>; Tue,  9 Jan 2024 21:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MoYjeXax"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-7ce3e5bc2afso612935241.3
        for <iwd@lists.linux.dev>; Tue, 09 Jan 2024 13:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704836260; x=1705441060; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Me2zXH9z6SAw81398ChgaqE8QGhqMufT+X8tII5cNXw=;
        b=MoYjeXaxYQrQ33K1vHCmFz7+cIc9gu0NooYHD7LnVuUlQ8c6qZUYFz2SVfdYKrncMi
         tTEYWji9Bvwkgvtib+S5g5VnuiRagTlzMNvvHghufCX+x7xeGRZzHvudMqMcIQTYfoB4
         j/6j4RiR2FMH7KdVP3N5/57Km+SdLTV5w23mT3zyATG1RSa680MMGN9Vvd75X3utL0nQ
         bm8cL9QMofHVwMisymbbQmfPONQptSSiOEhYSkJWj3/cDI3WwuX5aPStBaCk67eVVQnG
         P0oSKzINZNmGsPJBqgNMbl1d7xcqL5tgk4b5MsuytVTnkTJ+VLhqmcZBzXWiqQD0y6B5
         m1Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704836260; x=1705441060;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Me2zXH9z6SAw81398ChgaqE8QGhqMufT+X8tII5cNXw=;
        b=FhIqFmLZoNUV4p4oU6y3Qx+sDbNJEgfuNl7nmjVG/quT5lq6nJ62ApVGzI3dP/uPC0
         prKu1aA7HI8yA2zazd3aENHx7mgUxMUkHZn09eT8L4fZRb/Os+8gbOyYe32WDKU2YeU1
         DvnJPjG1hkIZfJ1g2Q8ebXLv+nSYYSg9BR+9SM5T7mJEiLBSJYdR+nIFP5shUMIWzw5n
         3wW009xSwqvj4V3/rou1vtOb+Eh11RckmchLe5G6VFP/fOuFFL9O2zIXOFkmyjDPE6+6
         XMp5eFFMry35cW0N0V8CFslvuHku9Yx49Oz6bMb3juNnge7vz6afusilTA5lPXX8fq9H
         +czw==
X-Gm-Message-State: AOJu0YwK9Ut/37opnxXpOnxDA+/4op1gA6Xodb7iMzqojTB0Xqr3PgKT
	4wmOhE3SGAcPFIjckrBHmLAUjJ8eYzL1+oy5hhUH/ti60GQb3Q==
X-Google-Smtp-Source: AGHT+IF3YX9gE35JQEeIihzBq6hO/aNFdq1H3ZoDP9XOK8cwYkFz8yqHgFmiNE9SerlIIjeM9BWX8FmZLM1JdHz39pQ=
X-Received: by 2002:a05:6102:1518:b0:467:c7a9:f12d with SMTP id
 f24-20020a056102151800b00467c7a9f12dmr4031936vsv.22.1704836259632; Tue, 09
 Jan 2024 13:37:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Robert Nelson <robertcnelson@gmail.com>
Date: Tue, 9 Jan 2024 15:37:13 -0600
Message-ID: <CAOCHtYj9OjZGQ=G139i=KRRcxpFD-1=GSvUPmFYaqSvFz0NwJg@mail.gmail.com>
Subject: iwd 2.12 - Received error during CMD_TRIGGER_SCAN: Invalid argument (22)
To: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi iwd Developers,

For BeagleBoard.org devices I've been looking to move us to iwd vs
wpa_supplicant, and have been fighting an CMD_TRIGGER_SCAN error on
bootup, so devices don't auto connect to WiFI once configured.

Our main stack is Debian 12.x (Bookworm) with backports of libell-dev
and iwd on a 5.10.x based vendor kernel (well my 5.10.x)

https://packages.debian.org/sid/libell-dev
https://packages.debian.org/source/sid/iwd

```
debian@42-am335x-bbbw:~$ dpkg --list | grep libell
ii  libell0:armhf
0.61-1bbbio0~bookworm+20231207          armhf        Embedded Linux
library
debian@42-am335x-bbbw:~$ dpkg --list | grep iwd
ii  iwd
2.12-1bbbio0~bookworm+20240103          armhf        wireless daemon
for Linux
```

Normally on bootup iwd will report:

```
Jan 09 15:10:41 41-am335x-bbbw iwd[360]: D-Bus disconnected, quitting...
Jan 09 15:10:41 41-am335x-bbbw iwd[360]: Removing scan context for wdev 2
Jan 09 15:10:41 41-am335x-bbbw iwd[360]: Terminate
Jan 09 15:10:41 41-am335x-bbbw systemd[1]: Stopping iwd.service -
Wireless service...
Jan 09 15:10:42 41-am335x-bbbw iwd[360]: Removing scan context for wdev 3
Jan 09 15:10:42 41-am335x-bbbw systemd[1]: iwd.service: Deactivated
successfully.
Jan 09 15:10:42 41-am335x-bbbw systemd[1]: Stopped iwd.service -
Wireless service.
Jan 09 15:10:44 41-am335x-bbbw systemd[1]: Starting iwd.service -
Wireless service...
Jan 09 15:10:47 41-am335x-bbbw iwd[363]: Wireless daemon version 2.12
Jan 09 15:10:47 41-am335x-bbbw iwd[363]: Loaded configuration from
/etc/iwd/main.conf
Jan 09 15:10:47 41-am335x-bbbw systemd[1]: Started iwd.service -
Wireless service.
Jan 09 15:10:47 41-am335x-bbbw iwd[363]: station: Network
configuration is disabled.
Jan 09 15:11:14 41-am335x-bbbw iwd[363]: Wiphy: 0, Name: phy0
Jan 09 15:11:14 41-am335x-bbbw iwd[363]:         Permanent Address:
5c:31:3e:e2:24:6a
Jan 09 15:11:14 41-am335x-bbbw iwd[363]:         2.4GHz Band:
Jan 09 15:11:14 41-am335x-bbbw iwd[363]:                 Bitrates (non-HT):
Jan 09 15:11:14 41-am335x-bbbw iwd[363]:                          1.0 Mbps
Jan 09 15:11:14 41-am335x-bbbw iwd[363]:                          2.0 Mbps
Jan 09 15:11:14 41-am335x-bbbw iwd[363]:                          5.5 Mbps
Jan 09 15:11:14 41-am335x-bbbw iwd[363]:                         11.0 Mbps
Jan 09 15:11:14 41-am335x-bbbw iwd[363]:                          6.0 Mbps
Jan 09 15:11:14 41-am335x-bbbw iwd[363]:                          9.0 Mbps
Jan 09 15:11:14 41-am335x-bbbw iwd[363]:                         12.0 Mbps
Jan 09 15:11:14 41-am335x-bbbw iwd[363]:                         18.0 Mbps
Jan 09 15:11:14 41-am335x-bbbw iwd[363]:                         24.0 Mbps
Jan 09 15:11:14 41-am335x-bbbw iwd[363]:                         36.0 Mbps
Jan 09 15:11:14 41-am335x-bbbw iwd[363]:                         48.0 Mbps
Jan 09 15:11:14 41-am335x-bbbw iwd[363]:                         54.0 Mbps
Jan 09 15:11:14 41-am335x-bbbw iwd[363]:                 HT Capabilities:
Jan 09 15:11:14 41-am335x-bbbw iwd[363]:                         HT20
Jan 09 15:11:14 41-am335x-bbbw iwd[363]:                         Short
GI for 20Mhz
Jan 09 15:11:14 41-am335x-bbbw iwd[363]:                 HT RX MCS indexes:
Jan 09 15:11:14 41-am335x-bbbw iwd[363]:                         0-15
Jan 09 15:11:14 41-am335x-bbbw iwd[363]:         5GHz Band:
Jan 09 15:11:14 41-am335x-bbbw iwd[363]:                 Bitrates (non-HT):
Jan 09 15:11:14 41-am335x-bbbw iwd[363]:                          6.0 Mbps
Jan 09 15:11:14 41-am335x-bbbw iwd[363]:                          9.0 Mbps
Jan 09 15:11:14 41-am335x-bbbw iwd[363]:                         12.0 Mbps
Jan 09 15:11:14 41-am335x-bbbw iwd[363]:                         18.0 Mbps
Jan 09 15:11:14 41-am335x-bbbw iwd[363]:                         24.0 Mbps
Jan 09 15:11:14 41-am335x-bbbw iwd[363]:                         36.0 Mbps
Jan 09 15:11:14 41-am335x-bbbw iwd[363]:                         48.0 Mbps
Jan 09 15:11:14 41-am335x-bbbw iwd[363]:                         54.0 Mbps
Jan 09 15:11:14 41-am335x-bbbw iwd[363]:                 HT Capabilities:
Jan 09 15:11:14 41-am335x-bbbw iwd[363]:                         HT40
Jan 09 15:11:14 41-am335x-bbbw iwd[363]:                         Short
GI for 20Mhz
Jan 09 15:11:14 41-am335x-bbbw iwd[363]:                         Short
GI for 40Mhz
Jan 09 15:11:14 41-am335x-bbbw iwd[363]:                 HT RX MCS indexes:
Jan 09 15:11:14 41-am335x-bbbw iwd[363]:                         0-7
Jan 09 15:11:14 41-am335x-bbbw iwd[363]:         Ciphers: CCMP-128 TKIP
Jan 09 15:11:14 41-am335x-bbbw iwd[363]:         Supported iftypes:
station ap p2p-client p2p-go p2p-device
Jan 09 15:11:16 41-am335x-bbbw iwd[363]: connect event timed out, reason=3
Jan 09 15:11:16 41-am335x-bbbw iwd[363]: connect event timed out, reason=3
Jan 09 15:11:17 41-am335x-bbbw iwd[363]: connect event timed out, reason=3
Jan 09 15:11:18 41-am335x-bbbw iwd[363]: connect event timed out, reason=3
Jan 09 15:11:18 41-am335x-bbbw iwd[363]: connect event timed out, reason=2
Jan 09 15:11:18 41-am335x-bbbw iwd[363]: Received error during
CMD_TRIGGER_SCAN: Invalid argument (22)
Jan 09 15:11:28 41-am335x-bbbw iwd[363]: Received error during
CMD_TRIGGER_SCAN: Invalid argument (22)
Jan 09 15:11:48 41-am335x-bbbw iwd[363]: Received error during
CMD_TRIGGER_SCAN: Invalid argument (22)
```

What's weird, if i login over serial and restart, sometimes it just works..

```
Jan 09 14:58:11 42-am335x-bbbw iwd[362]: Received error during
CMD_TRIGGER_SCAN: Invalid argument (22)
Jan 09 15:03:11 42-am335x-bbbw iwd[362]: Received error during
CMD_TRIGGER_SCAN: Invalid argument (22)
Jan 09 15:07:58 42-am335x-bbbw sudo[676]:   debian : TTY=ttyS0 ;
PWD=/home/debian ; USER=root ; COMMAND=/usr/bin/systemctl restart
iwd.service
Jan 09 15:08:19 42-am335x-bbbw sudo[720]:   debian : TTY=ttyS0 ;
PWD=/home/debian ; USER=root ; COMMAND=/usr/bin/systemctl restart
iwd.service
Jan 09 15:24:44 42-am335x-bbbw sudo[1246]:   debian : TTY=ttyS0 ;
PWD=/home/debian/lab ; USER=root ; COMMAND=/usr/bin/nano
/etc/iwd/main.conf
Jan 09 15:25:01 42-am335x-bbbw systemd[1]: Starting iwd.service -
Wireless service...
Jan 09 15:25:04 42-am335x-bbbw iwd[363]: Wireless daemon version 2.12
Jan 09 15:25:04 42-am335x-bbbw iwd[363]: Loaded configuration from
/etc/iwd/main.conf
Jan 09 15:25:04 42-am335x-bbbw systemd[1]: Started iwd.service -
Wireless service.
Jan 09 15:25:04 42-am335x-bbbw iwd[363]: station: Network
configuration is disabled.
Jan 09 15:25:30 42-am335x-bbbw iwd[363]: Wiphy: 0, Name: phy0
Jan 09 15:25:30 42-am335x-bbbw iwd[363]:         Permanent Address:
5c:31:3e:e3:bb:e4
Jan 09 15:25:30 42-am335x-bbbw iwd[363]:         2.4GHz Band:
Jan 09 15:25:30 42-am335x-bbbw iwd[363]:                 Bitrates (non-HT):
Jan 09 15:25:30 42-am335x-bbbw iwd[363]:                          1.0 Mbps
Jan 09 15:25:30 42-am335x-bbbw iwd[363]:                          2.0 Mbps
Jan 09 15:25:30 42-am335x-bbbw iwd[363]:                          5.5 Mbps
Jan 09 15:25:30 42-am335x-bbbw iwd[363]:                         11.0 Mbps
Jan 09 15:25:30 42-am335x-bbbw iwd[363]:                          6.0 Mbps
Jan 09 15:25:30 42-am335x-bbbw iwd[363]:                          9.0 Mbps
Jan 09 15:25:30 42-am335x-bbbw iwd[363]:                         12.0 Mbps
Jan 09 15:25:30 42-am335x-bbbw iwd[363]:                         18.0 Mbps
Jan 09 15:25:30 42-am335x-bbbw iwd[363]:                         24.0 Mbps
Jan 09 15:25:30 42-am335x-bbbw iwd[363]:                         36.0 Mbps
Jan 09 15:25:30 42-am335x-bbbw iwd[363]:                         48.0 Mbps
Jan 09 15:25:30 42-am335x-bbbw iwd[363]:                         54.0 Mbps
Jan 09 15:25:30 42-am335x-bbbw iwd[363]:                 HT Capabilities:
Jan 09 15:25:30 42-am335x-bbbw iwd[363]:                         HT20
Jan 09 15:25:30 42-am335x-bbbw iwd[363]:                         Short
GI for 20Mhz
Jan 09 15:25:30 42-am335x-bbbw iwd[363]:                 HT RX MCS indexes:
Jan 09 15:25:30 42-am335x-bbbw iwd[363]:                         0-15
Jan 09 15:25:30 42-am335x-bbbw iwd[363]:         5GHz Band:
Jan 09 15:25:30 42-am335x-bbbw iwd[363]:                 Bitrates (non-HT):
Jan 09 15:25:30 42-am335x-bbbw iwd[363]:                          6.0 Mbps
Jan 09 15:25:30 42-am335x-bbbw iwd[363]:                          9.0 Mbps
Jan 09 15:25:30 42-am335x-bbbw iwd[363]:                         12.0 Mbps
Jan 09 15:25:30 42-am335x-bbbw iwd[363]:                         18.0 Mbps
Jan 09 15:25:30 42-am335x-bbbw iwd[363]:                         24.0 Mbps
Jan 09 15:25:30 42-am335x-bbbw iwd[363]:                         36.0 Mbps
Jan 09 15:25:30 42-am335x-bbbw iwd[363]:                         48.0 Mbps
Jan 09 15:25:30 42-am335x-bbbw iwd[363]:                         54.0 Mbps
Jan 09 15:25:30 42-am335x-bbbw iwd[363]:                 HT Capabilities:
Jan 09 15:25:30 42-am335x-bbbw iwd[363]:                         HT40
Jan 09 15:25:30 42-am335x-bbbw iwd[363]:                         Short
GI for 20Mhz
Jan 09 15:25:30 42-am335x-bbbw iwd[363]:                         Short
GI for 40Mhz
Jan 09 15:25:30 42-am335x-bbbw iwd[363]:                 HT RX MCS indexes:
Jan 09 15:25:30 42-am335x-bbbw iwd[363]:                         0-7
Jan 09 15:25:30 42-am335x-bbbw iwd[363]:         Ciphers: CCMP-128 TKIP
Jan 09 15:25:30 42-am335x-bbbw iwd[363]:         Supported iftypes:
station ap p2p-client p2p-go p2p-device
Jan 09 15:25:32 42-am335x-bbbw iwd[363]: hardware_rekey not supported
```

i'm hoping iwd developers can help decode what `iwd[362]: Received
error during CMD_TRIGGER_SCAN: Invalid argument (22)` actually means,
and i'm starting to wonder if this is just a race condition..

```
debian@42-am335x-bbbw:~$ lsmod
Module                  Size  Used by
bnep                   28672  2
wl18xx                 90112  0
wlcore                200704  1 wl18xx
mac80211              696320  2 wl18xx,wlcore
libarc4                16384  1 mac80211
hci_uart              106496  0
btqca                  20480  1 hci_uart
btrtl                  24576  1 hci_uart
btbcm                  16384  1 hci_uart
btintel                24576  1 hci_uart
uio_pruss              16384  0
bluetooth             516096  29 btrtl,hci_uart,btintel,btqca,bnep,btbcm
pvrsrvkm              368640  0
pm33xx                 20480  0
wlcore_sdio            20480  0
wkup_m3_ipc            20480  1 pm33xx
cpufreq_dt             20480  0
evdev                  24576  1
rpcsec_gss_krb5        28672  0
ccm                    20480  9
algif_aead             16384  0
aes_arm_bs             24576  5
crypto_simd            16384  1 aes_arm_bs
cryptd                 20480  2 crypto_simd
uio_pdrv_genirq        20480  0
uio                    20480  2 uio_pruss,uio_pdrv_genirq
cfg80211              671744  3 wl18xx,wlcore,mac80211
binfmt_misc            24576  1
dm_mod                110592  0
```

TI_AM335x_BeagleBone_Black_Wireless on [5.10.168-ti-r75]

Thanks!

-- 
Robert Nelson
https://rcn-ee.com/
