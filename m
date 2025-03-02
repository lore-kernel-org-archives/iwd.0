Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAA07081E
	for <iwd@lists.linux.dev>; Sun,  2 Mar 2025 04:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740889975; cv=none; b=QR58x3gS+HPMlXb/PyIgLjQVKlvf0ZuJ4RZYM/f6aY60a4qXgoyWtOQ7SrMl2cQRLU+Y465T+CFgTlSBLj8/hqJTa5vwiUtY+z2Fwh2cpp8Hxefjz3DsSLPEKbAVPRdaBJepyeGI4ZWyrEWESrBi8vzyzg7wssI8UnBxEoEjbWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740889975; c=relaxed/simple;
	bh=TkuX61TfCPXlfJdNkklSoE/9fZXaxMps4Ujfv6O+tL0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=eypqBVx4BSP7zn2qRA2nca1j+JWSQMAMPl8CP6Rg/eafHq0Ge7DrEJI5Et6F69irlBGl4VoFYEw7N9CgrD5tpUVhJ5EcZ+vEkjo4sQR4dIRGRi12zO17CHWLcEzT6ouCtgPYAk7yMv5qLey3bF3FunBbSbP607CTTCeGSFn00Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YLexaPZA; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLexaPZA"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2f83a8afcbbso5832450a91.1
        for <iwd@lists.linux.dev>; Sat, 01 Mar 2025 20:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740889972; x=1741494772; darn=lists.linux.dev;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LmSMhbUMWSDoM+z7j0iRkCkwesTV641RhtkDlNK3Hok=;
        b=YLexaPZAAmfYkYdbePTVzA7iYFn5tj243mKH1fYA7xhm+s4fW06vP3ccjocr3nwTNA
         efaBc2GnB6JOd5BDLH2C9tJdYCi60egH4mNbADTnBiOa7eejVoOpX02u1jcN+6MxDjxl
         Rt7+2nxkZ0x/sCdvd7vIswNK0L2ZS4v268zr/z6j5C5dDmh85wydbJzXZ9QKfI1JDAl/
         rQZtwfMyij//AIWozSED/ATiEgVriCDJiD9dNWxngeEtzG1CPv8s8TMVojzcJD1EqFLY
         uxQJG3252X+A31q9p5SD1m1UbFG/Z9Oe+9Gqr+lfYAGnUgmNjtfJ2ABTQMFpyFgdS/T2
         C9Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740889972; x=1741494772;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LmSMhbUMWSDoM+z7j0iRkCkwesTV641RhtkDlNK3Hok=;
        b=QzvM7oCkBSzuewK4+aftp4wx04zBLAiig0eVZxJGpyk8sGds1XHmsvxar2g2p8AfGc
         ev/P1LNnWkiMlI5aM98xiWEyFKLLN5xupPeJ0FyJpOfUdfg0FrqN1iWHCVhuUPztnhjB
         3abFK8HMKnvCN3rchRrlE+OEg6meZH/YXvxbzmPdJuYF6r4/USw347q9JPCs14ZgPruP
         Uki/145z3CWtpCF1i1nl96ZTZJQFzlpBFyzmQ7qo5hRFOHtj8UIwtYN1Y5TbF7jho3rg
         J/IvfioRb/g5VKRQs3QUgCYo+iIy4/Vv0B8YRqz8kFABKbd2fZqwYNp3CH/IDkakp1Nb
         x/3A==
X-Gm-Message-State: AOJu0YyFcCu1u3Te6fNbqcgimgC7cCotf4RQdxMMdTxxZ2byI8UnI7Ep
	a06VVwBcvknCbb5MjRkJKULmBHpQ6gmvY9TAiHk3IZeMOlk4urSQQZjnjg5lGn9oXBu/xDBwrIZ
	TmlbB8U9xzcPGGzytTtRf3SRNBVdlWb3E
