Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E57628AAEC
	for <iwd@lists.linux.dev>; Wed,  7 May 2025 13:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746626061; cv=none; b=WcecHLWGMPa5b6oiRjdX1huvHcWU6LqF4ZQp74AfGpWq80hohNyNl4tRZ1nQy70/p8J2zwEM2Ouc6YlsHU1qlAY/o97jSqVksaseQx2s8wKOsS7McOqxx1OEgq8m2m6Fg8h2+vEm32Hmv8bV/YgaonX33HgcAwDd/Sqy1+RBGyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746626061; c=relaxed/simple;
	bh=gziU/a8e1mPFBShneeQS17K5S0WaMRUhivM0KZlVieM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mcmDXooRkpwBk/6dTnaa7gLIj39421Qo1GDV08SVbuUDU/JaMozMDPaSQZLBwCde9UcRR3iIB40zjVHyEPNwefCDnJjT/zHBDaAd+jfoEPZLTHY4S+K3EFziVaa98pAjMdBBzGZomcBW+BquOO1oba8gFw0Gk/UZm8hgOdpWztQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SWCYOovt; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SWCYOovt"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22e15aea506so64630295ad.1
        for <iwd@lists.linux.dev>; Wed, 07 May 2025 06:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746626058; x=1747230858; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T4jdDIyh2hL9qsjSQbbGBId1ap+bopJcLzhHwLMZkfc=;
        b=SWCYOovt0clikQVud/BfLi4XFdMveNG3YaDhGcinTCvoh4bvo0yY+H9vWhKUIeT/wt
         lTLOKgUdf/b/i3tb9ZB4XGLs3beudbGLuohuVZTUfr6J5uLNmNirDXzx9g5O45DlziEK
         wqqwUsb5r4tEWQv1a+TiYD0AA7iFoqnG0D3yCguSDtkJB6qEyT1WJDP8xSyf4x+sO7db
         uv1Ec+xsRtHD1J2hH/Es/YMXcumRDlu5TsNaWstdPkbFnuw2Xbi9ZyMFt35Gt1joNX02
         mabzwWSZxcQxrvJuKaMcwPKqyXKcf8M2ycPc5WbwdQbwTLAk9j7q+E9qSOANnfCg+bRx
         /Jlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746626058; x=1747230858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T4jdDIyh2hL9qsjSQbbGBId1ap+bopJcLzhHwLMZkfc=;
        b=fyWQqeCPq49HYcc1pzW16KZlGMDPFKDu7ZCLW0vVb9yriQiirN9nPcHjtvLzjZtrYl
         33gdvZKoe3t0sWAxWNqn+r1TcVPDfgO77g8AZgTDJ/rlg7Bm9SNx+jO2YvKNPKYm4bxJ
         y6/w5IgvQAw2ILb622z7cEKZod5Ix2twsVd7je0vQjTQa4DUNyAcFyogSDLtlT8cheq7
         O8PXEw8ksu3vhWfTOwckkL7nzqnMKXT8x9tsa/vxpqxam7bdYvqo1hPTGEvm7q8GPxHZ
         Ue7lxTeggEBcKu5MgNK4a2ATRWXbTpfdCYHa5lcxit6U7BHbs41LcTImIqAS1Keh2n7c
         45RA==
X-Forwarded-Encrypted: i=1; AJvYcCUimoK0KSD81WkzYh0A4deT8R1dEDVbijULD0w8VOUYzVWDrfd/Mb/x2PkWUgT9rlyfovA=@lists.linux.dev
X-Gm-Message-State: AOJu0YyZ6+P/zNc68qIAs55bjrcWNn607ajY1zUOy/FvATW2D3gyMRHM
	0gLrwJD+Bv5pRXfLMpzzqvYs1spXfMVdGJuELccJ1xh8qhFDDVYXnwRpusqAREQgGLWzNXBVvWy
	rKWwJK617OpQ+bRiRO0cELwS5JZA=
X-Gm-Gg: ASbGncsQCOSNURpzbyu0ifGvYnM0LzPUIQEHTI31wmHCd4vptAoi3Jxgd4huYHC220o
	C68nx5HMC7Qvyafr7xrSypw/ATXdgmAu2U6JG1QzlebbfuNV/o41MAEXnJ7bxL4Pkn5x+DeUXcK
	gv2jkSjNZQrT0DRz2azQmMrIyiGPhfceuJ3J4=
