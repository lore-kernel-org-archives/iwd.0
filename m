Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB43288D2
	for <iwd@lists.linux.dev>; Mon,  3 Mar 2025 13:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741006976; cv=none; b=HRdWAEqC2ZcZDGTKyEODuULrwd6RQ3x1qEl30nE3L8XC9JhbSLG7XaeUlxb9u/xWIP5aM5rHanMBq05G6dToYDKrHIC3zmc/Do/e2g5ARjxSL9zN2XkERX4PefKrg1Y33s0h7251NcEWg/poylZvzH7vYF7DQFAMOrqJZJUjWKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741006976; c=relaxed/simple;
	bh=uc3BW3L/cUoKwQRzKialgRTky/gYk9VWyE8mza8gaT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=aJv5bEb8RY6/JmW8dESDzWfRiobd79IQ6Cij5IC2iUXWqq2gsv7m45yYvfSj5eqmXNuH9YgzUEtLtCnK3xsjt1yPhAE2BLkSSPQB9u2pXr0dytI3IDW2XuOgGabJaLHEu+3b9EsV2bRehP+XpRrjiZTamdeM02QlDShylah9WHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SRGUYulk; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRGUYulk"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ff04f36fd2so1453960a91.1
        for <iwd@lists.linux.dev>; Mon, 03 Mar 2025 05:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741006974; x=1741611774; darn=lists.linux.dev;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wHY+Z418+IrbOK17DncbUl2OZOG6hmISqzhQUjDU3Jg=;
        b=SRGUYulkBFiBPJI2/afeXiQwZ21n1byjDD3hVmp/t3NLkziUirQN2FQYbLZD1gO64p
         0ZfGGzWY6r8DD70rMcAzE2lRnt5Cgp5o7SeFoIxXYh1cSpNLJu1UoL2a2mSrlEi35ZJJ
         SbIbJcVpBOZeufqrti3au+jz9qg2o0vjw0Pn9V3xNSLXuVJdZgc3T+R2CEYJD1X+d5Ep
         xAqYU8gZ5FP0rz+kyfzEQOqEH9yOLEpOBvo7XHTN6Vnz6Z2R8cKEfk1Cb9Rk5wPPDIJT
         kFKu2ge2mLnOLuMm84ZGztX4LEyrH+w9dnadUAbl4CLQCA+hxfjNPsCPkPAiQ/GKWv50
         jdXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741006974; x=1741611774;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wHY+Z418+IrbOK17DncbUl2OZOG6hmISqzhQUjDU3Jg=;
        b=X86BvB0sWI+5zBwNakHUqqM4a89sx5MXfgvebaDqvidG1UzjzzezpE9UWtSNgbFy/T
         /1CNHLcsGGV74SMTV57ANBhNL+2ABQa8GaQnvrPKFvtcYb7Pgkm9ra0XoSAW+S+6y3lo
         oSFbRU+YVu2P0sKO4Y96aM7ngIFp4tT2j0/UJ0GdAJqczHXJm8U2FfRb4+i8f/7sDYYP
         WhwsBLghST+K+ntDYHxpnQuQ8pLD94w6CwhlWobo+dTVxgDGkJAKGCCQrbk7GKydvFz9
         PVkbWrOXmUz8DA/ILasR7BmqFDtLIwcXVVMzKCBousBARNYiEjAChy4m35OJKtcyf0oi
         Zmxg==
X-Gm-Message-State: AOJu0Yz5Hg/+5GeA51sKrE9lujKmd8FhuhOc/zxWQ6h317hsSbH5i0WP
	dJQlNyCjbbNVlObf9pPYrFIciEhCNJTePvoLsfgNckgsisTQA4b9nz3HZsCQS9GsnHRnuJaw4lF
	Qkzo0GB0MPyj+adwzpkydB6kZD9UD3w==
X-Gm-Gg: ASbGncuxNO6d+Tg7f0BO2xzksjKBEIFHddD+/4TyX/K7Rt7QGaaB5gWkGyDvXpT967a
	qPp5PdPSW2q5LhaJpJZMoer9ABB578NsUuvCL2GIXmt7w1+id2hA5iRTKI1CTEjz/h6Co7W9L0e
	N6RsVSnaFzJhCztDBiFihkDl5QBGyIU0QO5WoH5G/PJuKpr+bSwVib7y/orVlq
