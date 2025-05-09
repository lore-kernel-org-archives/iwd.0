Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554F821ABC9
	for <iwd@lists.linux.dev>; Fri,  9 May 2025 14:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746801976; cv=none; b=SBUgLhlmZSyf6GkZw//G268lP2EdBqof28PznEgiUZZHSkjVR82gK/MCi+AgqbB27uvfSgXn2xySsQw9jwg8nPGgXaeG1XUppUsgSeHa94NZTi/GaERvn/YQGq5J5tWSsQ/AsUs3CZHM8iac1kxzMdvf5oq4+d/DdUA6LT1EBR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746801976; c=relaxed/simple;
	bh=KgxEPzYFYZ0jOuLE/E7wDVVzjwKF110mY/rn0tI2HiM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fRqMd49OT/XAvzT9LFuYf/JnKGSpZHPLGgnYzcUoPxwmEBwFINp8PPcQb/PthZq/vt4yXMC9193AXJOtS8jiZRjjxXB2xZNXWaR7V32yXhpKkN8vNcjP8vLVKhVHUBamMbhWyG+WHfphIqpnTnzRjG2Mb375ROq7I5U2aiwceyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C81Y1uu7; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C81Y1uu7"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-30a894cc07cso2248931a91.2
        for <iwd@lists.linux.dev>; Fri, 09 May 2025 07:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746801973; x=1747406773; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=elRr0cpCUoLLvLAYfBFOpo3bcG/5+Fvn8+b8etbT82Q=;
        b=C81Y1uu7iajx6zH1+em3VzBFrwHW1SEdEwlPI+TSDGeJ7QQeTcT3vhv+KFD5REAy4z
         d+5g5QZSh+AO9DDb0jITHggJel9iWKgRkInDcuCZk+ioNeHdHaFYrcbnTU5t9oNMeYYJ
         PGheeMFI9goQgohw4X3vDCozZQ9yelQT9fNWKXwx0KXBSpTXG6Om448H2d3yoBRjpmMK
         0YggCoTLFv2pBzQMDDSzSN7IJiOWoSNGCGXjl0d58JOXX8yqi/tsVgmtxq8zV12YQ4U7
         PtS/CQw/gbRJcBo2bUAY6maTxONoFmbUJRp6hrY3N5bL5vC4K2estKDhLdB3SqcLrvR9
         0I0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746801973; x=1747406773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=elRr0cpCUoLLvLAYfBFOpo3bcG/5+Fvn8+b8etbT82Q=;
        b=v9dqyROrvhN2dQvKh/fFE4vGnQAyJQZUXfbdmyonJKIQ/J5ZnHUHkMG7o/PE93m46D
         PMj3DK+EjBP6ax1C7lLZ4uH0rsokC1FWzzWZ9qaVgAQT9c4cdgxYnmpTeS3oMUYZlY5k
         +ecBm4lNrASUs2pqJv+n73XtlzUdT8k4PZ8CPUB+wWlOp0mrFtJzGkom31YBL5RYvG4Q
         OOj7Wl8/GxYGgvQ+Sa/6W7E1quTTSfya2tGSeM9CnDIQqkCpP8KSndrGUe1uWbhBfsF6
         aeXwNRoo6O+N2q0ByA3l4tATuKugXTydiehnsmLCLJKgYriE6sbYsB4y9pqPp3fr897L
         5nZw==
X-Forwarded-Encrypted: i=1; AJvYcCXekQs0gwmqTgTqlUaMlbaD8FvTSIRQsKWbHHsTOPAvpJ5KxoamJnQ4qJfaMhqvTyiein0=@lists.linux.dev
X-Gm-Message-State: AOJu0Ywqrp8sy+J6oZZ5I4XgI8JMcf0L9YJJdanP/JJMFmagzPEyjkuK
	t30TKfxdl4BFCb/jvKgnMtATMIDVoq6yN8kCfr5gQ0gLm55f+gdsG3FF7vaqL3Q0gbl2kjnRtuq
	N8Z3jAwFu4vYZkIE254FyZCGtRak=
