Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29481F582E
	for <iwd@lists.linux.dev>; Sun,  3 Aug 2025 10:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754218796; cv=none; b=tmGv607M7pYL7MzFnSPyf6pQX/XhJcxtIIT7gf7/X8w5Gvi9pRzOG1++Zol7rizGtf3QNgFtgV0AebBcZVzU1HvFcrjqRGAC5SzFrMiwI24VLKMl5MjGr1+ee+Nkh5Zb+I1gFsIQ67G4lew46O/BdCXQZpwZ3avQZgkIcUMAGGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754218796; c=relaxed/simple;
	bh=7/IFfR1zT/ySY7iHaezsaQij4ooVxQpgNXgxQCEqjmM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=B2yoDUiQIz7o9XKZDlVXA4CBA3f/Esexk8HyLyuie2bxfWBsdcPci5n7RdhQFi8Mq5BiaUH9phRKds/inL2UA3WI/WVMd3IC/eTLu3MU9WepAg1p3GuR6BZBvVCjlB2YDeSZzOtzUTvNheyOC5O3DohqtcUkCN+Pq1PogY3phRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kjXB/Lxi; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjXB/Lxi"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-88bab5ffd32so542444241.0
        for <iwd@lists.linux.dev>; Sun, 03 Aug 2025 03:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754218792; x=1754823592; darn=lists.linux.dev;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ezt1dir/wuDLQFNjSwU8WdTVSwneALxTQ6+LQjW4q2c=;
        b=kjXB/Lxio49bDeZi1PKscARUZniJwsmITGn9c1Svm/OlT5vus0yEy6JbwHOEKzImJ4
         fqqIZMc+gWBQubB/ApSKO/iU/Lg2AeskxgMGu8XRjhB52D1ziBtHZTTT3KVT37o0x5BJ
         Py4abkWTIxnc1h8xN7uLQRULB4wBSuLZVWai+DD49wefdfcnmVZ3c1k7cjCpdO9Ca92c
         j5SQPzZRj4TSrWcYgEIExVRwnrOv3rlgDEU+DQG0Il468vG6XBFTv8ftgpA3jMPyiweU
         A0lLuFjdWEczUaPeZlzD6rK+sV0vC9Qe0FaNc8JyGtRJS4c/UARPl0H2QzbezmZBgg/w
         idVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754218792; x=1754823592;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ezt1dir/wuDLQFNjSwU8WdTVSwneALxTQ6+LQjW4q2c=;
        b=KwyQa2zy/QyLQAyhMdohz2p1Xh+Vy3P8Q83eZuueARjmnDQYB0WVVeo/OJdWVCaM+6
         CQ9f4ROnycqyIobXADOm6XFpXOdS08QeLMnWoNSCmXIh84YWKdtAa23wofhu+qoTuXQH
         wXrU3yS6eNfk/t2/qfIK7X+91FJ262ks1D7Xh/PfHZyefif5JO8BLCqpcxECX6ngC0fR
         bY2Yt0izrfm9NwADtEHIjllevJMUFODhwNidf/rqnqtX+392eLz9Yd/ITovcgcxpHeAW
         oTYs6jrUbVSk4uxKsgaf3PINDpmqCgM7RIjzQPDTWSI8L+koa0X72iZz1fpeAnDWIfhP
         sL8Q==
X-Gm-Message-State: AOJu0YzqS7X8TiJ2a/oKiWjHD9HVLn1ya7ggCp0MdHa0Nq68dMaKHC3S
	4bzq/rX94yWcx1OBYf8iFfD+XGer7fppiYOcPDuwtkjNPftkn/xNh3PifzdYHuVgyyX8XRrE3ee
	CtvjZiyStAmAdDDtmXWsBBBNvy9yG52XHWyz7
X-Gm-Gg: ASbGncszEGcVSz+H6MgHg8GIZk0JvfcjvUj+b9K2S5WI0xCFUqbU24CA5TNALE4mEQR
	jxnlvBfhrTh3VrqS89AbdtJ3NQflhcafreSxqvHd7+FaAUY32JvTNoTUhq3D8m0HsLyjSGktMVx
	rK4vWtuM3SvO+ktzrsTNuxtqYn8nGozu0cAE5EkXKJyqw8obAhci2bJVqFbRdgSgS2zQ2zEouDn
	pm4sicgT9zpTcUFJ0aTO99UpyZUEaIg4B925dix
