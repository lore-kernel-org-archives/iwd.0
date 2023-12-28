Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F085EAD1
	for <iwd@lists.linux.dev>; Thu, 28 Dec 2023 18:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JjRHFKvq"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d3e6c86868so49211205ad.1
        for <iwd@lists.linux.dev>; Thu, 28 Dec 2023 10:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703788939; x=1704393739; darn=lists.linux.dev;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YSy5vCbCQZO4bFa131BMBJYAuI3j8Lzw6qmvvwylOvU=;
        b=JjRHFKvqhTjvz2lIuCFAH3SmkmxHM0ZFotYmRWZ4d7veNJHdSHBXxsj5F+b8ctUtw/
         12CB75uULvDd3CKg6t/0m3fk2kIwCVDr179NW6qQAuK/ezrLwoWUlk+su7m3ca52OiEf
         ynRwHtK2YvJKEtetWicPtK42Vz5GM1/FHSZVjAKq1yQfH8Fa7LsH++ltf/5GXrHQI4mC
         n0qJuSSY7eVAm0SYDlc9QQQW8Y+uIjGmHmsTeO5XP7JakYJGVkw6dzVUwrjdW5n/cprh
         lwX8rL77lN7U0jxdg0ykVcZDoMEab8uBmXPuzuU5o25S40UaygJsWrsikP8mXIKlWqa+
         S7UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703788939; x=1704393739;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YSy5vCbCQZO4bFa131BMBJYAuI3j8Lzw6qmvvwylOvU=;
        b=kfK8rFanahZ/St2VaMlihUfarlhvlw4cn2pX2IRefkSsofmFbBPWIPczC+pYZxdqbY
         QUX9ep7XhvAk7n71a4vNwaGGsTBbrT06mRUv2rGkTe+oacQFHQsksV7QgLsZbu2RNtWQ
         TPZ+X961xxFKHMFlwOvEbqemi0bvt006x1iLPxUp5IklLskGmAVkWCAAqsAYKpoGVKow
         BLvBjPs5gSdqPp63i3rUoJxp5yg7871Xydl/JHsU0Lito4nanvsPS72OlQKa2eSKht2b
         6F7eQ3i/QKAfHY6YxUd8kzIRqv4/5m6O8Oo0gthd1KjdHoyAGaC+XVc/8ohjJqH/uPJd
         wfyA==
X-Gm-Message-State: AOJu0YyAz31nVGywjnuphj6CfxQESKyhY8KNJKdNacJNLgqlYMKeYcFf
	5tYgc9S+vMgFVHlVtxhSgF2UL8S0fi9nbN0XhaJe2ifSIQo=
X-Google-Smtp-Source: AGHT+IH5BTPN4lCGdQh54i/NpAuwRuITy2+imSvxw4F00yBAw29KDX2ivf/uYlCTt3CjONZV7/me86TuRm52pFsdK1E=
X-Received: by 2002:a17:902:e541:b0:1d3:ac23:b511 with SMTP id
 n1-20020a170902e54100b001d3ac23b511mr13819155plf.54.1703788939143; Thu, 28
 Dec 2023 10:42:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAG17S_MXzqBrOrCuRYuwx0tfQT2V9Qe0MyD9c+hckZ+a7TMBHA@mail.gmail.com>
In-Reply-To: <CAG17S_MXzqBrOrCuRYuwx0tfQT2V9Qe0MyD9c+hckZ+a7TMBHA@mail.gmail.com>
From: KeithG <ys3al35l@gmail.com>
Date: Thu, 28 Dec 2023 12:42:08 -0600
Message-ID: <CAG17S_M4xvot2HahnxMT2pmB6BYr1aJu+exFmSO00j+jxYDDEw@mail.gmail.com>
Subject: Re: disconnects when in AP mode
To: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I put iwd in debug mode and this is what happens at disconnect. Maybe
better for diagnostics.
If there is something else I can do to help diagnose it, please let me know