X-Gm-Gg: ASbGncvFQrEuMKdZNM92r0MP8/9YWgvcBhM3zQj+g448D7KG2xes3SgLhDAyTwmz6bz
	lku75NcwKHxp6Bgq/+ol32GxluD0q+ZtVgUl7MXGTW4N96/gS1ZWXM2te7HuK+7dsna0242TbcO
	5eZQYv8vi4Az23hiCFSUBzrTsvjA==
X-Google-Smtp-Source: AGHT+IE1QAW9JxZuRCvGtbrWkXqNUa+BOQL4mYwAqW2GoNnK2/k0r8l//EpGes4u2jeFDBS0DK49yqApI+d01FMG3R8=
X-Received: by 2002:a17:90a:d408:b0:2fa:603e:905c with SMTP id
 98e67ed59e1d1-2fea12683b9mr20803237a91.2.1740889972158; Sat, 01 Mar 2025
 20:32:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAG17S_Pxv86uZ9hQe_upS8ybu6KDpXxhUYDa-q=R6muWSYXu+g@mail.gmail.com>
In-Reply-To: <CAG17S_Pxv86uZ9hQe_upS8ybu6KDpXxhUYDa-q=R6muWSYXu+g@mail.gmail.com>
From: KeithG <ys3al35l@gmail.com>
Date: Sat, 1 Mar 2025 22:32:40 -0600
X-Gm-Features: AQ5f1JoppTMp0boBvYUXYXP97oq4f9K-EkSZyn2QiHPsaztP9CBfvf5TPCzcvSo
Message-ID: <CAG17S_NWzR7DtwVYPRFRkLHzfp1mAnK5_yC_pgNHaA79fVASRg@mail.gmail.com>
Subject: Re: Suddenly, no DHCP
To: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 1, 2025 at 10:47=E2=80=AFAM KeithG <ys3al35l@gmail.com> wrote:
>
> Group,
>
> I am flummoxed. I have an image that I had been using to connect to a
> WPA2 SSID and it has been working for a very long time. It suddenly
> quit connecting. This is an Rpi Zero2w with the brcmfmac 43430 chip. I
> am running bookworm with kernel 6.6.77. When I set iwd to debug, I get
> this:
> Mar 01 09:58:38 zero2w connmand[29811]: Interface wlan0 [ wifi ] state
> is association
> Mar 01 09:58:38 zero2w iwd[29733]: src/network.c:network_connect()
> Mar 01 09:58:38 zero2w iwd[29733]: src/network.c:network_connect_psk()
> ask_passphrase: true
> Mar 01 09:58:38 zero2w iwd[29733]:
> src/agent.c:agent_request_passphrase() agent 0x5569b85c50 owner :1.896
> path /net/connman/iwd_agent
> Mar 01 09:58:38 zero2w iwd[29733]:
> src/agent.c:agent_send_next_request() send request to :1.896
> /net/connman/iwd_agent
> Mar 01 09:58:38 zero2w iwd[29733]: src/agent.c:agent_receive_reply()
> agent 0x5569b85c50 request id 136
> Mar 01 09:58:38 zero2w iwd[29733]: src/network.c:passphrase_callback() re=
sult 0
> Mar 01 09:58:38 zero2w iwd[29733]:
> src/network.c:network_generate_sae_pt() Generating PT for Group 19
> Mar 01 09:58:38 zero2w iwd[29733]:
> src/network.c:network_generate_sae_pt() Generating PT for Group 20
> Mar 01 09:58:38 zero2w iwd[29733]: src/netdev.c:netdev_cqm_rssi_update()
> Mar 01 09:58:38 zero2w iwd[29733]:
> src/wiphy.c:wiphy_radio_work_insert() Inserting work item 5
> Mar 01 09:58:38 zero2w iwd[29733]: src/wiphy.c:wiphy_radio_work_next()
> Starting work item 5
> Mar 01 09:58:38 zero2w iwd[29733]: event: connect-info, ssid: spg5,
> bss: bc:2e:48:fd:9e:70, signal: -37, load: 22/255
> Mar 01 09:58:38 zero2w iwd[29733]: event: state, old:
> autoconnect_full, new: connecting
> Mar 01 09:58:38 zero2w iwd[29733]: src/scan.c:scan_periodic_stop()
> Stopping periodic scan for wdev 1
> Mar 01 09:58:38 zero2w iwd[29733]:
> src/netdev.c:netdev_cmd_set_cqm_cb() CMD_SET_CQM not supported,
> falling back to polling
> Mar 01 09:58:38 zero2w connmand[29811]: Interface wlan0 [ wifi ] state
> is configuration
> Mar 01 09:58:39 zero2w systemd[1]: Reloading.
> Mar 01 09:58:43 zero2w kernel: sh (31068): drop_caches: 3
> Mar 01 09:59:19 zero2w avahi-daemon[261]: Joining mDNS multicast group
> on interface wlan0.IPv4 with address 169.254.3.191.
> Mar 01 09:59:19 zero2w avahi-daemon[261]: New relevant interface
> wlan0.IPv4 for mDNS.
> Mar 01 09:59:19 zero2w avahi-daemon[261]: Registering new address
> record for 169.254.3.191 on wlan0.IPv4.
> Mar 01 09:59:19 zero2w connmand[29811]: Interface wlan0 [ wifi ] state is=
 ready