X-Google-Smtp-Source: AGHT+IHRBDG4jrPq1EvbujxhRGXoeBB+SQlSf4AeMkB2BhFTtT6xkCMvT7gWIZe+n+vY5cwFsrrmIyyC8XWtEWJeWCA=
X-Received: by 2002:a17:902:d4c6:b0:223:377f:9795 with SMTP id
 d9443c01a7336-22e5e986f39mr48992705ad.0.1746626057884; Wed, 07 May 2025
 06:54:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAG17S_M4_+CR1uSsajyvHBjig6cfCuxegipnHREhk1sXjSyOsA@mail.gmail.com>
 <a0dcf03d-3bd3-43e5-9532-5a565d20930f@gmail.com> <CAG17S_MKZXf3vC0zgaK_MUrA1nqRzhGcPGUho873KU3jYVShXw@mail.gmail.com>
 <45bc2f1b-b037-4784-a2a9-7732a82b7391@gmail.com> <CAG17S_MqLBQV6ktjbWsoAv0e+2A0dnNN5+X7Pf+b-qDP3mrL1Q@mail.gmail.com>
 <19691dcb210.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CAG17S_MX3S9=EmiHBae8WsRnmsUGBJ5h4d8kCmgdxYZ2Zaeh8Q@mail.gmail.com>
 <1fb12821-1707-4478-941b-9fbc007c4e9a@broadcom.com> <CAG17S_M9_-TG4YnHAwx2+O2bJ6sbEE75X=V0y4Pbxy222O3ZJg@mail.gmail.com>
In-Reply-To: <CAG17S_M9_-TG4YnHAwx2+O2bJ6sbEE75X=V0y4Pbxy222O3ZJg@mail.gmail.com>
From: KeithG <ys3al35l@gmail.com>
Date: Wed, 7 May 2025 08:54:06 -0500
X-Gm-Features: ATxdqUF21HLJXcG-YGL3jZcbsGnrLPGupLipBl5484C8wwpaZuZsL04rV6yjGV8
Message-ID: <CAG17S_Njkt7rFTk4Tn-KnLVS8kzA61KJGyWgNQ9kqx5M=s7DnA@mail.gmail.com>
Subject: Re: brcmfmac disconnects when iwd scans
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev, 
	James Prestwood <prestwoj@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

further information...

I tried this with 2 different pi4s and have been able to confirm
wpa_supplicant/hostapd is stable on the Pi4 (will try others when I
get a chance). I also tried both the 'shipping' brcmfmac43455 firmware
and the 'latest'. It is only with the 'latest' that I get reliable
connections. With the 'shipping' version, I can get connections for
both wlan0 with wpa_suppolicant and ap0 with hostapd, but the ap0
connection is flaky without any connection on wlan0. And I cannot
sustain both connections at all. This 'latest' firmware is required
for a sustainable, reliable ap0 with connection with hostapd.

this is the firmware required:
[    3.658201] brcmfmac: brcmf_fw_alloc_request: using
brcm/brcmfmac43455-sdio for chip BCM4345/6
[    3.660643] usbcore: registered new interface driver brcmfmac
[    4.041524] brcmfmac: brcmf_c_process_txcap_blob: no txcap_blob
available (err=3D-2)
[    4.042269] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4345/6
wl0: Oct 28 2024 23:27:00 version 7.45.286 (be70ab3 CY) FWID
01-95efe7fa

The only annoyance I get is that the log fills up with failed scan messages=
:
May 07 08:43:11 deskrune wpa_supplicant[604]: wlan0: Failed to
initiate sched scan

the Pi still works and is scanning because when a known ssid appears,
it immediately connects, so it is scanning, I just get this message.

Now that I have this working well with wpa_supplicant and know how to
get it all 'up' and stable, I will start investigating what
differences there are with iwd and why it is flaky. Please guide me as
to the best way to do this.

Regards,

Keith