X-Google-Smtp-Source: AGHT+IGDt8OD6lLyfKc26Nts7yigo2k7Oov6G8oW+e4lYZWE051ABaZX4gKuOQS4UXKJYjBmQGFuPa5ZCmHk5cGhXEQ=
X-Received: by 2002:a05:6102:c0b:b0:4fb:def3:d27c with SMTP id
 ada2fe7eead31-4fdc4312c31mr1409782137.22.1754218791952; Sun, 03 Aug 2025
 03:59:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: daniel antoine <univac55@gmail.com>
Date: Sun, 3 Aug 2025 12:59:40 +0200
X-Gm-Features: Ac12FXyDPSIkB8tmM7K15nuRxYt_sI0cL6HYDDH1iuBErRNUyRAH7naTLxVaep0
Message-ID: <CA+iibzA3ZSfvbF51EC8H1JqHm+w1oW8WeRBvkeFVfSi4NhkGYA@mail.gmail.com>
Subject: Received error during CMD_TRIGGER_SCAN: Operation not supported (95)
To: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi
I have a random problem when my laptop connects with my livebox by
wifi. The connection works but takes some time 5 to 10 s to reach the
online state. And from time to time this error is present Received
error during CMD_TRIGGER_SCAN: Operation not supported (95). The wifi
device is 04:00.0 Network controller: MEDIATEK Corp. MT7921K (RZ608)
Wi-Fi 6E 80MHz . The linux-firmware package is the last version of
linux-firmware 20250708. I have added the -d option to get the logs.

