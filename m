Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDEC1DBB38
	for <iwd@lists.linux.dev>; Mon,  6 Jan 2025 14:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736173218; cv=none; b=bVMH9zrhLKQ5bcVn7S8c0/iWZMfcQsiV0bcZyqbGa07jDLXHsCExjPHbDUHXNT7gOmpJQ6FMHYd1kbqodCPhPn9mKuuzLS+H4vx/gDwjQIvGnwaMA3iuv7clr8zcX4aHGZCXlcHwDU/o/INp9++C9PbhC2a5nYXAJtg1XsFmptQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736173218; c=relaxed/simple;
	bh=ekESqXr/xG+AtQwJSGj6xcWtmHTvGHxUFp2c9aK/GfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RVgWXGsjVEnOximtPo6tATy2FQwucJDnc4d4QzAoNIQceET73UQ548vi9haxTm94Y0FXdRfdkWht1kyyfyal10SDu2s2aZvqDkFqKtCFFXQ/qT63HvUlMESYwgG7DyzavKqBdSujQ56qcYckhiTzbPBbSytvoxvwJ8/YDsMGbiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XNd7Tumt; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNd7Tumt"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e39f43344c5so18674653276.1
        for <iwd@lists.linux.dev>; Mon, 06 Jan 2025 06:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736173214; x=1736778014; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QxidkjdumeO5F1+baMwiZABzs8fhYOHQGe24yyyea5Q=;
        b=XNd7TumtMQJWNjDSimqpU2MHDNHG4SfiPRnGudXrl/9Ky4+peKTYAJqkExxxwoKzdH
         t/R4h6z3Km+kGj7K68sA3q+SbSvA+21G3x1yv44V034VOapK1v2Su9J/RcCm8FuZZA/e
         quY7POBm1hkgxWiBxUJ3/wNcykMwoHVf5Uo5/Mamh9ewD37K6Vy4ul1rB3yZnN47fXK8
         KVHWqbMh+tlOND9RmgoEm4hPeEIW+Ta7HbW/BtCSDTxGxnDuoj3pN/cKmuITZpglBidD
         jNj7PZE3eDQsYtSijXx0yarUXhfuU0k0gM2uvDF7NjvwZVaBPY/HQtdqNjNE8LLLxyLk
         I5+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736173214; x=1736778014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QxidkjdumeO5F1+baMwiZABzs8fhYOHQGe24yyyea5Q=;
        b=lP71t8gIVtgWaDG9s7csSHXwSi2lnG1ZiZD3zCtNffaTYJkjKGv+fdP/BMuWXbJvVe
         C/5/ojFWZeBwcIXYemRfoAYcLQFP2CpuOktdMcY5J+rAdvmJvTDQaZN8bor5GVUv9aMK
         /I6qM46707vpoWZj+Xse/N+lHWnsomFBt7IPp8Mz/86zISoKAhxS8LvqX57DEJUyixeD
         yh3f85bfQydEYvhwQwEKVfDVJHHZhLeSkbo3lhuciLm1+hKFlZWCHYlOZgLsiKIEYfs9
         ihJ+eozoDN8MQ6x9RiUbBRTaRsAIdMapL7+0aKdLDSZeRNlhBLdBkrKM2ofRlKMrp4A0
         2Irw==
X-Gm-Message-State: AOJu0Yw1aNdEN32RoI5kfz93s7QEfEutvDArvKfu6mbBvNV75Vt8vQBf
	6l+1PDkIV+W4kbcjb2R8DlqZ6IfzYSVkQcq5r7UpTH9Rv1TjwXwOjl7w1fbtYxT1L0x7QSgDIGm
	vppJx0fpjP1a0J2maaTDXkH8w1N4rSeOL
X-Gm-Gg: ASbGncvAXdheQOLYMbyeUea/05bq0EUTNk4hHlV2q88U8lZmx7hbls5aZAW6uiasYqx
	rK1Iz+ipAoIjXt7W9rsau3gykrlRF8Dz7jqJWDQvIMCgD+gPEr42sEsTHvNmCndDFNg==
