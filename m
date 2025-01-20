Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6871E8841
	for <iwd@lists.linux.dev>; Mon, 20 Jan 2025 15:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737387414; cv=none; b=Fl4Jf2GHTo+WXwTmqgPXbD19NIII4yddHIfgdAm39xmrO3xqTu12kmL3Im+1kZBsuJqoJelMLRjV0Vr3d3pGLx8Qvp4B+blO8u7CVyafblsbMfNOuvkE8V9UMFhTcuEeYMkjgdeIpSSFBI/2I9X2PlQAMfINaIlgnFvre+8Y/oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737387414; c=relaxed/simple;
	bh=Zud/yZVDFzdsfXN3+iqdtkpWmL2IjAtz9xwi+Fjw8m4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Ma40s/V6mjYWfRIbSBesqMakRVfRftKu/MvVfhAW2IkIVLKBAfJL8h2uF6H/Ff61RCiJQCmxX9ZdLSY06rNVE18BMDKpsrQrR5srDWcD9kbwi3OADyi1JkJQ/6h8ZDFIgGPbDDMO7U+93WUnz6LuXt8FYKYoWO2yae5F6CREbPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YTb5nA4C; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTb5nA4C"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-438a3216fc2so18792355e9.1
        for <iwd@lists.linux.dev>; Mon, 20 Jan 2025 07:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737387410; x=1737992210; darn=lists.linux.dev;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JC0UTk6hxP/+IRJ6jbjWsZeu0CSkvBgZbg97lChIz24=;
        b=YTb5nA4CmWNfnjntWg9kfIXU8xeE7xP2GzaR7MMM8jZbllBM05szc7tE3imW9rtHLx
         GYOt/ORHk8bqjEGbxq9TfkeOCEUBNVyBwpa57+3Cv3jRd0HO0CpMaRx8Dzl8AOgC7dMl
         PxHUrgx+o7zsABAfZf3TL7a9X7je4KTJpnNVPnnfxNYj8aQZIOxB003IuhVg1821miOO
         yare+s1KqsetRdy6KAu29o4d1QRH3KG9e/m5NlDdy1R3S2SN7CJNIKIU1aWHuq9fnIKx
         B968STk62bV6R6tMufekrDqqv1B8otS6RI+cIea4iIpPK8F+VYStp/j8gtriFWjLxy4p
         fJWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737387410; x=1737992210;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JC0UTk6hxP/+IRJ6jbjWsZeu0CSkvBgZbg97lChIz24=;
        b=Iij8TCmNsl8AgTg/XfOWkNo2ocYTIExdOdaQAzpENfX/eoIJqHTys2zPOq6bH1b6CI
         KmFJ1fEkjPZCF5uBgcMNZcURGYsqLAVqNm29X6t5EX9yXsCSV792X8QtENf3w+e5r/Ai
         fPMGazfHa4z/eLc2O7X0jJ0Q4D/ExfZWPGIgVgbQeawBc0TS5ZDw6HGrbubRAJipw2z1
         KDfXafHRvOtAL/CxNQzJnnZWi9gGr6BMi0WQmjiuffIvVSa+ti8pQprW/SlB/jEHLs/1
         zGzzItp2rnEEaUqqNhcni+XR9LT+1tW7CQVekyF60Qcuao+JcvHvApbQKOp0E302qJA0
         YmJw==
X-Forwarded-Encrypted: i=1; AJvYcCUvuLxzxIV60J21PaoJlDvRhwM5bq9Vs7mXI9H9RyKT7g6Tu4HvZtHMMHLV4d4supfv15g=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx942p7Ct8Recz56x5bIFCiIV5IyluXLBq+RkW1C1HEDEGaReHy
	CkXrylhI3JmKmjNqGMaHyQl8KZfkjm0HRDEFIQhjm3SwBfZUlLNG
