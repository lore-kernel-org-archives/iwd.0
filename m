Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAF7101FF
	for <iwd@lists.linux.dev>; Sun,  4 May 2025 12:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746362004; cv=none; b=egc5jaY6QPFyr+lTKAogB0qw6/TBDwZf/Q2bDYx4zkL8tBCKv6rxVmNUBrGfGld0RYmQ55YFd0NbEW5E1zRr25HAJbUiBHFYVxbC+VKVMVCCt7aa6dOhKmQ1huJ+Kcy9FKH6RjJBJXOBRPWGhLY+vgveUgpenA/tQlR3tHKrVOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746362004; c=relaxed/simple;
	bh=t5ikPVMYyNYl3gMO022PrQ+hO1v/GRcvPhQoNf01OcY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qcs1RltfjuNwz0zRUH5wdwVa0TBAzrKZ0KhM6vJ9gQrJgDXWtcDBcxMyYNnkl9KjNPhul+KIxrBtES9xkp5VnSILqPj+FzfjnTSwoR9eav7J1kmTQ+bff4gOYVQd+e+/nkrkCkpTm37OK8zKWhlE/pBpvX8dFwciI8bW0pelFPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hUrKVOmO; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUrKVOmO"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-301c4850194so2837802a91.2
        for <iwd@lists.linux.dev>; Sun, 04 May 2025 05:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746362002; x=1746966802; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q4TnZikPbBhaihbh1LVN7G7J1XRodWrIp1MXm5IAHIw=;
        b=hUrKVOmO2N51SIZvqfCNPBsjBVjiFOkaiMppr6H9bTlEMZw9vwpzN5BsmjxcVnQ7fJ
         FiQgOPE7lwFlvdK9TykxPa222ndJukc558ZZMMS5kk67rJYQ/sK36qoyWB+xXavjgkXE
         hdcMcO7Ts7YiiaTYMXU0jqfT3gNkGo14SOlPH6kFAKd0U+xh+0vroxGNSePMjxL4+/uW
         mOgDUCEhXzbTZb4XzIooD37BcwZFjB6CQ0xzzADZMFz+8YrTpm/u6PNszwVWrsI56jbW
         R0LnZy23APAP/liVafSsSdKqUFgYkXy6Xg+Tj0gY8RnOryoAi8d1CJ9yq3LsvcxkqCuj
         Araw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746362002; x=1746966802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q4TnZikPbBhaihbh1LVN7G7J1XRodWrIp1MXm5IAHIw=;
        b=GEDqpAPheTGWiTzpGvic/evx9Qwu4uEhs2AfBmRuZlJvAwO7y9OV6fW2t5AT98bW/i
         qqBU+UhxL2iTDFz1soW3tKLwuUCWsCRK2YTUYZwpfL9m2otPQnmdK78zA6sYEmPy6Z7X
         uSwTCmho0YdQAM3v15n70Y9nOK3+5fpTKu/LL71DM1hzFBs4RtOIsCDumCBCYOdv+Z6j
         85ttFVKQJHDbbYwjfcJyaj3dgKk8U9E+OtSuHag/zWh0k9yEkLNpNBH+LyJOBX6RL/8g
         wBc0mkwdutXYu7k7UAewu8t60je3uoJmKKIsxipRBqPELGPHwtaCvNe7sHTD7zQiXK3L
         oGAQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+K9xfZ15RWG+GDb5sEmda1pTlrdoIsr7HbjW+b0W4oTTlwY8E97mO3h6Vf7f7mFp8umY=@lists.linux.dev
X-Gm-Message-State: AOJu0YzQn4C0y0FKr+oc1t1aDEz3eCYg/mqrn0ZkD50+MQ7owO+2nPlx
	d5p8v7KiFKsXSl4tB+dllY8okpTfFiNBrKHkltHalwofPndoCMtbL2tuOTMNyLnHpd/I2lqiqT6
	3SO2+zFFTrB1SZlB1Qv4Pt400HgE=
X-Gm-Gg: ASbGncsgtnZ5QhS9DxQ2pHYMYKOpYrXfL7SN0m89+VKKSGwJmQwMSbnGm3ZubgkUJe0
	R1wD6AHE1luxd4VLNPCJY25BOkl/3w9TEQYTc7zgJ5uqDrT7A7H86+FtLS0pWJUxZhnNmoyIflv
	OnY+VsixtWb13pXudiYuMNW9rkdPQVct5vZTs=
