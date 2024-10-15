Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614481C3F0A
	for <iwd@lists.linux.dev>; Tue, 15 Oct 2024 08:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728982634; cv=none; b=tWdItuBG39/vhNIXg2dG4hl4xlIe2F3Lc4S55qBzU9sB/ILnxqPe77xWAo/5mQxwG8EgBzztbAAdXDdqCgc1iUZiMZGCm26K30TBC/Vz+kqcM4IqCbGmYlV5jxYN41NRkVm6iPPBNG/WE7zKE5ZMZ+9qtLFBPV9N1M1lj7xREm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728982634; c=relaxed/simple;
	bh=QxsasNLdc9RdIsxy6CkBha3FqmjzSifcJ6YdxFMXU3o=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=iS+4g1bQ4cxUfqWNb7chmFW4Ga7y+OXDethgJR+hIIChP5zMBBPPvBNOwqfV3xA5WFeYNhVg8Unt0isT9FjdLqLEI0H7/0Z60mTzNdh3PHCGB++h86OIGFWVlZ4ggB24K17lia2KDBVvt4fbKKW5U80eOq9n/9Pf/WYjjALNrnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K197VBz8; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K197VBz8"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2fb59652cb9so10183261fa.3
        for <iwd@lists.linux.dev>; Tue, 15 Oct 2024 01:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728982630; x=1729587430; darn=lists.linux.dev;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=n2ct+XiUssvLiBYqGZBZrj/PLjgxrvbgzV5ODE34/84=;
        b=K197VBz805ORskXZ4sX0IbIc0dDG3npZ5F9GQ7jwzHjDC2zus4WNfJeQeezQW/K7ts
         y2lkYDNzFy6Rcub2dwxsyn+MHWNAATZw9VXVcZ4gIx9ChV7xaiWTAHoIwzpSbpu7x21e
         EkdOlpOfM4Kpy/6XWJFI8lsVPQaMaOtofIs8eQroB1ub/Vt/PmqHLFFee+SwKUdyTCY/
         ttsUDfsc9WxCTnPujLHxizWlTCBS26F8IH4T9yydt2vjxLlq8TYhKmd4wpteDR9YKiiL
         9sdRBGDlgxeNvyLHZwwkuWCCGn2WoTPQjtU/h5AfleM1eOumHoX4nfXcsf/PNCPWopyq
         A7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728982630; x=1729587430;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n2ct+XiUssvLiBYqGZBZrj/PLjgxrvbgzV5ODE34/84=;
        b=Es8KezeCOiwFI7E53hAr5UpUnrcZ/SpD0yZ2yN2vw1bpIHG10dXb1vqxhQehjgqwek
         Fg/en/St86lRfxr6ictdaYqZW4oGtsJPkrS5MqhL8Rc5bf/sh7bpGMOTqJDP00cwt5DU
         NwQp3rPa0gKftSPJ6FU2X9yXry0djLVIrbAPxHObAF+tM/YV8kRCE6USmER99b/LXFpW
         rr01Ubikf+d4BwLsMmtWzTePJynv1kXfmFgSBUJfuOAPE26wM7wnl6GAQmtRNvdSub2B
         lCC9LEX9jOFDvoWXWMFR4kkg22QtZb3Iw2u09wf+VCMJ09Edf1K/d7AoIle/e5Ngc5XC
         +htQ==
X-Gm-Message-State: AOJu0YyMRX7KjEd4GXMEvNcCZ3dkIVfx5zb8Eym6vXBSxQVAnrgqUuXH
	1yPRPi7ARtw4UgYCPRfDpbvUf+zEb71mGQOq2rTPcxKBnApSu35AULr8PA==
X-Google-Smtp-Source: AGHT+IFNdsWVaTqvGEmJl083olcs0VjzClAJPN2k56+bDzeq7IIxjliDUxls/WJv1d+fuB+DNucy4w==
X-Received: by 2002:a05:651c:1547:b0:2fb:3e40:a924 with SMTP id 38308e7fff4ca-2fb3e40aaf7mr40471611fa.5.1728982628640;
        Tue, 15 Oct 2024 01:57:08 -0700 (PDT)
Received: from smtpclient.apple (89-73-96-21.dynamic.chello.pl. [89.73.96.21])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb5d135e86sm1097641fa.70.2024.10.15.01.57.06
        for <iwd@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2024 01:57:07 -0700 (PDT)
From: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: iwd 2.22 scan fails but... works ok with ConnMan
Message-Id: <CF5A13CE-18AF-4A33-98F9-13FA353657C4@gmail.com>
Date: Tue, 15 Oct 2024 10:56:55 +0200
To: iwd@lists.linux.dev
X-Mailer: Apple Mail (2.3776.700.51.11.1)

Hi,