X-Google-Smtp-Source: AGHT+IFyRsv91TxZM2ZhMv6ohllGmhdCgLmdxHnHxflFuVS19YET7UqQDg9+VsKBHvNGSXHTTeWNT9j9EBYthgxKF5w=
X-Received: by 2002:a17:90a:e703:b0:2fe:a742:51b0 with SMTP id
 98e67ed59e1d1-2febabf8272mr18733851a91.31.1741006972089; Mon, 03 Mar 2025
 05:02:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAG17S_Pxv86uZ9hQe_upS8ybu6KDpXxhUYDa-q=R6muWSYXu+g@mail.gmail.com>
 <CAG17S_NWzR7DtwVYPRFRkLHzfp1mAnK5_yC_pgNHaA79fVASRg@mail.gmail.com>
In-Reply-To: <CAG17S_NWzR7DtwVYPRFRkLHzfp1mAnK5_yC_pgNHaA79fVASRg@mail.gmail.com>
From: KeithG <ys3al35l@gmail.com>
Date: Mon, 3 Mar 2025 07:02:40 -0600
X-Gm-Features: AQ5f1JrwMDDeHVRjmEUE3rFBdHQNFPw0W1oVdgQ8ugGRevLIMJr44oUx2y-xnWI
Message-ID: <CAG17S_P+E9o-_OZQ2s4NewFWtf8qx+DrFPvOM6Cbtz4Yed_A0A@mail.gmail.com>
Subject: Re: Suddenly, no DHCP
To: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 1, 2025 at 10:32=E2=80=AFPM KeithG <ys3al35l@gmail.com> wrote:
>
> On Sat, Mar 1, 2025 at 10:47=E2=80=AFAM KeithG <ys3al35l@gmail.com> wrote=
:
> >
> > Group,
> >
> > I am flummoxed. I have an image that I had been using to connect to a
> > WPA2 SSID and it has been working for a very long time. It suddenly
> > quit connecting. This is an Rpi Zero2w with the brcmfmac 43430 chip. I
> > am running bookworm with kernel 6.6.77. When I set iwd to debug, I get
> > this:
> > Mar 01 09:58:38 zero2w connmand[29811]: Interface wlan0 [ wifi ] state
> > is association
> > Mar 01 09:58:38 zero2w iwd[29733]: src/network.c:network_connect()
> > Mar 01 09:58:38 zero2w iwd[29733]: src/network.c:network_connect_psk()
> > ask_passphrase: true
> > Mar 01 09:58:38 zero2w iwd[29733]:
> > src/agent.c:agent_request_passphrase() agent 0x5569b85c50 owner :1.896
> > path /net/connman/iwd_agent
> > Mar 01 09:58:38 zero2w iwd[29733]:
> > src/agent.c:agent_send_next_request() send request to :1.896
> > /net/connman/iwd_agent
> > Mar 01 09:58:38 zero2w iwd[29733]: src/agent.c:agent_receive_reply()
> > agent 0x5569b85c50 request id 136
> > Mar 01 09:58:38 zero2w iwd[29733]: src/network.c:passphrase_callback() =
result 0
> > Mar 01 09:58:38 zero2w iwd[29733]:
> > src/network.c:network_generate_sae_pt() Generating PT for Group 19
> > Mar 01 09:58:38 zero2w iwd[29733]:
> > src/network.c:network_generate_sae_pt() Generating PT for Group 20
> > Mar 01 09:58:38 zero2w iwd[29733]: src/netdev.c:netdev_cqm_rssi_update(=
)
> > Mar 01 09:58:38 zero2w iwd[29733]:
> > src/wiphy.c:wiphy_radio_work_insert() Inserting work item 5
> > Mar 01 09:58:38 zero2w iwd[29733]: src/wiphy.c:wiphy_radio_work_next()
> > Starting work item 5
> > Mar 01 09:58:38 zero2w iwd[29733]: event: connect-info, ssid: spg5,
> > bss: bc:2e:48:fd:9e:70, signal: -37, load: 22/255
> > Mar 01 09:58:38 zero2w iwd[29733]: event: state, old:
> > autoconnect_full, new: connecting
> > Mar 01 09:58:38 zero2w iwd[29733]: src/scan.c:scan_periodic_stop()
> > Stopping periodic scan for wdev 1
> > Mar 01 09:58:38 zero2w iwd[29733]:
> > src/netdev.c:netdev_cmd_set_cqm_cb() CMD_SET_CQM not supported,
> > falling back to polling
> > Mar 01 09:58:38 zero2w connmand[29811]: Interface wlan0 [ wifi ] state
> > is configuration
> > Mar 01 09:58:39 zero2w systemd[1]: Reloading.
> > Mar 01 09:58:43 zero2w kernel: sh (31068): drop_caches: 3
> > Mar 01 09:59:19 zero2w avahi-daemon[261]: Joining mDNS multicast group
> > on interface wlan0.IPv4 with address 169.254.3.191.
> > Mar 01 09:59:19 zero2w avahi-daemon[261]: New relevant interface
> > wlan0.IPv4 for mDNS.
> > Mar 01 09:59:19 zero2w avahi-daemon[261]: Registering new address
> > record for 169.254.3.191 on wlan0.IPv4.
> > Mar 01 09:59:19 zero2w connmand[29811]: Interface wlan0 [ wifi ] state =
is ready
> > Mar 01 09:59:19 zero2w connmand[29811]: wlan0 {add} address
> > 169.254.3.191/16 label wlan0 family 2
> > Mar 01 09:59:24 zero2w dbus-daemon[264]: [system] Activating via
> > systemd: service name=3D'org.freedesktop.timedate1'
> > unit=3D'dbus-org.freedesktop.timedate1.service' requested by ':1.946'
> > (uid=3D0 pid=3D31657 comm=3D"timedatectl show -a")
> > Mar 01 09:59:24 zero2w systemd[1]: Starting systemd-timedated.service
> > - Time & Date Service...
> > Mar 01 09:59:25 zero2w dbus-daemon[264]: [system] Successfully
> > activated service 'org.freedesktop.timedate1'
> > Mar 01 09:59:25 zero2w systemd[1]: Started systemd-timedated.service -
> > Time & Date Service.
> > Mar 01 09:59:42 zero2w iwd[29733]: src/netdev.c:netdev_link_notify()
> > event 16 on ifindex 4
> >
> > Mar 01 09:58:38 kitchenrune iwd[29733]:
> > src/netdev.c:netdev_cmd_set_cqm_cb() CMD_SET_CQM not supported,
> > falling back to polling
> > Mar 01 09:58:38 kitchenrune connmand[29811]: Interface wlan0 [ wifi ]
> > state is configuration
> > Mar 01 09:58:39 kitchenrune systemd[1]: Reloading.
> > Mar 01 09:58:43 kitchenrune kernel: sh (31068): drop_caches: 3
> > Mar 01 09:59:19 kitchenrune avahi-daemon[261]: Joining mDNS multicast
> > group on interface wlan0.IPv4 with address 169.254.3.191.
> > Mar 01 09:59:19 kitchenrune avahi-daemon[261]: New relevant interface
> > wlan0.IPv4 for mDNS.
> > Mar 01 09:59:19 kitchenrune avahi-daemon[261]: Registering new address
> > record for 169.254.3.191 on wlan0.IPv4.
> > Mar 01 09:59:19 kitchenrune connmand[29811]: Interface wlan0 [ wifi ]
> > state is ready
> > Mar 01 09:59:19 kitchenrune connmand[29811]: wlan0 {add} address
> > 169.254.3.191/16 label wlan0 family 2
> > Mar 01 09:59:24 kitchenrune dbus-daemon[264]: [system] Activating via
> > systemd: service name=3D'org.freedesktop.timedate1'
> > unit=3D'dbus-org.freedesktop.timedate1.service' requested by ':1.946'
> > (uid=3D0 pid=3D31657 comm=3D"timedatectl show -a")
> > Mar 01 09:59:24 kitchenrune systemd[1]: Starting
> > systemd-timedated.service - Time & Date Service...
> > Mar 01 09:59:25 kitchenrune dbus-daemon[264]: [system] Successfully
> > activated service 'org.freedesktop.timedate1'
> > Mar 01 09:59:25 kitchenrune systemd[1]: Started
> > systemd-timedated.service - Time & Date Service.
> > Mar 01 09:59:42 kitchenrune iwd[29733]:
> > src/netdev.c:netdev_link_notify() event 16 on ifindex 4
> >
> > as you can see, it does not get a DHCP address, but gets an APIPA
> > address. Any ideas what might be going on? I have tried rebooting the
> > Pi and also rebooted the DHCP server and restarted the router.
>
> Built a fresh kernel so I could get iwmon and tried again. This is a
> WPA2 ssid and all my other devices connect and this particular device
> connected up until this morning. I don't think I did anything to break
> it and the rest of my devices are still connected.
> What is missing?
> The attempted connect results in this:
> Journal:
> Mar 01 22:20:28 zero2w iwd[15809]: event: connect-info, FullMAC
> driver: brcmfmac using SAE.  Expect EXTERNAL_AUTH
> Mar 01 22:20:32 zero2w connmand[15858]: Interface wlan0 [ wifi ] state
> is association
> Mar 01 22:20:32 zero2w iwd[15809]: event: connect-info, ssid: spg5,
> bss: bc:2e:48:fd:9e:70, signal: -44, load: 39/255
> Mar 01 22:20:32 zero2w iwd[15809]: event: state, old:
> autoconnect_full, new: connecting
> Mar 01 22:20:32 zero2w connmand[15858]: Interface wlan0 [ wifi ] state
> is configuration
> Mar 01 22:21:13 zero2w connmand[15858]: Interface wlan0 [ wifi ] state is=
 ready