X-Google-Smtp-Source: AGHT+IHdfyPPpQ+2+T65UXONjDBWvOTp6HqitJhH+Beyq4apSBE0fpZV74R33jmdrbTuELQsdr58ok+hqw2wFbLdEW4=
X-Received: by 2002:a17:90b:5147:b0:2ee:e113:815d with SMTP id
 98e67ed59e1d1-30a6198d023mr6222275a91.8.1746362000786; Sun, 04 May 2025
 05:33:20 -0700 (PDT)
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
 <CAG17S_MX3S9=EmiHBae8WsRnmsUGBJ5h4d8kCmgdxYZ2Zaeh8Q@mail.gmail.com> <1fb12821-1707-4478-941b-9fbc007c4e9a@broadcom.com>
In-Reply-To: <1fb12821-1707-4478-941b-9fbc007c4e9a@broadcom.com>
From: KeithG <ys3al35l@gmail.com>
Date: Sun, 4 May 2025 07:33:09 -0500
X-Gm-Features: ATxdqUHiaulTq3bhAXsMzfD828qalKMaLN_1PEifsSRxIfI70t0gPFERMR60fd4
Message-ID: <CAG17S_M9_-TG4YnHAwx2+O2bJ6sbEE75X=V0y4Pbxy222O3ZJg@mail.gmail.com>
Subject: Re: brcmfmac disconnects when iwd scans
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev, 
	James Prestwood <prestwoj@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 4, 2025 at 12:51=E2=80=AFAM Arend van Spriel
<arend.vanspriel@broadcom.com> wrote:
>
> On 5/3/2025 1:43 AM, KeithG wrote:
> > On Fri, May 2, 2025 at 11:38=E2=80=AFAM Arend Van Spriel
> > <arend.vanspriel@broadcom.com> wrote:
> >>
> >> On May 2, 2025 6:10:35 PM KeithG <ys3al35l@gmail.com> wrote:
> >>
> >>> On Fri, May 2, 2025 at 9:45=E2=80=AFAM Denis Kenzior <denkenz@gmail.c=
om> wrote:
> >>>>
> >>>> Hi Keith,
> >>>>
> >>>>> I am building iwd from git with those 3 patches and every time it
> >>>>> scans, it disconnects the AP.
> >>>>> When I use wpa_supplicant, it does not disconnect regardless of usi=
ng:
> >>>>> iw wlan0 scan passive
> >>>>> or
> >>>>> iw wlan0 scan
> >>>>>
> >>>>> it is only with iwd that it disconnects and only with iwctl. If I r=
un
> >>>>> 'iw wlan0 scan passive' or
> >>>>> 'iw wlan0 scan' when iwd is running and wpa_aupplicant is removed, =
It
> >>>>> seems to be OK.
> >>>>> My laptop shows a disconnect, sometimes, but when I check the wlan0=
 on
> >>>>> the laptop
> >>>>> it is still connected to the ap running on the RPi. I think it loos=
es
> >>>>> the connection for a
> >>>>> second but reconnects. If I run the 'iwctl station wlan0 scan' it w=
ill
> >>>>> disconnect and not reconnect.
> >>>>> When it does, the ap0 gets to a strange state as it takes a number =
of
> >>>>> attempts to get it to
> >>>>> reconnect and sometimes it requires a tear down and restart of ap0
> >>>>> before I can reconnect
> >>>>>
> >>>>> This is an iwmon log of my RPi.
> >>>>> https://drive.google.com/file/d/1WNZz0dOip0XZZVIOs7RGcYIeLY2W4bXC/v=
iew?usp=3Dsharing
> >>>>> I had connected to it from my laptop. I then ran:
> >>>>>
> >>>>> # iw wlan0 scan
> >>>>> # iw wlan0 scan passive
> >>>>> # iwctl station wlan0 scan
> >>>>>
> >>>>> after I ran the last command, the Pi's ap0 disconnected from my lap=
top.
> >>>>
> >>>> I do indeed see the local AP interface generating 'Del Station' even=
ts, which
> >>>> means the local client was disconnected.  The funny part is that iwd=
 ends up
> >>>> scanning a subset of the frequencies triggered via 'iw', it just doe=
s it in two
> >>>> sets.
> >>>>
> >>>> Here's what I see iw doing:
> >>>>
> >>>> < Request: Trigger Scan (0x21) len 16 [ack]                         =
  22.190542