X-Google-Smtp-Source: AGHT+IGB2x8plOUnBpcTV2UIea7Xso9MjfT/FilJTRcO96GsEuKJmzrUACBuUa5rDNaQwhAk1yGwgs666+0IsDRvhm0=
X-Received: by 2002:a05:690c:d1f:b0:6ee:baf5:a4e3 with SMTP id
 00721157ae682-6f3f822f406mr373300537b3.42.1736173214161; Mon, 06 Jan 2025
 06:20:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAPDaQ_wdXGvy7Sa=10bSC7eAbLut4Jw_CP16Xob7aVtqgCYxSg@mail.gmail.com>
 <a24382ff-0756-45f2-8e5d-69da8993e3df@gmail.com> <CAPDaQ_z3GyLsQM86wDXa0UwN9n5p0T4sNmPvSUcgEfpAkqsKQw@mail.gmail.com>
 <b606fe1b-5265-4a96-ac90-a80c1725abb3@gmail.com>
In-Reply-To: <b606fe1b-5265-4a96-ac90-a80c1725abb3@gmail.com>
From: Owen Garland <garland.owen@gmail.com>
Date: Mon, 6 Jan 2025 15:19:37 +0100
Message-ID: <CAPDaQ_xVjZf-1n6fz5XGtunS+CKTm0FHAJBGRFT4h6eJKKqz2g@mail.gmail.com>
Subject: Re: Repeated Deauthentication event, reason: 4
To: James Prestwood <prestwoj@gmail.com>
Cc: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hej,

> Was there any kernel logs here?

Would that be from dmesg? Or elsewhere?

I'm a little embarrassed to say that I've moved my router to improve
my signal (went from -79~ to -63~) and the issues have seemingly been
resolved.

Perhaps it is still a bug that it gives that immediate disconnect and
reason 4 though, it was a red herring in my troubleshooting.

Thanks for the support, let me know if you want me to try and
replicate it again with further logging from the kernel, I'd be happy
to help.

Cheers!

On Mon, Jan 6, 2025 at 2:52=E2=80=AFPM James Prestwood <prestwoj@gmail.com>=
 wrote:
>
> Hi Owen,
>
> On 1/4/25 1:17 AM, Owen Garland wrote:
> > Hey, thanks for the quick response!
> >
> > I'm unsure that the signal strength is the issue, though I can't rule
> > it out, as this issue has manifested itself since I've changed OS from
> > Manjaro with NetworkManager to Arch with iwd, which has lead me to
> > think it's a software issue.
> That would make sense. My guess is some difference in the kernel version
> or iwlwifi firmware version between Manjaro and Arch. To at least remove
> IWD from the equation you could try wpa_supplicant with your current
> Arch distro. If you see the same behavior this is likely some regression
> with the kernel/iwlwifi.
> >
> > Here is the logs of the event with debug enabled:
> >
> > ~ =CE=BB journalctl -u iwd | grep -C 15 08:57:34
> > Jan 04 08:57:33 titanium iwd[415831]: src/netdev.c:netdev_set_rekey_off=
load() 7
> > Jan 04 08:57:33 titanium iwd[415831]:
> > src/netdev.c:netdev_new_group_key_cb() ifindex: 7, err: 0
> > Jan 04 08:57:33 titanium iwd[415831]:
> > src/netdev.c:try_handshake_complete() ptk_installed: 0, gtk_installed:
> > 1, igtk_installed: 1
> > Jan 04 08:57:33 titanium iwd[415831]:
> > src/netdev.c:netdev_mlme_notify() MLME notification Control Port TX
> > Status(139)
> > Jan 04 08:57:33 titanium iwd[415831]: src/netdev.c:netdev_set_station_c=
b()
> > Jan 04 08:57:33 titanium iwd[415831]:
> > src/netdev.c:try_handshake_complete() ptk_installed: 1, gtk_installed:
> > 1, igtk_installed: 1
> > Jan 04 08:57:33 titanium iwd[415831]:
> > src/netdev.c:try_handshake_complete() nhs->complete: 0
> > Jan 04 08:57:33 titanium iwd[415831]:
> > src/netdev.c:try_handshake_complete() Invoking handshake_event()
> > Jan 04 08:57:33 titanium iwd[415831]:
> > src/handshake.c:handshake_state_cache_pmksa() (nil)
> > Jan 04 08:57:33 titanium iwd[415831]: src/netdev.c:netdev_connect_ok()
> > Jan 04 08:57:33 titanium iwd[415831]:
> > src/station.c:station_connect_cb() 7, result: 0
> > Jan 04 08:57:33 titanium iwd[415831]: src/station.c:station_connect_ok(=
)
> > Jan 04 08:57:33 titanium iwd[415831]: event: state, old: connecting
> > (auto), new: connecting (netconfig)
> > Jan 04 08:57:33 titanium iwd[415831]:
> > src/wiphy.c:wiphy_radio_work_done() Work item 713 done
> > Jan 04 08:57:33 titanium iwd[415831]:
> > src/netdev.c:netdev_link_notify() event 16 on ifindex 7
> > Jan 04 08:57:34 titanium iwd[415831]:
> > src/netdev.c:netdev_link_notify() event 16 on ifindex 7
> > Jan 04 08:57:34 titanium iwd[415831]:
> > src/netdev.c:netdev_mlme_notify() MLME notification Del Station(20)
> > Jan 04 08:57:34 titanium iwd[415831]:
> > src/netdev.c:netdev_mlme_notify() MLME notification Deauthenticate(39)
> > Jan 04 08:57:34 titanium iwd[415831]: src/netdev.c:netdev_deauthenticat=
e_event()
> > Jan 04 08:57:34 titanium iwd[415831]:
> > src/netdev.c:netdev_mlme_notify() MLME notification Disconnect(48)
> > Jan 04 08:57:34 titanium iwd[415831]: src/netdev.c:netdev_disconnect_ev=
ent()
> > Jan 04 08:57:34 titanium iwd[415831]: Received Deauthentication event,
> > reason: 4, from_ap: false
> > Jan 04 08:57:34 titanium iwd[415831]: src/station.c:station_disconnect_=
event() 7
> > Jan 04 08:57:34 titanium iwd[415831]: event: disconnect-info, reason: 4
> So we get this disconnect immediately after connecting. Was there any
> kernel logs here? I'm expecting to see something from iwlwifi like
> "connection lost". Unfortunately userspace has no control over this type
> of disconnect. The kernel disconnected for some reason and is notifying
> userspace. If you do see an improvement with wpa_supplicant using the
> same kernel/firmware that would be odd, and would warrant a closer look
> at IWD itself.
> > Jan 04 08:57:34 titanium iwd[415831]: src/station.c:station_disassociat=
ed() 7
> > Jan 04 08:57:34 titanium iwd[415831]:
> > src/station.c:station_reset_connection_state() 7
> > Jan 04 08:57:34 titanium iwd[415831]: src/station.c:station_roam_state_=
clear() 7
> > Jan 04 08:57:34 titanium iwd[415831]: event: state, old: connecting
> > (netconfig), new: disconnected
> > Jan 04 08:57:34 titanium iwd[415831]: event: state, old: disconnected,
> > new: autoconnect_quick
> > Jan 04 08:57:34 titanium iwd[415831]:
> > src/wiphy.c:wiphy_radio_work_insert() Inserting work item 714
> > Jan 04 08:57:34 titanium iwd[415831]:
> > src/wiphy.c:wiphy_radio_work_next() Starting work item 714
> > Jan 04 08:57:34 titanium iwd[415831]:
> > src/netdev.c:netdev_link_notify() event 16 on ifindex 7
> > Jan 04 08:57:34 titanium iwd[415831]: src/scan.c:scan_notify() Scan
> > notification Trigger Scan(33)
> > Jan 04 08:57:34 titanium iwd[415831]:
> > src/scan.c:scan_request_triggered() Active scan triggered for wdev 6
> > Jan 04 08:57:34 titanium iwd[415831]:
> > src/station.c:station_quick_scan_triggered() Quick scan triggered for
> > wlan0
> > Jan 04 08:57:35 titanium iwd[415831]: src/scan.c:scan_notify() Scan
> > notification New Scan Results(34)
> > Jan 04 08:57:35 titanium iwd[415831]:
> > src/netdev.c:netdev_link_notify() event 16 on ifindex 7
> > Jan 04 08:57:35 titanium iwd[415831]:
> > src/station.c:station_print_scan_bss() Processing BSS
> > '60:38:e0:3d:f0:b2' with SSID: Tronx_Lower, freq: 2447, rank: 177,
> > strength: -7700, data_rate: 21.7, load: 24/255, clients: 1
> > Jan 04 08:57:35 titanium iwd[415831]:
> > src/station.c:station_print_scan_bss() Processing BSS
> > 'c8:78:7d:e6:d3:53' with SSID: Tronx_Middle, freq: 2447, rank: 118,
> > strength: -7800, data_rate: 14.4, load: 25/255, clients: 5
> > Jan 04 08:57:35 titanium iwd[415831]:
> > src/station.c:station_print_scan_bss() Processing BSS
> > 'b0:38:29:18:14:0f' with SSID: Omni10_Setup_40F, freq: 2462, rank: 75,
> > strength: -8300, data_rate: 11.0
> > Jan 04 08:57:35 titanium iwd[415831]:
> > src/station.c:station_print_scan_bss() Processing BSS
> > '22:d2:cc:07:9c:b5' with SSID: Tronx_Upper, freq: 2422, rank: 75,
> > strength: -8300, data_rate: 11.0
> > Jan 04 08:57:35 titanium iwd[415831]: src/station.c:station_autoconnect=
_start()
> > Jan 04 08:57:35 titanium iwd[415831]:
> > src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
> > Tronx_Upper
> > Jan 04 08:57:35 titanium iwd[415831]:
> > src/station.c:station_autoconnect_next() autoconnect:
> > '22:d2:cc:07:9c:b5' freq: 2422, rank: 75, strength: -8300
> > Jan 04 08:57:35 titanium iwd[415831]: src/netdev.c:netdev_cqm_rssi_upda=
te()
> > Jan 04 08:57:35 titanium iwd[415831]:
> > src/wiphy.c:wiphy_radio_work_insert() Inserting work item 715
> > Jan 04 08:57:35 titanium iwd[415831]: event: connect-info, ssid:
> > Tronx_Upper, bss: 22:d2:cc:07:9c:b5, signal: -83, load: 0/255
> > Jan 04 08:57:35 titanium iwd[415831]: event: state, old:
> > autoconnect_quick, new: connecting (auto)
> > Jan 04 08:57:35 titanium iwd[415831]: src/scan.c:scan_cancel() Trying
> > to cancel scan id 714 for wdev 6
> > Jan 04 08:57:35 titanium iwd[415831]:
> > src/wiphy.c:wiphy_radio_work_done() Work item 714 done
> >
> > Let me know if you need to see anything else :)
> >
> > Thanks again!
> >
> > On Sat, Jan 4, 2025 at 12:25=E2=80=AFAM James Prestwood <prestwoj@gmail=
.com> wrote:
> >> Hi,
> >>
> >> On 1/3/25 2:16 PM, Owen Garland wrote:
> >>> Hej all,
> >>>
> >>> I couldn't find an issue tracker so I am trying here. Essentially my
> >>> problem is I get deauthenticated from AP's at seemingly random
> >>> intervals, with `reason: 4`.
> >>>
> >>> iwd --version: 3.3
> >>> OS: Arch-Linux 6.11.9-arch1-1
> >>> Device: Dell XPS 9370
> >>> Network controller: Intel Corporation Wireless 8265 / 8275 (rev 78)
> >>>           Subsystem: Intel Corporation Device 8050
> >>>           Kernel driver in use: iwlwifi
> >>>           Kernel modules: iwlwifi
> >>> iwconfig:
> >>>     wlan0     IEEE 802.11  ESSID:"Tronx_Upper"
> >>>              Mode:Managed  Frequency:2.422 GHz  Access Point: 22:D2:C=
C:07:9C:B5
> >>>              Bit Rate=3D65 Mb/s   Tx-Power=3D22 dBm
> >>>              Retry short limit:7   RTS thr:off   Fragment thr:off
> >>>              Power Management:off
> >>>              Link Quality=3D31/70  Signal level=3D-79 dBm
> >>>              Rx invalid nwid:0  Rx invalid crypt:0  Rx invalid frag:0
> >>>              Tx excessive retries:209  Invalid misc:664   Missed beac=
on:0
> >>>
> >>> The logs from `journactl -u iwd` show this:
> >>>
> >>> Jan 03 21:52:09 titanium systemd[1]: Starting Wireless service...
> >>> Jan 03 21:52:09 titanium iwd[318201]: Wireless daemon version 3.3
> >>> Jan 03 21:52:09 titanium iwd[318201]: Loaded configuration from
> >>> /etc/iwd/main.conf
> >>> Jan 03 21:52:09 titanium systemd[1]: Started Wireless service.
> >>> Jan 03 21:52:09 titanium iwd[318201]: Wiphy: 0, Name: phy0
> >>> Jan 03 21:52:09 titanium iwd[318201]:         Permanent Address:
> >>> 64:5d:86:ed:80:5a
> >>> Jan 03 21:52:09 titanium iwd[318201]:         2.4GHz Band:
> >>> Jan 03 21:52:09 titanium iwd[318201]:                 Bitrates (non-H=
T):
> >>> Jan 03 21:52:09 titanium iwd[318201]:                          1.0 Mb=
ps
> >>> Jan 03 21:52:09 titanium iwd[318201]:                          2.0 Mb=
ps
> >>> Jan 03 21:52:09 titanium iwd[318201]:                          5.5 Mb=
ps
> >>> Jan 03 21:52:09 titanium iwd[318201]:                         11.0 Mb=
ps
> >>> Jan 03 21:52:09 titanium iwd[318201]:                          6.0 Mb=
ps
> >>> Jan 03 21:52:09 titanium iwd[318201]:                          9.0 Mb=
ps
> >>> Jan 03 21:52:09 titanium iwd[318201]:                         12.0 Mb=
ps
> >>> Jan 03 21:52:09 titanium iwd[318201]:                         18.0 Mb=
ps
> >>> Jan 03 21:52:09 titanium iwd[318201]:                         24.0 Mb=
ps
> >>> Jan 03 21:52:09 titanium iwd[318201]:                         36.0 Mb=
ps
> >>> Jan 03 21:52:09 titanium iwd[318201]:                         48.0 Mb=
ps
> >>> Jan 03 21:52:09 titanium iwd[318201]:                         54.0 Mb=
ps
> >>> Jan 03 21:52:09 titanium iwd[318201]:                 HT Capabilities=
:
> >>> Jan 03 21:52:09 titanium iwd[318201]:                         HT40
> >>> Jan 03 21:52:09 titanium iwd[318201]:                         Short G=
I for 20Mhz
> >>> Jan 03 21:52:09 titanium iwd[318201]:                         Short G=
I for 40Mhz
> >>> Jan 03 21:52:09 titanium iwd[318201]:                 HT RX MCS index=
es:
> >>> Jan 03 21:52:09 titanium iwd[318201]:                         0-15
> >>> Jan 03 21:52:09 titanium iwd[318201]:         5GHz Band:
> >>> Jan 03 21:52:09 titanium iwd[318201]:                 Bitrates (non-H=
T):
> >>> Jan 03 21:52:09 titanium iwd[318201]:                          6.0 Mb=
ps
> >>> Jan 03 21:52:09 titanium iwd[318201]:                          9.0 Mb=
ps
> >>> Jan 03 21:52:09 titanium iwd[318201]:                         12.0 Mb=
ps
> >>> Jan 03 21:52:09 titanium iwd[318201]:                         18.0 Mb=
ps
> >>> Jan 03 21:52:09 titanium iwd[318201]:                         24.0 Mb=
ps
> >>> Jan 03 21:52:09 titanium iwd[318201]:                         36.0 Mb=
ps
> >>> Jan 03 21:52:09 titanium iwd[318201]:                         48.0 Mb=
ps
> >>> Jan 03 21:52:09 titanium iwd[318201]:                         54.0 Mb=
ps
> >>> Jan 03 21:52:09 titanium iwd[318201]:                 HT Capabilities=
:
> >>> Jan 03 21:52:09 titanium iwd[318201]:                         HT40
> >>> Jan 03 21:52:09 titanium iwd[318201]:                         Short G=
I for 20Mhz
> >>> Jan 03 21:52:09 titanium iwd[318201]:                         Short G=
I for 40Mhz
> >>> Jan 03 21:52:09 titanium iwd[318201]:                 HT RX MCS index=
es:
> >>> Jan 03 21:52:09 titanium iwd[318201]:                         0-15
> >>> Jan 03 21:52:09 titanium iwd[318201]:                 VHT Capabilitie=
s:
> >>> Jan 03 21:52:09 titanium iwd[318201]:                         Short G=
I for 80Mhz
> >>> Jan 03 21:52:09 titanium iwd[318201]:                         Max RX
> >>> MCS: 0-9 for NSS: 2
> >>> Jan 03 21:52:09 titanium iwd[318201]:                         Max TX
> >>> MCS: 0-9 for NSS: 2
> >>> Jan 03 21:52:09 titanium iwd[318201]:         Ciphers: BIP-CMAC-128
> >>> CCMP-128 TKIP
> >>> Jan 03 21:52:09 titanium iwd[318201]:         Supported iftypes:
> >>> ad-hoc station ap p2p-client p2p-go p2p-device
> >>> Jan 03 21:52:09 titanium iwd[318201]: event: state, old: disconnected=
,
> >>> new: autoconnect_quick
> >>> Jan 03 21:52:09 titanium iwd[318201]: udev interface=3Dwlan0 ifindex=
=3D6
> >>> Jan 03 21:52:10 titanium iwd[318201]: event: connect-info, ssid:
> >>> Tronx_Upper, bss: 22:d2:cc:07:9c:b5, signal: -79, load: 0/255
> >>> Jan 03 21:52:10 titanium iwd[318201]: event: state, old:
> >>> autoconnect_quick, new: connecting (auto)
> >>> Jan 03 21:52:10 titanium iwd[318201]: event: state, old: connecting
> >>> (auto), new: connecting (netconfig)
> >>> Jan 03 21:52:10 titanium iwd[318201]: event: state, old: connecting
> >>> (netconfig), new: connected
> >>> Jan 03 21:52:15 titanium iwd[318201]: event: roam-scan,
> >>> <truncated>
> >>> Jan 03 22:41:53 titanium iwd[318201]: Received Deauthentication event=
,
> >>> reason: 4, from_ap: false
> >>> Jan 03 22:41:53 titanium iwd[318201]: event: disconnect-info, reason:=
 4