Dec 28 12:32:37 runeaudio iwd[5127]: src/netdev.c:netdev_mlme_notify()
MLME notification Del Station(20)
Dec 28 12:32:37 runeaudio iwd[5127]: src/netdev.c:netdev_mlme_notify()
MLME notification Del Station(20)
Dec 28 12:35:13 runeaudio iwd[5127]: src/netdev.c:netdev_mlme_notify()
MLME notification New Station(19)
Dec 28 12:35:13 runeaudio iwd[5127]: KEY_SEQ not returned in GET_KEY reply
Dec 28 12:35:13 runeaudio iwd[5127]: src/eapol.c:eapol_start()
Dec 28 12:35:13 runeaudio iwd[5127]:
src/eapol.c:eapol_send_ptk_1_of_4() STA: f0:42:1c:d7:da:e8 retries=3D0
Dec 28 12:35:13 runeaudio iwd[5127]:
src/eapol.c:eapol_handle_ptk_2_of_4() ifindex=3D4
Dec 28 12:35:13 runeaudio iwd[5127]:
src/eapol.c:eapol_send_ptk_3_of_4() STA: f0:42:1c:d7:da:e8 retries=3D0
Dec 28 12:35:13 runeaudio iwd[5127]:
src/eapol.c:eapol_ptk_3_of_4_retry() attempt 1
Dec 28 12:35:13 runeaudio iwd[5127]:
src/eapol.c:eapol_handle_ptk_4_of_4() ifindex=3D4
Dec 28 12:35:13 runeaudio iwd[5127]: src/netdev.c:netdev_set_tk()
ifindex=3D4 key_idx=3D0
Dec 28 12:35:13 runeaudio iwd[5127]: src/netdev.c:netdev_set_station_cb()
Dec 28 12:35:13 runeaudio iwd[5127]:
src/netdev.c:try_handshake_complete() ptk_installed: 1, gtk_installed:
1, igtk_installed: 1
Dec 28 12:35:13 runeaudio iwd[5127]:
src/netdev.c:try_handshake_complete() nhs->complete: 0
Dec 28 12:35:13 runeaudio iwd[5127]:
src/netdev.c:try_handshake_complete() Invoking handshake_event()
Dec 28 12:35:13 runeaudio iwd[5127]: src/ap.c:ap_new_rsna() STA
f0:42:1c:d7:da:e8 authenticated
Dec 28 12:35:55 runeaudio iwd[5127]: src/agent.c:agent_register()
agent register called
Dec 28 12:35:55 runeaudio iwd[5127]: src/agent.c:agent_register()
agent :1.566 path /agent/12001
Dec 28 12:35:55 runeaudio iwd[5127]: src/station.c:station_dbus_scan()
Scan called from DBus
Dec 28 12:35:55 runeaudio iwd[5127]:
src/wiphy.c:wiphy_radio_work_insert() Inserting work item 13
Dec 28 12:35:55 runeaudio iwd[5127]:
src/wiphy.c:wiphy_radio_work_next() Starting work item 13

