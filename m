Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E411B14A90
	for <iwd@lists.linux.dev>; Fri, 29 Dec 2023 22:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M7PIUivn"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-28bf1410e37so5720965a91.2
        for <iwd@lists.linux.dev>; Fri, 29 Dec 2023 14:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703888256; x=1704493056; darn=lists.linux.dev;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V9MLbSvisFnSuDFPHRgqLC61bLWKQXCoQs8adCwknKg=;
        b=M7PIUivn8WFYTiRddlqyert2k6ENYmROIybxTHXZLLUsN/vDi4VITNYnI3T1lHlkeV
         YP4UTAuWFP7XYMtK+Z+MNosTvC3mNIIlL8Mc1gARNS3FvizuKdM/OY2nnTvXbdqwbGK7
         uN5TE6iJK14tX6DNo0b3yYXBeN8K3wIoUnHi+Me/TMQYtcmWyWw/YIUl594RKV8x0AAB
         8/fCSb/ity9An7YI3aU1V/vK3730uNv4tLwkxEb374H3f06NHr5EgSSrkM29LEIISz0m
         UhzYf7xuIUgwaRwSLoJL0Bg089PxHAUCFn+GASZbvU/72QI67cjJFfr/DRRf+EPpnSM6
         7OoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703888256; x=1704493056;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V9MLbSvisFnSuDFPHRgqLC61bLWKQXCoQs8adCwknKg=;
        b=XfinIlEsLT7cbs6hyPyu14MBYN3cf/0SKHRrBJSEG1rUdjhTsymkwmVyutzDsQc0tF
         L8bQoFLBtrc22zzA0rQiYUHJN2XuWBhhIGf+rZLzhvhblM4dTTQr/d4L7AqtNXA2r48V
         kWmi32km3yxc/fr9p56NRNsZSvvzguT7wTG/YT+0Ue0XVO4YO/3+ueNUR+786Do0HDs7
         Lo7tPvVwt6OegmO3b9Z5el2jIYhqTatkgdQ7wF65EU9Q+EnWYRg4YutN1Ls/S8w1BmKi
         avwMtwc6xba7AXUgzqZstRb8BlkanF8o+Yacgh7317zDlwC47kERP/u2HfhjNgw9NTwu
         ZrKA==
X-Gm-Message-State: AOJu0YxmFkMYFkg+ertuJKg8dDz5kpWCM91HUk7NMSAS37BwqjvqQQcp
	v83WjxAavNxmAjBGFau7bwf7YaubWi1fK3vI3i4hdM0JrwY=
X-Google-Smtp-Source: AGHT+IEJRmClO1S0YUGp3F0OIR6iSYB5wr/457oDzAbyvmrBFFNkxgvkk3+Ge54PNgmOwunXRPKNCapZA63qzNfmprA=
X-Received: by 2002:a17:90a:df0f:b0:28c:59d6:edb1 with SMTP id
 gp15-20020a17090adf0f00b0028c59d6edb1mr5233994pjb.69.1703888255816; Fri, 29
 Dec 2023 14:17:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAG17S_MXzqBrOrCuRYuwx0tfQT2V9Qe0MyD9c+hckZ+a7TMBHA@mail.gmail.com>
 <CAG17S_M4xvot2HahnxMT2pmB6BYr1aJu+exFmSO00j+jxYDDEw@mail.gmail.com> <CAG17S_MpE_p=TS4uBSY+_8XvedKct_FqXzr66tUbhtQL0x6_rg@mail.gmail.com>