X-Gm-Gg: ASbGncuvCB2tmH4xcjZW9vGvlI/gIqqMHKm9Rfm+I6Ka8juBh+SgaeVlL5IaXWGjGt1
	f7BiV5zSiCZzwmdCnNj4Dyogj8Io8+8Pubz8ZydBFDI7enIDk9QIr/rxRjppt3lpxox140IRS53
	aoZGLC3AsuSoiZU3PIUTrXgZ5pDjDRDeXkXsfttUTghlnPa14frda8ZOwZpMQeK0FL0QICK6qHA
	t8/yh9mgQoaAN8QQtWyLvGuOpJJnfuHkg4beiBMXxpJk7aJqfDQx9SntLTCu1uQfMMt5HV+vc5J
	RLuuPUY011q3mWHp
X-Google-Smtp-Source: AGHT+IEFiELoGVPV3hWedps2Mx9ARGaT0Pds7qZIaxUXja2Lw4a2kmUoV4bWOcxvUUWHxYukAyJVOQ==
X-Received: by 2002:a5d:588b:0:b0:385:f1d9:4b90 with SMTP id ffacd0b85a97d-38bf577f826mr12012630f8f.13.1737387409201;
        Mon, 20 Jan 2025 07:36:49 -0800 (PST)
Received: from smtpclient.apple ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf3275562sm11038451f8f.66.2025.01.20.07.36.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jan 2025 07:36:48 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: Re: How to triage an "Invalid Key" error message?
From: Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <CAG17S_NS18ubECyF0sz0AmtFq3wufjTVjQV2QpWLxCqV8ei1UA@mail.gmail.com>
Date: Mon, 20 Jan 2025 19:36:35 +0400
Cc: James Prestwood <prestwoj@gmail.com>,
 iwd@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <578421A3-35DA-431A-9319-96D847AA4CB2@gmail.com>
References: <345AE010-CAD8-4A38-BAE1-3BCD4930414C@gmail.com>
 <60c1b2cf-95be-4a4b-9195-f141adf45a6c@gmail.com>
 <CAG17S_NS18ubECyF0sz0AmtFq3wufjTVjQV2QpWLxCqV8ei1UA@mail.gmail.com>
To: KeithG <ys3al35l@gmail.com>
X-Mailer: Apple Mail (2.3826.200.121)

> On 18 Jan 2025, at 8:38=E2=80=AFpm, KeithG <ys3al35l@gmail.com> wrote:
>=20
> Christian,
>=20
> Is this, perhaps, on devices with the brcmfmac chip? I have seen this
> recently with on my Pis with wpa2 and wpa3 APs.

The majority of reports are from RPi 4/5 users which have brcmfmac
chips, but 85% of our distro installed base runs an RPi board so
that mostly reflects our demographics. I=E2=80=99ve also seen reports on
Amlogic and Rockchip SoC devices (also using brcmfmac); but to
offset theories on it being brcmfmac specific, we=E2=80=99ve also had
reports from users with Intel iwlwifi hardware and someone using
an RTL8723BS chip. So it=E2=80=99s more likely to be an interaction with
common code not driver code.

At one point we suspected an issue with WPA3, but that was triaged
with RPi developers and we now disable SAE offload which allows
boards to connect to mixed WPA2/WPA3 networks, see:

https://forum.libreelec.tv/thread/29155-rpi5-network-disappeared
https://github.com/LibreELEC/LibreELEC.tv/pull/9477/files

In the following forum and GitHub issue threads. There=E2=80=99s lots of
assumptions, guesswork, and false conclusions, but among the noise
there are some snippets of iwd debug log:

https://github.com/LibreELEC/LibreELEC.tv/issues/7166
https://github.com/LibreELEC/LibreELEC.tv/issues/8731
https://github.com/LibreELEC/LibreELEC.tv/issues/8760
https://github.com/LibreELEC/LibreELEC.tv/issues/8762

I=E2=80=99ll need to rig a distro image for greater debug (as per =
James=E2=80=99
instructions) to see if we can obtain more log output.

Christian


