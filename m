Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830B31C5497
	for <iwd@lists.linux.dev>; Wed, 11 Dec 2024 23:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733958005; cv=none; b=HVJeJxsNtghp3y7LgGotUM80WrZx5bC+CrPRxtIkUJiDZ/3ie7ud+XcpOnKv5omsGCum+oFP5J39vQeMgxm5ufvslWIV5R6XMe5e8PxTiDyxW6bdE3oHI15HEn1u8iLezISlDLHsLlCSJ01O2qV13CdORZoxZTOYvkkAKiM/OQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733958005; c=relaxed/simple;
	bh=9LjcITyy0UqQ7dTNWEk4yk2lXnMHcLOylHzdeuwFm+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KsrL2sgXykWiTQmnJllAzKtqduRr74/rGgIVkhK9tKWdlrFHpXS5FYVz3/igBwFMwqaJnhS3cAou9mSQo7To5ExTWr+UO6uPx2KE0+DgmsYE7ZNdgTSHFHPVKyZmwGh2xqgKu6DGzlgLPxHpuIJwG5Pb1fLkF0CFLwWFKC9iLtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shapertools.com; spf=pass smtp.mailfrom=shapertools.com; dkim=pass (2048-bit key) header.d=shapertools.com header.i=@shapertools.com header.b=UHxcSuUY; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shapertools.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shapertools.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shapertools.com header.i=@shapertools.com header.b="UHxcSuUY"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5401bd6cdb4so4317069e87.2
        for <iwd@lists.linux.dev>; Wed, 11 Dec 2024 15:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shapertools.com; s=google; t=1733958001; x=1734562801; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+R1DYEng8TJj9ipFvDT2+YjVe3e+6lPbS+FhnhFjn7U=;
        b=UHxcSuUYwYXKBoTuU8lkxl25XvpeSkHRoHI+aXEjugoMEizYpMrt9zaPeQeUgS1K9N
         J5He7syfYg0YCEZpEaY7NG1pFC3w60wcHkkifLqps/vKbVADssoc/tigotyyrqZQ5cF4
         jyfACmLAPa/2IHndV2BZoULGA38d5jmuHnncWu7/F8RRPGIeYlZBr/n2sT24PT8GBpvi
         1w3Q+LCfZs1THa3244O0Qw0FtMmH3hKO/8QOAch0VvKJMKvN3oVBRsLpaYBAAx5Qk3Zd
         g4DnJcIKKTNOYavgOp71dVCeIZyU+J4UGHV9XP67DVQWrXr1xc5JYD1MMr14ZlITH9NB
         EKtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733958001; x=1734562801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+R1DYEng8TJj9ipFvDT2+YjVe3e+6lPbS+FhnhFjn7U=;
        b=QsfkALS+U0rLEIycDSDaO28n7rBD6LbVom2zkI4Z4+aGFmrhWiAzNdaLBuoJG2dc4w
         MWZdUnWA+KmBr93psenA8OcAO0naM2iQGQGtwn+rNa4KgtlN1ZYJZE7/VCYSxq0KMNgj
         E/1GKH2gIirqEe1NIrI0ZVWFoJap7+Giuj/ugxO2yFmeuouepKLwF4bWK+15Rv9THygK
         cd6V1aiwqpsB0dg44asDMZYFyNJJ0FocyosLtucMzYJeyFkKyrsB000uqX0JYCTNESEx
         5bXFfe0vvQrLrPuhAUc2m4m0muh5wr1O6+uaRZzPSIoB33/WOezCWuq4ktdueazEr87C
         38Lw==
X-Forwarded-Encrypted: i=1; AJvYcCVmF1831NGRHn7FnhlEtWYjT+p+syAKUVBEoxU6zJ9tGX7hKDJoKBpmBzRg7dt10YSCC58=@lists.linux.dev
X-Gm-Message-State: AOJu0YyW8UBHCIt1OBQDFswjLYU1VBfJwAClsOs6MdOphHW/urpHkOLC
	Np1LjERJZgujxmvk8Hp1MKTW1uPuRaFHlm51LREdvhkbnq0lfvieoZzYB4fIGKzOHgmVYO5cqG1
	n/sWtGQBxZHIEpVsRNr/9hqjdafHqMEptzAsaEA==