On Sun, May 4, 2025 at 7:33=E2=80=AFAM KeithG <ys3al35l@gmail.com> wrote:
>
> On Sun, May 4, 2025 at 12:51=E2=80=AFAM Arend van Spriel
> <arend.vanspriel@broadcom.com> wrote:
> >
> > On 5/3/2025 1:43 AM, KeithG wrote:
> > > On Fri, May 2, 2025 at 11:38=E2=80=AFAM Arend Van Spriel
> > > <arend.vanspriel@broadcom.com> wrote:
> > >>
> > >> On May 2, 2025 6:10:35 PM KeithG <ys3al35l@gmail.com> wrote:
> > >>
> > >>> On Fri, May 2, 2025 at 9:45=E2=80=AFAM Denis Kenzior <denkenz@gmail=
.com> wrote:
> > >>>>
> > >>>> Hi Keith,
> > >>>>
> > >>>>> I am building iwd from git with those 3 patches and every time it
> > >>>>> scans, it disconnects the AP.
> > >>>>> When I use wpa_supplicant, it does not disconnect regardless of u=
sing:
> > >>>>> iw wlan0 scan passive
> > >>>>> or
> > >>>>> iw wlan0 scan
> > >>>>>
> > >>>>> it is only with iwd that it disconnects and only with iwctl. If I=
 run
> > >>>>> 'iw wlan0 scan passive' or
> > >>>>> 'iw wlan0 scan' when iwd is running and wpa_aupplicant is removed=
, It
> > >>>>> seems to be OK.
> > >>>>> My laptop shows a disconnect, sometimes, but when I check the wla=
n0 on
> > >>>>> the laptop
> > >>>>> it is still connected to the ap running on the RPi. I think it lo=
oses
> > >>>>> the connection for a
> > >>>>> second but reconnects. If I run the 'iwctl station wlan0 scan' it=
 will
> > >>>>> disconnect and not reconnect.
> > >>>>> When it does, the ap0 gets to a strange state as it takes a numbe=
r of
> > >>>>> attempts to get it to
> > >>>>> reconnect and sometimes it requires a tear down and restart of ap=
0
> > >>>>> before I can reconnect
> > >>>>>
> > >>>>> This is an iwmon log of my RPi.
> > >>>>> https://drive.google.com/file/d/1WNZz0dOip0XZZVIOs7RGcYIeLY2W4bXC=
/view?usp=3Dsharing
> > >>>>> I had connected to it from my laptop. I then ran:
> > >>>>>
> > >>>>> # iw wlan0 scan
> > >>>>> # iw wlan0 scan passive
> > >>>>> # iwctl station wlan0 scan
> > >>>>>
> > >>>>> after I ran the last command, the Pi's ap0 disconnected from my l=
aptop.
> > >>>>
> > >>>> I do indeed see the local AP interface generating 'Del Station' ev=
ents, which
> > >>>> means the local client was disconnected.  The funny part is that i=
wd ends up
> > >>>> scanning a subset of the frequencies triggered via 'iw', it just d=
oes it in two
> > >>>> sets.
> > >>>>
> > >>>> Here's what I see iw doing:
> > >>>>
> > >>>> < Request: Trigger Scan (0x21) len 16 [ack]                       =
    22.190542
> > >>>> Interface Index: 3 (0x00000003)
> > >>>> Scan Flags: Mask: 0x00004000 len 4
> > >>>>      Colocated6G
> > >>>>> Event: Trigger Scan (0x21) len 364                               =
   22.194336
