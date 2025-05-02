Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74396225413
	for <iwd@lists.linux.dev>; Fri,  2 May 2025 23:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746229443; cv=none; b=o8+PdupWxrYVN6jOCTb1eBc7C3RnHa0j5LVRXzFYagwpwgOlSE9xjRWETHgcmwswKXv1lHNHp1dM9QMHOstVyoXoKQ0g87FRn/09p3ZhL2dyKpYOR0FIBH452g/Z7lomv/rwrvXQqnHUW0lLDvTuob6wwoDCVRB9jqQw3kmHZpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746229443; c=relaxed/simple;
	bh=/I3SzbUgwqFVCquNv+L8/EXQ6XnSptKx60M8SLETI2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fvxH+OuEoLoyKK86H1NRy9CORIulf5agbY8WPOut+SMrlUQWaQIBhLOvS87g80cWlqBebTL2LlFF2+Bo2bXCESxBjyaC1fHA9WazVMHfLLcQSF9CVNsQSk5kVlwf7unm8flWis+yQSEjUmglvJ4mBMmDuo3/DpZbWMd+0cuSfH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=daYSU9Z8; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="daYSU9Z8"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-736c277331eso3577296b3a.1
        for <iwd@lists.linux.dev>; Fri, 02 May 2025 16:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746229441; x=1746834241; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NKo3rKnc0y/RVysiID3ChrBS/6Wcw4LsS2O3q+8lzdU=;
        b=daYSU9Z8D4g5X/kgoVf6MqUy4U/Mit9ysOTeFNVlDK0+AlTyW6x78+3amcI0ycki2M
         IMJ/bLMWzudAPmlHyfhS5v74vVoTtGkzz4Wum8bTPzDPVsvrcw9fH9B2rsx4GoDJ5hKa
         FtB32LoVJtqOErmfFMNwYV4YRcNdkPf1LbSbqzPvL0A60BnPZnR+ntNH50kX5iNsZVn/
         wckT4cYH8QNI6RikyDtsTrxise+M0uAJU2eoIFwmxP3mIa+D1Eq/3w8FraAnONcmaPlt
         +bjCjvWrFURQdllh3U9+iGvfEfuGO940RXCMHGC2loqMnHkZITGK4hPmocb6IqnffMk2
         rqyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746229441; x=1746834241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NKo3rKnc0y/RVysiID3ChrBS/6Wcw4LsS2O3q+8lzdU=;
        b=bowIDGQdu/vWhoUYK/xBynqZr3uDPOzKLS2OL9EOeH+H/82ijqDOd9ckXtbQobv1sI
         0qvRt+fq7PfB5o82r/rmb7FJlT39KIcDK7EWvQaL8Rr3BNoc302B3yahifz2T106K+3g
         1mJVrz0PkzdVOeJ2xEvCxwD3G3Ol4pDrcvgnL6Sr1B9MX3mf7Yj8nFykcS67IObijqSV
         q+2/LKhkRCg+M3rqq1zwhb8Po6VL+erkqcGyMCIYkO6S4dRDCOsGXh+pqS5lVxBB6p9Q
         G9cPrVfFnknasxhtkL7DTtpQcC6/nmFiqqY99r0LShl8bQO9715l049v+IXo2Q3U9nfT
         5wBA==
X-Forwarded-Encrypted: i=1; AJvYcCXQh41O5kjet9SLptWIP/yiZ088LrHSSywrzdBpsDjSmUVNBldDsxkuT2NmETEAiP2GTfQ=@lists.linux.dev
X-Gm-Message-State: AOJu0YxAbOkJ+CRtFkoyRYabM35WMD3FIH+vFFP7SDsTPHuFq11QbMB2
	xqto30qpbbXWlM4clyAptHKV3ke1U8UUGk7FZsk62+gujXx3iYzHX9KOy+DaEzxRtzkfkYN1POE
	73Tokdke3clcrEa9MQ3XwMeL1brM=
X-Gm-Gg: ASbGncuTLFYds/xHJGFaMnYK+Ul8uxmsmtfKkCSsDnErdLZm2+TJgEKzhEEmbfSE3sq
	3ZzpftCxgM0eoGDzMucmCW4QVvI2mUL21/Zc6LVyHfeY7MR8vVE/2J4o1r/P2xvFAlRAk/PbEDU
	vghkfAAJF/zMOducxN6DdNK4wM
X-Google-Smtp-Source: AGHT+IHsoB6W057yAfzN4k7kdlzUyY2MlX345xDLbBZS2GlgIMBpx+hQr8L7lpCZlrhUmMQ08184be9Kp3fvJxFGrNk=
X-Received: by 2002:a17:90b:2e44:b0:2fa:1c09:3cee with SMTP id
 98e67ed59e1d1-30a42e9a5a3mr11389647a91.9.1746229440540; Fri, 02 May 2025
 16:44:00 -0700 (PDT)
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
In-Reply-To: <19691dcb210.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
From: KeithG <ys3al35l@gmail.com>
Date: Fri, 2 May 2025 18:43:50 -0500
X-Gm-Features: ATxdqUFbf91bnA9dEaPN6xkh53Vlng-j0QD0Byi1vBuNL45VfBaZDygGhQtJhYc
Message-ID: <CAG17S_MX3S9=EmiHBae8WsRnmsUGBJ5h4d8kCmgdxYZ2Zaeh8Q@mail.gmail.com>
Subject: Re: brcmfmac disconnects when iwd scans
To: Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev, 
	James Prestwood <prestwoj@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 2, 2025 at 11:38=E2=80=AFAM Arend Van Spriel