> >>> Jan 03 22:41:53 titanium iwd[318201]: event: state, old: connected,
> >>> new: disconnected
> >>> Jan 03 22:41:53 titanium iwd[318201]: event: state, old: disconnected=
,
> >>> new: autoconnect_quick
> >>> Jan 03 22:41:54 titanium iwd[318201]: event: state, old:
> >>> autoconnect_quick, new: autoconnect_full
> >>> Jan 03 22:42:13 titanium iwd[318201]: event: connect-info, ssid:
> >>> Tronx_Upper, bss: 22:d2:cc:07:9c:b5, signal: -79, load: 0/255
> >>> Jan 03 22:42:13 titanium iwd[318201]: event: state, old:
> >>> autoconnect_full, new: connecting (auto)
> >>> Jan 03 22:42:17 titanium iwd[318201]: event: state, old: connecting
> >>> (auto), new: connecting (netconfig)
> >>> Jan 03 22:42:18 titanium iwd[318201]: event: state, old: connecting
> >>> (netconfig), new: connected
> >>>
> >>> This then appears to happen several times, and at seemingly random
> >>> intervals. It can be fine for several hours, then there is one
> >>> disconnect, or there may be a few disconnects in a short time. As an
> >>> example the 28th had this:
> >>>
> >>>    Dec 28 15:40:49 titanium iwd[869]: Received Deauthentication event=
,
> >>> reason: 4, from_ap: false
> >>>    Dec 28 15:41:12 titanium iwd[869]: Received Deauthentication event=
,
> >>> reason: 4, from_ap: false
> >>>    Dec 28 16:02:27 titanium iwd[869]: Received Deauthentication event=
,
> >>> reason: 4, from_ap: false
> >>>    Dec 28 16:13:12 titanium iwd[869]: Received Deauthentication event=
,
> >>> reason: 4, from_ap: false
> >>>    Dec 28 16:13:27 titanium iwd[869]: Received Deauthentication event=
,
> >>> reason: 4, from_ap: false
> >>>    Dec 28 16:34:55 titanium iwd[869]: Received Deauthentication event=
,
> >>> reason: 4, from_ap: false
> >>>    Dec 28 17:02:41 titanium iwd[869]: Received Deauthentication event=
,
> >>> reason: 4, from_ap: false
> >>>    Dec 28 17:11:34 titanium iwd[869]: Received Deauthentication event=
,
> >>> reason: 4, from_ap: false
> >>>    Dec 28 17:16:38 titanium iwd[869]: Received Deauthentication event=
,
> >>> reason: 4, from_ap: false
> >>>    Dec 28 17:20:27 titanium iwd[869]: Received Deauthentication event=
,
> >>> reason: 4, from_ap: false
> >>>    Dec 28 17:25:01 titanium iwd[869]: Received Deauthentication event=
,
> >>> reason: 4, from_ap: false
> >>>    Dec 28 18:52:40 titanium iwd[869]: Received Deauthentication event=
,
> >>> reason: 4, from_ap: false
> >>>    Dec 28 20:21:20 titanium iwd[869]: Received Deauthentication event=
,
> >>> reason: 4, from_ap: false
> >>>    Dec 28 20:21:28 titanium iwd[869]: Received Deauthentication event=
,
> >>> reason: 4, from_ap: false
> >>>    Dec 28 20:21:46 titanium iwd[869]: Received Deauthentication event=
,
> >>> reason: 4, from_ap: false
> >>>    Dec 28 21:07:33 titanium iwd[869]: Received Deauthentication event=
,
> >>> reason: 4, from_ap: false
> >> Were there any additional kernel/IWD logs at those time? Its probably
> >> best to enable IWD debugging with the "-d" flag.
> >>
> >> This reason code is "Disassociated due to inactivity" and a local
> >> disconnect, which we see in our deployments as well. Is your device
> >> operating in low RSSI conditions? I see when you connected the RSSI wa=
s
> >> -79 which is at or at least very quickly approaching unusable connecti=
on
> >> quality. I suspect this i
> >>
> >>> My investigations haven't led to much, not having a publicly viewable
> >>> issue tracker is certainly not helping. I have found a few other
> >>> threads where people have had this issue, however none of the propose=
d
> >>> remedies have made an impact. The one thing I did try was disabling
> >>> powersaving by adding this to my config:
> >>>
> >>> ~ =CE=BB cat /etc/modprobe.d/iwlwifi.conf
> >>> options iwlmvm power_scheme=3D1
> >>> options iwlwifi power_save=3D0
> >>>
> >>>    Any suggestions on where to take this, and let me know if I can
> >>> provide you with any further information.
> >>>
> >>> Thanks for making open source software <3
> >>>
