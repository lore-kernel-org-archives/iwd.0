Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE42625D55B
	for <iwd@lists.linux.dev>; Fri,  2 May 2025 16:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746202237; cv=none; b=s8gr1R8if7T1vjjOsgMnrHzNx4+145piq9RIkj3Jx5uHgHr/dRdu3o1C4dhwZFxc1nkZohHSE9NyjaM8x6F2A3qiZIJP2HVs9u5xJTVbfdgTaSHRcZ2lh/4X9l750mEfTc01Tt2z4ELJSq6Zu1HhOh+orol2PLebZ2bKmA00JME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746202237; c=relaxed/simple;
	bh=s4Hs15+VwGGCeSKaeRROkCQYYhYv2ml8ZypXTBxrrZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H1gzpjD+sWZdghEJOVUNXOMhQRi4ygWGUk0N1uGVWoeSGCHjIKbiU0xBaksRsJcG9ruzJUXBtN9fFCFefgzTs5nJPz4nQuMerU1m60pS0tnMhfNt3j5IV76QsLjbykeIO4XsNx19Y1P9y+B/KkK3SeSLwNVzdl6VIv+HTeAN3yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lYnSni61; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYnSni61"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-306b6ae4fb3so2508939a91.1
        for <iwd@lists.linux.dev>; Fri, 02 May 2025 09:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746202235; x=1746807035; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/wk1Q6y7461R6EWbXGki9a7feZ6NL4S7zUmkI1GdJs=;
        b=lYnSni617b9w06/vNOwP5SQsiAhZs7anMDx514AuzNkMMfRdoD+hvJ1U9opQ1WlyrF
         dbBQdxKV0AIwJA3Y8NDld7a2JWLHgpiUIIhNXL41qCfoopywFw0QxZnIbKGVug+0IMlj
         Y0Gj/2Vr3aT9wpNJ9KtOMfIovQDssvEiIACIO6Is2+cO+u1fCAskcdlnH24AunF9hVZi
         H7kh+TjyKfAXF1dvcfUHa68ANoOEQ05MQhaMST+QTZbeHIMg6d24bL/b8eb1JHV6pPGv
         9cW/JtvtyzlMrEZjVOE6u91fbAVYindDyWammjsukTVE/Jrt4UPTbqv/24huf8JxAt+h
         q1Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746202235; x=1746807035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f/wk1Q6y7461R6EWbXGki9a7feZ6NL4S7zUmkI1GdJs=;
        b=ooJuQ2un0kGtfeyPKvRPuueTsAX+tXy5P6OoOoHUTyeknGAnD0QMU+ZdIQH2uu+n4C
         ZeA8EKR3mpLTTvHYwkhoVYwfZgD4FW4YJY1tF8M/GybmohEHvZozi2EP0294j5L6d2g/
         VZwCBJYRKjD8QAqcYxOalZ7wKbc5h2LEq00OB267tLh8I9pHKMqPGNc5otx62IkvYPsU
         NByAvXHD7/CYda3bWmA2NkDBjLdKZ3wdwwoacZ1OjB8YjIEj+XOU0SOzBgr58medK55q
         vXq/36ZwYGSsIbhwVyIK9XSLHFKM81O6bjXpiCCSEhDZqV3mRXCYOxbPNoUBTMZFS6Ix
         1lHA==
X-Gm-Message-State: AOJu0YxeLxJjtckWME5Y+ZWDafxFo93Y9QMO9t4Mt4GHOK7FHDAIYo2H
	Ot0dLNILqq5XhICCsHKtbrEQMgoLC/6lZtcxhRSfEmq6FUisaoWXAJn07Vgm9EWoYvsJynMMk5B
	VEj7szetROr+118t8v5MZAJ2SPnJJmQ==
X-Gm-Gg: ASbGncsteFJ4IGYs0SQhpaIOtVWWp9g99BykeLCSF5wgzjn/VsHGEWiGPhJSXQT9FF4
	7nUwLzM6a7QYGI5Tn8BwaBcLZT+/T64xb1ygrKXBNXXpS+PWdY9ByTOy6hG4vEW1loO8riduJ2L
	4E0UlrimnjOBIQGK5yGsUj4pMr