> Mar 01 09:59:19 zero2w connmand[29811]: wlan0 {add} address
> 169.254.3.191/16 label wlan0 family 2
> Mar 01 09:59:24 zero2w dbus-daemon[264]: [system] Activating via
> systemd: service name=3D'org.freedesktop.timedate1'
> unit=3D'dbus-org.freedesktop.timedate1.service' requested by ':1.946'
> (uid=3D0 pid=3D31657 comm=3D"timedatectl show -a")
> Mar 01 09:59:24 zero2w systemd[1]: Starting systemd-timedated.service
> - Time & Date Service...
> Mar 01 09:59:25 zero2w dbus-daemon[264]: [system] Successfully
> activated service 'org.freedesktop.timedate1'
> Mar 01 09:59:25 zero2w systemd[1]: Started systemd-timedated.service -
> Time & Date Service.
> Mar 01 09:59:42 zero2w iwd[29733]: src/netdev.c:netdev_link_notify()
> event 16 on ifindex 4
>
> Mar 01 09:58:38 kitchenrune iwd[29733]:
> src/netdev.c:netdev_cmd_set_cqm_cb() CMD_SET_CQM not supported,
> falling back to polling
> Mar 01 09:58:38 kitchenrune connmand[29811]: Interface wlan0 [ wifi ]
> state is configuration
> Mar 01 09:58:39 kitchenrune systemd[1]: Reloading.
> Mar 01 09:58:43 kitchenrune kernel: sh (31068): drop_caches: 3
> Mar 01 09:59:19 kitchenrune avahi-daemon[261]: Joining mDNS multicast
> group on interface wlan0.IPv4 with address 169.254.3.191.
> Mar 01 09:59:19 kitchenrune avahi-daemon[261]: New relevant interface
> wlan0.IPv4 for mDNS.
> Mar 01 09:59:19 kitchenrune avahi-daemon[261]: Registering new address
> record for 169.254.3.191 on wlan0.IPv4.
> Mar 01 09:59:19 kitchenrune connmand[29811]: Interface wlan0 [ wifi ]
> state is ready
> Mar 01 09:59:19 kitchenrune connmand[29811]: wlan0 {add} address
> 169.254.3.191/16 label wlan0 family 2
> Mar 01 09:59:24 kitchenrune dbus-daemon[264]: [system] Activating via
> systemd: service name=3D'org.freedesktop.timedate1'
> unit=3D'dbus-org.freedesktop.timedate1.service' requested by ':1.946'
> (uid=3D0 pid=3D31657 comm=3D"timedatectl show -a")
> Mar 01 09:59:24 kitchenrune systemd[1]: Starting
> systemd-timedated.service - Time & Date Service...
> Mar 01 09:59:25 kitchenrune dbus-daemon[264]: [system] Successfully
> activated service 'org.freedesktop.timedate1'
> Mar 01 09:59:25 kitchenrune systemd[1]: Started
> systemd-timedated.service - Time & Date Service.
> Mar 01 09:59:42 kitchenrune iwd[29733]:
> src/netdev.c:netdev_link_notify() event 16 on ifindex 4
>
> as you can see, it does not get a DHCP address, but gets an APIPA
> address. Any ideas what might be going on? I have tried rebooting the
> Pi and also rebooted the DHCP server and restarted the router.