> >>>> Interface Index: 3 (0x00000003)
> >>>> Scan Flags: Mask: 0x00004000 len 4
> >>>>      Colocated6G
> >>>>> Event: Trigger Scan (0x21) len 364                                 =
 22.194336
> >>>> Wiphy: 0 (0x00000000)
> >>>> Interface Index: 3 (0x00000003)
> >>>> Wireless Device: 1 (0x0000000000000001)
> >>>> Scan SSIDs: len 0
> >>>> Scan Frequencies: len 320
> >>>> 0: 2412 (0x0000096c)
> >>>> 1: 2417 (0x00000971)
> >>>> 2: 2422 (0x00000976)
> >>>> 3: 2427 (0x0000097b)
> >>>> 4: 2432 (0x00000980)
> >>>> 5: 2437 (0x00000985)
> >>>> 6: 2442 (0x0000098a)
> >>>> 7: 2447 (0x0000098f)
> >>>> 8: 2452 (0x00000994)
> >>>> 9: 2457 (0x00000999)
> >>>> 10: 2462 (0x0000099e)
> >>>> 11: 5170 (0x00001432)
> >>>> 12: 5180 (0x0000143c)
> >>>> 13: 5190 (0x00001446)
> >>>> 14: 5200 (0x00001450)
> >>>> 15: 5210 (0x0000145a)
> >>>> 16: 5220 (0x00001464)
> >>>> 17: 5230 (0x0000146e)
> >>>> 18: 5240 (0x00001478)
> >>>> 19: 5260 (0x0000148c)
> >>>> 20: 5280 (0x000014a0)
> >>>> 21: 5300 (0x000014b4)
> >>>> 22: 5320 (0x000014c8)
> >>>> 23: 5500 (0x0000157c)
> >>>> 24: 5520 (0x00001590)
> >>>> 25: 5540 (0x000015a4)
> >>>> 26: 5560 (0x000015b8)
> >>>> 27: 5580 (0x000015cc)
> >>>> 28: 5600 (0x000015e0)
> >>>> 29: 5620 (0x000015f4)
> >>>> 30: 5640 (0x00001608)
> >>>> 31: 5660 (0x0000161c)
> >>>> 32: 5680 (0x00001630)
> >>>> 33: 5700 (0x00001644)
> >>>> 34: 5720 (0x00001658)
> >>>> 35: 5745 (0x00001671)
> >>>> 36: 5765 (0x00001685)
> >>>> 37: 5785 (0x00001699)
> >>>> 38: 5805 (0x000016ad)
> >>>> 39: 5825 (0x000016c1)
> >>>> Scan Flags: Mask: 0x00004000 len 4
> >>>>      Colocated6G
> >>>>
> >>>> While iwd does:
> >>>> < Request: Trigger Scan (0x21) len 64 [ack]                         =
  31.619536
> >>>> Wireless Device: 1 (0x0000000000000001)
> >>>> Information Elements: len 12
> >>>> Extended Capabilities: len 10
> >>>>      Capability: bit 19: BSS transition
> >>>>      00 00 08 00 00 00 00 00 00 01                    ..........
> >>>> Scan Frequencies: len 24
> >>>> 0: 2412 (0x0000096c)
> >>>> 1: 2437 (0x00000985)
> >>>> 2: 2462 (0x0000099e)
> >>>> Scan Flags: Mask: 0x00004002 len 4
> >>>>      Flush
> >>>>      Colocated6G
> >>>>
> >>>> then
> >>>> < Request: Trigger Scan (0x21) len 248 [ack]                        =
  32.040780