X-Google-Smtp-Source: AGHT+IEepxq1zIVrREU4l36n9yAu07jddtZ8vjZJ7e49km1M4ZCbuHaUGsekboxZHnhpLqihwPvqTnjTwXMRdRSx4p4=
X-Received: by 2002:a17:90b:384b:b0:2f5:88bb:12f with SMTP id
 98e67ed59e1d1-30a4e5ccd19mr4848508a91.21.1746202234787; Fri, 02 May 2025
 09:10:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAG17S_M4_+CR1uSsajyvHBjig6cfCuxegipnHREhk1sXjSyOsA@mail.gmail.com>
 <a0dcf03d-3bd3-43e5-9532-5a565d20930f@gmail.com> <CAG17S_MKZXf3vC0zgaK_MUrA1nqRzhGcPGUho873KU3jYVShXw@mail.gmail.com>
 <45bc2f1b-b037-4784-a2a9-7732a82b7391@gmail.com>
In-Reply-To: <45bc2f1b-b037-4784-a2a9-7732a82b7391@gmail.com>
From: KeithG <ys3al35l@gmail.com>
Date: Fri, 2 May 2025 11:10:23 -0500
X-Gm-Features: ATxdqUHDh8GGfGlGiDBYOgHkOpQ8NWMpUS_iKLHmSRnltMSICcRF5JOF-xVLF34
Message-ID: <CAG17S_MqLBQV6ktjbWsoAv0e+2A0dnNN5+X7Pf+b-qDP3mrL1Q@mail.gmail.com>
Subject: Re: brcmfmac disconnects when iwd scans
To: Denis Kenzior <denkenz@gmail.com>
Cc: iwd@lists.linux.dev, James Prestwood <prestwoj@gmail.com>, 
	Arend Van Spriel <arend.vanspriel@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 2, 2025 at 9:45=E2=80=AFAM Denis Kenzior <denkenz@gmail.com> wr=
ote:
>
> Hi Keith,
>
>  > I am building iwd from git with those 3 patches and every time it
> > scans, it disconnects the AP.
> > When I use wpa_supplicant, it does not disconnect regardless of using:
> > iw wlan0 scan passive
> > or
> > iw wlan0 scan
> >
> > it is only with iwd that it disconnects and only with iwctl. If I run
> > 'iw wlan0 scan passive' or
> > 'iw wlan0 scan' when iwd is running and wpa_aupplicant is removed, It
> > seems to be OK.
> > My laptop shows a disconnect, sometimes, but when I check the wlan0 on
> > the laptop
> > it is still connected to the ap running on the RPi. I think it looses
> > the connection for a
> > second but reconnects. If I run the 'iwctl station wlan0 scan' it will
> > disconnect and not reconnect.
> > When it does, the ap0 gets to a strange state as it takes a number of
> > attempts to get it to
> > reconnect and sometimes it requires a tear down and restart of ap0
> > before I can reconnect
> >
> > This is an iwmon log of my RPi.
> > https://drive.google.com/file/d/1WNZz0dOip0XZZVIOs7RGcYIeLY2W4bXC/view?=
usp=3Dsharing
> > I had connected to it from my laptop. I then ran:
> >
> > # iw wlan0 scan
> > # iw wlan0 scan passive
> > # iwctl station wlan0 scan
> >
> > after I ran the last command, the Pi's ap0 disconnected from my laptop.
>
> I do indeed see the local AP interface generating 'Del Station' events, w=
hich
> means the local client was disconnected.  The funny part is that iwd ends=
 up