In-Reply-To: <CAG17S_MpE_p=TS4uBSY+_8XvedKct_FqXzr66tUbhtQL0x6_rg@mail.gmail.com>
From: KeithG <ys3al35l@gmail.com>
Date: Fri, 29 Dec 2023 16:17:24 -0600
Message-ID: <CAG17S_MJdOj195CvvcEAXvA_WOQQH1XYsKuFU1NhdWL2_JJ7pw@mail.gmail.com>
Subject: Re: disconnects when in AP mode
To: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 29, 2023 at 12:53=E2=80=AFPM KeithG <ys3al35l@gmail.com> wrote:
>
> On Thu, Dec 28, 2023 at 12:42=E2=80=AFPM KeithG <ys3al35l@gmail.com> wrot=
e:
> >
> > I put iwd in debug mode and this is what happens at disconnect. Maybe
> > better for diagnostics.
> > If there is something else I can do to help diagnose it, please let me =
know
> >
> > Dec 28 12:32:37 runeaudio iwd[5127]: src/netdev.c:netdev_mlme_notify()
> > MLME notification Del Station(20)
> > Dec 28 12:32:37 runeaudio iwd[5127]: src/netdev.c:netdev_mlme_notify()
> > MLME notification Del Station(20)
> > Dec 28 12:35:13 runeaudio iwd[5127]: src/netdev.c:netdev_mlme_notify()
> > MLME notification New Station(19)
> > Dec 28 12:35:13 runeaudio iwd[5127]: KEY_SEQ not returned in GET_KEY re=
ply
> > Dec 28 12:35:13 runeaudio iwd[5127]: src/eapol.c:eapol_start()
> > Dec 28 12:35:13 runeaudio iwd[5127]:
> > src/eapol.c:eapol_send_ptk_1_of_4() STA: f0:42:1c:d7:da:e8 retries=3D0
> > Dec 28 12:35:13 runeaudio iwd[5127]:
> > src/eapol.c:eapol_handle_ptk_2_of_4() ifindex=3D4
> > Dec 28 12:35:13 runeaudio iwd[5127]:
> > src/eapol.c:eapol_send_ptk_3_of_4() STA: f0:42:1c:d7:da:e8 retries=3D0
> > Dec 28 12:35:13 runeaudio iwd[5127]:
> > src/eapol.c:eapol_ptk_3_of_4_retry() attempt 1
> > Dec 28 12:35:13 runeaudio iwd[5127]:
> > src/eapol.c:eapol_handle_ptk_4_of_4() ifindex=3D4
> > Dec 28 12:35:13 runeaudio iwd[5127]: src/netdev.c:netdev_set_tk()
> > ifindex=3D4 key_idx=3D0
> > Dec 28 12:35:13 runeaudio iwd[5127]: src/netdev.c:netdev_set_station_cb=
()
> > Dec 28 12:35:13 runeaudio iwd[5127]:
> > src/netdev.c:try_handshake_complete() ptk_installed: 1, gtk_installed:
> > 1, igtk_installed: 1
> > Dec 28 12:35:13 runeaudio iwd[5127]:
> > src/netdev.c:try_handshake_complete() nhs->complete: 0
> > Dec 28 12:35:13 runeaudio iwd[5127]:
> > src/netdev.c:try_handshake_complete() Invoking handshake_event()
> > Dec 28 12:35:13 runeaudio iwd[5127]: src/ap.c:ap_new_rsna() STA
> > f0:42:1c:d7:da:e8 authenticated
> > Dec 28 12:35:55 runeaudio iwd[5127]: src/agent.c:agent_register()
> > agent register called
> > Dec 28 12:35:55 runeaudio iwd[5127]: src/agent.c:agent_register()
> > agent :1.566 path /agent/12001
> > Dec 28 12:35:55 runeaudio iwd[5127]: src/station.c:station_dbus_scan()
> > Scan called from DBus
> > Dec 28 12:35:55 runeaudio iwd[5127]:
> > src/wiphy.c:wiphy_radio_work_insert() Inserting work item 13
> > Dec 28 12:35:55 runeaudio iwd[5127]:
> > src/wiphy.c:wiphy_radio_work_next() Starting work item 13
> >
> > On Thu, Dec 28, 2023 at 12:19=E2=80=AFPM KeithG <ys3al35l@gmail.com> wr=
ote:
> > >
> > > Group,
> > >
> > > I finally gave up on getting connman to manage scanning when iwd is i=
n
> > > AP mode. What I have done is listen to James who posted this a long
> > > time ago and I just finally figured out what he was saying.
> > >
> > > I am doing what is outlined here:
> > > https://lore.kernel.org/linux-wireless/87k0dhdg0d.fsf@bang-olufsen.dk=
/
> > >
> > > I am running this on RPis all with the brcmfmac adapters. I can get i=
t
> > > all working, but when connected to the RPi on its advertised AP, I ca=
n
> > > get a connection for a bit then it disconnects, requiring a reconnect=
.
> > > I am running a freshly built iwd version 2.11 with ell 0.61 on RPiOS
> > > fully up to date on Bookworm
> > >
> > > I get tons of this in the log: "wiphy_estimate_data_rate() failed" an=
d
> > > a few others but it does not seem like this is what triggers it to
> > > disconnect. I have not been able to pinpoint anything in the log wher=
e
> > > it disconnects.
> > >
> > > Any help appreciated.
> > >
> > > # uname -a
> > > Linux runeaudio 6.1.0-rpi7-rpi-v8 #1 SMP PREEMPT Debian
> > > 1:6.1.63-1+rpt1 (2023-11-24) aarch64 GNU/Linux
> > >
> > > this is what shows at bootup
> > > Dec 28 11:50:45 runeaudio kernel: brcmfmac: F1 signature read
> > > @0x18000000=3D0x15264345
> > > Dec 28 11:50:45 runeaudio kernel: brcmfmac: brcmf_fw_alloc_request:
> > > using brcm/brcmfmac43455-sdio for chip BCM4345/6
> > > Dec 28 11:50:45 runeaudio kernel: usbcore: registered new interface
> > > driver brcmfmac
> > > Dec 28 11:50:45 runeaudio kernel: Bluetooth: hci0: BCM4345C0
> > > 'brcm/BCM4345C0.raspberrypi,3-model-b-plus.hcd' Patch
> > > Dec 28 11:50:45 runeaudio kernel: brcmfmac: brcmf_c_preinit_dcmds:
> > > Firmware: BCM4345/6 wl0: Nov  1 2021 00:37:25 version 7.45.241
> > > (1a2f2fa CY) FWID 01-703fd60
> > > Dec 28 11:50:48 runeaudio kernel: brcmfmac:
> > > brcmf_cfg80211_set_power_mgmt: power save enabled
> > > Dec 28 11:50:55 runeaudio kernel: brcmfmac:
> > > brcmf_cfg80211_set_power_mgmt: power save disabled
> > > Dec 28 11:51:30 runeaudio kernel: brcmfmac:
> > > brcmf_cfg80211_set_power_mgmt: power save disabled
> > > Dec 28 11:51:31 runeaudio kernel: brcmfmac:
> > > brcmf_cfg80211_set_power_mgmt: power save disabled
> > > Dec 28 11:51:40 runeaudio kernel: ieee80211 phy0: brcmf_escan_timeout=
:
> > > timer expired
> > >
> > > I get this in the log:
> > > Dec 28 11:51:30 runeaudio iwd[1306]: No Diffie-Hellman support found,
> > > WPS will not be available
> > > Dec 28 11:51:30 runeaudio iwd[1306]: The following options are missin=
g
> > > in the kernel:
> > > Dec 28 11:51:30 runeaudio iwd[1306]:         CONFIG_KEY_DH_OPERATIONS
> > > Dec 28 11:51:30 runeaudio iwd[1306]: Wireless daemon version 2.11
> > > Dec 28 11:51:30 runeaudio iwd[1306]: Loaded configuration from
> > > /etc/iwd/main.conf
> > > Dec 28 11:51:30 runeaudio systemd[1]: Started iwd.service - Wireless =
service.
> > > Dec 28 11:51:30 runeaudio iwd[1306]: Wiphy: 0, Name: phy0
> > > Dec 28 11:51:30 runeaudio iwd[1306]:         Permanent Address:
> > > b8:27:eb:52:cc:d0
> > > Dec 28 11:51:30 runeaudio iwd[1306]:         2.4GHz Band:
> > > Dec 28 11:51:30 runeaudio iwd[1306]:                 Bitrates (non-HT=
):
> > > Dec 28 11:51:30 runeaudio iwd[1306]:                          1.0 Mbp=
s
> > > Dec 28 11:51:30 runeaudio iwd[1306]:                          2.0 Mbp=
s
> > > Dec 28 11:51:30 runeaudio iwd[1306]:                          5.5 Mbp=
s
> > > Dec 28 11:51:30 runeaudio iwd[1306]:                         11.0 Mbp=
s
> > > Dec 28 11:51:30 runeaudio iwd[1306]:                          6.0 Mbp=
s
> > > Dec 28 11:51:30 runeaudio iwd[1306]:                          9.0 Mbp=
s
> > > Dec 28 11:51:30 runeaudio iwd[1306]:                         12.0 Mbp=
s
> > > Dec 28 11:51:30 runeaudio iwd[1306]:                         18.0 Mbp=
s
> > > Dec 28 11:51:30 runeaudio iwd[1306]:                         24.0 Mbp=
s
> > > Dec 28 11:51:30 runeaudio iwd[1306]:                         36.0 Mbp=
s
> > > Dec 28 11:51:30 runeaudio iwd[1306]:                         48.0 Mbp=
s
> > > Dec 28 11:51:30 runeaudio iwd[1306]:                         54.0 Mbp=
s
> > > Dec 28 11:51:30 runeaudio iwd[1306]:                 HT Capabilities:
> > > Dec 28 11:51:30 runeaudio iwd[1306]:                         HT40
> > > Dec 28 11:51:30 runeaudio iwd[1306]:                         Short GI=
 for 20Mhz