<arend.vanspriel@broadcom.com> wrote:
>
> On May 2, 2025 6:10:35 PM KeithG <ys3al35l@gmail.com> wrote:
>
> > On Fri, May 2, 2025 at 9:45=E2=80=AFAM Denis Kenzior <denkenz@gmail.com=
> wrote:
> >>
> >> Hi Keith,
> >>
> >>> I am building iwd from git with those 3 patches and every time it
> >>> scans, it disconnects the AP.
> >>> When I use wpa_supplicant, it does not disconnect regardless of using=
:
> >>> iw wlan0 scan passive
> >>> or
> >>> iw wlan0 scan
> >>>
> >>> it is only with iwd that it disconnects and only with iwctl. If I run
> >>> 'iw wlan0 scan passive' or
> >>> 'iw wlan0 scan' when iwd is running and wpa_aupplicant is removed, It
> >>> seems to be OK.
> >>> My laptop shows a disconnect, sometimes, but when I check the wlan0 o=
n
> >>> the laptop
> >>> it is still connected to the ap running on the RPi. I think it looses
> >>> the connection for a
> >>> second but reconnects. If I run the 'iwctl station wlan0 scan' it wil=
l
> >>> disconnect and not reconnect.
> >>> When it does, the ap0 gets to a strange state as it takes a number of
> >>> attempts to get it to
> >>> reconnect and sometimes it requires a tear down and restart of ap0
> >>> before I can reconnect
> >>>
> >>> This is an iwmon log of my RPi.
> >>> https://drive.google.com/file/d/1WNZz0dOip0XZZVIOs7RGcYIeLY2W4bXC/vie=
w?usp=3Dsharing
> >>> I had connected to it from my laptop. I then ran:
> >>>
> >>> # iw wlan0 scan
> >>> # iw wlan0 scan passive
> >>> # iwctl station wlan0 scan
> >>>
> >>> after I ran the last command, the Pi's ap0 disconnected from my lapto=
p.
> >>
> >> I do indeed see the local AP interface generating 'Del Station' events=
, which
> >> means the local client was disconnected.  The funny part is that iwd e=
nds up
> >> scanning a subset of the frequencies triggered via 'iw', it just does =
it in two
> >> sets.
> >>
> >> Here's what I see iw doing:
> >>
> >> < Request: Trigger Scan (0x21) len 16 [ack]                           =
22.190542
> >> Interface Index: 3 (0x00000003)
> >> Scan Flags: Mask: 0x00004000 len 4
> >>     Colocated6G
> >>> Event: Trigger Scan (0x21) len 364                                  2=
2.194336
> >> Wiphy: 0 (0x00000000)
> >> Interface Index: 3 (0x00000003)
> >> Wireless Device: 1 (0x0000000000000001)
> >> Scan SSIDs: len 0
> >> Scan Frequencies: len 320
> >> 0: 2412 (0x0000096c)
> >> 1: 2417 (0x00000971)
> >> 2: 2422 (0x00000976)
> >> 3: 2427 (0x0000097b)
> >> 4: 2432 (0x00000980)
> >> 5: 2437 (0x00000985)
> >> 6: 2442 (0x0000098a)
> >> 7: 2447 (0x0000098f)
> >> 8: 2452 (0x00000994)
> >> 9: 2457 (0x00000999)
> >> 10: 2462 (0x0000099e)
> >> 11: 5170 (0x00001432)
> >> 12: 5180 (0x0000143c)
> >> 13: 5190 (0x00001446)
> >> 14: 5200 (0x00001450)
> >> 15: 5210 (0x0000145a)
> >> 16: 5220 (0x00001464)
> >> 17: 5230 (0x0000146e)
> >> 18: 5240 (0x00001478)
> >> 19: 5260 (0x0000148c)
> >> 20: 5280 (0x000014a0)
> >> 21: 5300 (0x000014b4)
> >> 22: 5320 (0x000014c8)
> >> 23: 5500 (0x0000157c)
> >> 24: 5520 (0x00001590)
> >> 25: 5540 (0x000015a4)
> >> 26: 5560 (0x000015b8)
> >> 27: 5580 (0x000015cc)
> >> 28: 5600 (0x000015e0)
> >> 29: 5620 (0x000015f4)
> >> 30: 5640 (0x00001608)
> >> 31: 5660 (0x0000161c)
> >> 32: 5680 (0x00001630)
> >> 33: 5700 (0x00001644)
> >> 34: 5720 (0x00001658)
> >> 35: 5745 (0x00001671)
> >> 36: 5765 (0x00001685)
> >> 37: 5785 (0x00001699)
> >> 38: 5805 (0x000016ad)
> >> 39: 5825 (0x000016c1)
> >> Scan Flags: Mask: 0x00004000 len 4
> >>     Colocated6G
> >>
> >> While iwd does:
> >> < Request: Trigger Scan (0x21) len 64 [ack]                           =
31.619536
> >> Wireless Device: 1 (0x0000000000000001)
> >> Information Elements: len 12
> >> Extended Capabilities: len 10
> >>     Capability: bit 19: BSS transition
> >>     00 00 08 00 00 00 00 00 00 01                    ..........
> >> Scan Frequencies: len 24
> >> 0: 2412 (0x0000096c)
> >> 1: 2437 (0x00000985)
> >> 2: 2462 (0x0000099e)
> >> Scan Flags: Mask: 0x00004002 len 4
> >>     Flush
> >>     Colocated6G
> >>
> >> then
> >> < Request: Trigger Scan (0x21) len 248 [ack]                          =
32.040780
> >> Wireless Device: 1 (0x0000000000000001)
> >> Information Elements: len 12
> >> Extended Capabilities: len 10
> >>     Capability: bit 19: BSS transition
> >>     00 00 08 00 00 00 00 00 00 01                    ..........
> >> Scan Frequencies: len 208
> >> 0: 5180 (0x0000143c)
> >> 1: 5200 (0x00001450)
> >> 2: 5210 (0x0000145a)
> >> 3: 5220 (0x00001464)
> >> 4: 5240 (0x00001478)
> >> 5: 5260 (0x0000148c)
> >> 6: 5280 (0x000014a0)
> >> 7: 5300 (0x000014b4)
> >> 8: 5320 (0x000014c8)
> >> 9: 5500 (0x0000157c)
> >> 10: 5520 (0x00001590)
> >> 11: 5540 (0x000015a4)
> >> 12: 5560 (0x000015b8)
> >> 13: 5580 (0x000015cc)
> >> 14: 5600 (0x000015e0)
> >> 15: 5620 (0x000015f4)
> >> 16: 5640 (0x00001608)
> >> 17: 5660 (0x0000161c)
> >> 18: 5680 (0x00001630)
> >> 19: 5700 (0x00001644)
> >> 20: 5720 (0x00001658)
> >> 21: 5745 (0x00001671)
> >> 22: 5765 (0x00001685)
> >> 23: 5785 (0x00001699)
> >> 24: 5805 (0x000016ad)
> >> 25: 5825 (0x000016c1)
> >> Scan Flags: Mask: 0x00004002 len 4
> >>     Flush
> >>     Colocated6G
> >>
> >> And about 1.5 seconds later the Del Station event comes in.
> >>> Event: Del Station (0x14) len 32                                    3=
3.560662
> >> Interface Index: 7 (0x00000007)
> >> MAC Address 50:84:92:A6:7A:7A
> >> Generation: 0 (0x00000000)
> >> Station Info: len 0
> >>
> >> Not really sure what could be causing this.  Maybe this is a question =
for
> >> Arend?
> >>
> >> Regards,
> >> -Denis
> >
> > Denis,
> >
> > Thanks for going through this. I am still trying to get more pertinent
> > information as to what may cause these disconnects. If there is
> > anything I can test or more info I can provide, let me know. As it is,
> > I am trying to set up hostapd/wpa_supplicant to see if it is any more
> > stable.
>
> So is this thread in any way related to the thread with subject "Cannot
> maintain an ap with brcmfmac"? I responded to that on April 21, but never
> saw any follow-up on that. It's kinda hard to debug by email especially
> when new threads are started in parallel. More than willing to help but a
> bit lost in the woods here.
>
> Regards,
> Arend
>
Arend,

Sorry about that, Yes it is the same. I stopped responding to that
thread as it seemed to me to be be an IWD issue and not a
wpa_supplicant/hostapd/firmware/driver issue that I was running into.
It still may be, but I thought I'd investigate iwd first. I composed a
whole response, but then noticed that it seemed more stable with
wpa_supplicant than iwd and did not want to exercise everyone (you).

my next steps are to reconfigure everything with just
hostapd/wpa_supplicant and see if it is any more stable. If so, then
look to see if I can characterize how it behaves differently with iwd
than wpa_supplicant.

What we want is to be able to use the single WiFi chip with 2
interfaces, one as the default alan0 and one as ap0 . Have it scan
automatically on wlan0 while ap0 is up and advertising if not
connected. If the scan shows a 'known network', tear down off the ap0,
stop hostapd and initiate a connection to the SSID on the wlan0. We
create the ap0 via these commands:

iw dev wlan0 interface add ap0 type __ap
ip link set dev ap0 address '$some_MAC'
ip link set dev ap0 up

then set up the AP mode with either iwd or hostapd