Built a fresh kernel so I could get iwmon and tried again. This is a
WPA2 ssid and all my other devices connect and this particular device
connected up until this morning. I don't think I did anything to break
it and the rest of my devices are still connected.
What is missing?
The attempted connect results in this:
Journal:
Mar 01 22:20:28 zero2w iwd[15809]: event: connect-info, FullMAC
driver: brcmfmac using SAE.  Expect EXTERNAL_AUTH
Mar 01 22:20:32 zero2w connmand[15858]: Interface wlan0 [ wifi ] state
is association
Mar 01 22:20:32 zero2w iwd[15809]: event: connect-info, ssid: spg5,
bss: bc:2e:48:fd:9e:70, signal: -44, load: 39/255
Mar 01 22:20:32 zero2w iwd[15809]: event: state, old:
autoconnect_full, new: connecting
Mar 01 22:20:32 zero2w connmand[15858]: Interface wlan0 [ wifi ] state
is configuration
Mar 01 22:21:13 zero2w connmand[15858]: Interface wlan0 [ wifi ] state is r=
eady
Mar 01 22:21:13 zero2w connmand[15858]: wlan0 {add} address
169.254.62.170/16 label wlan0 family 2

iwmon:
> Response: Set CQM (0x3f) len 4                                      18.19=
3961
    Status: Operation not supported (95)