> > > Dec 28 11:51:30 runeaudio iwd[1306]:                 HT RX MCS indexe=
s:
> > > Dec 28 11:51:30 runeaudio iwd[1306]:                         0-7
> > > Dec 28 11:51:30 runeaudio iwd[1306]:         5GHz Band:
> > > Dec 28 11:51:30 runeaudio iwd[1306]:                 Bitrates (non-HT=
):
> > > Dec 28 11:51:30 runeaudio iwd[1306]:                          6.0 Mbp=
s
> > > Dec 28 11:51:30 runeaudio iwd[1306]:                          9.0 Mbp=
s
> > > Dec 28 11:51:30 runeaudio iwd[1306]:                         12.0 Mbp=
s
> > > Dec 28 11:51:30 runeaudio iwd[1306]:                         18.0 Mbp=
s
> > > Dec 28 11:51:30 runeaudio iwd[1306]:                         24.0 Mbp=
s
> > > Dec 28 11:51:30 runeaudio iwd[1306]:                         36.0 Mbp=
s
> > > Dec 28 11:51:30 runeaudio iwd[1306]:                         48.0 Mbp=
s
> > > Dec 28 11:51:30 runeaudio iwd[1306]:                         54.0 Mbp=
s
> > > Dec 28 11:51:30 runeaudio iwd[1306]:                 HT Capabilities:
> > > Dec 28 11:51:30 runeaudio iwd[1306]:                         HT40
> > > Dec 28 11:51:30 runeaudio iwd[1306]:                         Short GI=
 for 20Mhz
