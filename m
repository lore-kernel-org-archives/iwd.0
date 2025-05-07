Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99F320FAB4
	for <iwd@lists.linux.dev>; Wed,  7 May 2025 23:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746658988; cv=none; b=ImMtuA0UrcTB3asc4Y3lPfujX86P8yFy0lVaXEmzXfQTSemi8hYA5L8v51kmI/kU4Fos8imOJsWGm8YkYFnWuKzXASMej83kmfCKSy9GRMdWkeXuNi6vrtfGeC7XWOixvr9CuRxHoxh8m/xg8tSKCKmz66r2dWEIckaT2h/7skk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746658988; c=relaxed/simple;
	bh=SK/ed/Wro7cJwCtKG85/3LwNLxH+IXlkHKosjiDjBko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qcVqWPORu10ixvJOfw/VIpgjzlG69N5BUhRXphNbSMWT5ea7kniHH8t/GqrGgUNMJPPXV/XV/aqfX3YmQpW/vQRy/sTfap+cKcuLz2FA/4mTyqLpAhTR9HjQtd7hy0yu1E+TqWlEq4nRjIYLmj/OipyG1My2If+AWg8xh4Inn+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=njKoNhoc; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="njKoNhoc"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b1fd59851baso202459a12.0
        for <iwd@lists.linux.dev>; Wed, 07 May 2025 16:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746658985; x=1747263785; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=flGjvE1atE4ftL/pJx8rYh1U2Kxjyg9P4+1Q84bA+vE=;
        b=njKoNhocZFFgooco/0ZPAeA2fp6JCgQl78A3LZbg8LFE+iqxsMLh/Prjh/XJmh7Dp8
         Al5+uIG+T6c8Eh/+5r0BEZcUEBjosGm/Wf024iF22ALs47JCgD/MPknQKA0NlDyE//H8
         +ceZ/nDVqEbQBaQ3tcpdoMmy+l1N/hC6M4LjK52pAyOp+ZVb1pg0fafux/2eBxWnzOdd
         fELHl3D4o1mw32jd2lYQHj7j5w4Kng6Ig2NZgcJA88TusWXJ6Fui5C9gyH2dh+YDq2kX
         sciEk//KHU2yih6z3MdFFIVy7S8EJsTmXGDN88kWe9qslA8H4Zxcyc1Jrj7DShX07M4v
         AHkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746658985; x=1747263785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=flGjvE1atE4ftL/pJx8rYh1U2Kxjyg9P4+1Q84bA+vE=;
        b=DyDYkudurQ2+6CWnODzroktk/qOHbGgvtuX9D/f1sh01Loef4n9+koZrZi90AZwKox
         CAl4mEs9UEBrRFfyD4c7Eei3mC3BvLCyUqobMhMRQTTi+MJLRTZ5ZtfwzGU3V1tKMWmv
         /pI7MbV9B6XcRmMQTGdIJNA8w+9o+ZYeaJKq/qlLN9HrVK+D8vA9kDj5ckCEDNNagEne
         rkva0iQH3P6swQVoumQXUrX0kSI9mr0YBpQ9OGd/gOhwwJtGit7s3Dwr+Ce5ckHfG1Ak
         jlGklixTCjKi7HgLM+db+t0WawFJk9B3cdEynF0E0bPclqkoF4LdNf28XtEbsda+ZOsx
         3hMA==
X-Forwarded-Encrypted: i=1; AJvYcCWtUkW6CC4CIXHjDS0qDzOovff9WczZqn39o7iqmNSkPf00p9Y48zuTnA5ZEtVuyxhvUEg=@lists.linux.dev
X-Gm-Message-State: AOJu0YyODOnK9s7ohyq49LOoZhwNB3PVmwrVs+8m3ZAnYXDcrp6wXAAG
	BaAwjI01WJs/4+rbdsreFbdvhwdm6+Qu+Wwt8Ms9ZppwcMcHJ+BS/ZwB7SA9nrf++nTtMJ8BBz1
	DluF9X+Li5JE9+44jgVUIANEBlO8=
X-Gm-Gg: ASbGnctJFxXIFiPrFP086dQUgfO5W1nd1+s6rkvBJIsypuir88Dt/JHG1lbNxeMPjHg
	LUoqRNpHslJE5PP2fZz2Db0nvvqtekvLI8NFqGLGGfb6iHc7+sJdn1eWVtAhdgE3/TPTTrnsFzX
	BVa/8RGBylJw4UQRM2WE8yWlW9Nc2+JK0loro=