On Thu, Dec 28, 2023 at 12:19=E2=80=AFPM KeithG <ys3al35l@gmail.com> wrote:
>
> Group,
>
> I finally gave up on getting connman to manage scanning when iwd is in
> AP mode. What I have done is listen to James who posted this a long
> time ago and I just finally figured out what he was saying.
>
> I am doing what is outlined here:
> https://lore.kernel.org/linux-wireless/87k0dhdg0d.fsf@bang-olufsen.dk/
>
> I am running this on RPis all with the brcmfmac adapters. I can get it
> all working, but when connected to the RPi on its advertised AP, I can
> get a connection for a bit then it disconnects, requiring a reconnect.
> I am running a freshly built iwd version 2.11 with ell 0.61 on RPiOS
> fully up to date on Bookworm
>
> I get tons of this in the log: "wiphy_estimate_data_rate() failed" and
> a few others but it does not seem like this is what triggers it to
> disconnect. I have not been able to pinpoint anything in the log where
> it disconnects.
>
> Any help appreciated.
>
> # uname -a
> Linux runeaudio 6.1.0-rpi7-rpi-v8 #1 SMP PREEMPT Debian
> 1:6.1.63-1+rpt1 (2023-11-24) aarch64 GNU/Linux
>
> this is what shows at bootup
> Dec 28 11:50:45 runeaudio kernel: brcmfmac: F1 signature read
> @0x18000000=3D0x15264345
> Dec 28 11:50:45 runeaudio kernel: brcmfmac: brcmf_fw_alloc_request:
> using brcm/brcmfmac43455-sdio for chip BCM4345/6
> Dec 28 11:50:45 runeaudio kernel: usbcore: registered new interface
> driver brcmfmac
> Dec 28 11:50:45 runeaudio kernel: Bluetooth: hci0: BCM4345C0
> 'brcm/BCM4345C0.raspberrypi,3-model-b-plus.hcd' Patch
> Dec 28 11:50:45 runeaudio kernel: brcmfmac: brcmf_c_preinit_dcmds:
> Firmware: BCM4345/6 wl0: Nov  1 2021 00:37:25 version 7.45.241
> (1a2f2fa CY) FWID 01-703fd60
> Dec 28 11:50:48 runeaudio kernel: brcmfmac:
> brcmf_cfg80211_set_power_mgmt: power save enabled
> Dec 28 11:50:55 runeaudio kernel: brcmfmac:
> brcmf_cfg80211_set_power_mgmt: power save disabled
> Dec 28 11:51:30 runeaudio kernel: brcmfmac:
> brcmf_cfg80211_set_power_mgmt: power save disabled
> Dec 28 11:51:31 runeaudio kernel: brcmfmac:
> brcmf_cfg80211_set_power_mgmt: power save disabled
> Dec 28 11:51:40 runeaudio kernel: ieee80211 phy0: brcmf_escan_timeout:
> timer expired
>
> I get this in the log:
> Dec 28 11:51:30 runeaudio iwd[1306]: No Diffie-Hellman support found,
> WPS will not be available
> Dec 28 11:51:30 runeaudio iwd[1306]: The following options are missing
> in the kernel:
> Dec 28 11:51:30 runeaudio iwd[1306]:         CONFIG_KEY_DH_OPERATIONS
> Dec 28 11:51:30 runeaudio iwd[1306]: Wireless daemon version 2.11
> Dec 28 11:51:30 runeaudio iwd[1306]: Loaded configuration from
> /etc/iwd/main.conf
> Dec 28 11:51:30 runeaudio systemd[1]: Started iwd.service - Wireless serv=
ice.
> Dec 28 11:51:30 runeaudio iwd[1306]: Wiphy: 0, Name: phy0
> Dec 28 11:51:30 runeaudio iwd[1306]:         Permanent Address:
> b8:27:eb:52:cc:d0
> Dec 28 11:51:30 runeaudio iwd[1306]:         2.4GHz Band:
> Dec 28 11:51:30 runeaudio iwd[1306]:                 Bitrates (non-HT):
> Dec 28 11:51:30 runeaudio iwd[1306]:                          1.0 Mbps
> Dec 28 11:51:30 runeaudio iwd[1306]:                          2.0 Mbps
> Dec 28 11:51:30 runeaudio iwd[1306]:                          5.5 Mbps
> Dec 28 11:51:30 runeaudio iwd[1306]:                         11.0 Mbps
> Dec 28 11:51:30 runeaudio iwd[1306]:                          6.0 Mbps
> Dec 28 11:51:30 runeaudio iwd[1306]:                          9.0 Mbps
> Dec 28 11:51:30 runeaudio iwd[1306]:                         12.0 Mbps
> Dec 28 11:51:30 runeaudio iwd[1306]:                         18.0 Mbps
> Dec 28 11:51:30 runeaudio iwd[1306]:                         24.0 Mbps
> Dec 28 11:51:30 runeaudio iwd[1306]:                         36.0 Mbps
> Dec 28 11:51:30 runeaudio iwd[1306]:                         48.0 Mbps
> Dec 28 11:51:30 runeaudio iwd[1306]:                         54.0 Mbps
> Dec 28 11:51:30 runeaudio iwd[1306]:                 HT Capabilities:
> Dec 28 11:51:30 runeaudio iwd[1306]:                         HT40
> Dec 28 11:51:30 runeaudio iwd[1306]:                         Short GI for=
 20Mhz
