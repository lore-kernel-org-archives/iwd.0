Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CD3273F9
	for <iwd@lists.linux.dev>; Sat, 18 Jan 2025 16:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737218299; cv=none; b=CFGAnoSYlv6KBR6mib+L/J6jrnbFRE6PTwmI7P3rDdOY4F9c2jfiA9vMB0YK+1ZmCOy3H29szv7tp1gquDw/kwb7+G9hnt8+KkpNksluDnTOFEiYgDqlgxO8TdJolHEhx0tzmNB3f7pr2VQKURGfa6/cpWs2xUHLK1jjAICEmSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737218299; c=relaxed/simple;
	bh=odx5Gw3gseZFntRaPG7v6NiAMq9naRo2eG4qS0XLw0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YZuzYmNTk6Jmd132RKD8Q7zjjeT78eULRc6x6iAMC8AQndKKDh00Uwwj6a/9altRcTNBRRScjG0CuzSgf04c6SuI0t9dAn9OScCWBMCfM5uCzXuy2ts0HltPBJn+0Oi+VVs5HDotb3QEJ//xbNoPj82O+r1M6tH014Z+p361qm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ankISbth; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ankISbth"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2ee46851b5eso4266698a91.1
        for <iwd@lists.linux.dev>; Sat, 18 Jan 2025 08:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737218296; x=1737823096; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hb3G85jt90KlXQStT/rzRPQccK0JX05vayIlEbTN5+w=;
        b=ankISbthy+ZFhS9dTIFF0JNJoQRS5W1yQeuJxUticFPuK05id8joZNZGvOaG5MOoBv
         ekyJrbPYpRjCB1y8bgv/k0pqqkAXb4HYT0dztkJLM1djWG81PRXzZj5EdKs0VNSSrixD
         3/Vgn3GJ+VmzkTiybK2zd39K6+2GfRQulTFsA9MJpYJWUPwwP3l3+r1/kSzTOvTymGv5
         MnO9+HSzAWaXeh6ZZzpo1l6lor5AZqpYO2KW2YgwcLfXn10GJ4POW6nddFicYULOs6T1
         Ksp6w19fAXLUsy0FtfFwEcPmmlXCF3hzm3wh6cBMLCuzOcqXqCBpDYhPCxYbayGC+Q4c
         iSkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737218296; x=1737823096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hb3G85jt90KlXQStT/rzRPQccK0JX05vayIlEbTN5+w=;
        b=Ks3PpltE0Eud3Lpl6j2aF91KgrKkPYWDua3+10QcLBrHf1T8GALlAkRvkkMl0yh9XI
         BL4zPyhk1fGPeYI7bZn5SiffqxSYoPHPoWJhkZYdobPerMv2htW7LWjtr0mcAY+QaQ5e
         s8cTAYbQ+TDwq6JGtjyFNzXzK8MicsbSB/N8UTeHyKQosjQfN3oMFpZtE5M6dgT/b9k/
         FHV0hjSAf9cqNbe00Ly0UDASnNNpl8pT66JR3PskoDthZ+awqCxMfB8IyCesuGo27R7N
         n4Ro/3IMWoGrj455VtK2myeSirnHA92iehUWdLoyqQv3ymrYtmwxsuULaPP1LYxe39Lw
         pjjw==
X-Forwarded-Encrypted: i=1; AJvYcCXil6W7t4l4TUE2JxCJ1uN1FIHhSWch5YFas3iPNnc+kC1E1ZrIzKoFNZ9HO4tdy/MD81s=@lists.linux.dev
X-Gm-Message-State: AOJu0YxjVJOlovoYgnbvIRYPWCwHPnD8KabfOz5mIp6fYwwrBMr+a+N0
	xOKVOVlKwwEpR7T4P1xLZCbmfEM8FdD5VgFp7yh3FH+XKcaBu8QTX6/cOHi0O/gqMPSISO35eH9
	KnOzluKwPDb/Nqd584+TFjJc4pBfAXy4V
X-Gm-Gg: ASbGncvd6q18rEl7AvYKQeSosAMPuk6a760EQxlpJcR1vqfTeCYbTiR3p0VlDmsJr9R
	M3OIzG2n1KnnGGqQc00n1JXHuMYk1UixPQm6Fp3AyQtsBLnCPJzU=