> scanning a subset of the frequencies triggered via 'iw', it just does it =
in two
> sets.
>
> Here's what I see iw doing:
>
> < Request: Trigger Scan (0x21) len 16 [ack]                           22.=
190542
>      Interface Index: 3 (0x00000003)
>      Scan Flags: Mask: 0x00004000 len 4
>              Colocated6G
>  > Event: Trigger Scan (0x21) len 364                                  22=
.194336
>      Wiphy: 0 (0x00000000)
>      Interface Index: 3 (0x00000003)
>      Wireless Device: 1 (0x0000000000000001)
>      Scan SSIDs: len 0
>      Scan Frequencies: len 320
>          0: 2412 (0x0000096c)
>          1: 2417 (0x00000971)
>          2: 2422 (0x00000976)
>          3: 2427 (0x0000097b)
>          4: 2432 (0x00000980)
>          5: 2437 (0x00000985)
>          6: 2442 (0x0000098a)
>          7: 2447 (0x0000098f)
>          8: 2452 (0x00000994)
>          9: 2457 (0x00000999)
>          10: 2462 (0x0000099e)
>          11: 5170 (0x00001432)
>          12: 5180 (0x0000143c)
>          13: 5190 (0x00001446)
>          14: 5200 (0x00001450)
>          15: 5210 (0x0000145a)
>          16: 5220 (0x00001464)
>          17: 5230 (0x0000146e)
>          18: 5240 (0x00001478)
>          19: 5260 (0x0000148c)
>          20: 5280 (0x000014a0)
>          21: 5300 (0x000014b4)
>          22: 5320 (0x000014c8)
>          23: 5500 (0x0000157c)
>          24: 5520 (0x00001590)
>          25: 5540 (0x000015a4)
>          26: 5560 (0x000015b8)
>          27: 5580 (0x000015cc)
>          28: 5600 (0x000015e0)
>          29: 5620 (0x000015f4)
>          30: 5640 (0x00001608)
>          31: 5660 (0x0000161c)
>          32: 5680 (0x00001630)
>          33: 5700 (0x00001644)
>          34: 5720 (0x00001658)
>          35: 5745 (0x00001671)
>          36: 5765 (0x00001685)
>          37: 5785 (0x00001699)
>          38: 5805 (0x000016ad)
>          39: 5825 (0x000016c1)
>      Scan Flags: Mask: 0x00004000 len 4
>              Colocated6G
>
> While iwd does:
> < Request: Trigger Scan (0x21) len 64 [ack]                           31.=
619536
>      Wireless Device: 1 (0x0000000000000001)
>      Information Elements: len 12
>          Extended Capabilities: len 10
>              Capability: bit 19: BSS transition
>              00 00 08 00 00 00 00 00 00 01                    ..........
>      Scan Frequencies: len 24
>          0: 2412 (0x0000096c)
>          1: 2437 (0x00000985)
>          2: 2462 (0x0000099e)
>      Scan Flags: Mask: 0x00004002 len 4
>              Flush
>              Colocated6G
>
> then
> < Request: Trigger Scan (0x21) len 248 [ack]                          32.=
040780
>      Wireless Device: 1 (0x0000000000000001)
>      Information Elements: len 12
>          Extended Capabilities: len 10
>              Capability: bit 19: BSS transition
>              00 00 08 00 00 00 00 00 00 01                    ..........
>      Scan Frequencies: len 208
>          0: 5180 (0x0000143c)
>          1: 5200 (0x00001450)
>          2: 5210 (0x0000145a)
>          3: 5220 (0x00001464)
>          4: 5240 (0x00001478)
>          5: 5260 (0x0000148c)
>          6: 5280 (0x000014a0)
>          7: 5300 (0x000014b4)
>          8: 5320 (0x000014c8)
>          9: 5500 (0x0000157c)
>          10: 5520 (0x00001590)
>          11: 5540 (0x000015a4)
>          12: 5560 (0x000015b8)
>          13: 5580 (0x000015cc)
>          14: 5600 (0x000015e0)
>          15: 5620 (0x000015f4)
>          16: 5640 (0x00001608)
>          17: 5660 (0x0000161c)
>          18: 5680 (0x00001630)
>          19: 5700 (0x00001644)
>          20: 5720 (0x00001658)
>          21: 5745 (0x00001671)
>          22: 5765 (0x00001685)
>          23: 5785 (0x00001699)
>          24: 5805 (0x000016ad)
>          25: 5825 (0x000016c1)
>      Scan Flags: Mask: 0x00004002 len 4
>              Flush
>              Colocated6G
>
> And about 1.5 seconds later the Del Station event comes in.
>  > Event: Del Station (0x14) len 32                                    33=
.560662
>      Interface Index: 7 (0x00000007)
>      MAC Address 50:84:92:A6:7A:7A
>      Generation: 0 (0x00000000)
>      Station Info: len 0
>
> Not really sure what could be causing this.  Maybe this is a question for=
 Arend?
>
> Regards,
> -Denis

Denis,

Thanks for going through this. I am still trying to get more pertinent
information as to what may cause these disconnects. If there is
anything I can test or more info I can provide, let me know. As it is,
I am trying to set up hostapd/wpa_supplicant to see if it is any more
stable.

Keith