I=E2=80=99m using iwd 2.22 as default way of automated wifi connection =
in my project (https://github.com/warpme/minimyth2)

Some of my users started to report issues about not able to establish =
wifi connections.
I asked to do 1st step verification: launch ConnMan =
(https://wiki.archlinux.org/title/ConnMan) to verify is HW working ok.

With ConnMan users are able to connect so HW is OK.
It looks to me like issue is specific to iwd.

With iwd log says like below.

May somebody from iwd team help me to solve this issue?
=20

Wireless daemon version 2.22
src/main.c:main() Using configuration directory /etc/iwd
Loaded configuration from /etc/iwd/main.conf
src/storage.c:storage_create_dirs() Using state directory /var/lib/iwd
src/main.c:nl80211_appeared() Found nl80211 interface
src/module.c:iwd_modules_init()
station: Network configuration is disabled.
src/knownnetworks.c:known_network_frequencies_load() No known frequency =
file found.
src/wsc.c:wsc_init()
src/eap.c:__eap_method_enable()
src/eap-wsc.c:eap_wsc_init()
src/eap-ttls.c:eap_ttls_init()
src/eap-tls.c:eap_tls_init()
src/eap-md5.c:eap_md5_init()
src/eap-pwd.c:eap_pwd_init()
src/eap-gtc.c:eap_gtc_init()
src/eap-peap.c:eap_peap_init()
src/eap-aka.c:eap_aka_prime_init()
src/eap-aka.c:eap_aka_init()
src/eap-sim.c:eap_sim_init()
src/eap-mschapv2.c:eap_mschapv2_init()
src/udev.c:udev_init()
src/manager.c:manager_wiphy_dump_callback() New wiphy phy0 added (0)
src/manager.c:manager_wiphy_dump_done()
src/manager.c:manager_filtered_wiphy_dump_done()
Wiphy: 0, Name: phy0
        Permanent Address: 00:00:00:00:00:00
        2.4GHz Band:
                Bitrates (non-HT):
                         1.0 Mbps
                         2.0 Mbps
                         5.5 Mbps
                        11.0 Mbps
                         6.0 Mbps
                         9.0 Mbps
                        12.0 Mbps
                        18.0 Mbps
                        24.0 Mbps
                        36.0 Mbps
                        48.0 Mbps
                        54.0 Mbps
                         6.5 Mbps
                        13.0 Mbps
                        19.5 Mbps
                        26.0 Mbps
                        39.0 Mbps
                        52.0 Mbps
                        58.5 Mbps
                        13.0 Mbps
                        26.0 Mbps
                        39.0 Mbps
                        52.0 Mbps
                HT Capabilities:
                        HT40
                        Short GI for 20Mhz
                        Short GI for 40Mhz
                HT RX MCS indexes:
                        0-7
                HT TX MCS set undefined
        5GHz Band:
                Bitrates (non-HT):
                         6.0 Mbps
                         9.0 Mbps
                        12.0 Mbps
                        18.0 Mbps
                        24.0 Mbps
                        36.0 Mbps
                        48.0 Mbps
                        54.0 Mbps
                         6.5 Mbps
                        13.0 Mbps
                        19.5 Mbps
                        26.0 Mbps
                        39.0 Mbps
                        52.0 Mbps
                        58.5 Mbps
                        13.0 Mbps
                        26.0 Mbps
                        39.0 Mbps
                        52.0 Mbps
                HT Capabilities:
                        HT40
                        Short GI for 20Mhz
                        Short GI for 40Mhz
                HT RX MCS indexes:
                        0-7
                HT TX MCS set undefined
                VHT Capabilities:
                        Short GI for 80Mhz
                        Max RX MCS: 0-9 for NSS: 1
                        Max TX MCS: 0-9 for NSS: 1
        Ciphers: BIP-CMAC-128 CCMP-128 TKIP
        Supported iftypes: ad-hoc station ap p2p-client p2p-go =
p2p-device
Wiphy phy0 will only use the default interface
src/manager.c:manager_interface_dump_callback()
src/manager.c:manager_get_interface_cb()
src/manager.c:manager_interface_dump_done()
src/manager.c:manager_use_default()
src/netdev.c:netdev_create_from_genl() Created interface wlan0[3 1]
src/wiphy.c:wiphy_update_reg_domain() New reg domain country code for =
phy0 is 00
src/netdev.c:netdev_link_notify() event 16 on ifindex 3
src/netdev.c:netdev_set_4addr() netdev: 3 use_4addr: 0
src/netdev.c:netdev_initial_up_cb() Interface 3 initialized
event: state, old: disconnected, new: autoconnect_quick
src/scan.c:scan_periodic_start() Starting periodic scan for wdev 1
src/wiphy.c:wiphy_radio_work_insert() Inserting work item 1
src/wiphy.c:wiphy_radio_work_next() Starting work item 1
src/rrm.c:rrm_add_frame_watches()
src/netdev.c:netdev_link_notify() event 16 on ifindex 3
Could not register frame watch type 00b0: -22
src/manager.c:manager_config_notify() Notification of command Set =
Interface(6)
src/scan.c:scan_periodic_rearm() Arming periodic scan timer: 10
src/wiphy.c:wiphy_radio_work_done() Work item 1 done
Received error during CMD_TRIGGER_SCAN: Invalid argument (22)
src/scan.c:scan_periodic_timeout() 1
src/wiphy.c:wiphy_radio_work_insert() Inserting work item 2
src/wiphy.c:wiphy_radio_work_next() Starting work item 2
src/scan.c:scan_periodic_rearm() Arming periodic scan timer: 20
src/wiphy.c:wiphy_radio_work_done() Work item 2 done
Received error during CMD_TRIGGER_SCAN: Invalid argument (22)



