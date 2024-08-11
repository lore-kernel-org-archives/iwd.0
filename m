Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402981CAAF
	for <iwd@lists.linux.dev>; Sun, 11 Aug 2024 14:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723386966; cv=none; b=AROzEp5dZBjrXPy0drk5w4fyDiHAbvg00TxC1fw0Lg3gMBYY4I56i/UzgLNyStFr0PfZAzatMcXpvo/+CkYMiV7F5h2cDEGlj+RvhebnKg6hnHV9M8iHGYCWHlZfW+MMqgMKXxDgWY4btIh+fNM79TnyTWrD0lZwtJz5asyF7io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723386966; c=relaxed/simple;
	bh=hk7Af+mlddKmCDYHM1kAKNFsqu2B0JExiPOgzpGCCD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OMXe1jG47Wiy+te64rd6/bxYxDhGWpwsfj9L4gRCcTwK8TwbYDap4e+FlGKPusc/XKuBXV3iQYFpxM7f7hlUs+v51uVE+x2Gm8wgYyp86fzj2XfDrA4xitfqV7fHiPqhdyme949ZWU5GNGGAZBJFyEKsxrjECmn1Y/+z1l8t5KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a4z/ffFB; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4z/ffFB"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2cb63ceff6dso2794138a91.1
        for <iwd@lists.linux.dev>; Sun, 11 Aug 2024 07:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723386964; x=1723991764; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=besWImQLDEsd1/JTVNsVO71Zb+8UmpstOdeovLDKrqk=;
        b=a4z/ffFBx8TS/xPS/+Xf43VC8wTqZ85eFyCeqKtkI92GrGTan6+vqD1cHf+xBO7wnl
         iiAlwwZfEscGGOYaXPRItg1VEjw7o/83Kq9Ij/KJBbQBI0ZvcdnWEvS2q8uncWf1LUbz
         LSeNV7w0Khdc6RxgVvcBt28AzvmRkGzkMn3KQ/C94dUZnqzJD3eBG7v8Hev4nlvt0BML
         VRsEDTZ2O9L/4+pJSWH069pasOH9uoe02DXFgf2otuhslryjL8hgqUj8OFEpGYpQG30v
         KgQ72aIx/bPrYVMPbTni0j3X/k9uzCgopA9Rt/RxJXDEStoiuvCpstUBTGC+rclVy14N
         39rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723386964; x=1723991764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=besWImQLDEsd1/JTVNsVO71Zb+8UmpstOdeovLDKrqk=;
        b=WSOb2DDWqPuEn5K3BLEfeoQ6miV9lMkTfoqlgISA3B3QDyxR8Rz8Z+edyZRd/51ayU
         4R3Jzu8Os97tqDl7Hzv6Kr2RbX/2xqqi765GVNXVgkEXrUUcr29OY66TNbC0gF9wqaDE
         Nbl4X3NGY5ENi+SMIJcIKNuGH3bD09qWAID4/ilcWZWSSYpDSZsVGoU2CFr37IgSN/vC
         CXR/1feuy6TEamtpvx0Ocn9U4vMS+qwaSn94iEIHHROI9JqDVPw9Ndw+djteJihHcLEH
         3mooVWuECaLaGffx6FtK/jX5D1GuiH2dZJi5JtVeznC41Iap82w5/UbwTlCmRey3xq4J
         H2jQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9P7Cc2ICD2jBOQ8H4V+8WoFvCcH3vnkRFTn+hZ8aOGeeAR8NDYXOXA51yonX0fv5Bn70REY+JYjhAbxJEFedPE7Z5
X-Gm-Message-State: AOJu0YwFV/jrmyRocimouW0hHuHY5+YvHGZFImzRrK/FiHiPksY4kk6f
	nmNXvu99/npCWfhcEWEDdpcJje+fVfN6dlLEC8bDQ5pMkmjl5a50m2gOZbsLEl9F58ge3LBZdIH
	j3prq4YKTKdCXWdUHRenMQruvQTyBmSpy