ao=C3=BBt 03 11:52:29 grat-os1 iwd[476]: Received error during
CMD_TRIGGER_SCAN: Operation not supported (95)
ao=C3=BBt 03 12:34:22 grat-os1 iwd[476]: Terminate
ao=C3=BBt 03 12:34:22 grat-os1 iwd[476]: Removing scan context for wdev 2
ao=C3=BBt 03 12:34:22 grat-os1 iwd[476]: D-Bus disconnected, quitting...
ao=C3=BBt 03 12:34:23 grat-os1 iwd[476]: Removing scan context for wdev 3
ao=C3=BBt 03 12:34:23 grat-os1 systemd[1]: iwd.service: Deactivated success=
fully.
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]: Wireless daemon version 3.9
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]: src/main.c:main() Using
configuration directory /etc/iwd
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:
src/storage.c:storage_create_dirs() Using state directory /var/lib/iwd
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]: src/main.c:nl80211_appeared()
Found nl80211 interface
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]: src/module.c:iwd_modules_init()
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]: station: Network configuration is =
disabled.
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]: src/wsc.c:wsc_init()
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]: src/udev.c:udev_init()
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]: src/eap.c:__eap_method_enable()
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]: src/eap-wsc.c:eap_wsc_init()
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]: src/eap-md5.c:eap_md5_init()
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]: src/eap-tls.c:eap_tls_init()
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]: src/eap-ttls.c:eap_ttls_init()
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]: src/eap-mschapv2.c:eap_mschapv2_in=
it()
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]: src/eap-sim.c:eap_sim_init()
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]: src/eap-aka.c:eap_aka_prime_init()
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]: src/eap-aka.c:eap_aka_init()
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]: src/eap-peap.c:eap_peap_init()
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]: src/eap-gtc.c:eap_gtc_init()
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]: src/eap-pwd.c:eap_pwd_init()
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:
src/manager.c:manager_wiphy_dump_callback() New wiphy phy0 added (0)
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]: src/netdev.c:netdev_link_notify()
event 16 on ifindex 2
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]: src/netdev.c:netdev_link_notify()
event 16 on ifindex 2
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]: src/netdev.c:netdev_link_notify()
event 16 on ifindex 4
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]: src/manager.c:manager_wiphy_dump_d=
one()
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:
src/manager.c:manager_filtered_wiphy_dump_done()
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]: Wiphy: 0, Name: phy0
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:         Permanent Address: 50:c2:e=
8:0b
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:         2.4GHz Band:
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:                 Bitrates (non-HT):
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:                          1.0 Mbps
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:                          2.0 Mbps
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:                          5.5 Mbps
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:                         11.0 Mbps
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:                          6.0 Mbps
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:                          9.0 Mbps
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:                         12.0 Mbps
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:                         18.0 Mbps
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:                         24.0 Mbps
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:                         36.0 Mbps
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:                         48.0 Mbps
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:                         54.0 Mbps
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:                 HT Capabilities:
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:                         HT40
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:                         Short GI f=
or 20Mhz
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:                         Short GI f=
or 40Mhz
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:                 HT RX MCS indexes:
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:                         0-15
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:                 HE Capabilities
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:                         Interface =
Types: ap
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:                         Max HE RX
<=3D 80MHz MCS: 0-11 for NSS: 2
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:                         Max HE TX
<=3D 80MHz MCS: 0-11 for NSS: 2
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:                         Interface
Types: station
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:                         Max HE RX
<=3D 80MHz MCS: 0-11 for NSS: 2
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:                         Max HE TX
<=3D 80MHz MCS: 0-11 for NSS: 2
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:         5GHz Band:
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:                 Bitrates (non-HT):
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:                          6.0 Mbps
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:                          9.0 Mbps
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:                         12.0 Mbps
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:                         18.0 Mbps
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:                         24.0 Mbps
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:                         36.0 Mbps
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:                         48.0 Mbps
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:                         54.0 Mbps
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:                 HT Capabilities:
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:                         HT40
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:                         Short GI f=
or 20Mhz
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:                         Short GI f=
or 40Mhz
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:                 HT RX MCS indexes:
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:                         0-15
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:                 VHT Capabilities:
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:                         Short GI f=
or 80Mhz
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:                         Max RX
MCS: 0-9 for NSS: 2
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:                         Max TX
MCS: 0-9 for NSS: 2
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:                 HE Capabilities
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:                         Interface =
Types: ap
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:                         Max HE RX
<=3D 80MHz MCS: 0-11 for NSS: 2
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:                         Max HE TX
<=3D 80MHz MCS: 0-11 for NSS: 2
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:                         Interface
Types: station
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:                         Max HE RX
<=3D 80MHz MCS: 0-11 for NSS: 2
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:                         Max HE TX
<=3D 80MHz MCS: 0-11 for NSS: 2
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:         6GHz Band:
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:                 Bitrates (non-HT):
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:                          6.0 Mbps
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:                          9.0 Mbps
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:                         12.0 Mbps
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:                         18.0 Mbps
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:                         24.0 Mbps
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:                         36.0 Mbps
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:                         48.0 Mbps
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:                         54.0 Mbps
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:                 HE Capabilities
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:                         Interface =
Types: ap
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:                         Max HE RX
<=3D 80MHz MCS: 0-11 for NSS: 2
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:                         Max HE TX
<=3D 80MHz MCS: 0-11 for NSS: 2
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:                         Interface
Types: station
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:                         Max HE RX
<=3D 80MHz MCS: 0-11 for NSS: 2
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:                         Max HE TX
<=3D 80MHz MCS: 0-11 for NSS: 2
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:         Ciphers: BIP-CMAC-256
BIP-GMAC-256 BIP-GMAC-128 CCMP-256
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:                  GCMP-256 GCMP-128
BIP-CMAC-128 CCMP-128
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:                  TKIP
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:         Supported iftypes: station
ap p2p-client p2p-go p2p-device
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]: udev interface=3Dvirbr0 ifindex=3D=
4
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]: src/agent.c:agent_register() agent
register called
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]: src/agent.c:agent_register() agent
:1.6 path /net/connman/iwd_agent
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:
src/manager.c:manager_interface_dump_callback()
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]: src/manager.c:manager_get_interfac=
e_cb()
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]: src/manager.c:manager_get_interfac=
e_cb()
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]: src/manager.c:manager_interface_du=
mp_done()
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:
src/wiphy.c:wiphy_update_reg_domain() New reg domain country code for
(global) is FR
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:
src/manager.c:manager_config_notify() Notification of command Del
Interface(8)
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]: src/netdev.c:netdev_link_notify()
event 17 on ifindex 3
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]: src/manager.c:manager_del_interfac=
e_cb()
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:
src/manager.c:manager_create_interfaces() creating wlan0
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:
src/manager.c:manager_create_interfaces() creating wlan0-p2p
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:
src/manager.c:manager_config_notify() Notification of command New
Interface(7)
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]: src/netdev.c:netdev_link_notify()
event 16 on ifindex 5
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:
src/manager.c:manager_new_station_interface_cb()
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:
src/netdev.c:netdev_create_from_genl() Created interface wlan0[5 2]
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:
src/manager.c:manager_config_notify() Notification of command New
Interface(7)
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]: src/manager.c:manager_new_p2p_inte=
rface_cb()
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:
src/p2p.c:p2p_device_update_from_genl() Created P2P device 3
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]: src/netdev.c:netdev_link_notify()
event 16 on ifindex 5
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]: src/netdev.c:netdev_set_4addr()
netdev: 5 use_4addr: 0
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:
src/netdev.c:netdev_initial_up_cb() Interface 5 initialized
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]: event: state, old: disconnected,
new: autoconnect_quick
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:
src/wiphy.c:wiphy_radio_work_insert() Inserting work item 1
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:
src/wiphy.c:wiphy_radio_work_next() Starting work item 1
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]: src/rrm.c:rrm_add_frame_watches()
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]: src/netdev.c:netdev_link_notify()
event 16 on ifindex 5
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]: src/netdev.c:netdev_link_notify()
event 16 on ifindex 5
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:
src/manager.c:manager_config_notify() Notification of command Set
Interface(6)
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]: src/scan.c:scan_notify() Scan
notification Trigger Scan(33)
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:
src/scan.c:scan_request_triggered() Active scan triggered for wdev 2
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:
src/station.c:station_quick_scan_triggered() Quick scan triggered for
wlan0
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]: udev interface=3Dwlan0 ifindex=3D5
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]: src/netdev.c:netdev_link_notify()
event 16 on ifindex 4
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]: src/scan.c:scan_notify() Scan
notification New Scan Results(34)
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]: src/netdev.c:netdev_link_notify()
event 16 on ifindex 5
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]: src/scan.c:scan_notify() Scan
notification Trigger Scan(33)
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:
src/scan.c:scan_request_triggered() Active scan triggered for wdev 2
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]: src/scan.c:scan_notify() Scan
notification New Scan Results(34)
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]: src/netdev.c:netdev_link_notify()
event 16 on ifindex 5
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]: src/station.c:station_autoconnect_=
start()
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]: event: state, old:
autoconnect_quick, new: autoconnect_full
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]: src/scan.c:scan_periodic_start()
Starting periodic scan for wdev 2
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:
src/wiphy.c:wiphy_radio_work_insert() Inserting work item 2
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:
src/wiphy.c:wiphy_radio_work_done() Work item 1 done
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:
src/wiphy.c:wiphy_radio_work_next() Starting work item 2
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]: src/scan.c:scan_notify() Scan
notification Trigger Scan(33)
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:
src/scan.c:scan_request_triggered() Passive scan triggered for wdev 2
ao=C3=BBt 03 12:34:37 grat-os1 iwd[476]:
src/scan.c:scan_periodic_triggered() Periodic scan triggered for wdev
2
ao=C3=BBt 03 12:34:38 grat-os1 iwd[476]: src/scan.c:scan_notify() Scan
notification New Scan Results(34)
ao=C3=BBt 03 12:34:38 grat-os1 iwd[476]: src/netdev.c:netdev_link_notify()
event 16 on ifindex 5
ao=C3=BBt 03 12:34:38 grat-os1 iwd[476]: src/scan.c:scan_notify() Scan
notification Trigger Scan(33)
ao=C3=BBt 03 12:34:38 grat-os1 iwd[476]:
src/scan.c:scan_request_triggered() Passive scan triggered for wdev 2
ao=C3=BBt 03 12:34:40 grat-os1 iwd[476]: src/scan.c:scan_notify() Scan
notification New Scan Results(34)
ao=C3=BBt 03 12:34:40 grat-os1 iwd[476]: src/netdev.c:netdev_link_notify()
event 16 on ifindex 5
ao=C3=BBt 03 12:34:40 grat-os1 iwd[476]: src/scan.c:scan_periodic_rearm()
Arming periodic scan timer: 10
ao=C3=BBt 03 12:34:40 grat-os1 iwd[476]:
src/station.c:station_print_scan_bss() Processing BSS '10:e9:92:c with
SSID: Livebox-5C, freq: 2462, rank: 591, strength: -4600, data_rate:
72.2, load: 17/255, clients: 0
ao=C3=BBt 03 12:34:40 grat-os1 iwd[476]:
src/station.c:station_add_seen_bss() Added new Network "Livebox-5C"
security psk
ao=C3=BBt 03 12:34:40 grat-os1 iwd[476]: src/station.c:station_autoconnect_=
start()
ao=C3=BBt 03 12:34:40 grat-os1 iwd[476]:
src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
Livebox-5C
ao=C3=BBt 03 12:34:40 grat-os1 iwd[476]:
src/station.c:station_autoconnect_next() autoconnect: '10:e9:92' freq:
2462, rank: 591, strength: -4600
ao=C3=BBt 03 12:34:40 grat-os1 iwd[476]:
src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: Operation not permitted (-1)
ao=C3=BBt 03 12:34:40 grat-os1 iwd[476]:
src/wiphy.c:wiphy_radio_work_done() Work item 2 done
ao=C3=BBt 03 12:34:50 grat-os1 iwd[476]: src/scan.c:scan_periodic_timeout()=
 2