X-Gm-Gg: ASbGncsn0i6BlbYQe3baXsb1GYuXS3j0KvgETGTWuqwWbakH59v09P1Hf+0tIRjhHbz
	1TQL4Qsfy9nFm/Oe5UzPIvlVmmFcUnY5Y5elC
X-Google-Smtp-Source: AGHT+IENvS0Q8P32dvfPRAM0PUr4XjfNjibEaCinGDHealV6T9qU6vtJkHk9GdH5JJS9+Xk/w5qTRHk19oVvSR+yWEw=
X-Received: by 2002:a05:6512:108f:b0:53e:24fa:ce2 with SMTP id
 2adb3069b0e04-5402a6020f1mr1394157e87.38.1733958001535; Wed, 11 Dec 2024
 15:00:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240823174220.498594-1-denkenz@gmail.com> <20240921185902.170612-1-yshuiv7@gmail.com>
 <ba78a253-de77-4427-85c3-d876ef9fdd8a@gmail.com> <1921859cb98.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CAG17S_PAm0NsA+oRho5Qt-Y8MowB4nkeOnugzaE==pWLSpGYpg@mail.gmail.com>
 <1921a891f18.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CAG17S_O1njCdiFaWUSh8N11DhiRBKhvnigCpLiNfkCp+JwuGJA@mail.gmail.com> <CAG17S_MVSrnyz_ctW8CU1HMvkzcU2ZYOzpTjKXzXESaSmzeEAw@mail.gmail.com>
In-Reply-To: <CAG17S_MVSrnyz_ctW8CU1HMvkzcU2ZYOzpTjKXzXESaSmzeEAw@mail.gmail.com>
From: Jeremy Blum <jeremy@shapertools.com>
Date: Wed, 11 Dec 2024 14:59:44 -0800
Message-ID: <CAE+F7TFpuoVEbY9eZzo=0d50bnjzstsypdoWeF0g8H7wP=o8=w@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/2] External Auth support
To: KeithG <ys3al35l@gmail.com>
Cc: Arend Van Spriel <arend.vanspriel@broadcom.com>, Denis Kenzior <denkenz@gmail.com>, 
	Yuxuan Shui <yshuiv7@gmail.com>, iwd@lists.linux.dev, prestwoj@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Infineon has just released updated firmware for the 43455 chipset, and
and updated brcmfmac driver. May be relevant to this conversation
about getting IWD supporting WPA3 with the brcmfmac SAE offload
implementation.
https://community.infineon.com/t5/AIROC-Wi-Fi-and-Wi-Fi-Bluetooth/Cypress-L=
inux-WiFi-Driver-Release-FMAC-2024-11-21/td-p/902888


On Thu, Oct 10, 2024 at 8:38=E2=80=AFAM KeithG <ys3al35l@gmail.com> wrote:
>
> Arend,
>
> Is there anything I can help with on this effort to get External Auth
> working on a kernel that more of us are using? RPiOS is currently at
> 6.6.51.
>
> Keith
>
> On Sun, Sep 22, 2024 at 11:29=E2=80=AFAM KeithG <ys3al35l@gmail.com> wrot=
e:
> >
> > On Sun, Sep 22, 2024 at 11:20=E2=80=AFAM Arend Van Spriel
> > <arend.vanspriel@broadcom.com> wrote:
> > >
> > > On September 22, 2024 5:36:53 PM KeithG <ys3al35l@gmail.com> wrote:
> > >
> > > > On Sun, Sep 22, 2024 at 1:09=E2=80=AFAM Arend Van Spriel
> > > > <arend.vanspriel@broadcom.com> wrote:
> > > >>
> > > >> On September 22, 2024 5:35:03 AM Denis Kenzior <denkenz@gmail.com>=
 wrote:
> > > >>
> > > >>> Hi Yuxuan Shui,
> > > >>>
> > > >>>>
> > > >>>> I tested this on an RPi5 too, and indeed I am having the same pr=
oblem as KeithG
> > > >>>> as well. However I managed to get some debug information from br=
cmfmac when
> > > >>>> running wpa_supplicant. Interestingly wpa_supplicant gets the sa=
me -52 error as
> > > >>>> well, which it reports as an authentication timeout. But if I as=
k it to try
> > > >>>> again, it will connect successfully, and there is no external au=
th related log
> > > >>>> the second time around.
> > > >>>
> > > >>> Yep.  It looks like wpa_s puts the resulting PMKSA into the kerne=
l cache even
> > > >>> though the initial connection using external auth fails.  I've on=
ly seen
> > > >>> 2.10 do
> > > >>> this, not 2.11.  Either way, it is a bug / lucky coincidence.
> > > >>>
> > > >>>>
> > > >>>> So I suspect this is a firmware bug, but it should be relatively=
 easy to
> > > >>>> workaround I think? Basically we also add a timeout and retry.
> > > >>>
> > > >>> It would be far nicer if the brcmfmac firmware + driver combinati=
on worked
> > > >>> properly :)
> > > >>
> > > >> Indeed it would. So what's in the mix? What kernel is used? Upstre=
am or RPi
> > > >> kernel? What firmware capabilities are listed in debugfs?
> > > >>
> > > >> Recently I submitted patches upstream to add external auth support=
. As I
> > > >> ported downstream patch the results you see do not make me optimis=
tic that
> > > >> my patch is ready. Maybe you could help testing it?
> > > >>
> > > >> https://patchwork.kernel.org/project/linux-wireless/list/?series=
=3D891248&state=3D*
> > > >>
> > > >> Regards,
> > > >> Arend
> > > > Arend,
> > > >
> > > > I tried to apply the patch set to kernel 6.6.44-v8 and was unable t=
o patch it:
> > > >
> > > > $ patch -p1 <
> > > > RFT-v2-1-3-wifi-brcmfmac-support-per-vendor-cfg80211-callbacks-and-=
firmware-events.patch
> > > > patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg8=
0211.c
> > > > Hunk #1 FAILED at 6752.
> > > > 1 out of 1 hunk FAILED -- saving rejects to file
> > > > drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c.rej
> > > > patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/comm=
on.c
> > > > Hunk #1 succeeded at 524 (offset 33 lines).
> > > > patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/core=
.c
> > > > Hunk #1 FAILED at 1359.
> > > > 1 out of 1 hunk FAILED -- saving rejects to file
> > > > drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c.rej
> > > > patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh=
.c
> > > > Hunk #1 succeeded at 74 (offset -1 lines).
> > > > Hunk #2 succeeded at 336 (offset -70 lines).
> > > > patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvi=
d.h
> > > > Hunk #1 FAILED at 15.
> > > > Hunk #2 succeeded at 47 with fuzz 1 (offset -9 lines).
> > > > 1 out of 2 hunks FAILED -- saving rejects to file
> > > > drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.h.rej
> > > >
> > > > I did not try the other patches as this attempt failed. Do I need t=
o
> > > > use a newer kernel? The latest kernel from RPiOS is 6.6.47.
> > >
> > > I did major rework to support multiple vendors with differing firmwar=
e
> > > APIs. So I can imagine you would need other patches that were submitt=
ed
> > > earlier. Easiest would be to use the backports project which allows r=
unning
> > > latest driver like wireless-next on older kernels.
> > >
> > > I can try. Do you have a URL of the RPiOS kernel repo?
> > >
> > > Regards,
> > > Arend
> > > > Keith
> > >
> > >
> >
> > Arend,
> > It is either here as a git clone:
> > git clone --depth=3D1 https://github.com/raspberrypi/linux
> >
> > or here as a gzip:
> > https://github.com/raspberrypi/linux/archive/refs/tags/stable_20240529.=
tar.gz
> >
> > Keith
>


--=20
Jeremy Blum   |   jeremy@shapertools.com   |   +1 (914) 522-0416