X-Google-Smtp-Source: AGHT+IFuZPW9iPTi3whbe9k8Vy0pPLoayBxRzwnhZvQGOBr+eq8A66z0+Qj2z3se8Ax4Kx/KiH7J71TEm5nP4n07+Ms=
X-Received: by 2002:a17:90a:714b:b0:2cb:5134:562a with SMTP id
 98e67ed59e1d1-2d1e7f9b01dmr7847507a91.7.1723386964134; Sun, 11 Aug 2024
 07:36:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAG17S_N+Hjt2c8t8hN4VMx79QsQ3hiiE_cwOErg6fKoyHkr67A@mail.gmail.com>
 <ef38aa12-634e-4870-888c-219c961f301c@gmail.com> <b0ef10a2-c30b-4b6c-8370-66f9e0ace7b1@gmail.com>
In-Reply-To: <b0ef10a2-c30b-4b6c-8370-66f9e0ace7b1@gmail.com>
From: KeithG <ys3al35l@gmail.com>
Date: Sun, 11 Aug 2024 09:35:52 -0500
Message-ID: <CAG17S_P_MO4_BZYTCp4WDkJ_q4j=0s_s3azCOWrsvqmLD0ravw@mail.gmail.com>
Subject: Re: [Request] iwd to support brcmfmac 'SAE with AUTHENTICATE'
To: Denis Kenzior <denkenz@gmail.com>
Cc: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 8:56=E2=80=AFAM Denis Kenzior <denkenz@gmail.com> wr=
ote:
>
> Hi James,
>
> >> ...
> >>   Device supports SAE with AUTHENTICATE command
> >
> > So this is interesting... IWD does not expect a fullmac card to support
> > AUTHENTICATE but if this is the direction brcmfmac is going I guess we =
can
>
> That's because iw output is misleading.  This driver uses CMD_EXTERNAL_AU=
TH to
> tell iwd/wpa_s to transfer SAE authenticate frames via CMD_FRAME (similar=
 to how
> iwd does FT-Auth frames).
>
> Unfortunately the kernel never dedicated an actual capability bit to tell
> userspace that CMD_EXTERNAL_AUTH is being used.  They just reuse the gene=
ric
> FEATURE_SAE.
>
> > support it. This is such a mess though and brcmfmac just needs to decid=
e what
> > they are doing. This just makes things even more complicated as we now =
have 3
> > (?) ways to do SAE just on brcmfmac.
>
> Its still just 2, SAE_OFFLOAD and EXTERNAL_AUTH
>
> Regards,
> -Denis
James,

Sorry it took so long, but I needed time to build a kernel with the
nlmon module... PiOS does not include it.
THis is with kernel 6.6.44 running on a Pi3B+