> > >>>> Wiphy: 0 (0x00000000)
> > >>>> Interface Index: 3 (0x00000003)
> > >>>> Wireless Device: 1 (0x0000000000000001)
> > >>>> Scan SSIDs: len 0
> > >>>> Scan Frequencies: len 320
> > >>>> 0: 2412 (0x0000096c)
> > >>>> 1: 2417 (0x00000971)
> > >>>> 2: 2422 (0x00000976)
> > >>>> 3: 2427 (0x0000097b)
> > >>>> 4: 2432 (0x00000980)
> > >>>> 5: 2437 (0x00000985)
> > >>>> 6: 2442 (0x0000098a)
> > >>>> 7: 2447 (0x0000098f)
> > >>>> 8: 2452 (0x00000994)
> > >>>> 9: 2457 (0x00000999)
> > >>>> 10: 2462 (0x0000099e)
> > >>>> 11: 5170 (0x00001432)
> > >>>> 12: 5180 (0x0000143c)
> > >>>> 13: 5190 (0x00001446)
> > >>>> 14: 5200 (0x00001450)
> > >>>> 15: 5210 (0x0000145a)
> > >>>> 16: 5220 (0x00001464)
> > >>>> 17: 5230 (0x0000146e)
> > >>>> 18: 5240 (0x00001478)
> > >>>> 19: 5260 (0x0000148c)
> > >>>> 20: 5280 (0x000014a0)
> > >>>> 21: 5300 (0x000014b4)
> > >>>> 22: 5320 (0x000014c8)
> > >>>> 23: 5500 (0x0000157c)
> > >>>> 24: 5520 (0x00001590)
> > >>>> 25: 5540 (0x000015a4)
> > >>>> 26: 5560 (0x000015b8)
> > >>>> 27: 5580 (0x000015cc)
> > >>>> 28: 5600 (0x000015e0)
> > >>>> 29: 5620 (0x000015f4)
> > >>>> 30: 5640 (0x00001608)
> > >>>> 31: 5660 (0x0000161c)
> > >>>> 32: 5680 (0x00001630)
> > >>>> 33: 5700 (0x00001644)
> > >>>> 34: 5720 (0x00001658)
> > >>>> 35: 5745 (0x00001671)
> > >>>> 36: 5765 (0x00001685)
> > >>>> 37: 5785 (0x00001699)
> > >>>> 38: 5805 (0x000016ad)
> > >>>> 39: 5825 (0x000016c1)
> > >>>> Scan Flags: Mask: 0x00004000 len 4
> > >>>>      Colocated6G
> > >>>>
> > >>>> While iwd does:
> > >>>> < Request: Trigger Scan (0x21) len 64 [ack]                       =
    31.619536
> > >>>> Wireless Device: 1 (0x0000000000000001)
> > >>>> Information Elements: len 12
> > >>>> Extended Capabilities: len 10
> > >>>>      Capability: bit 19: BSS transition
> > >>>>      00 00 08 00 00 00 00 00 00 01                    ..........
> > >>>> Scan Frequencies: len 24
> > >>>> 0: 2412 (0x0000096c)
> > >>>> 1: 2437 (0x00000985)
> > >>>> 2: 2462 (0x0000099e)
> > >>>> Scan Flags: Mask: 0x00004002 len 4
> > >>>>      Flush
> > >>>>      Colocated6G
> > >>>>
> > >>>> then
> > >>>> < Request: Trigger Scan (0x21) len 248 [ack]                      =
    32.040780
> > >>>> Wireless Device: 1 (0x0000000000000001)
> > >>>> Information Elements: len 12
> > >>>> Extended Capabilities: len 10
> > >>>>      Capability: bit 19: BSS transition
> > >>>>      00 00 08 00 00 00 00 00 00 01                    ..........
> > >>>> Scan Frequencies: len 208
> > >>>> 0: 5180 (0x0000143c)
> > >>>> 1: 5200 (0x00001450)
> > >>>> 2: 5210 (0x0000145a)
> > >>>> 3: 5220 (0x00001464)
> > >>>> 4: 5240 (0x00001478)
> > >>>> 5: 5260 (0x0000148c)
> > >>>> 6: 5280 (0x000014a0)
> > >>>> 7: 5300 (0x000014b4)
> > >>>> 8: 5320 (0x000014c8)
> > >>>> 9: 5500 (0x0000157c)
> > >>>> 10: 5520 (0x00001590)
> > >>>> 11: 5540 (0x000015a4)
> > >>>> 12: 5560 (0x000015b8)
> > >>>> 13: 5580 (0x000015cc)
> > >>>> 14: 5600 (0x000015e0)
> > >>>> 15: 5620 (0x000015f4)
> > >>>> 16: 5640 (0x00001608)
> > >>>> 17: 5660 (0x0000161c)
> > >>>> 18: 5680 (0x00001630)
> > >>>> 19: 5700 (0x00001644)
> > >>>> 20: 5720 (0x00001658)
> > >>>> 21: 5745 (0x00001671)
> > >>>> 22: 5765 (0x00001685)
> > >>>> 23: 5785 (0x00001699)
> > >>>> 24: 5805 (0x000016ad)
> > >>>> 25: 5825 (0x000016c1)
> > >>>> Scan Flags: Mask: 0x00004002 len 4
> > >>>>      Flush
> > >>>>      Colocated6G
> > >>>>
> > >>>> And about 1.5 seconds later the Del Station event comes in.
> > >>>>> Event: Del Station (0x14) len 32                                 =
   33.560662