X-Google-Smtp-Source: AGHT+IEz9B59xUY8NSQrwzWblOa9AV0r+in+pMxj7Yovu4xmGjIC4oLIptudarnd4xXYB2uuOv/1YvQ+FwU4scfV+0Q=
X-Received: by 2002:a05:6a00:90a3:b0:725:e4b9:a600 with SMTP id
 d2e1a72fcca58-72dafb367d4mr11232667b3a.16.1737218296153; Sat, 18 Jan 2025
 08:38:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <345AE010-CAD8-4A38-BAE1-3BCD4930414C@gmail.com> <60c1b2cf-95be-4a4b-9195-f141adf45a6c@gmail.com>
In-Reply-To: <60c1b2cf-95be-4a4b-9195-f141adf45a6c@gmail.com>
From: KeithG <ys3al35l@gmail.com>
Date: Sat, 18 Jan 2025 10:38:04 -0600
X-Gm-Features: AbW1kvZha950itPcQOHydQgz0-s3JBN3Tt_gPsnH7gTcyrecqQOIKUCE3L0Hoko
Message-ID: <CAG17S_NS18ubECyF0sz0AmtFq3wufjTVjQV2QpWLxCqV8ei1UA@mail.gmail.com>
Subject: Re: How to triage an "Invalid Key" error message?
To: James Prestwood <prestwoj@gmail.com>
Cc: Christian Hewitt <christianshewitt@gmail.com>, iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Christian,

Is this, perhaps, on devices with the brcmfmac chip? I have seen this
recently with on my Pis with wpa2 and wpa3 APs.

This is the journal snippet from one such 'Invalid Key' with wpa3,
though I have also seen it with wpa2:
Jan 04 11:23:57 jackrune iwd[10541]:
src/station.c:station_connect_cb() 3, result: 6
Jan 04 11:23:57 jackrune iwd[10541]: event: disconnect-info, reason: 0
Jan 04 11:23:57 jackrune iwd[10541]: src/wiphy.c:wiphy_select_akm()
Network is WPA3-Personal...
Jan 04 11:23:57 jackrune iwd[10541]: event: connect-info, FullMAC
driver: brcmfmac using SAE.  Expect EXTERNAL_AUTH
Jan 04 11:23:57 jackrune iwd[10541]:
src/station.c:station_reset_connection_state() 3
Jan 04 11:23:57 jackrune iwd[10541]: src/station.c:station_roam_state_clear=
() 3
Jan 04 11:23:57 jackrune iwd[10541]: event: state, old: connecting,
new: disconnected
Jan 04 11:23:57 jackrune iwd[10541]: event: state, old: disconnected,
new: autoconnect_quick
Jan 04 11:23:57 jackrune iwd[10541]: src/scan.c:scan_periodic_start()
Starting periodic scan for wdev 1
Jan 04 11:23:57 jackrune iwd[10541]:
src/wiphy.c:wiphy_radio_work_insert() Inserting work item 63
Jan 04 11:23:57 jackrune iwd[10541]:
src/wiphy.c:wiphy_radio_work_next() Starting work item 63
Jan 04 11:23:57 jackrune iwd[10541]: src/netdev.c:netdev_link_notify()
event 16 on ifindex 3
Jan 04 11:23:57 jackrune iwd[10541]: src/scan.c:scan_notify() Scan
notification Trigger Scan(33)
Jan 04 11:23:57 jackrune iwd[10541]: src/netdev.c:netdev_link_notify()
event 16 on ifindex 3
Jan 04 11:23:57 jackrune iwd[10541]:
src/scan.c:scan_request_triggered() Active scan triggered for wdev 1
Jan 04 11:23:57 jackrune iwd[10541]:
src/scan.c:scan_periodic_triggered() Periodic scan triggered for wdev
1
Jan 04 11:23:57 jackrune iwd[10541]: src/station.c:station_dbus_disconnect(=
)
Jan 04 11:23:57 jackrune iwd[10541]: event: state, old:
autoconnect_full, new: disconnected
Jan 04 11:23:57 jackrune iwd[10541]: src/scan.c:scan_periodic_stop()
Stopping periodic scan for wdev 1
Jan 04 11:23:57 jackrune iwd[10541]: src/scan.c:scan_cancel() Trying
to cancel scan id 63 for wdev 1
Jan 04 11:23:57 jackrune iwd[10541]: src/scan.c:scan_cancel() Scan has
been triggered, wait for it to complete
Jan 04 11:23:57 jackrune connmand[9885]: wlan0 {RX} 871 packets 104097 byte=
s
Jan 04 11:23:57 jackrune connmand[9885]: wlan0 {TX} 167 packets 25045 bytes
Jan 04 11:23:57 jackrune connmand[9885]: wlan0 {update} flags 4099 <UP>
Jan 04 11:23:57 jackrune connmand[9885]: wlan0 {newlink} index 3
address B8:27:EB:A4:6E:0F mtu 1500
Jan 04 11:23:57 jackrune connmand[9885]: wlan0 {newlink} index 3
operstate 2 <DOWN>
Jan 04 11:23:57 jackrune connmand[9885]: Interface wlan0 [ wifi ]
error "invalid-key"
Jan 04 11:23:57 jackrune connmand[9885]: Interface wlan0 [ wifi ]
state is failure