X-Gm-Gg: ASbGncsor/dbj7pVtjo8ykiyAkyCgjOB/Ps6+mWRTGY4RoBR5gcz/oiYtfCkvM9kGUh
	i/COAyILpSYGF8k2MMCbuegRX11XlDvwVw2zSYJumECXcS37MoKDw5WvomNHXygb/Vej45g53SD
	DBnIIpfUf+RzdCuNRAIyi+7bTY
X-Google-Smtp-Source: AGHT+IGmdNe3jxDFCKd0eD0yoflavOn4zi/W9CLUW056cshSEpQepJ8rDd8VhuRLU//8Wixj54EhXmyvNmu13ysd5Ok=
X-Received: by 2002:a17:90b:268a:b0:2ff:7331:18bc with SMTP id
 98e67ed59e1d1-30c3d641350mr5189379a91.26.1746801973121; Fri, 09 May 2025
 07:46:13 -0700 (PDT)
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
 <CAG17S_Njkt7rFTk4Tn-KnLVS8kzA61KJGyWgNQ9kqx5M=s7DnA@mail.gmail.com>
 <38be0ddf-50ff-4ef9-bd98-748ffcfed2e1@broadcom.com> <CAG17S_NCAmDPa+jK=OPdF18H8Yuuio3czytaa2q5hMSJiKO9bw@mail.gmail.com>
 <CAG17S_MbUsp6Nu=idnk0p9sQLRJWg=G8oaE1X2kdjwZ_uH4KAA@mail.gmail.com>
In-Reply-To: <CAG17S_MbUsp6Nu=idnk0p9sQLRJWg=G8oaE1X2kdjwZ_uH4KAA@mail.gmail.com>
From: KeithG <ys3al35l@gmail.com>
Date: Fri, 9 May 2025 09:46:01 -0500
X-Gm-Features: ATxdqUH2h79X6eY2fpo9rhNJM2rOjndsW4ZvXLXyt6dSDqYGHT_czspr0Ait57k
Message-ID: <CAG17S_PxYNxLpAMzXOuS6riv46G22zpOM0rT0D7Xp-usbWyo+A@mail.gmail.com>
Subject: Re: brcmfmac disconnects when iwd scans
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev, 
	James Prestwood <prestwoj@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 6:02=E2=80=AFPM KeithG <ys3al35l@gmail.com> wrote:
>
> On Wed, May 7, 2025 at 2:44=E2=80=AFPM KeithG <ys3al35l@gmail.com> wrote:
> >
> > On Wed, May 7, 2025 at 9:27=E2=80=AFAM Arend van Spriel
> > <arend.vanspriel@broadcom.com> wrote:
> > >
> > > On 5/7/2025 3:54 PM, KeithG wrote:
> > > > further information...
> > > >
> > > > I tried this with 2 different pi4s and have been able to confirm
> > > > wpa_supplicant/hostapd is stable on the Pi4 (will try others when I
> > > > get a chance). I also tried both the 'shipping' brcmfmac43455 firmw=
are
> > > > and the 'latest'. It is only with the 'latest' that I get reliable
> > > > connections. With the 'shipping' version, I can get connections for
> > > > both wlan0 with wpa_suppolicant and ap0 with hostapd, but the ap0
> > > > connection is flaky without any connection on wlan0. And I cannot
> > > > sustain both connections at all. This 'latest' firmware is required
> > > > for a sustainable, reliable ap0 with connection with hostapd.
> > > >
> > > > this is the firmware required:
> > > > [    3.658201] brcmfmac: brcmf_fw_alloc_request: using
> > > > brcm/brcmfmac43455-sdio for chip BCM4345/6
> > > > [    3.660643] usbcore: registered new interface driver brcmfmac
> > > > [    4.041524] brcmfmac: brcmf_c_process_txcap_blob: no txcap_blob
> > > > available (err=3D-2)
> > > > [    4.042269] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4345/6
> > > > wl0: Oct 28 2024 23:27:00 version 7.45.286 (be70ab3 CY) FWID
> > > > 01-95efe7fa
> > > >
> > > > The only annoyance I get is that the log fills up with failed scan =
messages:
> > > > May 07 08:43:11 deskrune wpa_supplicant[604]: wlan0: Failed to
> > > > initiate sched scan
> > >
> > > The scheduled scan is basically a scan offload in which user-space te=
lls
> > > the driver what to look for and how often (hence scheduled). The
> > > advantage of the scheduled scan is that the host (RPi) goes to sleep
> > > while the wifi chip is on the lookout for the ssid. No idea why it is
> > > failing though.
> > >
> > > > the Pi still works and is scanning because when a known ssid appear=
s,
> > > > it immediately connects, so it is scanning, I just get this message=
.
> > >
> > > What I recall from wpa_supplicant behavior is that it does a regular
> > > scan for a configured ssid and after a number of attempts it does try=
 to
