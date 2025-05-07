Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1099D28E5F5
	for <iwd@lists.linux.dev>; Wed,  7 May 2025 19:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746647096; cv=none; b=meArPfWmqcpPsN3OgcTDr2WKXp7cPKvDGyJit9CtUV891+WI6x4Qa9xAWmYjxt9XMYrqMdsJgSV+BY0zOguLE1Gvu95tZtQRQuPGvDYR9WsCKt9J57AbqVdwaIOpiGizkNdXjoeDbh++f56mSvcWJOJ109Ej0xC1DlrdtNnSTuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746647096; c=relaxed/simple;
	bh=6rgf0Xn0ralCHYPFURjUuBL/qPSJOuep8GwINlAC+w4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mLgDVtvCfbwQyBAm26HkA9YdZs3lcb/A3SePXtU0fOWs9OQvNAqSNAZrmybhu+V6dKzcdoa7bHqn4a7NDUkpYb5UW4DHtBEyzSNa3MZuJFupwMA78mPWnYuAuNsibogsMStm9Crf//Pp/R0CVbGg40L3bczOQbbk9BDRuuBPars=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NwMGw9Uz; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwMGw9Uz"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22c33677183so2954485ad.2
        for <iwd@lists.linux.dev>; Wed, 07 May 2025 12:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746647094; x=1747251894; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dOPoEF80avTCyWNNUoE4Oyw89v2Ein/1CTwIOK7mRbA=;
        b=NwMGw9UzgPMFYOpGHLa+QfVKR88iygfEeiXbMwkfyYjR8qOuj9XI4QZhwkXuHXRv5o
         tasPPD4gUHMRmBRfStx1A8j7Gehic2nuyI7r3zmxOKn6Dpxo12WQFKjVPQw0Dy1udMJv
         p4qIMqUgXUoZXmNjEcwk/r3Qgd/TUluUQApLxMp3i8ujD0DWT9hSR/R7FsUIFpqdUS/d
         L6PI7+WkfQz1eRsgnb4aFcGa3ebIFhPpwqtEDlxDx1HHBmX3p0cmzDSgbEz0wiNbufYG
         rz2lGk672y6EveSabZkTpiXFYm2RHCJ7RIZ8srg7XZw1XzT6aiwFqMpaMwIVEG1x9uwb
         wsgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746647094; x=1747251894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dOPoEF80avTCyWNNUoE4Oyw89v2Ein/1CTwIOK7mRbA=;
        b=KqSPkeUxlEzg5TKWg/XHBXkbN0uLVl1IScLq5h0CjnOxtooYA1aHSHUSmhHnOgbK3k
         B7F2di+KqT3nLYxKFHpuWVq6Q7x0rRdE3KcOupf2jwCV9XPMw5U5VUheQ/ufgxo6AKW2
         6XHY8r84BITxVkSN6HA+Im68oa8YSAbIJMcA20vFuSKJBxbyHIIIVHYiqzzJImNH/xVL
         ySbpsF7k9LRCy1iyT2wzF+lxfje+fVhIZxwTkbBOhkK0829kx8A7q2xgsZde+cEwD96X
         8Hxl4K6ERjzRBZSMquec0+T7vyyAF+uPbhFmfYttmM2h+yDb2Fmtf8XSk9JpAtM6ZY+V
         Hgzw==
X-Forwarded-Encrypted: i=1; AJvYcCXcsfVCJGez4cxbqlBsytRdO2wQF30xXpFx+Dw7rjh8w5erx4sovYroAR3qUmNIIqKkuxg=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw037rWsA4jEZQiPJ2PcyQ/5SLQU/eUPULiDjISsBY+sp13odov
	tEFJNVz452jQGf/xji0Wr9PVptRjvhARxcAHD3p8wYwKqHU0vFgOpmEzpCEo9zrHq/OjGUWQAEn
	2lQnOCpes+n/M86PrkBEKjueolLo=
X-Gm-Gg: ASbGncu43I/LX3+lp5TzJtAcdb10t0OpNB9p8weu04Scl4LLdf+3khwZrKtIxsAMGtk
	A7zC0Fr/k41aSL/LY/Lg7tKgz4KnztZmOUpK7cK1kILaDoT7qwnAbCb9nLSLJGYJaYgJXE5RK1c
	dP/6JzVBYoGgKKXj1769aUN2LYmif21NZfob4=