ao=C3=BBt 03 12:34:50 grat-os1 iwd[476]:
src/wiphy.c:wiphy_radio_work_insert() Inserting work item 3
ao=C3=BBt 03 12:34:50 grat-os1 iwd[476]:
src/wiphy.c:wiphy_radio_work_next() Starting work item 3
ao=C3=BBt 03 12:34:50 grat-os1 iwd[476]: src/scan.c:scan_notify() Scan
notification Trigger Scan(33)
ao=C3=BBt 03 12:34:50 grat-os1 iwd[476]:
src/scan.c:scan_request_triggered() Passive scan triggered for wdev 2
ao=C3=BBt 03 12:34:50 grat-os1 iwd[476]:
src/scan.c:scan_periodic_triggered() Periodic scan triggered for wdev
2
ao=C3=BBt 03 12:34:50 grat-os1 iwd[476]: src/scan.c:scan_notify() Scan
notification New Scan Results(34)
ao=C3=BBt 03 12:34:50 grat-os1 iwd[476]: src/netdev.c:netdev_link_notify()
event 16 on ifindex 5
ao=C3=BBt 03 12:34:50 grat-os1 iwd[476]: src/scan.c:scan_notify() Scan
notification Trigger Scan(33)
ao=C3=BBt 03 12:34:50 grat-os1 iwd[476]:
src/scan.c:scan_request_triggered() Passive scan triggered for wdev 2
ao=C3=BBt 03 12:34:52 grat-os1 iwd[476]: src/scan.c:scan_notify() Scan
notification New Scan Results(34)
ao=C3=BBt 03 12:34:52 grat-os1 iwd[476]: src/netdev.c:netdev_link_notify()
event 16 on ifindex 5
ao=C3=BBt 03 12:34:52 grat-os1 iwd[476]: src/scan.c:scan_periodic_rearm()
Arming periodic scan timer: 20
ao=C3=BBt 03 12:34:52 grat-os1 iwd[476]:
src/station.c:station_print_scan_bss() Processing BSS '10:e9:92:' with
SSID: Livebox-5C freq: 5520, rank: 7093, strength: -4000, data_rate:
866.7, load: 11/255, clients: 4
ao=C3=BBt 03 12:34:52 grat-os1 iwd[476]:
src/station.c:station_print_scan_bss() Processing BSS '10:e9:92:' with
SSID: Livebox-5C, freq: 2462, rank: 591, strength: -4600, data_rate:
72.2, load: 15/255, clients: 0
ao=C3=BBt 03 12:34:52 grat-os1 iwd[476]:
src/station.c:station_print_scan_bss() Processing BSS
'6c:61:f4:68:f9:5d' with SSID: SFR_F958_5GHZ, freq: 5180, rank: 16,
strength: -9200, data_rate: 2.0, load: 3/255, clients: 1
ao=C3=BBt 03 12:34:52 grat-os1 iwd[476]:
src/station.c:station_add_seen_bss() Added new Network "SFR_F958_5GHZ"
security psk
ao=C3=BBt 03 12:34:52 grat-os1 iwd[476]:
src/station.c:station_print_scan_bss() Processing BSS
'62:61:f4:68:f9:5f' with SSID: SFR_F958, freq: 5180, rank: 16,
strength: -9300, data_rate: 2.0, load: 3/255, clients: 1
ao=C3=BBt 03 12:34:52 grat-os1 iwd[476]:
src/station.c:station_add_seen_bss() Added new Network "SFR_F958"
security psk
ao=C3=BBt 03 12:34:52 grat-os1 iwd[476]: src/station.c:station_autoconnect_=
start()
ao=C3=BBt 03 12:34:52 grat-os1 iwd[476]:
src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
Livebox-5C
ao=C3=BBt 03 12:34:52 grat-os1 iwd[476]:
src/station.c:station_autoconnect_next() autoconnect: '10:e9:92 freq:
5520, rank: 7093, strength: -4000
ao=C3=BBt 03 12:34:52 grat-os1 iwd[476]: src/netdev.c:netdev_cqm_rssi_updat=
e()
ao=C3=BBt 03 12:34:52 grat-os1 iwd[476]:
src/wiphy.c:wiphy_radio_work_insert() Inserting work item 4
ao=C3=BBt 03 12:34:52 grat-os1 iwd[476]: event: connect-info, ssid:
Livebox-5C, bss: 10:e9:92:, signal: -40, load: 11/255
ao=C3=BBt 03 12:34:52 grat-os1 iwd[476]: event: state, old:
autoconnect_full, new: connecting (auto)
ao=C3=BBt 03 12:34:52 grat-os1 iwd[476]: src/scan.c:scan_periodic_stop()
Stopping periodic scan for wdev 2
ao=C3=BBt 03 12:34:52 grat-os1 iwd[476]: src/scan.c:scan_cancel() Trying to
cancel scan id 3 for wdev 2
ao=C3=BBt 03 12:34:52 grat-os1 iwd[476]:
src/wiphy.c:wiphy_radio_work_done() Work item 3 done
ao=C3=BBt 03 12:34:52 grat-os1 iwd[476]:
src/wiphy.c:wiphy_radio_work_next() Starting work item 4
ao=C3=BBt 03 12:34:53 grat-os1 iwd[476]: src/netdev.c:netdev_mlme_notify()
MLME notification New Station(19)
ao=C3=BBt 03 12:34:53 grat-os1 iwd[476]: src/netdev.c:netdev_mlme_notify()
MLME notification Authenticate(37)
ao=C3=BBt 03 12:34:53 grat-os1 iwd[476]: src/netdev.c:netdev_authenticate_e=
vent()
ao=C3=BBt 03 12:34:53 grat-os1 iwd[476]: src/netdev.c:netdev_mlme_notify()
MLME notification Associate(38)
ao=C3=BBt 03 12:34:53 grat-os1 iwd[476]: src/netdev.c:netdev_associate_even=
t()
ao=C3=BBt 03 12:34:53 grat-os1 iwd[476]: src/netdev.c:netdev_link_notify()
event 16 on ifindex 5
ao=C3=BBt 03 12:34:53 grat-os1 iwd[476]: src/netdev.c:netdev_mlme_notify()
MLME notification Connect(46)
ao=C3=BBt 03 12:34:53 grat-os1 iwd[476]: src/netdev.c:netdev_connect_event(=
)
ao=C3=BBt 03 12:34:53 grat-os1 iwd[476]:
src/netdev.c:netdev_connect_event() aborting and ignore_connect_event
not set, proceed
ao=C3=BBt 03 12:34:53 grat-os1 iwd[476]:
src/netdev.c:netdev_connect_event() expect_connect_failure not set,
proceed
ao=C3=BBt 03 12:34:53 grat-os1 iwd[476]: src/netdev.c:parse_request_ies()
ao=C3=BBt 03 12:34:53 grat-os1 iwd[476]:
src/netdev.c:netdev_connect_event() Request / Response IEs parsed
ao=C3=BBt 03 12:34:53 grat-os1 iwd[476]: src/netdev.c:netdev_get_oci()
ao=C3=BBt 03 12:34:53 grat-os1 iwd[476]: src/netdev.c:netdev_link_notify()
event 16 on ifindex 5
ao=C3=BBt 03 12:34:53 grat-os1 iwd[476]: src/netdev.c:netdev_link_notify()
event 16 on ifindex 5
ao=C3=BBt 03 12:34:53 grat-os1 iwd[476]: src/netdev.c:netdev_get_oci_cb()
Obtained OCI: freq: 5520, width: 3, center1: 5530, center2: 0
ao=C3=BBt 03 12:34:53 grat-os1 iwd[476]: src/eapol.c:eapol_start()
ao=C3=BBt 03 12:34:53 grat-os1 iwd[476]:
src/station.c:station_handshake_event() Handshaking
ao=C3=BBt 03 12:34:53 grat-os1 iwd[476]: src/netdev.c:netdev_link_notify()
event 16 on ifindex 5
ao=C3=BBt 03 12:34:54 grat-os1 iwd[476]:
src/netdev.c:netdev_unicast_notify() Unicast notification Control Port
Frame(129)
ao=C3=BBt 03 12:34:54 grat-os1 iwd[476]:
src/netdev.c:netdev_control_port_frame_event()
ao=C3=BBt 03 12:34:54 grat-os1 iwd[476]:
src/eapol.c:eapol_handle_ptk_1_of_4() ifindex=3D5
ao=C3=BBt 03 12:34:54 grat-os1 iwd[476]: src/netdev.c:netdev_mlme_notify()
MLME notification Control Port TX Status(139)
ao=C3=BBt 03 12:34:54 grat-os1 iwd[476]:
src/netdev.c:netdev_unicast_notify() Unicast notification Control Port
Frame(129)
ao=C3=BBt 03 12:34:54 grat-os1 iwd[476]:
src/netdev.c:netdev_control_port_frame_event()
ao=C3=BBt 03 12:34:54 grat-os1 iwd[476]:
src/eapol.c:eapol_handle_ptk_3_of_4() ifindex=3D5
ao=C3=BBt 03 12:34:54 grat-os1 iwd[476]: src/netdev.c:netdev_set_gtk()
ifindex=3D5 key_idx=3D1
ao=C3=BBt 03 12:34:54 grat-os1 iwd[476]:
src/station.c:station_handshake_event() Setting keys
ao=C3=BBt 03 12:34:54 grat-os1 iwd[476]: src/netdev.c:netdev_set_tk()
ifindex=3D5 key_idx=3D0
ao=C3=BBt 03 12:34:54 grat-os1 iwd[476]: src/netdev.c:netdev_set_rekey_offl=
oad() 5
ao=C3=BBt 03 12:34:54 grat-os1 iwd[476]:
src/netdev.c:netdev_new_group_key_cb() ifindex: 5, err: 0
ao=C3=BBt 03 12:34:54 grat-os1 iwd[476]:
src/netdev.c:try_handshake_complete() ptk_installed: 0, gtk_installed:
1, igtk_installed: 1
ao=C3=BBt 03 12:34:54 grat-os1 iwd[476]: src/netdev.c:netdev_mlme_notify()
MLME notification Control Port TX Status(139)
ao=C3=BBt 03 12:34:54 grat-os1 iwd[476]: src/netdev.c:netdev_set_station_cb=
()
ao=C3=BBt 03 12:34:54 grat-os1 iwd[476]:
src/netdev.c:try_handshake_complete() ptk_installed: 1, gtk_installed:
1, igtk_installed: 1
ao=C3=BBt 03 12:34:54 grat-os1 iwd[476]:
src/netdev.c:try_handshake_complete() nhs->complete: 0
ao=C3=BBt 03 12:34:54 grat-os1 iwd[476]:
src/netdev.c:try_handshake_complete() Invoking handshake_event()
ao=C3=BBt 03 12:34:54 grat-os1 iwd[476]:
src/handshake.c:handshake_state_cache_pmksa() No PMKSA for
10:e9:92:c0:73:75
ao=C3=BBt 03 12:34:54 grat-os1 iwd[476]: src/netdev.c:netdev_connect_ok()
ao=C3=BBt 03 12:34:54 grat-os1 iwd[476]: src/station.c:station_connect_cb()
5, result: 0
ao=C3=BBt 03 12:34:54 grat-os1 iwd[476]: src/station.c:station_connect_ok()
ao=C3=BBt 03 12:34:54 grat-os1 iwd[476]: event: state, old: connecting
(auto), new: connected
ao=C3=BBt 03 12:34:54 grat-os1 iwd[476]:
src/wiphy.c:wiphy_radio_work_done() Work item 4 done
ao=C3=BBt 03 12:34:54 grat-os1 iwd[476]: src/netdev.c:netdev_link_notify()
event 16 on ifindex 5
ao=C3=BBt 03 12:34:54 grat-os1 iwd[476]: src/netdev.c:netdev_mlme_notify()
MLME notification Frame TX Status(60)
ao=C3=BBt 03 12:34:54 grat-os1 iwd[476]:
src/netdev.c:netdev_unicast_notify() Unicast notification Frame(59)
ao=C3=BBt 03 12:34:54 grat-os1 iwd[476]: src/netdev.c:netdev_mlme_notify()
MLME notification Frame TX Status(60)
ao=C3=BBt 03 12:34:54 grat-os1 iwd[476]:
src/station.c:station_early_neighbor_report_cb() ifindex: 5, error:
0()
ao=C3=BBt 03 12:34:54 grat-os1 iwd[476]:
src/netdev.c:netdev_unicast_notify() Unicast notification Frame(59)
ao=C3=BBt 03 12:34:56 grat-os1 iwd[476]: src/netdev.c:netdev_mlme_notify()
MLME notification Notify CQM(64)
ao=C3=BBt 03 12:34:56 grat-os1 iwd[476]: src/netdev.c:netdev_cqm_event()
Signal change event (above=3D1 signal=3D-45)
ao=C3=BBt 03 12:34:59 grat-os1 iwd[476]: src/netdev.c:netdev_mlme_notify()
MLME notification Notify CQM(64)
ao=C3=BBt 03 12:34:59 grat-os1 iwd[476]: src/netdev.c:netdev_cqm_event()
Signal change event (above=3D1 signal=3D-46)
ao=C3=BBt 03 12:35:02 grat-os1 iwd[476]: src/netdev.c:netdev_mlme_notify()
MLME notification Notify CQM(64)
ao=C3=BBt 03 12:35:02 grat-os1 iwd[476]: src/netdev.c:netdev_cqm_event()
Signal change event (above=3D1 signal=3D-46)
ao=C3=BBt 03 12:35:05 grat-os1 iwd[476]: src/netdev.c:netdev_mlme_notify()
MLME notification Notify CQM(64)
ao=C3=BBt 03 12:35:05 grat-os1 iwd[476]: src/netdev.c:netdev_cqm_event()
Signal change event (above=3D1 signal=3D-48)
ao=C3=BBt 03 12:35:08 grat-os1 iwd[476]: src/netdev.c:netdev_mlme_notify()
MLME notification Notify CQM(64)
ao=C3=BBt 03 12:35:08 grat-os1 iwd[476]: src/netdev.c:netdev_cqm_event()
Signal change event (above=3D1 signal=3D-46)
ao=C3=BBt 03 12:35:11 grat-os1 iwd[476]: src/netdev.c:netdev_mlme_notify()
MLME notification Notify CQM(64)
ao=C3=BBt 03 12:35:11 grat-os1 iwd[476]: src/netdev.c:netdev_cqm_event()
Signal change event (above=3D1 signal=3D-49)
ao=C3=BBt 03 12:35:14 grat-os1 iwd[476]: src/netdev.c:netdev_mlme_notify()
MLME notification Notify CQM(64)
ao=C3=BBt 03 12:35:14 grat-os1 iwd[476]: src/netdev.c:netdev_cqm_event()
Signal change event (above=3D1 signal=3D-49)
ao=C3=BBt 03 12:35:17 grat-os1 iwd[476]: src/netdev.c:netdev_mlme_notify()
MLME notification Notify CQM(64)
ao=C3=BBt 03 12:35:17 grat-os1 iwd[476]: src/netdev.c:netdev_cqm_event()
Signal change event (above=3D1 signal=3D-47)
root@grat-os1:~#

I have had some problem in the past with the command CMD_SET_CQM and
patches has been installed to resolve it

I will tried to get more information as the problem is really random

Best regards

Daniel