> >>>> Wireless Device: 1 (0x0000000000000001)
> >>>> Information Elements: len 12
> >>>> Extended Capabilities: len 10
> >>>>      Capability: bit 19: BSS transition
> >>>>      00 00 08 00 00 00 00 00 00 01                    ..........
> >>>> Scan Frequencies: len 208
> >>>> 0: 5180 (0x0000143c)
> >>>> 1: 5200 (0x00001450)
> >>>> 2: 5210 (0x0000145a)
> >>>> 3: 5220 (0x00001464)
> >>>> 4: 5240 (0x00001478)
> >>>> 5: 5260 (0x0000148c)
> >>>> 6: 5280 (0x000014a0)
> >>>> 7: 5300 (0x000014b4)
> >>>> 8: 5320 (0x000014c8)
> >>>> 9: 5500 (0x0000157c)
> >>>> 10: 5520 (0x00001590)
> >>>> 11: 5540 (0x000015a4)
> >>>> 12: 5560 (0x000015b8)
> >>>> 13: 5580 (0x000015cc)
> >>>> 14: 5600 (0x000015e0)
> >>>> 15: 5620 (0x000015f4)
> >>>> 16: 5640 (0x00001608)
> >>>> 17: 5660 (0x0000161c)
> >>>> 18: 5680 (0x00001630)
> >>>> 19: 5700 (0x00001644)
> >>>> 20: 5720 (0x00001658)
> >>>> 21: 5745 (0x00001671)
> >>>> 22: 5765 (0x00001685)
> >>>> 23: 5785 (0x00001699)
> >>>> 24: 5805 (0x000016ad)
> >>>> 25: 5825 (0x000016c1)
> >>>> Scan Flags: Mask: 0x00004002 len 4
> >>>>      Flush
> >>>>      Colocated6G
> >>>>
> >>>> And about 1.5 seconds later the Del Station event comes in.
> >>>>> Event: Del Station (0x14) len 32                                   =
 33.560662
> >>>> Interface Index: 7 (0x00000007)
> >>>> MAC Address 50:84:92:A6:7A:7A
> >>>> Generation: 0 (0x00000000)
> >>>> Station Info: len 0
> >>>>
> >>>> Not really sure what could be causing this.  Maybe this is a questio=
n for
> >>>> Arend?
> >>>>
> >>>> Regards,
> >>>> -Denis
> >>>
> >>> Denis,
> >>>
> >>> Thanks for going through this. I am still trying to get more pertinen=
t
> >>> information as to what may cause these disconnects. If there is
> >>> anything I can test or more info I can provide, let me know. As it is=
,
> >>> I am trying to set up hostapd/wpa_supplicant to see if it is any more
> >>> stable.
> >>
> >> So is this thread in any way related to the thread with subject "Canno=
t
> >> maintain an ap with brcmfmac"? I responded to that on April 21, but ne=
ver
> >> saw any follow-up on that. It's kinda hard to debug by email especiall=
y
> >> when new threads are started in parallel. More than willing to help bu=
t a
> >> bit lost in the woods here.
> >>
> >> Regards,
> >> Arend
> >>
> > Arend,
> >
> > Sorry about that, Yes it is the same. I stopped responding to that
> > thread as it seemed to me to be be an IWD issue and not a
> > wpa_supplicant/hostapd/firmware/driver issue that I was running into.
> > It still may be, but I thought I'd investigate iwd first. I composed a
> > whole response, but then noticed that it seemed more stable with
> > wpa_supplicant than iwd and did not want to exercise everyone (you).
>
> No problem. Glad we have it clarified. With user-space and kernel driver
> interacting it is good to keep both sides in the loop and stick with a
> single email thread.
>
> > my next steps are to reconfigure everything with just
> > hostapd/wpa_supplicant and see if it is any more stable. If so, then
> > look to see if I can characterize how it behaves differently with iwd
> > than wpa_supplicant.
>
> You could try without encryption if that is possible to see if that
> makes a difference. Also would help if you enabled CONFIG_BRCMDBG for
> the brcmfmac driver so you can enble additional debug prints by passing
> the 'debug' module parameter. CONN, EVENT, and FIL debug levels are good
> to have and maybe SCAN =3D> debug=3D0xd400.
>
> > What we want is to be able to use the single WiFi chip with 2
> > interfaces, one as the default alan0 and one as ap0 . Have it scan
> > automatically on wlan0 while ap0 is up and advertising if not
> > connected. If the scan shows a 'known network', tear down off the ap0,
> > stop hostapd and initiate a connection to the SSID on the wlan0. We
> > create the ap0 via these commands:
>
> Okay. That sounds a bit peculiar. So what is the idea here. When it is
> not connected and running ap0 clients can connect to it and then what?
> Is the use-case here that those client can setup 'known networks'?
> Anyways, you have your reasons and leave it with that.
>
> > iw dev wlan0 interface add ap0 type __ap
> > ip link set dev ap0 address '$some_MAC'
> > ip link set dev ap0 up
>
> Would it be sufficient to only create the ap0 interface and leave the
> rest to hostapd/iwd. I am pretty sure hostapd does take care of those ste=
ps.
>
> Regards,
> Arend