X-Google-Smtp-Source: AGHT+IEFkbNmLe4oSFWJ8zExuS0w04aBHZ1rtf2wvKG4dNboEpeAS/UkxUMyrVadaIglYYGyqAZug1/y6ue5KmBpaIo=
X-Received: by 2002:a17:90b:1e4b:b0:304:ec28:4437 with SMTP id
 98e67ed59e1d1-30aac2a104amr6144011a91.22.1746647094156; Wed, 07 May 2025
 12:44:54 -0700 (PDT)
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
 <CAG17S_Njkt7rFTk4Tn-KnLVS8kzA61KJGyWgNQ9kqx5M=s7DnA@mail.gmail.com> <38be0ddf-50ff-4ef9-bd98-748ffcfed2e1@broadcom.com>
In-Reply-To: <38be0ddf-50ff-4ef9-bd98-748ffcfed2e1@broadcom.com>
From: KeithG <ys3al35l@gmail.com>
Date: Wed, 7 May 2025 14:44:43 -0500
X-Gm-Features: ATxdqUEHkr3uMC6SJ7njvLaLeRD1DkNNSmPw8hMz1DDLB7VH4kwld7ij3-ooP50
Message-ID: <CAG17S_NCAmDPa+jK=OPdF18H8Yuuio3czytaa2q5hMSJiKO9bw@mail.gmail.com>
Subject: Re: brcmfmac disconnects when iwd scans
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev, 
	James Prestwood <prestwoj@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 9:27=E2=80=AFAM Arend van Spriel
<arend.vanspriel@broadcom.com> wrote:
>
> On 5/7/2025 3:54 PM, KeithG wrote:
> > further information...
> >
> > I tried this with 2 different pi4s and have been able to confirm
> > wpa_supplicant/hostapd is stable on the Pi4 (will try others when I
> > get a chance). I also tried both the 'shipping' brcmfmac43455 firmware
> > and the 'latest'. It is only with the 'latest' that I get reliable
> > connections. With the 'shipping' version, I can get connections for
> > both wlan0 with wpa_suppolicant and ap0 with hostapd, but the ap0
> > connection is flaky without any connection on wlan0. And I cannot
> > sustain both connections at all. This 'latest' firmware is required
> > for a sustainable, reliable ap0 with connection with hostapd.
> >
> > this is the firmware required:
> > [    3.658201] brcmfmac: brcmf_fw_alloc_request: using
> > brcm/brcmfmac43455-sdio for chip BCM4345/6
> > [    3.660643] usbcore: registered new interface driver brcmfmac
> > [    4.041524] brcmfmac: brcmf_c_process_txcap_blob: no txcap_blob
> > available (err=3D-2)
> > [    4.042269] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4345/6
> > wl0: Oct 28 2024 23:27:00 version 7.45.286 (be70ab3 CY) FWID
> > 01-95efe7fa
> >
> > The only annoyance I get is that the log fills up with failed scan mess=
ages:
> > May 07 08:43:11 deskrune wpa_supplicant[604]: wlan0: Failed to
> > initiate sched scan
>
> The scheduled scan is basically a scan offload in which user-space tells
> the driver what to look for and how often (hence scheduled). The
> advantage of the scheduled scan is that the host (RPi) goes to sleep
> while the wifi chip is on the lookout for the ssid. No idea why it is
> failing though.
>
> > the Pi still works and is scanning because when a known ssid appears,
> > it immediately connects, so it is scanning, I just get this message.
>
> What I recall from wpa_supplicant behavior is that it does a regular
> scan for a configured ssid and after a number of attempts it does try to
> setup a scheduled scan if the driver supports it. When it fails it
> simply continues with the regular scans. The brcmfmac driver supports
> scheduled scan so it seems like regression although apart from the log
> message the end-user is not really affected. I expect it will not make
> much noticable difference on the energy bill. ;-)
>
> > Now that I have this working well with wpa_supplicant and know how to
> > get it all 'up' and stable, I will start investigating what
> > differences there are with iwd and why it is flaky. Please guide me as
> > to the best way to do this.
>
> Were you successful using nlmon. I suspect differences should show up
> between wpa_supplicant and iwd.
>
> Regards,
> Arend

I will use nlmon and see what the difference is. Will post them when I get =
them.

Keith