The full iw list:
# iw list
Wiphy phy0
    wiphy index: 0
    max # scan SSIDs: 10
    max scan IEs length: 2048 bytes
    max # sched scan SSIDs: 16
    max # match sets: 16
    Retry short limit: 7
    Retry long limit: 4
    Coverage class: 0 (up to 0m)
    Device supports roaming.
    Supported Ciphers:
        * WEP40 (00-0f-ac:1)
        * WEP104 (00-0f-ac:5)
        * TKIP (00-0f-ac:2)
        * CCMP-128 (00-0f-ac:4)
        * CMAC (00-0f-ac:6)
    Available Antennas: TX 0 RX 0
    Supported interface modes:
         * IBSS
         * managed
         * AP
         * P2P-client
         * P2P-GO
         * P2P-device
    Band 1:
        Capabilities: 0x1022
            HT20/HT40
            Static SM Power Save
            RX HT20 SGI
            No RX STBC
            Max AMSDU length: 3839 bytes
            DSSS/CCK HT40
        Maximum RX AMPDU length 65535 bytes (exponent: 0x003)
        Minimum RX AMPDU time spacing: 16 usec (0x07)
        HT TX/RX MCS rate indexes supported: 0-7
        Bitrates (non-HT):
            * 1.0 Mbps
            * 2.0 Mbps (short preamble supported)
            * 5.5 Mbps (short preamble supported)
            * 11.0 Mbps (short preamble supported)
            * 6.0 Mbps
            * 9.0 Mbps
            * 12.0 Mbps
            * 18.0 Mbps
            * 24.0 Mbps
            * 36.0 Mbps
            * 48.0 Mbps
            * 54.0 Mbps
        Frequencies:
            * 2412 MHz [1] (20.0 dBm)
            * 2417 MHz [2] (20.0 dBm)
            * 2422 MHz [3] (20.0 dBm)
            * 2427 MHz [4] (20.0 dBm)
            * 2432 MHz [5] (20.0 dBm)
            * 2437 MHz [6] (20.0 dBm)
            * 2442 MHz [7] (20.0 dBm)
            * 2447 MHz [8] (20.0 dBm)
            * 2452 MHz [9] (20.0 dBm)
            * 2457 MHz [10] (20.0 dBm)
            * 2462 MHz [11] (20.0 dBm)
            * 2467 MHz [12] (disabled)
            * 2472 MHz [13] (disabled)
            * 2484 MHz [14] (disabled)
    Band 2:
        Capabilities: 0x1062
            HT20/HT40
            Static SM Power Save
            RX HT20 SGI
            RX HT40 SGI
            No RX STBC
            Max AMSDU length: 3839 bytes
            DSSS/CCK HT40
        Maximum RX AMPDU length 65535 bytes (exponent: 0x003)
        Minimum RX AMPDU time spacing: 16 usec (0x07)
        HT TX/RX MCS rate indexes supported: 0-7
        VHT Capabilities (0x00001020):
            Max MPDU length: 3895
            Supported Channel Width: neither 160 nor 80+80
            short GI (80 MHz)
            SU Beamformee
        VHT RX MCS set:
            1 streams: MCS 0-9
            2 streams: not supported
            3 streams: not supported
            4 streams: not supported
            5 streams: not supported
            6 streams: not supported
            7 streams: not supported
            8 streams: not supported
        VHT RX highest supported: 0 Mbps
        VHT TX MCS set:
            1 streams: MCS 0-9
            2 streams: not supported
            3 streams: not supported
            4 streams: not supported
            5 streams: not supported
            6 streams: not supported
            7 streams: not supported
            8 streams: not supported
        VHT TX highest supported: 0 Mbps
        VHT extended NSS: not supported
        Bitrates (non-HT):
            * 6.0 Mbps
            * 9.0 Mbps
            * 12.0 Mbps
            * 18.0 Mbps
            * 24.0 Mbps
            * 36.0 Mbps
            * 48.0 Mbps
            * 54.0 Mbps
        Frequencies:
            * 5170 MHz [34] (20.0 dBm)
            * 5180 MHz [36] (20.0 dBm)
            * 5190 MHz [38] (20.0 dBm)
            * 5200 MHz [40] (20.0 dBm)
            * 5210 MHz [42] (20.0 dBm)
            * 5220 MHz [44] (20.0 dBm)
            * 5230 MHz [46] (20.0 dBm)
            * 5240 MHz [48] (20.0 dBm)
            * 5260 MHz [52] (20.0 dBm) (radar detection)
            * 5280 MHz [56] (20.0 dBm) (radar detection)
            * 5300 MHz [60] (20.0 dBm) (radar detection)
            * 5320 MHz [64] (20.0 dBm) (radar detection)
            * 5500 MHz [100] (20.0 dBm) (radar detection)
            * 5520 MHz [104] (20.0 dBm) (radar detection)
            * 5540 MHz [108] (20.0 dBm) (radar detection)
            * 5560 MHz [112] (20.0 dBm) (radar detection)
            * 5580 MHz [116] (20.0 dBm) (radar detection)
            * 5600 MHz [120] (20.0 dBm) (radar detection)
            * 5620 MHz [124] (20.0 dBm) (radar detection)
            * 5640 MHz [128] (20.0 dBm) (radar detection)
            * 5660 MHz [132] (20.0 dBm) (radar detection)
            * 5680 MHz [136] (20.0 dBm) (radar detection)
            * 5700 MHz [140] (20.0 dBm) (radar detection)
            * 5720 MHz [144] (20.0 dBm) (radar detection)
            * 5745 MHz [149] (20.0 dBm)
            * 5765 MHz [153] (20.0 dBm)
            * 5785 MHz [157] (20.0 dBm)
            * 5805 MHz [161] (20.0 dBm)
            * 5825 MHz [165] (20.0 dBm)
    Supported commands:
         * new_interface
         * set_interface
         * new_key
         * start_ap
         * join_ibss
         * set_pmksa
         * del_pmksa
         * flush_pmksa
         * remain_on_channel
         * frame
         * set_wiphy_netns
         * set_channel
         * start_sched_scan
         * start_p2p_device
         * connect
         * disconnect
         * crit_protocol_start
         * crit_protocol_stop
         * update_connect_params
    software interface modes (can always be added):
    valid interface combinations:
         * #{ managed } <=3D 2, #{ P2P-device } <=3D 1, #{ P2P-client,