> This is the journal snippet from one such 'Invalid Key' with wpa3,
> though I have also seen it with wpa2:
> Jan 04 11:23:57 jackrune iwd[10541]:
> src/station.c:station_connect_cb() 3, result: 6
> Jan 04 11:23:57 jackrune iwd[10541]: event: disconnect-info, reason: 0
> Jan 04 11:23:57 jackrune iwd[10541]: src/wiphy.c:wiphy_select_akm()
> Network is WPA3-Personal...
> Jan 04 11:23:57 jackrune iwd[10541]: event: connect-info, FullMAC
> driver: brcmfmac using SAE.  Expect EXTERNAL_AUTH
> Jan 04 11:23:57 jackrune iwd[10541]:
> src/station.c:station_reset_connection_state() 3
> Jan 04 11:23:57 jackrune iwd[10541]: =
src/station.c:station_roam_state_clear() 3
> Jan 04 11:23:57 jackrune iwd[10541]: event: state, old: connecting,
> new: disconnected
> Jan 04 11:23:57 jackrune iwd[10541]: event: state, old: disconnected,
> new: autoconnect_quick
> Jan 04 11:23:57 jackrune iwd[10541]: src/scan.c:scan_periodic_start()
> Starting periodic scan for wdev 1
> Jan 04 11:23:57 jackrune iwd[10541]:
> src/wiphy.c:wiphy_radio_work_insert() Inserting work item 63
> Jan 04 11:23:57 jackrune iwd[10541]:
> src/wiphy.c:wiphy_radio_work_next() Starting work item 63
> Jan 04 11:23:57 jackrune iwd[10541]: src/netdev.c:netdev_link_notify()
> event 16 on ifindex 3
> Jan 04 11:23:57 jackrune iwd[10541]: src/scan.c:scan_notify() Scan
> notification Trigger Scan(33)
> Jan 04 11:23:57 jackrune iwd[10541]: src/netdev.c:netdev_link_notify()
> event 16 on ifindex 3
> Jan 04 11:23:57 jackrune iwd[10541]:
> src/scan.c:scan_request_triggered() Active scan triggered for wdev 1
> Jan 04 11:23:57 jackrune iwd[10541]:
> src/scan.c:scan_periodic_triggered() Periodic scan triggered for wdev
> 1
> Jan 04 11:23:57 jackrune iwd[10541]: =
src/station.c:station_dbus_disconnect()
> Jan 04 11:23:57 jackrune iwd[10541]: event: state, old:
> autoconnect_full, new: disconnected
> Jan 04 11:23:57 jackrune iwd[10541]: src/scan.c:scan_periodic_stop()
> Stopping periodic scan for wdev 1
> Jan 04 11:23:57 jackrune iwd[10541]: src/scan.c:scan_cancel() Trying
> to cancel scan id 63 for wdev 1
> Jan 04 11:23:57 jackrune iwd[10541]: src/scan.c:scan_cancel() Scan has
> been triggered, wait for it to complete
> Jan 04 11:23:57 jackrune connmand[9885]: wlan0 {RX} 871 packets 104097 =
bytes
> Jan 04 11:23:57 jackrune connmand[9885]: wlan0 {TX} 167 packets 25045 =
bytes
> Jan 04 11:23:57 jackrune connmand[9885]: wlan0 {update} flags 4099 =
<UP>
> Jan 04 11:23:57 jackrune connmand[9885]: wlan0 {newlink} index 3
> address B8:27:EB:A4:6E:0F mtu 1500
> Jan 04 11:23:57 jackrune connmand[9885]: wlan0 {newlink} index 3
> operstate 2 <DOWN>
> Jan 04 11:23:57 jackrune connmand[9885]: Interface wlan0 [ wifi ]
> error "invalid-key"
> Jan 04 11:23:57 jackrune connmand[9885]: Interface wlan0 [ wifi ]
> state is failure
>=20
> This is the iwmon snippet of what I think is the same exchange:
> < Request: Connect (0x2e) len 148 [ack]                               =
16.707632
>    Interface Index: 3 (0x00000003)
>    Wiphy Frequency: 2412 (0x0000096c)
>    MAC Address D8:3A:DD:60:A3:0C
>    SSID: len 7
>        64 65 73 6b 53 41 45                             deskSAE
>    Auth Type: 4 (0x00000004)
>    External Auth Support: 261 len 0
>    Privacy: true
>    Socket Owns Interface/Connection: true
>    Cipher Suites Pairwise:
>        CCMP (00:0f:ac) suite  04
>    Cipher Suite Group: CCMP (00:0f:ac) suite  04
>    Use MFP: 1 (0x00000001)
>    AKM Suites:
>        SAE/PMKSA caching SHA256; RSNA PMKSA caching SHA256/mesh
> peering exchange (00:0f:ac) suite  08
>    WPA Versions: 4 (0x00000004)
>    Control Port: true
>    Information Elements: len 38
>        RSN:
>            Group Data Cipher Suite: len 4
>                CCMP (00:0f:ac) suite  04
>            Pairwise Cipher Suite: len 4
>                CCMP (00:0f:ac) suite  04
>            AKM Suite: len 4
>                SAE/PMKSA caching SHA256; RSNA PMKSA caching
> SHA256/mesh peering exchange (00:0f:ac) suite  08
>            RSN capabilities: bits  2 - 3: 1 replay counter per PTKSA
>            RSN capabilities: bits  4 - 5: 1 replay counter per GTKSA
>            RSN capabilities: bit  7: Management Frame Protection =
Capable
>            01 00 00 0f ac 04 01 00 00 0f ac 04 01 00 00 0f  =
................
>            ac 08 80 00                                      ....
>        Extended Capabilities: len 10
>            Capability: bit 19: BSS transition
>            00 00 08 00 00 00 00 00 00 01                    ..........
>        Tag 262: len 1
>            1a                                               .
>> Response: Connect (0x2e) len 4 [0x100]                              =
16.717389
>    Status: Success (0)
>> Event: External Auth (0x7f) len 56                                  =
16.765492
>    Wiphy: 0 (0x00000000)
>    Interface Index: 3 (0x00000003)
>    AKM Suites:
>        unknown (08:ac:0f) suite 00 (unknown)
>    External Auth Action: 260 len 4
>        00 00 00 00                                      ....
>    BSSID D8:3A:DD:60:A3:0C
>    SSID: len 7
>        64 65 73 6b 53 41 45                             deskSAE
> < Request: Frame (0x3b) len 140 [ack]                                 =
16.783162
>    Interface Index: 3 (0x00000003)
>    Frame: len 128
>        Frame Type: 0x00b0
>            Type: Management (0)
>            Authentication:
>                Frame Control: protocol: 00 type: 00 subtype: 11 to:
> 00 from: 00 more_frags: 00
>                    retry: 00 power_mgmt: 00 more_data: 00 protected:
> 00 order: 00
>                Duration: 0
>                Address 1 (RA): D8:3A:DD:60:A3:0C
>                Address 2 (TA): B8:27:EB:A4:6E:0F
>                Address 3: D8:3A:DD:60:A3:0C
>                Fragment Number: 0
>                Sequence Number: 0
>                Algorithm: SAE (seq: 1, status: 0)
>        b0 00 00 00 d8 3a dd 60 a3 0c b8 27 eb a4 6e 0f  =
.....:.`...'..n.
>        d8 3a dd 60 a3 0c 00 00 03 00 01 00 00 00 13 00  =
.:.`............
>        f0 db cc 49 7c ad 4b 75 65 da 78 de 53 11 30 de  =
...I|.Kue.x.S.0.
>        fb 47 cf 3e 97 63 99 ff 2a 01 7f a0 e9 9b dd ed  =
.G.>.c..*.......
>        13 07 4b 2c 46 8a 61 d0 ee 1d c6 82 60 b5 a9 90  =
..K,F.a.....`...
>        39 93 63 18 84 24 d2 06 51 26 93 91 2b c2 7c 52  =
9.c..$..Q&..+.|R
>        ea 3e 41 38 84 89 4d 41 bf 1a b7 4d 4f b0 fb a4  =
.>A8..MA...MO...
>        cc 86 26 c3 5b 84 e7 4e 97 33 be 9f 95 c6 ea 6d  =
..&.[..N.3.....m
>> Event: Frame TX Status (0x3c) len 176                               =
16.791308
>    Wiphy: 0 (0x00000000)
>    Interface Index: 3 (0x00000003)
>    Wireless Device: 1 (0x0000000000000001)
>    Frame: len 128
>        Frame Type: 0x00b0
>            Type: Management (0)
>            Authentication:
>                Frame Control: protocol: 00 type: 00 subtype: 11 to:
> 00 from: 00 more_frags: 00
>                    retry: 00 power_mgmt: 00 more_data: 00 protected:
> 00 order: 00
>                Duration: 0
>                Address 1 (RA): D8:3A:DD:60:A3:0C
>                Address 2 (TA): B8:27:EB:A4:6E:0F
>                Address 3: D8:3A:DD:60:A3:0C
>                Fragment Number: 0
>                Sequence Number: 0
>                Algorithm: SAE (seq: 1, status: 0)
>        b0 00 00 00 d8 3a dd 60 a3 0c b8 27 eb a4 6e 0f  =
.....:.`...'..n.
>        d8 3a dd 60 a3 0c 00 00 03 00 01 00 00 00 13 00  =
.:.`............
>        f0 db cc 49 7c ad 4b 75 65 da 78 de 53 11 30 de  =
...I|.Kue.x.S.0.
>        fb 47 cf 3e 97 63 99 ff 2a 01 7f a0 e9 9b dd ed  =
.G.>.c..*.......
>        13 07 4b 2c 46 8a 61 d0 ee 1d c6 82 60 b5 a9 90  =
..K,F.a.....`...
>        39 93 63 18 84 24 d2 06 51 26 93 91 2b c2 7c 52  =
9.c..$..Q&..+.|R
>        ea 3e 41 38 84 89 4d 41 bf 1a b7 4d 4f b0 fb a4  =
.>A8..MA...MO...
>        cc 86 26 c3 5b 84 e7 4e 97 33 be 9f 95 c6 ea 6d  =
..&.[..N.3.....m
>    Cookie: 0 (0x0000000000000000)
>    ACK: true
>> Result: Frame (0x3b) len 12                                         =
16.791335
>    Cookie: 0 (0x0000000000000000)
>> Response: Frame (0x3b) len 4 [0x100]                                =
16.791346
>    Status: Success (0)
>> Event: Frame (0x3b) len 184                                         =
16.815917
>    Wiphy: 0 (0x00000000)
>    Interface Index: 3 (0x00000003)
>    Wireless Device: 1 (0x0000000000000001)
>    Wiphy Frequency: 2412 (0x0000096c)
>    Unknown: 290 len 4
>        00 00 00 00                                      ....
>    Frame: len 128
>        Frame Type: 0x00b0
>            Type: Management (0)
>            Authentication:
>                Frame Control: protocol: 00 type: 00 subtype: 11 to:
> 00 from: 00 more_frags: 00
>                    retry: 00 power_mgmt: 00 more_data: 00 protected:
> 00 order: 00
>                Duration: 0
>                Address 1 (RA): B8:27:EB:A4:6E:0F
>                Address 2 (TA): D8:3A:DD:60:A3:0C
>                Address 3: 00:00:00:00:00:00
>                Fragment Number: 0
>                Sequence Number: 0
>                Algorithm: SAE (seq: 1, status: 0)
>        b0 00 00 00 b8 27 eb a4 6e 0f d8 3a dd 60 a3 0c  =
.....'..n..:.`..
>        00 00 00 00 00 00 00 00 03 00 01 00 00 00 13 00  =
................
>        43 80 d8 95 59 df 2a 68 cd 1f 2f 93 27 21 89 e5  =
C...Y.*h../.'!..
>        2b 25 63 a4 33 8b 60 3a 2e 63 5e a8 f7 ba 40 f8  =
+%c.3.`:.c^...@.
>        12 22 77 5c a1 9d bc 8b 07 1b 52 c1 ee 1b bc 9f  =
."w\......R.....
>        9e 6c 67 c1 e7 b4 95 bf 07 a6 8a 87 6c dc 15 1d  =
.lg.........l...
>        80 71 2e df f1 c6 f2 98 be cb 58 bd 95 ac ce cb  =
.q........X.....
>        fe a4 2a a0 82 78 b2 79 a0 c2 d4 cb ac 1b 2a 83  =
..*..x.y......*.
>    RX Management Flags: 2 (0x00000002)
> < Request: Frame (0x3b) len 76 [ack]                                  =
16.822238
>    Interface Index: 3 (0x00000003)
>    Frame: len 64
>        Frame Type: 0x00b0
>            Type: Management (0)
>            Authentication:
>                Frame Control: protocol: 00 type: 00 subtype: 11 to:
> 00 from: 00 more_frags: 00
>                    retry: 00 power_mgmt: 00 more_data: 00 protected:
> 00 order: 00
>                Duration: 0
>                Address 1 (RA): D8:3A:DD:60:A3:0C
>                Address 2 (TA): B8:27:EB:A4:6E:0F
>                Address 3: D8:3A:DD:60:A3:0C
>                Fragment Number: 0
>                Sequence Number: 0
>                Algorithm: SAE (seq: 2, status: 0)
>                IEs: len 34
>                    Error decoding Supported rates IE len 0: Invalid
> argument (-22)
>        b0 00 00 00 d8 3a dd 60 a3 0c b8 27 eb a4 6e 0f  =
.....:.`...'..n.
>        d8 3a dd 60 a3 0c 00 00 03 00 02 00 00 00 01 00  =
.:.`............
>        b4 69 71 a8 83 ee c4 c3 e1 5e c1 ef 5b 89 cc 18  =
.iq......^..[...
>        6d 37 81 bb e0 9e 60 7b 6e 87 cb be 2b 60 af cf  =
m7....`{n...+`..
>> Event: Frame TX Status (0x3c) len 112                               =
16.828004
>    Wiphy: 0 (0x00000000)
>    Interface Index: 3 (0x00000003)
>    Wireless Device: 1 (0x0000000000000001)
>    Frame: len 64
>        Frame Type: 0x00b0
>            Type: Management (0)
>            Authentication:
>                Frame Control: protocol: 00 type: 00 subtype: 11 to:
> 00 from: 00 more_frags: 00
>                    retry: 00 power_mgmt: 00 more_data: 00 protected:
> 00 order: 00
>                Duration: 0
>                Address 1 (RA): D8:3A:DD:60:A3:0C
>                Address 2 (TA): B8:27:EB:A4:6E:0F
>                Address 3: D8:3A:DD:60:A3:0C
>                Fragment Number: 0
>                Sequence Number: 0
>                Algorithm: SAE (seq: 2, status: 0)
>                IEs: len 34
>                    Error decoding Supported rates IE len 0: Invalid
> argument (-22)
>        b0 00 00 00 d8 3a dd 60 a3 0c b8 27 eb a4 6e 0f  =
.....:.`...'..n.
>        d8 3a dd 60 a3 0c 00 00 03 00 02 00 00 00 01 00  =
.:.`............
>        b4 69 71 a8 83 ee c4 c3 e1 5e c1 ef 5b 89 cc 18  =
.iq......^..[...
>        6d 37 81 bb e0 9e 60 7b 6e 87 cb be 2b 60 af cf  =
m7....`{n...+`..
>    Cookie: 0 (0x0000000000000000)
>    ACK: true
>> Result: Frame (0x3b) len 12                                         =
16.828029
>    Cookie: 0 (0x0000000000000000)
>> Response: Frame (0x3b) len 4 [0x100]                                =
16.828042
>    Status: Success (0)
>> Event: Frame (0x3b) len 120                                         =
16.839203
>    Wiphy: 0 (0x00000000)
>    Interface Index: 3 (0x00000003)
>    Wireless Device: 1 (0x0000000000000001)
>    Wiphy Frequency: 2412 (0x0000096c)
>    Unknown: 290 len 4
>        00 00 00 00                                      ....
>    Frame: len 64
>        Frame Type: 0x00b0
>            Type: Management (0)
>            Authentication:
>                Frame Control: protocol: 00 type: 00 subtype: 11 to:
> 00 from: 00 more_frags: 00
>                    retry: 00 power_mgmt: 00 more_data: 00 protected:
> 00 order: 00
>                Duration: 0
>                Address 1 (RA): B8:27:EB:A4:6E:0F
>                Address 2 (TA): D8:3A:DD:60:A3:0C
>                Address 3: 00:00:00:00:00:00
>                Fragment Number: 0
>                Sequence Number: 0
>                Algorithm: SAE (seq: 2, status: 0)
>                IEs: len 34
>                    Error decoding Supported rates IE len 0: Invalid
> argument (-22)
>        b0 00 00 00 b8 27 eb a4 6e 0f d8 3a dd 60 a3 0c  =
.....'..n..:.`..
>        00 00 00 00 00 00 00 00 03 00 02 00 00 00 01 00  =
................
>        f4 b4 13 37 c0 c2 ca 39 5f 0e ac 44 be d0 d0 04  =
...7...9_..D....
>        40 3c 1f cb 94 f8 e2 aa b7 df 65 d5 6a 88 14 7e  =
@<........e.j..~
>    RX Management Flags: 2 (0x00000002)
> < Request: External Auth (0x7f) len 40 [ack]                          =
16.839539
>    Interface Index: 3 (0x00000003)
>    Status Code: 0 (0x0000)
>    SSID: len 7
>        64 65 73 6b 53 41 45                             deskSAE
>    BSSID D8:3A:DD:60:A3:0C
>> Response: External Auth (0x7f) len 4 [0x100]                        =
16.840308
>    Status: Success (0)
>> PAE: len 121                                                        =
16.935734
>    Interface Index: 3
>    EAPoL: len 121
>        Protocol Version: 2 (802.1X-2004)
>        Type: 3 (Key)
>        Length: 117
>        Descriptor Type: 2
>        Key MIC: false
>        Secure: false
>        Error: false
>        Request: false
>        Encrypted Key Data: false
>        SMK Message: false
>        Key Descriptor Version: 0 (00)
>        Key Type: true
>        Install: false
>        Key ACK: true
>        Key Length: 16
>        Key Replay Counter: 1
>        Key NONCE
>            8c 7a ce cc 0e 1d 4f af 99 42 b6 b9 9c ce 17 e0  =
.z....O..B......
>            ec bf a4 02 f3 36 70 cb 24 b3 3b 97 91 65 1c ed  =
.....6p.$.;..e..
>        Key IV
>            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  =
................
>        Key RSC
>            00 00 00 00 00 00 00 00                          ........
>        Key MIC Data
>            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  =
................
>        Key Data: len 22
>            Vendor specific: len 20
>                IEEE 802.11 (00:0f:ac) type: 04
>                PMKID KDE
>                00 0f ac 04 34 5c a4 df d6 8c 75 dd 32 f9 a8 71
> ....4\....u.2..q
>                7a 32 ba c4                                      z2..
>        02 03 00 75 02 00 88 00 10 00 00 00 00 00 00 00  =
...u............
>        01 8c 7a ce cc 0e 1d 4f af 99 42 b6 b9 9c ce 17  =
..z....O..B.....
>        e0 ec bf a4 02 f3 36 70 cb 24 b3 3b 97 91 65 1c  =
......6p.$.;..e.
>        ed 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  =
................
>        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  =
................
>        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  =
................
>        00 00 16 dd 14 00 0f ac 04 34 5c a4 df d6 8c 75  =
.........4\....u
>        dd 32 f9 a8 71 7a 32 ba c4                       .2..qz2..
>> Event: Connect (0x2e) len 156                                       =
17.000544
>    Wiphy: 0 (0x00000000)
>    Interface Index: 3 (0x00000003)
>    MAC Address D8:3A:DD:60:A3:0C
>    Status Code: 0 (0x0000)
>    Request IE: len 80
>        SSID: deskSAE
>            64 65 73 6b 53 41 45                             deskSAE
>        Supported rates:
>            1.0(B) 2.0(B) 5.5(B) 11.0(B) 18.0 24.0 36.0 54.0 Mbit/s
>            82 84 8b 96 24 30 48 6c                          ....$0Hl
>        Extended supported rates:
>            6.0 9.0 12.0 48.0 Mbit/s
>            0c 12 18 60                                      ...`
>        Tag 33: len 2
>            03 14                                            ..
>        Tag 36: len 2
>            01 0b                                            ..
>        RSN:
>            Group Data Cipher Suite: len 4
>                CCMP (00:0f:ac) suite  04
>            Pairwise Cipher Suite: len 4
>                CCMP (00:0f:ac) suite  04
>            AKM Suite: len 4
>                SAE/PMKSA caching SHA256; RSNA PMKSA caching
> SHA256/mesh peering exchange (00:0f:ac) suite  08
>            RSN capabilities: bits  2 - 3: 1 replay counter per PTKSA
>            RSN capabilities: bits  4 - 5: 1 replay counter per GTKSA
>            RSN capabilities: bit  7: Management Frame Protection =
Capable
>            01 00 00 0f ac 04 01 00 00 0f ac 04 01 00 00 0f  =
................
>            ac 08 80 00                                      ....
>        Extended Capabilities: len 8
>            Capability: bit 62: Opmode Notification
>            00 00 00 00 00 00 00 40                          .......@
>        Vendor specific: len 9
>            Broadcom (00:10:18) type: 02
>            00 10 18 02 00 00 10 00 00                       .........
>        SSID:
>        SSID:
>    Response IE: len 32
>        Supported rates:
>            1.0(B) 2.0(B) 5.5(B) 11.0(B) 6.0 9.0 12.0 18.0 Mbit/s
>            82 84 8b 96 0c 12 18 24                          .......$
>        Extended supported rates:
>            24.0 36.0 48.0 54.0 Mbit/s
>            30 48 60 6c                                      0H`l
>        Extended Capabilities: len 8
>            Capability: bit  2: Extended channel switching
>            Capability: bit 62: Opmode Notification
>            04 00 00 00 00 00 00 40                          .......@
>=20
> On Sat, Jan 18, 2025 at 9:52=E2=80=AFAM James Prestwood =
<prestwoj@gmail.com> wrote:
>>=20
>> Hi Christian,
>>=20
>> On 1/17/25 10:03 PM, Christian Hewitt wrote:
>>> Hello folks :)
>>>=20
>>> The Kodi focussed distro LibreELEC switched to iwd from
>>> wpa_supplicant for our most recent release. It has been an
>>> overall positive change, but we continue to see a trickle
>>> of end-user reports of an =E2=80=9CInvalid Key=E2=80=9D error when =
devices
>>> connect to a network.
>>>=20
>>> Things we=E2=80=99ve established:
>>>=20
>>> * Reverting to wpa_supplicant allows the device to connect
>>> * Happens on a range of hardware so is not driver specific
>>> * Happens on a range of kernels (tested back to 6.1)
>>> * Poor signal strength shows the issue more frequently
>>> * Networks with FT enabled show the issue more frequently
>>> * Has nothing to do with passphrase length/characters
>>>=20
>>> TL/DR: We are reasonably confident the issue is within iwd
>>> code and not drivers or kernels. We also use latest or very
>>> recent kernels (and in-kernel drivers) and latest ConnMan
>>> (we are generally =E2=80=98current=E2=80=99 with upstream sources =
throughout
>>> the distro). We suspect a combination of radio properties
>>> (influenced by poor signal and features) results in an error
>>> which is not handled correctly so you end up in the wrong
>>> place in code and trip the =E2=80=98Invalid Key=E2=80=99 error =
instead.
>>>=20
>>> Our project team are not able to replicate the issue with
>>> our own devices and networks so we are currently reliant
>>> on end-user reports. We also lack iwd debugging experience.
>>> However, our embedded style distro packaging makes it very
>>> simple for users to update and run an image tweaked with
>>> iwd patches and/or config to get the output required to
>>> triage the issue.
>>>=20
>>> So I=E2=80=99d like to understand what needs to be collected or
>>> patched etc. to help start the process.
>>=20
>> For a start if you could gather debug logs when your users see the
>> "Invalid key" message. Tbh I don't see anywhere IWD itself would =
print
>> that, but ELL will signal that if some IWD settings file is using =
some
>> invalid characters, that's about all I can think of at the moment
>> without seeing debug logs. Our wiki [1] has some additional info =
about
>> debugging. I'd even be happy to look at any of your locally tracked =
bug
>> reports if there are any, otherwise just send some logs this way and
>> we'll take a look.
>>=20
>> [1] =
https://archive.kernel.org/oldwiki/iwd.wiki.kernel.org/debugging.html
>>=20
>> Thanks,
>>=20
>> James
>>=20
>>>=20
>>> Thanks in advance,
>>>=20
>>> Christian
>>=20