X-Google-Smtp-Source: AGHT+IG1VcXtTHBbV3988042ii3zlwF/LrmomlbFltMZ6GpqchjTHN8ajb3YgjyEfBYIj5crMAiayc/RwlOEBD9uyFw=
X-Received: by 2002:a17:90b:4b44:b0:30a:3e8e:12cd with SMTP id
 98e67ed59e1d1-30aac21f542mr6393499a91.22.1746658985002; Wed, 07 May 2025
 16:03:05 -0700 (PDT)
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
In-Reply-To: <CAG17S_NCAmDPa+jK=OPdF18H8Yuuio3czytaa2q5hMSJiKO9bw@mail.gmail.com>
From: KeithG <ys3al35l@gmail.com>
Date: Wed, 7 May 2025 18:02:52 -0500
X-Gm-Features: ATxdqUEdNQtahw-v6ExmxG7T7A5CMUlRpXYZTtCAc2QuUObXgTFbj83MNSuarj0
Message-ID: <CAG17S_MbUsp6Nu=idnk0p9sQLRJWg=G8oaE1X2kdjwZ_uH4KAA@mail.gmail.com>
Subject: Re: brcmfmac disconnects when iwd scans
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev, 
	James Prestwood <prestwoj@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 2:44=E2=80=AFPM KeithG <ys3al35l@gmail.com> wrote:
>
> On Wed, May 7, 2025 at 9:27=E2=80=AFAM Arend van Spriel
> <arend.vanspriel@broadcom.com> wrote:
> >
> > On 5/7/2025 3:54 PM, KeithG wrote:
> > > further information...
> > >
> > > I tried this with 2 different pi4s and have been able to confirm
> > > wpa_supplicant/hostapd is stable on the Pi4 (will try others when I
> > > get a chance). I also tried both the 'shipping' brcmfmac43455 firmwar=
e
> > > and the 'latest'. It is only with the 'latest' that I get reliable
> > > connections. With the 'shipping' version, I can get connections for
> > > both wlan0 with wpa_suppolicant and ap0 with hostapd, but the ap0
> > > connection is flaky without any connection on wlan0. And I cannot
> > > sustain both connections at all. This 'latest' firmware is required
> > > for a sustainable, reliable ap0 with connection with hostapd.
> > >
> > > this is the firmware required:
> > > [    3.658201] brcmfmac: brcmf_fw_alloc_request: using
> > > brcm/brcmfmac43455-sdio for chip BCM4345/6
> > > [    3.660643] usbcore: registered new interface driver brcmfmac
> > > [    4.041524] brcmfmac: brcmf_c_process_txcap_blob: no txcap_blob
> > > available (err=3D-2)
> > > [    4.042269] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4345/6
> > > wl0: Oct 28 2024 23:27:00 version 7.45.286 (be70ab3 CY) FWID
> > > 01-95efe7fa
> > >
> > > The only annoyance I get is that the log fills up with failed scan me=
ssages:
> > > May 07 08:43:11 deskrune wpa_supplicant[604]: wlan0: Failed to
> > > initiate sched scan
> >
> > The scheduled scan is basically a scan offload in which user-space tell=
s
> > the driver what to look for and how often (hence scheduled). The
> > advantage of the scheduled scan is that the host (RPi) goes to sleep
> > while the wifi chip is on the lookout for the ssid. No idea why it is
> > failing though.
> >
> > > the Pi still works and is scanning because when a known ssid appears,
> > > it immediately connects, so it is scanning, I just get this message.
> >
> > What I recall from wpa_supplicant behavior is that it does a regular
> > scan for a configured ssid and after a number of attempts it does try t=
o
> > setup a scheduled scan if the driver supports it. When it fails it
> > simply continues with the regular scans. The brcmfmac driver supports
> > scheduled scan so it seems like regression although apart from the log
> > message the end-user is not really affected. I expect it will not make
> > much noticable difference on the energy bill. ;-)
> >
> > > Now that I have this working well with wpa_supplicant and know how to
> > > get it all 'up' and stable, I will start investigating what
> > > differences there are with iwd and why it is flaky. Please guide me a=
s
> > > to the best way to do this.
> >
> > Were you successful using nlmon. I suspect differences should show up
> > between wpa_supplicant and iwd.
> >
> > Regards,
> > Arend
>
> I will use nlmon and see what the difference is. Will post them when I ge=
t them.
>
> Keith

This is an iwmon log showing the hostapd up then a connection from my
laptop then a wpa_supplicant connection to my phone acting as a hot
spot.

https://drive.google.com/file/d/12NhxYT-gF0K2NrBfYEpSvcuGQ6UyejQD/view?usp=
=3Dsharing

This is an iwmon log showing the same activities, but with iwd
managing the ap. The laptop connecting, then connecting to the phone
as a hot spot. Both disconnected. and passed no data.

https://drive.google.com/file/d/1diSp32FXpHjLzQeC5gF-tlNNHji8a1l5/view?usp=
=3Dsharing

I do not know how to read these, but hopefully they will provide some guida=
nce.

Keith