> > >>>> Interface Index: 7 (0x00000007)
> > >>>> MAC Address 50:84:92:A6:7A:7A
> > >>>> Generation: 0 (0x00000000)
> > >>>> Station Info: len 0
> > >>>>
> > >>>> Not really sure what could be causing this.  Maybe this is a quest=
ion for
> > >>>> Arend?
> > >>>>
> > >>>> Regards,
> > >>>> -Denis
> > >>>
> > >>> Denis,
> > >>>
> > >>> Thanks for going through this. I am still trying to get more pertin=
ent
> > >>> information as to what may cause these disconnects. If there is
> > >>> anything I can test or more info I can provide, let me know. As it =
is,
> > >>> I am trying to set up hostapd/wpa_supplicant to see if it is any mo=
re
> > >>> stable.
> > >>
> > >> So is this thread in any way related to the thread with subject "Can=
not
> > >> maintain an ap with brcmfmac"? I responded to that on April 21, but =
never
> > >> saw any follow-up on that. It's kinda hard to debug by email especia=
lly
> > >> when new threads are started in parallel. More than willing to help =
but a
> > >> bit lost in the woods here.
> > >>
> > >> Regards,
> > >> Arend
> > >>
> > > Arend,
> > >
> > > Sorry about that, Yes it is the same. I stopped responding to that
> > > thread as it seemed to me to be be an IWD issue and not a
> > > wpa_supplicant/hostapd/firmware/driver issue that I was running into.
> > > It still may be, but I thought I'd investigate iwd first. I composed =
a
> > > whole response, but then noticed that it seemed more stable with
> > > wpa_supplicant than iwd and did not want to exercise everyone (you).
> >
> > No problem. Glad we have it clarified. With user-space and kernel drive=
r
> > interacting it is good to keep both sides in the loop and stick with a
> > single email thread.
> >
> > > my next steps are to reconfigure everything with just
> > > hostapd/wpa_supplicant and see if it is any more stable. If so, then
> > > look to see if I can characterize how it behaves differently with iwd
> > > than wpa_supplicant.
> >
> > You could try without encryption if that is possible to see if that
> > makes a difference. Also would help if you enabled CONFIG_BRCMDBG for
> > the brcmfmac driver so you can enble additional debug prints by passing
> > the 'debug' module parameter. CONN, EVENT, and FIL debug levels are goo=
d
> > to have and maybe SCAN =3D> debug=3D0xd400.
> >
> > > What we want is to be able to use the single WiFi chip with 2
> > > interfaces, one as the default alan0 and one as ap0 . Have it scan
> > > automatically on wlan0 while ap0 is up and advertising if not
> > > connected. If the scan shows a 'known network', tear down off the ap0=
,
> > > stop hostapd and initiate a connection to the SSID on the wlan0. We
> > > create the ap0 via these commands:
> >
> > Okay. That sounds a bit peculiar. So what is the idea here. When it is
> > not connected and running ap0 clients can connect to it and then what?
> > Is the use-case here that those client can setup 'known networks'?
> > Anyways, you have your reasons and leave it with that.
> >
> > > iw dev wlan0 interface add ap0 type __ap
> > > ip link set dev ap0 address '$some_MAC'
> > > ip link set dev ap0 up
> >
> > Would it be sufficient to only create the ap0 interface and leave the
> > rest to hostapd/iwd. I am pretty sure hostapd does take care of those s=
teps.
> >
> > Regards,
> > Arend
>
> Arend,
>
> A bit to clarify. This is a headless RPi. Any config changes are
> through the web interface. What we are trying to do is make the
> headless RPi a bit more robust wrt WiFi connection. If it looses its
> connection to a known ssid, then it should fire up an AP so that a
> local user can connect to it to fix the issue or select another ssid
> or whatever. You make a good point and it appears that the tearing
> down of the interface seems to be what is causing some of the
> flakiness.
>
> I was experimenting today and it appears that ap0 does not go down
> when wpa_supplicant scans.
> To test this, I got wpa_cli working and with the combo of
> hostapd/dnsmasq running on the ap0 and wpa_supplicant scanning on
> wlan0. I noted that I can have a connection via wlan0 to my phone and
> a connection to my laptop on ap0 at the same time and can pass traffic
> both ways and neither goes down or gets flaky. I can access the web
> page on the Pi from both interfaces at the same time. It appears that
> wpa_supplicant scanning does not disturb the ap0 while it is connected
> at the same time.
>
> It does appears that iwd is causing something that causes the ap to
> get flaky and go down, periodically, when it scans. I am still trying
> to nail it all down as to what exactly is going on.
>
> I get this error with iwd when I connect to the ap0 from my laptop:
> May 04 06:47:43 pi4 iwd[630908]: Can't recurse into ATTR_KEY in GET_KEY r=
eply
> but it still connects and I can pass traffic.
>
> I also note that if I bring up a known SSID and allow iwd to connect
> to it that I get this as well where it looks like when the ap0 goes
> down that it takes wlan0 down with it then reconnects:
> May 04 07:15:50 pi4 iwd[941445]: event: connect-info, ssid: BatPhone,
> bss: 96:8d:a4:fa:41:33, signal: -60, load: 0/255
> May 04 07:15:50 pi4 iwd[941445]: event: state, old: autoconnect_full,
> new: connecting (auto)
> May 04 07:15:50 pi4 python3[936142]: wlan0 state: connecting
> May 04 07:15:51 pi4 systemd-networkd[180]: wlan0: Connected WiFi
> access point: BatPhone (96:8d:a4:fa:41:33)
> May 04 07:15:51 pi4 iwd[941445]: hardware_rekey not supported
> May 04 07:15:51 pi4 iwd[941445]: event: state, old: connecting (auto),
> new: connecting (netconfig)
> May 04 07:15:51 pi4 systemd-networkd[180]: wlan0: Gained carrier
> May 04 07:15:53 pi4 systemd-networkd[180]: wlan0: Gained IPv6LL
> May 04 07:15:57 pi4 iwd[941445]: Received Deauthentication event,
> reason: 0, from_ap: false
> May 04 07:15:57 pi4 iwd[941445]: event: disconnect-info, reason: 0
> May 04 07:15:57 pi4 systemd-networkd[180]: wlan0: Lost carrier
> May 04 07:15:57 pi4 iwd[941445]: event: state, old: connecting
> (netconfig), new: disconnected
> May 04 07:15:57 pi4 iwd[941445]: event: state, old: disconnected, new:
> autoconnect_quick
> May 04 07:15:57 pi4 python3[936142]: wlan0 state: disconnected
> May 04 07:15:57 pi4 iwd[941445]: event: connect-info, FullMAC driver:
> brcmfmac using SAE.  Expect EXTERNAL_AUTH
> May 04 07:15:57 pi4 iwd[941445]: event: connect-info, FullMAC driver:
> brcmfmac using SAE.  Expect EXTERNAL_AUTH
> May 04 07:15:57 pi4 iwd[941445]: event: connect-info, ssid: BatPhone,
> bss: 96:8d:a4:fa:41:33, signal: -59, load: 0/255
> May 04 07:15:57 pi4 iwd[941445]: event: state, old: autoconnect_quick,
> new: connecting (auto)
> May 04 07:15:57 pi4 python3[936142]: wlan0 state: connecting
> May 04 07:15:58 pi4 systemd-networkd[180]: wlan0: Connected WiFi
> access point: BatPhone (96:8d:a4:fa:41:33)
>
> I currently destroy ap0 when it connects to the wlan0, but will
> experiment with just leaving it up but stop iwd AP.
> I do not get this behavior with wpa_supplicant/hostapd (default
> versions for RPiOS Bookworm). If I stop hostapd then tear down the
> interface, wpa_supplicant remains connected. This may be due to the
> need of iwd to be restarted in order for it to manage a new or hot
> plugged interface, in this case ap0.