P2P-GO } <=3D 1,
           total <=3D 3, #channels <=3D 2
         * #{ managed } <=3D 1, #{ AP } <=3D 1, #{ P2P-client } <=3D 1, #{
P2P-device } <=3D 1,
           total <=3D 4, #channels <=3D 1
    Device supports SAE with AUTHENTICATE command
    Device supports scan flush.
    Device supports randomizing MAC-addr in sched scans.
    max # scan plans: 1
    max scan plan interval: 508
    max scan plan iterations: 0
    Supported TX frame types:
         * managed: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 0x90
0xa0 0xb0 0xc0 0xd0 0xe0 0xf0
         * AP: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 0x90 0xa0
0xb0 0xc0 0xd0 0xe0 0xf0
         * P2P-client: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80
0x90 0xa0 0xb0 0xc0 0xd0 0xe0 0xf0
         * P2P-GO: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 0x90
0xa0 0xb0 0xc0 0xd0 0xe0 0xf0
         * P2P-device: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80
0x90 0xa0 0xb0 0xc0 0xd0 0xe0 0xf0
    Supported RX frame types:
         * managed: 0x40 0xb0 0xd0
         * AP: 0x00 0x20 0x40 0xa0 0xb0 0xc0 0xd0
         * P2P-client: 0x40 0xd0
         * P2P-GO: 0x00 0x20 0x40 0xa0 0xb0 0xc0 0xd0
         * P2P-device: 0x40 0xd0
    Supported extended features:
        * [ CQM_RSSI_LIST ]: multiple CQM_RSSI_THOLD records
        * [ DFS_OFFLOAD ]: DFS offload

this is what dmesg shows:
# dmesg | grep brcmfmac
[   65.358538] brcmfmac: F1 signature read @0x18000000=3D0x15264345
[   65.372353] brcmfmac: brcmf_fw_alloc_request: using
brcm/brcmfmac43455-sdio for chip BCM4345/6
[   65.411731] usbcore: registered new interface driver brcmfmac
[   65.686557] brcmfmac: brcmf_c_process_txcap_blob: no txcap_blob
available (err=3D-2)
[   65.687105] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4345/6
wl0: Aug 29 2023 01:47:08 version 7.45.265 (28bca26 CY) FWID
01-b677b91b

The pcap is uploaded to my gdrive:
https://drive.google.com/file/d/1vIuje60MGFPklcXtSNMi9-IOlV_6sBJ8/view?usp=
=3Ddrivesdk

Hopefully, this helps to get started.

Keith