> > > setup a scheduled scan if the driver supports it. When it fails it
> > > simply continues with the regular scans. The brcmfmac driver supports
> > > scheduled scan so it seems like regression although apart from the lo=
g
> > > message the end-user is not really affected. I expect it will not mak=
e
> > > much noticable difference on the energy bill. ;-)
> > >
> > > > Now that I have this working well with wpa_supplicant and know how =
to
> > > > get it all 'up' and stable, I will start investigating what
> > > > differences there are with iwd and why it is flaky. Please guide me=
 as
> > > > to the best way to do this.
> > >
> > > Were you successful using nlmon. I suspect differences should show up
> > > between wpa_supplicant and iwd.
> > >
> > > Regards,
> > > Arend
> >
> > I will use nlmon and see what the difference is. Will post them when I =
get them.
> >
> > Keith
>
> This is an iwmon log showing the hostapd up then a connection from my
> laptop then a wpa_supplicant connection to my phone acting as a hot
> spot.
>
> https://drive.google.com/file/d/12NhxYT-gF0K2NrBfYEpSvcuGQ6UyejQD/view?us=
p=3Dsharing
>
> This is an iwmon log showing the same activities, but with iwd
> managing the ap. The laptop connecting, then connecting to the phone
> as a hot spot. Both disconnected. and passed no data.
>
> https://drive.google.com/file/d/1diSp32FXpHjLzQeC5gF-tlNNHji8a1l5/view?us=
p=3Dsharing
>
> I do not know how to read these, but hopefully they will provide some gui=
dance.
>
> Keith

Playing with this setup a bit more. It seems that my setup of creating
ap0 and running hostapd on it and setting up wpa_supplicant@wlan0 to
run the wlan0 and using wpa_cli is more solid than it has even been. I
can have both interfaces active for a while. I am connected to the RPi
via ap0 from a laptop and wlan0 is connected to my phone as a hotspot
and both interfaces stay up and are functional and pass data, at least
initially. This stability is only apparent with the latest firmware,
though. As long as there is no connection on wlan0 (regardless of
wpa_supplicant scanning), the ap0 connection stays connected.
Firmware: BCM4345/6 wl0: Oct 28 2024 23:27:00 version 7.45.286
(be70ab3 CY) FWID 01-95efe7fa
With the shipping firmware (265), the interface is flaky and ap0 will
go down almost immedaitely after connecting and I am unable to
maintain both at the same time.

With this setup, things work really well and the only strange thing I
am getting is a 'failed scheduled scan' message in the log every ~6
sec.

May 09 08:53:50 pi4 wpa_supplicant[2254218]: wlan0: Failed to initiate
sched scan
May 09 08:53:57 pi4 wpa_supplicant[2254218]: wlan0: Failed to initiate
sched scan
May 09 08:54:03 pi4 wpa_supplicant[2254218]: wlan0: Failed to initiate
sched scan
May 09 08:54:09 pi4 wpa_supplicant[2254218]: wlan0: Failed to initiate
sched scan
May 09 08:54:16 pi4 wpa_supplicant[2254218]: wlan0: Failed to initiate
sched scan
May 09 08:54:22 pi4 wpa_supplicant[2254218]: wlan0: Failed to initiate
sched scan

I have only the wpa_supplicant-wlan0.conf in /etc/wpa_supplicant and
have removed the /etc/network directory (no other configs or scripts).
I use wpa_cli to select and manage ssids.

iwd cannot perform this feat as the ap0 goes down before a connection
can be made (most times). The flakiness appears to be related to iwd
scanning on wlan0

Keith