> Dec 28 11:51:30 runeaudio iwd[1306]:                 HT RX MCS indexes:
> Dec 28 11:51:30 runeaudio iwd[1306]:                         0-7
> Dec 28 11:51:30 runeaudio iwd[1306]:         5GHz Band:
> Dec 28 11:51:30 runeaudio iwd[1306]:                 Bitrates (non-HT):
> Dec 28 11:51:30 runeaudio iwd[1306]:                          6.0 Mbps
> Dec 28 11:51:30 runeaudio iwd[1306]:                          9.0 Mbps
> Dec 28 11:51:30 runeaudio iwd[1306]:                         12.0 Mbps
> Dec 28 11:51:30 runeaudio iwd[1306]:                         18.0 Mbps
> Dec 28 11:51:30 runeaudio iwd[1306]:                         24.0 Mbps
> Dec 28 11:51:30 runeaudio iwd[1306]:                         36.0 Mbps
> Dec 28 11:51:30 runeaudio iwd[1306]:                         48.0 Mbps
> Dec 28 11:51:30 runeaudio iwd[1306]:                         54.0 Mbps
> Dec 28 11:51:30 runeaudio iwd[1306]:                 HT Capabilities:
> Dec 28 11:51:30 runeaudio iwd[1306]:                         HT40
> Dec 28 11:51:30 runeaudio iwd[1306]:                         Short GI for=
 20Mhz
> Dec 28 11:51:30 runeaudio iwd[1306]:                         Short GI for=
 40Mhz
> Dec 28 11:51:30 runeaudio iwd[1306]:                 HT RX MCS indexes:
> Dec 28 11:51:30 runeaudio iwd[1306]:                         0-7
> Dec 28 11:51:30 runeaudio iwd[1306]:                 VHT Capabilities:
> Dec 28 11:51:30 runeaudio iwd[1306]:                         Short GI for=
 80Mhz
> Dec 28 11:51:30 runeaudio iwd[1306]:                         Max RX
> MCS: 0-9 for NSS: 1
> Dec 28 11:51:30 runeaudio iwd[1306]:                         Max TX
> MCS: 0-9 for NSS: 1
> Dec 28 11:51:30 runeaudio iwd[1306]:         Ciphers: BIP-CMAC-128 CCMP-1=
28 TKIP
> Dec 28 11:51:30 runeaudio iwd[1306]:         Supported iftypes: ad-hoc
> station ap p2p-client p2p-go p2p-device
> Dec 28 11:51:30 runeaudio iwd[1306]:         Driver Flags: DefaultInterfa=
ce
> Dec 28 11:51:30 runeaudio iwd[1306]: Wiphy phy0 will only use the
> default interface
> Dec 28 11:51:30 runeaudio iwd[1306]: Could not register frame watch
> type 00b0: -22
> Dec 28 11:51:46 runeaudio iwd[1306]: wiphy_estimate_data_rate() failed
> Dec 28 11:51:56 runeaudio iwd[1306]: wiphy_estimate_data_rate() failed
> Dec 28 11:52:22 runeaudio iwd[1306]: wiphy_estimate_data_rate() failed
> Dec 28 11:52:22 runeaudio iwd[1306]: wiphy_estimate_data_rate() failed
> Dec 28 11:52:29 runeaudio iwd[1306]: KEY_SEQ not returned in GET_KEY repl=
y
> Dec 28 11:52:29 runeaudio iwd[1306]: 4-Way handshake failed for
> ifindex: 4, reason: 15
> Dec 28 11:52:39 runeaudio iwd[1306]: KEY_SEQ not returned in GET_KEY repl=
y
> Dec 28 11:52:40 runeaudio iwd[1306]: 4-Way handshake failed for
> ifindex: 4, reason: 15
> Dec 28 11:52:49 runeaudio iwd[1306]: KEY_SEQ not returned in GET_KEY repl=
y
> Dec 28 11:52:49 runeaudio iwd[1306]: 4-Way handshake failed for
> ifindex: 4, reason: 15
> Dec 28 11:53:07 runeaudio iwd[1306]: wiphy_estimate_data_rate() failed
> Dec 28 11:53:35 runeaudio iwd[1306]: KEY_SEQ not returned in GET_KEY repl=
y
> Dec 28 11:54:33 runeaudio iwd[1306]: wiphy_estimate_data_rate() failed
> Dec 28 11:54:33 runeaudio iwd[1306]: wiphy_estimate_data_rate() failed