< Request: Connect (0x2e) len 176 [ack]                               18.19=
4060
    Interface Index: 3 (0x00000003)
    Wiphy Frequency: 2422 (0x00000976)
    MAC Address BC:2E:48:FD:9E:70
    SSID: len 4
        73 70 67 35                                      spg5
    Auth Type: 0 (0x00000000)
    PMK: 254 len 32
        e3 d8 60 09 bb db 40 a5 ea 9c 81 1a 96 87 32 f9  ..`...@.......2.
        2b f9 9c 4e 91 96 76 4c 55 5b 06 0a 14 5e a3 ca  +..N..vLU[...^..
    Privacy: true
    Socket Owns Interface/Connection: true
    Cipher Suites Pairwise:
        CCMP (00:0f:ac) suite  04
    Cipher Suite Group: CCMP (00:0f:ac) suite  04
    Use MFP: 1 (0x00000001)
    AKM Suites:
        PSK; RSNA PSK (00:0f:ac) suite  02
    WPA Versions: 2 (0x00000002)
    Control Port: true
    Information Elements: len 38
        RSN:
            Group Data Cipher Suite: len 4
                CCMP (00:0f:ac) suite  04
            Pairwise Cipher Suite: len 4
                CCMP (00:0f:ac) suite  04
            AKM Suite: len 4
                PSK; RSNA PSK (00:0f:ac) suite  02
            RSN capabilities: bits  2 - 3: 1 replay counter per PTKSA
            RSN capabilities: bits  4 - 5: 1 replay counter per GTKSA
            RSN capabilities: bit  7: Management Frame Protection Capable
            01 00 00 0f ac 04 01 00 00 0f ac 04 01 00 00 0f  ..............=
..
            ac 02 80 00                                      ....
        Extended Capabilities: len 10
            Capability: bit 19: BSS transition
            00 00 08 00 00 00 00 00 00 01                    ..........
        Tag 262: len 1
            1a                                               .
> Response: Connect (0x2e) len 4 [0x100]                              18.22=
6572
    Status: Success (0)
< Request: Get Station (0x11) len 20 [ack]                            19.19=
4156
    Interface Index: 3 (0x00000003)
    MAC Address BC:2E:48:FD:9E:70
> Result: New Station (0x13) len 164                                  19.19=
6463
    Interface Index: 3 (0x00000003)
    MAC Address BC:2E:48:FD:9E:70
    Generation: 0 (0x00000000)
    Station Info: len 132
        Connected time: 0 (0x00000000)
        Inactivity time: 0 (0x00000000)
        Total RX bytes: 308 (0x00000134)
        Total TX bytes: 145 (0x00000091)
        TX bitrate: len 16
            Bit Rate: 10 (0x0000000a)
            Bit Rate (Legacy): 10 (0x000a)
        RX bitrate: len 16
            Bit Rate: 10 (0x0000000a)
            Bit Rate (Legacy): 10 (0x000a)
        RX packets: 2 (0x00000002)
        TX packets: 1 (0x00000001)
        TX failed: 0 (0x00000000)
        BSS parameters: len 20
            Short Slot Time: true
            DTIM Period: 3 (0x03)
            Beacon Interval: 100 (0x0064)
        Station flags: len 8
            Mask: 0x000000ea
                Authorized
                WME
                Authenticated
                TDLS-Peer
                Associated
            Set: 0x000000a8
                WME
                Authenticated
                Associated
> Response: Get Station (0x11) len 4 [0x100]                          19.19=
6484
    Status: Success (0)
< RTNL: Get Link (0x12) len 36 [request]                              23.88=
9242
    Flags: 1 (0x001)
    Sequence number: 1740889238 (0x67c3dc96)
    Port ID: 0
> RTNL: New Link (0x10) len 1072                                      23.88=
9324
    Flags: 0 (0x000)
    Sequence number: 1740889238 (0x67c3dc96)
    Port ID: 2976590107
    IFLA Family: Unknown
    IFLA Type: 1
    IFLA Index: 3
    IFLA ChangeMask: 0
    IFLA Flags: (0x1003) [up,broadcast,multicast]
        IfName (len:6): wlan0
        Txqlen: 1000 (0x000003e8)
        OperState: down (2)
        LinkMode: userspace controlled (1)
        MTU: 1500 (0x000005dc)
        Reserved: len 4
        Reserved: len 4
        Reserved: len 4
        Reserved: len 4
        Reserved: len 4
        Reserved: len 4
        Reserved: len 4
        Reserved: len 4
        Reserved: len 4
        Reserved: len 4
        Reserved: len 4
        Reserved: len 4
        Reserved: len 4
        Reserved: len 4
        Reserved: len 1
        Qdisc (len:11): pfifo_fast
        Reserved: len 4
        Reserved: len 4
        Reserved: len 4
        Reserved: len 1
        Map: len 32
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ..............=
..
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ..............=
..
        Interface Address: d8:3a:dd:a6:85:48
        Broadcast Address: ff:ff:ff:ff:ff:ff
        Reserved: len 200
        Stats: len 96
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ..............=
..
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ..............=
..
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ..............=
..
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ..............=
..
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ..............=
..
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ..............=
..
        Reserved: len 4
        Reserved: len 8
        Reserved: len 6
        Reserved: len 412
        Reserved: len 12
        Reserved: len 5
        Reserved: len 0
< RTNL: Get Link (0x12) len 24 [request]                              23.88=
9487
    Flags: 1 (0x001)
    Sequence number: 1740889238 (0x67c3dc96)
    Port ID: 0
    IFLA Family: Unknown
    IFLA Type: 0
    IFLA Index: 3
    IFLA ChangeMask: 0
    IFLA Flags: (0x00)
        Reserved: len 4
> RTNL: New Link (0x10) len 1072                                      23.88=
9513
    Flags: 0 (0x000)
    Sequence number: 1740889238 (0x67c3dc96)
    Port ID: 16898
    IFLA Family: Unknown
    IFLA Type: 1
    IFLA Index: 3
    IFLA ChangeMask: 0
    IFLA Flags: (0x1003) [up,broadcast,multicast]
        IfName (len:6): wlan0
        Txqlen: 1000 (0x000003e8)
        OperState: down (2)
        LinkMode: userspace controlled (1)
        MTU: 1500 (0x000005dc)
        Reserved: len 4
        Reserved: len 4
        Reserved: len 4
        Reserved: len 4
        Reserved: len 4
        Reserved: len 4
        Reserved: len 4
        Reserved: len 4
        Reserved: len 4
        Reserved: len 4
        Reserved: len 4
        Reserved: len 4
        Reserved: len 4
        Reserved: len 4
        Reserved: len 1
        Qdisc (len:11): pfifo_fast
        Reserved: len 4
        Reserved: len 4
        Reserved: len 4
        Reserved: len 1
        Map: len 32
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ..............=
..
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ..............=
..
        Interface Address: d8:3a:dd:a6:85:48
        Broadcast Address: ff:ff:ff:ff:ff:ff
        Reserved: len 200
        Stats: len 96
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ..............=
..
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ..............=
..
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ..............=
..
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ..............=
..
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ..............=
..
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ..............=
..
        Reserved: len 4
        Reserved: len 8
        Reserved: len 6
        Reserved: len 412
        Reserved: len 12
        Reserved: len 5
        Reserved: len 0
> RTNL: Done (0x03) len 4 [multi,0x20]                                23.88=
9572
    Flags: 34 (0x022)
    Sequence number: 1740889239 (0x67c3dc97)
    Port ID: 16898
    Status: 0
< RTNL: Get Link (0x12) len 36 [request]                              23.90=
3823
    Flags: 1 (0x001)
    Sequence number: 1740889238 (0x67c3dc96)
    Port ID: 0
> RTNL: New Link (0x10) len 1072                                      23.90=
3907
    Flags: 0 (0x000)
    Sequence number: 1740889238 (0x67c3dc96)
    Port ID: 3144330774
    IFLA Family: Unknown
    IFLA Type: 1
    IFLA Index: 3
    IFLA ChangeMask: 0
    IFLA Flags: (0x1003) [up,broadcast,multicast]
        IfName (len:6): wlan0
        Txqlen: 1000 (0x000003e8)
        OperState: down (2)
        LinkMode: userspace controlled (1)
        MTU: 1500 (0x000005dc)
        Reserved: len 4
        Reserved: len 4
        Reserved: len 4
        Reserved: len 4
        Reserved: len 4
        Reserved: len 4
        Reserved: len 4
        Reserved: len 4
        Reserved: len 4
        Reserved: len 4
        Reserved: len 4
        Reserved: len 4
        Reserved: len 4
        Reserved: len 4
        Reserved: len 1
        Qdisc (len:11): pfifo_fast
        Reserved: len 4
        Reserved: len 4
        Reserved: len 4
        Reserved: len 1
        Map: len 32
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ..............=
..
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ..............=
..
        Interface Address: d8:3a:dd:a6:85:48
        Broadcast Address: ff:ff:ff:ff:ff:ff
        Reserved: len 200
        Stats: len 96
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ..............=
..
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ..............=
..
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ..............=
..
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ..............=
..
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ..............=
..
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ..............=
..
        Reserved: len 4
        Reserved: len 8
        Reserved: len 6
        Reserved: len 412
        Reserved: len 12
        Reserved: len 5
        Reserved: len 0