> > > Dec 28 11:51:30 runeaudio iwd[1306]:                         Short GI=
 for 40Mhz
> > > Dec 28 11:51:30 runeaudio iwd[1306]:                 HT RX MCS indexe=
s:
> > > Dec 28 11:51:30 runeaudio iwd[1306]:                         0-7
> > > Dec 28 11:51:30 runeaudio iwd[1306]:                 VHT Capabilities=
:
> > > Dec 28 11:51:30 runeaudio iwd[1306]:                         Short GI=
 for 80Mhz
> > > Dec 28 11:51:30 runeaudio iwd[1306]:                         Max RX
> > > MCS: 0-9 for NSS: 1
> > > Dec 28 11:51:30 runeaudio iwd[1306]:                         Max TX
> > > MCS: 0-9 for NSS: 1
> > > Dec 28 11:51:30 runeaudio iwd[1306]:         Ciphers: BIP-CMAC-128 CC=
MP-128 TKIP
> > > Dec 28 11:51:30 runeaudio iwd[1306]:         Supported iftypes: ad-ho=
c
> > > station ap p2p-client p2p-go p2p-device
> > > Dec 28 11:51:30 runeaudio iwd[1306]:         Driver Flags: DefaultInt=
erface
> > > Dec 28 11:51:30 runeaudio iwd[1306]: Wiphy phy0 will only use the
> > > default interface
> > > Dec 28 11:51:30 runeaudio iwd[1306]: Could not register frame watch
> > > type 00b0: -22
> > > Dec 28 11:51:46 runeaudio iwd[1306]: wiphy_estimate_data_rate() faile=
d
> > > Dec 28 11:51:56 runeaudio iwd[1306]: wiphy_estimate_data_rate() faile=
d
> > > Dec 28 11:52:22 runeaudio iwd[1306]: wiphy_estimate_data_rate() faile=
d
> > > Dec 28 11:52:22 runeaudio iwd[1306]: wiphy_estimate_data_rate() faile=
d
> > > Dec 28 11:52:29 runeaudio iwd[1306]: KEY_SEQ not returned in GET_KEY =
reply
> > > Dec 28 11:52:29 runeaudio iwd[1306]: 4-Way handshake failed for
> > > ifindex: 4, reason: 15
> > > Dec 28 11:52:39 runeaudio iwd[1306]: KEY_SEQ not returned in GET_KEY =
reply
> > > Dec 28 11:52:40 runeaudio iwd[1306]: 4-Way handshake failed for
> > > ifindex: 4, reason: 15
> > > Dec 28 11:52:49 runeaudio iwd[1306]: KEY_SEQ not returned in GET_KEY =
reply
> > > Dec 28 11:52:49 runeaudio iwd[1306]: 4-Way handshake failed for
> > > ifindex: 4, reason: 15
> > > Dec 28 11:53:07 runeaudio iwd[1306]: wiphy_estimate_data_rate() faile=
d
> > > Dec 28 11:53:35 runeaudio iwd[1306]: KEY_SEQ not returned in GET_KEY =
reply
> > > Dec 28 11:54:33 runeaudio iwd[1306]: wiphy_estimate_data_rate() faile=
d
> > > Dec 28 11:54:33 runeaudio iwd[1306]: wiphy_estimate_data_rate() faile=
d
>
> I tried this similarly with hostapd and get similar results with
> disconnects. I have connman/iwd managing eth0 and wlano and created an
> ap0 virtual interface on wlan0 then start hostapd. It will come up but
> repeatedly disconnects in a similar fashion. I see these disconnects
> with my phone as well as with my laptop running an intel wireless
> card. My next investigation is to use wpa_supplicant on wlan0 and see
> if it is any more stable. After that, maybe looking for any more up to
> date firmware for the brcmfmac. Could iwd scanning in the wlan0 cause
> a disconnect on the virtual ap0? Any other ideas welcome.
>
> This is a snippet of the log showing iwd and hostapd:
>
> Dec 29 07:45:26 runeaudio iwd[19160]:
> src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
> DemBoyz_5G
> Dec 29 07:45:26 runeaudio iwd[19160]:
> src/station.c:station_autoconnect_next() autoconnect:
> 'd8:07:b6:8e:97:7a' freq: 5785, rank: 13, strength: -8100
> Dec 29 07:45:26 runeaudio iwd[19160]:
> src/station.c:station_autoconnect_next() autoconnect:
> network_autoconnect: No such file or directory (-2)
> Dec 29 07:45:26 runeaudio iwd[19160]:
> src/wiphy.c:wiphy_radio_work_done() Work item 12 done
> Dec 29 07:45:30 runeaudio iwd[19160]:
> src/netdev.c:netdev_mlme_notify() MLME notification Del Station(20)
> Dec 29 07:45:30 runeaudio hostapd[1583]: ap0: STA f0:42:1c:d7:da:e8
> IEEE 802.11: disassociated
> Dec 29 07:45:30 runeaudio iwd[19160]:
> src/netdev.c:netdev_mlme_notify() MLME notification Del Station(20)
> Dec 29 07:45:30 runeaudio hostapd[1583]: ap0: STA f0:42:1c:d7:da:e8
> IEEE 802.11: disassociated
> Dec 29 07:45:49 runeaudio iwd[19160]:
> src/netdev.c:netdev_mlme_notify() MLME notification New Station(19)
> Dec 29 07:45:49 runeaudio hostapd[1583]: ap0: STA f0:42:1c:d7:da:e8
> IEEE 802.11: associated
> Dec 29 07:45:49 runeaudio hostapd[1583]: ap0: STA f0:42:1c:d7:da:e8
> RADIUS: starting accounting session 28F5839359A8BF79
> Dec 29 07:45:49 runeaudio hostapd[1583]: ap0: STA f0:42:1c:d7:da:e8
> WPA: pairwise key handshake completed (RSN)