Arend,

A bit to clarify. This is a headless RPi. Any config changes are
through the web interface. What we are trying to do is make the
headless RPi a bit more robust wrt WiFi connection. If it looses its
connection to a known ssid, then it should fire up an AP so that a
local user can connect to it to fix the issue or select another ssid
or whatever. You make a good point and it appears that the tearing
down of the interface seems to be what is causing some of the
flakiness.

I was experimenting today and it appears that ap0 does not go down
when wpa_supplicant scans.
To test this, I got wpa_cli working and with the combo of
hostapd/dnsmasq running on the ap0 and wpa_supplicant scanning on
wlan0. I noted that I can have a connection via wlan0 to my phone and
a connection to my laptop on ap0 at the same time and can pass traffic
both ways and neither goes down or gets flaky. I can access the web
page on the Pi from both interfaces at the same time. It appears that
wpa_supplicant scanning does not disturb the ap0 while it is connected
at the same time.

It does appears that iwd is causing something that causes the ap to
get flaky and go down, periodically, when it scans. I am still trying
to nail it all down as to what exactly is going on.

I get this error with iwd when I connect to the ap0 from my laptop:
May 04 06:47:43 pi4 iwd[630908]: Can't recurse into ATTR_KEY in GET_KEY rep=
ly
but it still connects and I can pass traffic.

I also note that if I bring up a known SSID and allow iwd to connect
to it that I get this as well where it looks like when the ap0 goes
down that it takes wlan0 down with it then reconnects:
May 04 07:15:50 pi4 iwd[941445]: event: connect-info, ssid: BatPhone,
bss: 96:8d:a4:fa:41:33, signal: -60, load: 0/255
May 04 07:15:50 pi4 iwd[941445]: event: state, old: autoconnect_full,
new: connecting (auto)
May 04 07:15:50 pi4 python3[936142]: wlan0 state: connecting
May 04 07:15:51 pi4 systemd-networkd[180]: wlan0: Connected WiFi
access point: BatPhone (96:8d:a4:fa:41:33)
May 04 07:15:51 pi4 iwd[941445]: hardware_rekey not supported
May 04 07:15:51 pi4 iwd[941445]: event: state, old: connecting (auto),
new: connecting (netconfig)
May 04 07:15:51 pi4 systemd-networkd[180]: wlan0: Gained carrier
May 04 07:15:53 pi4 systemd-networkd[180]: wlan0: Gained IPv6LL
May 04 07:15:57 pi4 iwd[941445]: Received Deauthentication event,
reason: 0, from_ap: false
May 04 07:15:57 pi4 iwd[941445]: event: disconnect-info, reason: 0
May 04 07:15:57 pi4 systemd-networkd[180]: wlan0: Lost carrier
May 04 07:15:57 pi4 iwd[941445]: event: state, old: connecting
(netconfig), new: disconnected
May 04 07:15:57 pi4 iwd[941445]: event: state, old: disconnected, new:
autoconnect_quick
May 04 07:15:57 pi4 python3[936142]: wlan0 state: disconnected
May 04 07:15:57 pi4 iwd[941445]: event: connect-info, FullMAC driver:
brcmfmac using SAE.  Expect EXTERNAL_AUTH
May 04 07:15:57 pi4 iwd[941445]: event: connect-info, FullMAC driver:
brcmfmac using SAE.  Expect EXTERNAL_AUTH
May 04 07:15:57 pi4 iwd[941445]: event: connect-info, ssid: BatPhone,
bss: 96:8d:a4:fa:41:33, signal: -59, load: 0/255
May 04 07:15:57 pi4 iwd[941445]: event: state, old: autoconnect_quick,
new: connecting (auto)
May 04 07:15:57 pi4 python3[936142]: wlan0 state: connecting
May 04 07:15:58 pi4 systemd-networkd[180]: wlan0: Connected WiFi
access point: BatPhone (96:8d:a4:fa:41:33)

I currently destroy ap0 when it connects to the wlan0, but will
experiment with just leaving it up but stop iwd AP.
I do not get this behavior with wpa_supplicant/hostapd (default
versions for RPiOS Bookworm). If I stop hostapd then tear down the
interface, wpa_supplicant remains connected. This may be due to the
need of iwd to be restarted in order for it to manage a new or hot
plugged interface, in this case ap0.