> Mar 01 22:21:13 zero2w connmand[15858]: wlan0 {add} address
> 169.254.62.170/16 label wlan0 family 2
>
> iwmon:
> > Response: Set CQM (0x3f) len 4                                      18.=
193961
>     Status: Operation not supported (95)
> < Request: Connect (0x2e) len 176 [ack]                               18.=
194060
>     Interface Index: 3 (0x00000003)
>     Wiphy Frequency: 2422 (0x00000976)
>     MAC Address BC:2E:48:FD:9E:70
>     SSID: len 4
>         73 70 67 35                                      spg5
>     Auth Type: 0 (0x00000000)
>     PMK: 254 len 32
>         e3 d8 60 09 bb db 40 a5 ea 9c 81 1a 96 87 32 f9  ..`...@.......2.
>         2b f9 9c 4e 91 96 76 4c 55 5b 06 0a 14 5e a3 ca  +..N..vLU[...^..
>     Privacy: true
>     Socket Owns Interface/Connection: true
>     Cipher Suites Pairwise:
>         CCMP (00:0f:ac) suite  04
>     Cipher Suite Group: CCMP (00:0f:ac) suite  04
>     Use MFP: 1 (0x00000001)
>     AKM Suites:
>         PSK; RSNA PSK (00:0f:ac) suite  02
>     WPA Versions: 2 (0x00000002)
>     Control Port: true
>     Information Elements: len 38
>         RSN:
>             Group Data Cipher Suite: len 4
>                 CCMP (00:0f:ac) suite  04
>             Pairwise Cipher Suite: len 4
>                 CCMP (00:0f:ac) suite  04
>             AKM Suite: len 4
>                 PSK; RSNA PSK (00:0f:ac) suite  02
>             RSN capabilities: bits  2 - 3: 1 replay counter per PTKSA
>             RSN capabilities: bits  4 - 5: 1 replay counter per GTKSA
>             RSN capabilities: bit  7: Management Frame Protection Capable
>             01 00 00 0f ac 04 01 00 00 0f ac 04 01 00 00 0f  ............=
....
>             ac 02 80 00                                      ....
>         Extended Capabilities: len 10
>             Capability: bit 19: BSS transition
>             00 00 08 00 00 00 00 00 00 01                    ..........
>         Tag 262: len 1
>             1a                                               .
> > Response: Connect (0x2e) len 4 [0x100]                              18.=
226572
>     Status: Success (0)
> < Request: Get Station (0x11) len 20 [ack]                            19.=
194156
>     Interface Index: 3 (0x00000003)
>     MAC Address BC:2E:48:FD:9E:70
> > Result: New Station (0x13) len 164                                  19.=
196463
>     Interface Index: 3 (0x00000003)
>     MAC Address BC:2E:48:FD:9E:70
>     Generation: 0 (0x00000000)
>     Station Info: len 132
>         Connected time: 0 (0x00000000)
>         Inactivity time: 0 (0x00000000)
>         Total RX bytes: 308 (0x00000134)
>         Total TX bytes: 145 (0x00000091)
>         TX bitrate: len 16
>             Bit Rate: 10 (0x0000000a)
>             Bit Rate (Legacy): 10 (0x000a)
>         RX bitrate: len 16
>             Bit Rate: 10 (0x0000000a)
>             Bit Rate (Legacy): 10 (0x000a)
>         RX packets: 2 (0x00000002)
>         TX packets: 1 (0x00000001)
>         TX failed: 0 (0x00000000)
>         BSS parameters: len 20
>             Short Slot Time: true
>             DTIM Period: 3 (0x03)
>             Beacon Interval: 100 (0x0064)
>         Station flags: len 8
>             Mask: 0x000000ea
>                 Authorized
>                 WME
>                 Authenticated
>                 TDLS-Peer
>                 Associated
>             Set: 0x000000a8
>                 WME
>                 Authenticated
>                 Associated
> > Response: Get Station (0x11) len 4 [0x100]                          19.=
196484
>     Status: Success (0)
> < RTNL: Get Link (0x12) len 36 [request]                              23.=
889242
>     Flags: 1 (0x001)
>     Sequence number: 1740889238 (0x67c3dc96)
>     Port ID: 0
> > RTNL: New Link (0x10) len 1072                                      23.=
889324
>     Flags: 0 (0x000)
>     Sequence number: 1740889238 (0x67c3dc96)
>     Port ID: 2976590107
>     IFLA Family: Unknown
>     IFLA Type: 1
>     IFLA Index: 3
>     IFLA ChangeMask: 0
>     IFLA Flags: (0x1003) [up,broadcast,multicast]
>         IfName (len:6): wlan0
>         Txqlen: 1000 (0x000003e8)
>         OperState: down (2)
>         LinkMode: userspace controlled (1)
>         MTU: 1500 (0x000005dc)
>         Reserved: len 4
>         Reserved: len 4
>         Reserved: len 4
>         Reserved: len 4
>         Reserved: len 4
>         Reserved: len 4
>         Reserved: len 4
>         Reserved: len 4
>         Reserved: len 4
>         Reserved: len 4
>         Reserved: len 4
>         Reserved: len 4
>         Reserved: len 4
>         Reserved: len 4
>         Reserved: len 1
>         Qdisc (len:11): pfifo_fast
>         Reserved: len 4
>         Reserved: len 4
>         Reserved: len 4
>         Reserved: len 1
>         Map: len 32
>             00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ............=
....
>             00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ............=
....
>         Interface Address: d8:3a:dd:a6:85:48
>         Broadcast Address: ff:ff:ff:ff:ff:ff
>         Reserved: len 200
>         Stats: len 96
>             00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ............=
....
>             00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ............=
....
>             00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ............=
....
>             00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ............=
....
>             00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ............=
....
>             00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ............=
....
>         Reserved: len 4
>         Reserved: len 8
>         Reserved: len 6
>         Reserved: len 412
>         Reserved: len 12
>         Reserved: len 5
>         Reserved: len 0
> < RTNL: Get Link (0x12) len 24 [request]                              23.=
889487
>     Flags: 1 (0x001)
>     Sequence number: 1740889238 (0x67c3dc96)
>     Port ID: 0
>     IFLA Family: Unknown
>     IFLA Type: 0
>     IFLA Index: 3
>     IFLA ChangeMask: 0
>     IFLA Flags: (0x00)
>         Reserved: len 4
> > RTNL: New Link (0x10) len 1072                                      23.=
889513
>     Flags: 0 (0x000)
>     Sequence number: 1740889238 (0x67c3dc96)
>     Port ID: 16898
>     IFLA Family: Unknown
>     IFLA Type: 1
>     IFLA Index: 3
>     IFLA ChangeMask: 0
>     IFLA Flags: (0x1003) [up,broadcast,multicast]
>         IfName (len:6): wlan0
>         Txqlen: 1000 (0x000003e8)
>         OperState: down (2)
>         LinkMode: userspace controlled (1)
>         MTU: 1500 (0x000005dc)
>         Reserved: len 4
>         Reserved: len 4
>         Reserved: len 4
>         Reserved: len 4
>         Reserved: len 4
>         Reserved: len 4
>         Reserved: len 4
>         Reserved: len 4
>         Reserved: len 4
>         Reserved: len 4
>         Reserved: len 4
>         Reserved: len 4
>         Reserved: len 4
>         Reserved: len 4
>         Reserved: len 1
>         Qdisc (len:11): pfifo_fast
>         Reserved: len 4
>         Reserved: len 4
>         Reserved: len 4
>         Reserved: len 1
>         Map: len 32
>             00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ............=
....
>             00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ............=
....
>         Interface Address: d8:3a:dd:a6:85:48
>         Broadcast Address: ff:ff:ff:ff:ff:ff
>         Reserved: len 200
>         Stats: len 96
>             00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ............=
....
>             00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ............=
....
>             00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ............=
....
>             00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ............=
....
>             00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ............=
....
>             00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ............=
....
>         Reserved: len 4
>         Reserved: len 8
>         Reserved: len 6
>         Reserved: len 412
>         Reserved: len 12
>         Reserved: len 5
>         Reserved: len 0
> > RTNL: Done (0x03) len 4 [multi,0x20]                                23.=
889572
>     Flags: 34 (0x022)
>     Sequence number: 1740889239 (0x67c3dc97)
>     Port ID: 16898
>     Status: 0
> < RTNL: Get Link (0x12) len 36 [request]                              23.=
903823
>     Flags: 1 (0x001)
>     Sequence number: 1740889238 (0x67c3dc96)
>     Port ID: 0
> > RTNL: New Link (0x10) len 1072                                      23.=
903907
>     Flags: 0 (0x000)
>     Sequence number: 1740889238 (0x67c3dc96)
>     Port ID: 3144330774
>     IFLA Family: Unknown
>     IFLA Type: 1
>     IFLA Index: 3
>     IFLA ChangeMask: 0
>     IFLA Flags: (0x1003) [up,broadcast,multicast]
>         IfName (len:6): wlan0
>         Txqlen: 1000 (0x000003e8)
>         OperState: down (2)
>         LinkMode: userspace controlled (1)
>         MTU: 1500 (0x000005dc)
>         Reserved: len 4
>         Reserved: len 4
>         Reserved: len 4
>         Reserved: len 4
>         Reserved: len 4
>         Reserved: len 4
>         Reserved: len 4
>         Reserved: len 4
>         Reserved: len 4
>         Reserved: len 4
>         Reserved: len 4
>         Reserved: len 4
>         Reserved: len 4
>         Reserved: len 4
>         Reserved: len 1
>         Qdisc (len:11): pfifo_fast
>         Reserved: len 4
>         Reserved: len 4
>         Reserved: len 4
>         Reserved: len 1
>         Map: len 32
>             00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ............=
....
>             00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ............=
....
>         Interface Address: d8:3a:dd:a6:85:48
>         Broadcast Address: ff:ff:ff:ff:ff:ff
>         Reserved: len 200
>         Stats: len 96
>             00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ............=
....
>             00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ............=
....
>             00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ............=
....
>             00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ............=
....
>             00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ............=
....
>             00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ............=
....
>         Reserved: len 4
>         Reserved: len 8
>         Reserved: len 6
>         Reserved: len 412
>         Reserved: len 12
>         Reserved: len 5
>         Reserved: len 0

Disregard.

No idea what was going on. No amount of rebooting the device, dhcp
server or router seemed to fix it. Was able to 'fix' it by enabling a
'guest' 2.4GHz SSID on the router then connecting the PiZero2W to the
guest SSID. After this event, it started connecting to the original
SSID. I even went and bought a new PiZero2W and tried connecting if it
turned out to be a hardware issue on the Pi. The other 2.5GHz devices
(thermostat and smoke detector) did not loose connection.

Keith