I did the test of the latest firmware from cypress while still using
iwd and connman but using hostapd and get similar results. It still
disconnects right after iwd makes a scan.
Orig firmware on my Pi 7.45.241:
Dec 29 13:18:45 runeaudio kernel: brcmfmac: F1 signature read
@0x18000000=3D0x15264345
Dec 29 13:18:45 runeaudio kernel: brcmfmac: brcmf_fw_alloc_request:
using brcm/brcmfmac43455-sdio for chip BCM4345/6
Dec 29 13:18:45 runeaudio kernel: usbcore: registered new interface
driver brcmfmac
Dec 29 13:18:46 runeaudio kernel: brcmfmac: brcmf_c_preinit_dcmds:
Firmware: BCM4345/6 wl0: Nov  1 2021 00:37:25 version 7.45.241
(1a2f2fa CY) FWID 01-703fd60

This is the latest from cypress 7.45.265:
ec 29 14:17:26 runeaudio kernel: brcmfmac: F1 signature read
@0x18000000=3D0x15264345
Dec 29 14:17:26 runeaudio kernel: brcmfmac: brcmf_fw_alloc_request:
using brcm/brcmfmac43455-sdio for chip BCM4345/6
Dec 29 14:17:26 runeaudio kernel: usbcore: registered new interface
driver brcmfmac
Dec 29 14:17:27 runeaudio kernel: brcmfmac: brcmf_c_preinit_dcmds:
Firmware: BCM4345/6 wl0: Aug 29 2023 01:47:08 version 7.45.265
(28bca26 CY) FWID 01-b677b91b

This is is what happens with hostapd/dnsmasq on virtual ap0 and
connmanctl/iwd on wlan0. I get a disconnect as soon as iwd performs a
scan.
https://pastebin.com/FsepZ6PM

Could iwd -station be causing this to disconnect? When I use
connman/wpa_supplicant and hostapd, it is rock steady. No disconnects.
I waited over an hour and it stayed connected. There is not really a
way for me to use connman/wpa_supplicant and use iwctl to start the AP
on the virtual interface to test this hypothesis thst it is only iwd
station, but as it is, iwd ap mode does not really work for brcmfmac.