This is the iwmon snippet of what I think is the same exchange:
< Request: Connect (0x2e) len 148 [ack]                               16.70=
7632
    Interface Index: 3 (0x00000003)
    Wiphy Frequency: 2412 (0x0000096c)
    MAC Address D8:3A:DD:60:A3:0C
    SSID: len 7
        64 65 73 6b 53 41 45                             deskSAE
    Auth Type: 4 (0x00000004)
    External Auth Support: 261 len 0
    Privacy: true
    Socket Owns Interface/Connection: true
    Cipher Suites Pairwise:
        CCMP (00:0f:ac) suite  04
    Cipher Suite Group: CCMP (00:0f:ac) suite  04
    Use MFP: 1 (0x00000001)
    AKM Suites:
        SAE/PMKSA caching SHA256; RSNA PMKSA caching SHA256/mesh
peering exchange (00:0f:ac) suite  08
    WPA Versions: 4 (0x00000004)
    Control Port: true
    Information Elements: len 38
        RSN:
            Group Data Cipher Suite: len 4
                CCMP (00:0f:ac) suite  04
            Pairwise Cipher Suite: len 4
                CCMP (00:0f:ac) suite  04
            AKM Suite: len 4
                SAE/PMKSA caching SHA256; RSNA PMKSA caching
SHA256/mesh peering exchange (00:0f:ac) suite  08
            RSN capabilities: bits  2 - 3: 1 replay counter per PTKSA
            RSN capabilities: bits  4 - 5: 1 replay counter per GTKSA
            RSN capabilities: bit  7: Management Frame Protection Capable
            01 00 00 0f ac 04 01 00 00 0f ac 04 01 00 00 0f  ..............=
..
            ac 08 80 00                                      ....
        Extended Capabilities: len 10
            Capability: bit 19: BSS transition
            00 00 08 00 00 00 00 00 00 01                    ..........
        Tag 262: len 1
            1a                                               .
> Response: Connect (0x2e) len 4 [0x100]                              16.71=
7389
    Status: Success (0)
> Event: External Auth (0x7f) len 56                                  16.76=
5492
    Wiphy: 0 (0x00000000)
    Interface Index: 3 (0x00000003)
    AKM Suites:
        unknown (08:ac:0f) suite 00 (unknown)
    External Auth Action: 260 len 4
        00 00 00 00                                      ....
    BSSID D8:3A:DD:60:A3:0C
    SSID: len 7
        64 65 73 6b 53 41 45                             deskSAE
< Request: Frame (0x3b) len 140 [ack]                                 16.78=
3162
    Interface Index: 3 (0x00000003)
    Frame: len 128
        Frame Type: 0x00b0
            Type: Management (0)
            Authentication:
                Frame Control: protocol: 00 type: 00 subtype: 11 to:
00 from: 00 more_frags: 00
                    retry: 00 power_mgmt: 00 more_data: 00 protected:
00 order: 00
                Duration: 0
                Address 1 (RA): D8:3A:DD:60:A3:0C
                Address 2 (TA): B8:27:EB:A4:6E:0F
                Address 3: D8:3A:DD:60:A3:0C
                Fragment Number: 0
                Sequence Number: 0
                Algorithm: SAE (seq: 1, status: 0)
        b0 00 00 00 d8 3a dd 60 a3 0c b8 27 eb a4 6e 0f  .....:.`...'..n.
        d8 3a dd 60 a3 0c 00 00 03 00 01 00 00 00 13 00  .:.`............
        f0 db cc 49 7c ad 4b 75 65 da 78 de 53 11 30 de  ...I|.Kue.x.S.0.
        fb 47 cf 3e 97 63 99 ff 2a 01 7f a0 e9 9b dd ed  .G.>.c..*.......
        13 07 4b 2c 46 8a 61 d0 ee 1d c6 82 60 b5 a9 90  ..K,F.a.....`...
        39 93 63 18 84 24 d2 06 51 26 93 91 2b c2 7c 52  9.c..$..Q&..+.|R
        ea 3e 41 38 84 89 4d 41 bf 1a b7 4d 4f b0 fb a4  .>A8..MA...MO...
        cc 86 26 c3 5b 84 e7 4e 97 33 be 9f 95 c6 ea 6d  ..&.[..N.3.....m
> Event: Frame TX Status (0x3c) len 176                               16.79=
1308
    Wiphy: 0 (0x00000000)
    Interface Index: 3 (0x00000003)
    Wireless Device: 1 (0x0000000000000001)
    Frame: len 128
        Frame Type: 0x00b0
            Type: Management (0)
            Authentication:
                Frame Control: protocol: 00 type: 00 subtype: 11 to:
00 from: 00 more_frags: 00
                    retry: 00 power_mgmt: 00 more_data: 00 protected:
00 order: 00
                Duration: 0
                Address 1 (RA): D8:3A:DD:60:A3:0C
                Address 2 (TA): B8:27:EB:A4:6E:0F
                Address 3: D8:3A:DD:60:A3:0C
                Fragment Number: 0
                Sequence Number: 0
                Algorithm: SAE (seq: 1, status: 0)
        b0 00 00 00 d8 3a dd 60 a3 0c b8 27 eb a4 6e 0f  .....:.`...'..n.
        d8 3a dd 60 a3 0c 00 00 03 00 01 00 00 00 13 00  .:.`............
        f0 db cc 49 7c ad 4b 75 65 da 78 de 53 11 30 de  ...I|.Kue.x.S.0.
        fb 47 cf 3e 97 63 99 ff 2a 01 7f a0 e9 9b dd ed  .G.>.c..*.......
        13 07 4b 2c 46 8a 61 d0 ee 1d c6 82 60 b5 a9 90  ..K,F.a.....`...
        39 93 63 18 84 24 d2 06 51 26 93 91 2b c2 7c 52  9.c..$..Q&..+.|R
        ea 3e 41 38 84 89 4d 41 bf 1a b7 4d 4f b0 fb a4  .>A8..MA...MO...
        cc 86 26 c3 5b 84 e7 4e 97 33 be 9f 95 c6 ea 6d  ..&.[..N.3.....m
    Cookie: 0 (0x0000000000000000)
    ACK: true
> Result: Frame (0x3b) len 12                                         16.79=
1335
    Cookie: 0 (0x0000000000000000)
> Response: Frame (0x3b) len 4 [0x100]                                16.79=
1346
    Status: Success (0)
> Event: Frame (0x3b) len 184                                         16.81=
5917
    Wiphy: 0 (0x00000000)
    Interface Index: 3 (0x00000003)
    Wireless Device: 1 (0x0000000000000001)
    Wiphy Frequency: 2412 (0x0000096c)
    Unknown: 290 len 4
        00 00 00 00                                      ....
    Frame: len 128
        Frame Type: 0x00b0
            Type: Management (0)
            Authentication:
                Frame Control: protocol: 00 type: 00 subtype: 11 to:
00 from: 00 more_frags: 00
                    retry: 00 power_mgmt: 00 more_data: 00 protected:
00 order: 00
                Duration: 0
                Address 1 (RA): B8:27:EB:A4:6E:0F
                Address 2 (TA): D8:3A:DD:60:A3:0C
                Address 3: 00:00:00:00:00:00
                Fragment Number: 0
                Sequence Number: 0
                Algorithm: SAE (seq: 1, status: 0)
        b0 00 00 00 b8 27 eb a4 6e 0f d8 3a dd 60 a3 0c  .....'..n..:.`..
        00 00 00 00 00 00 00 00 03 00 01 00 00 00 13 00  ................
        43 80 d8 95 59 df 2a 68 cd 1f 2f 93 27 21 89 e5  C...Y.*h../.'!..
        2b 25 63 a4 33 8b 60 3a 2e 63 5e a8 f7 ba 40 f8  +%c.3.`:.c^...@.
        12 22 77 5c a1 9d bc 8b 07 1b 52 c1 ee 1b bc 9f  ."w\......R.....
        9e 6c 67 c1 e7 b4 95 bf 07 a6 8a 87 6c dc 15 1d  .lg.........l...
        80 71 2e df f1 c6 f2 98 be cb 58 bd 95 ac ce cb  .q........X.....
        fe a4 2a a0 82 78 b2 79 a0 c2 d4 cb ac 1b 2a 83  ..*..x.y......*.
    RX Management Flags: 2 (0x00000002)
< Request: Frame (0x3b) len 76 [ack]                                  16.82=
2238
    Interface Index: 3 (0x00000003)
    Frame: len 64
        Frame Type: 0x00b0
            Type: Management (0)
            Authentication:
                Frame Control: protocol: 00 type: 00 subtype: 11 to:
00 from: 00 more_frags: 00
                    retry: 00 power_mgmt: 00 more_data: 00 protected:
00 order: 00
                Duration: 0
                Address 1 (RA): D8:3A:DD:60:A3:0C
                Address 2 (TA): B8:27:EB:A4:6E:0F
                Address 3: D8:3A:DD:60:A3:0C
                Fragment Number: 0
                Sequence Number: 0
                Algorithm: SAE (seq: 2, status: 0)
                IEs: len 34
                    Error decoding Supported rates IE len 0: Invalid
argument (-22)
        b0 00 00 00 d8 3a dd 60 a3 0c b8 27 eb a4 6e 0f  .....:.`...'..n.
        d8 3a dd 60 a3 0c 00 00 03 00 02 00 00 00 01 00  .:.`............
        b4 69 71 a8 83 ee c4 c3 e1 5e c1 ef 5b 89 cc 18  .iq......^..[...
        6d 37 81 bb e0 9e 60 7b 6e 87 cb be 2b 60 af cf  m7....`{n...+`..
> Event: Frame TX Status (0x3c) len 112                               16.82=
8004
    Wiphy: 0 (0x00000000)
    Interface Index: 3 (0x00000003)
    Wireless Device: 1 (0x0000000000000001)
    Frame: len 64
        Frame Type: 0x00b0
            Type: Management (0)
            Authentication:
                Frame Control: protocol: 00 type: 00 subtype: 11 to:
00 from: 00 more_frags: 00
                    retry: 00 power_mgmt: 00 more_data: 00 protected:
00 order: 00
                Duration: 0
                Address 1 (RA): D8:3A:DD:60:A3:0C
                Address 2 (TA): B8:27:EB:A4:6E:0F
                Address 3: D8:3A:DD:60:A3:0C
                Fragment Number: 0
                Sequence Number: 0
                Algorithm: SAE (seq: 2, status: 0)
                IEs: len 34
                    Error decoding Supported rates IE len 0: Invalid
argument (-22)
        b0 00 00 00 d8 3a dd 60 a3 0c b8 27 eb a4 6e 0f  .....:.`...'..n.
        d8 3a dd 60 a3 0c 00 00 03 00 02 00 00 00 01 00  .:.`............
        b4 69 71 a8 83 ee c4 c3 e1 5e c1 ef 5b 89 cc 18  .iq......^..[...
        6d 37 81 bb e0 9e 60 7b 6e 87 cb be 2b 60 af cf  m7....`{n...+`..
    Cookie: 0 (0x0000000000000000)
    ACK: true
> Result: Frame (0x3b) len 12                                         16.82=
8029
    Cookie: 0 (0x0000000000000000)
> Response: Frame (0x3b) len 4 [0x100]                                16.82=
8042
    Status: Success (0)
> Event: Frame (0x3b) len 120                                         16.83=
9203
    Wiphy: 0 (0x00000000)
    Interface Index: 3 (0x00000003)
    Wireless Device: 1 (0x0000000000000001)
    Wiphy Frequency: 2412 (0x0000096c)
    Unknown: 290 len 4
        00 00 00 00                                      ....
    Frame: len 64
        Frame Type: 0x00b0
            Type: Management (0)
            Authentication:
                Frame Control: protocol: 00 type: 00 subtype: 11 to:
00 from: 00 more_frags: 00
                    retry: 00 power_mgmt: 00 more_data: 00 protected:
00 order: 00
                Duration: 0
                Address 1 (RA): B8:27:EB:A4:6E:0F
                Address 2 (TA): D8:3A:DD:60:A3:0C
                Address 3: 00:00:00:00:00:00
                Fragment Number: 0
                Sequence Number: 0
                Algorithm: SAE (seq: 2, status: 0)
                IEs: len 34
                    Error decoding Supported rates IE len 0: Invalid
argument (-22)
        b0 00 00 00 b8 27 eb a4 6e 0f d8 3a dd 60 a3 0c  .....'..n..:.`..
        00 00 00 00 00 00 00 00 03 00 02 00 00 00 01 00  ................
        f4 b4 13 37 c0 c2 ca 39 5f 0e ac 44 be d0 d0 04  ...7...9_..D....
        40 3c 1f cb 94 f8 e2 aa b7 df 65 d5 6a 88 14 7e  @<........e.j..~
    RX Management Flags: 2 (0x00000002)
< Request: External Auth (0x7f) len 40 [ack]                          16.83=
9539
    Interface Index: 3 (0x00000003)
    Status Code: 0 (0x0000)
    SSID: len 7
        64 65 73 6b 53 41 45                             deskSAE
    BSSID D8:3A:DD:60:A3:0C
> Response: External Auth (0x7f) len 4 [0x100]                        16.84=
0308
    Status: Success (0)
> PAE: len 121                                                        16.93=
5734
    Interface Index: 3
    EAPoL: len 121
        Protocol Version: 2 (802.1X-2004)
        Type: 3 (Key)
        Length: 117
        Descriptor Type: 2
        Key MIC: false
        Secure: false
        Error: false
        Request: false
        Encrypted Key Data: false
        SMK Message: false
        Key Descriptor Version: 0 (00)
        Key Type: true
        Install: false
        Key ACK: true
        Key Length: 16
        Key Replay Counter: 1
        Key NONCE
            8c 7a ce cc 0e 1d 4f af 99 42 b6 b9 9c ce 17 e0  .z....O..B....=
..
            ec bf a4 02 f3 36 70 cb 24 b3 3b 97 91 65 1c ed  .....6p.$.;..e=
..
        Key IV
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ..............=
..
        Key RSC
            00 00 00 00 00 00 00 00                          ........
        Key MIC Data
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ..............=
..
        Key Data: len 22
            Vendor specific: len 20
                IEEE 802.11 (00:0f:ac) type: 04
                PMKID KDE
                00 0f ac 04 34 5c a4 df d6 8c 75 dd 32 f9 a8 71
....4\....u.2..q
                7a 32 ba c4                                      z2..
        02 03 00 75 02 00 88 00 10 00 00 00 00 00 00 00  ...u............
        01 8c 7a ce cc 0e 1d 4f af 99 42 b6 b9 9c ce 17  ..z....O..B.....
        e0 ec bf a4 02 f3 36 70 cb 24 b3 3b 97 91 65 1c  ......6p.$.;..e.
        ed 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 16 dd 14 00 0f ac 04 34 5c a4 df d6 8c 75  .........4\....u
        dd 32 f9 a8 71 7a 32 ba c4                       .2..qz2..
> Event: Connect (0x2e) len 156                                       17.00=
0544
    Wiphy: 0 (0x00000000)
    Interface Index: 3 (0x00000003)
    MAC Address D8:3A:DD:60:A3:0C
    Status Code: 0 (0x0000)
    Request IE: len 80
        SSID: deskSAE
            64 65 73 6b 53 41 45                             deskSAE
        Supported rates:
            1.0(B) 2.0(B) 5.5(B) 11.0(B) 18.0 24.0 36.0 54.0 Mbit/s
            82 84 8b 96 24 30 48 6c                          ....$0Hl
        Extended supported rates:
            6.0 9.0 12.0 48.0 Mbit/s
            0c 12 18 60                                      ...`
        Tag 33: len 2
            03 14                                            ..
        Tag 36: len 2
            01 0b                                            ..
        RSN:
            Group Data Cipher Suite: len 4
                CCMP (00:0f:ac) suite  04
            Pairwise Cipher Suite: len 4
                CCMP (00:0f:ac) suite  04
            AKM Suite: len 4
                SAE/PMKSA caching SHA256; RSNA PMKSA caching
SHA256/mesh peering exchange (00:0f:ac) suite  08
            RSN capabilities: bits  2 - 3: 1 replay counter per PTKSA
            RSN capabilities: bits  4 - 5: 1 replay counter per GTKSA
            RSN capabilities: bit  7: Management Frame Protection Capable
            01 00 00 0f ac 04 01 00 00 0f ac 04 01 00 00 0f  ..............=
..
            ac 08 80 00                                      ....
        Extended Capabilities: len 8
            Capability: bit 62: Opmode Notification
            00 00 00 00 00 00 00 40                          .......@
        Vendor specific: len 9
            Broadcom (00:10:18) type: 02
            00 10 18 02 00 00 10 00 00                       .........
        SSID:
        SSID:
    Response IE: len 32
        Supported rates:
            1.0(B) 2.0(B) 5.5(B) 11.0(B) 6.0 9.0 12.0 18.0 Mbit/s
            82 84 8b 96 0c 12 18 24                          .......$
        Extended supported rates:
            24.0 36.0 48.0 54.0 Mbit/s
            30 48 60 6c                                      0H`l
        Extended Capabilities: len 8
            Capability: bit  2: Extended channel switching
            Capability: bit 62: Opmode Notification
            04 00 00 00 00 00 00 40                          .......@

On Sat, Jan 18, 2025 at 9:52=E2=80=AFAM James Prestwood <prestwoj@gmail.com=
> wrote:
>
> Hi Christian,
>
> On 1/17/25 10:03 PM, Christian Hewitt wrote:
> > Hello folks :)
> >
> > The Kodi focussed distro LibreELEC switched to iwd from
> > wpa_supplicant for our most recent release. It has been an
> > overall positive change, but we continue to see a trickle
> > of end-user reports of an =E2=80=9CInvalid Key=E2=80=9D error when devi=
ces
> > connect to a network.
> >
> > Things we=E2=80=99ve established:
> >
> > * Reverting to wpa_supplicant allows the device to connect
> > * Happens on a range of hardware so is not driver specific
> > * Happens on a range of kernels (tested back to 6.1)
> > * Poor signal strength shows the issue more frequently
> > * Networks with FT enabled show the issue more frequently
> > * Has nothing to do with passphrase length/characters
> >
> > TL/DR: We are reasonably confident the issue is within iwd
> > code and not drivers or kernels. We also use latest or very
> > recent kernels (and in-kernel drivers) and latest ConnMan
> > (we are generally =E2=80=98current=E2=80=99 with upstream sources throu=
ghout
> > the distro). We suspect a combination of radio properties
> > (influenced by poor signal and features) results in an error
> > which is not handled correctly so you end up in the wrong
> > place in code and trip the =E2=80=98Invalid Key=E2=80=99 error instead.
> >
> > Our project team are not able to replicate the issue with
> > our own devices and networks so we are currently reliant
> > on end-user reports. We also lack iwd debugging experience.
> > However, our embedded style distro packaging makes it very
> > simple for users to update and run an image tweaked with
> > iwd patches and/or config to get the output required to
> > triage the issue.
> >
> > So I=E2=80=99d like to understand what needs to be collected or
> > patched etc. to help start the process.
>
> For a start if you could gather debug logs when your users see the
> "Invalid key" message. Tbh I don't see anywhere IWD itself would print
> that, but ELL will signal that if some IWD settings file is using some
> invalid characters, that's about all I can think of at the moment
> without seeing debug logs. Our wiki [1] has some additional info about
> debugging. I'd even be happy to look at any of your locally tracked bug
> reports if there are any, otherwise just send some logs this way and
> we'll take a look.
>
> [1] https://archive.kernel.org/oldwiki/iwd.wiki.kernel.org/debugging.html
>
> Thanks,
>
> James
>
> >
> > Thanks in advance,
> >
> > Christian
>
