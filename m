Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AA542AA6
	for <iwd@lists.linux.dev>; Thu, 12 Dec 2024 14:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734014026; cv=none; b=kb3pb/ikfesEi+x+XOohz9504/qmKnIR1KLGUhhRrjt3D10ioQebIbul5JQ6YYRSWD+FleUIb90KRbDBdH7DGTFVTQzM1FQuFgo1NTRRwk6H7jCWFuHWuTIR1nyI5Bjt2P/M/hsgs1SLDDTR68g1LD2QLNVabKULpeYsxQptYH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734014026; c=relaxed/simple;
	bh=VFmc8+q3KajFKgMA7WSssgdtAzz/QyZ8jNm3ALQPGQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ipWwPVxs+USK8UhuI8pkBZCg3qeW/mSOJBme8R1qi09nFnNolQw6tJA6s5a+AVuDEAKzsXVvRyNjCoT/RPhERTEd/393FcKNA3sS0gZMQAjmUYLwvDIRkeP8fjQtM+/KNr2GUsBJKqzZsY6nAm5VDwpavrA1PwviolZoIyAp8VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MnzysBVe; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MnzysBVe"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-728f1525565so787175b3a.1
        for <iwd@lists.linux.dev>; Thu, 12 Dec 2024 06:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734014024; x=1734618824; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BBrLvr6HjGJp1yu9lITtpnsyc7AP2jr7FHUKP3kY8YQ=;
        b=MnzysBVe8kLn6hAOBBavMRG7JjKZioeZbXSBUqdlOSwBd51LSKfHPCUOupZXeJbXVB
         m2pWEeihcaUe1Jzy/YvHy7Y0t7ZlbbX+eiumxHy9rAWB/wIf5DRu7TQsfUTw4NZfH9mA
         8p6YD/sjFXWj6ljGci2b5tJ/Tpa6CtdTZv8GSgYg3dPWsfjfw7OmuFOrgiIAuogS8EUD
         k9ozSC1PnxeLAfUX+G3xblkkkMN+bsoBFwSbI46P1yHdAIf7XxaNSIBd6n7KGi6uDzjW
         7OWzirhk9HN/qiNfEiJyUbIxHcpgdqLT686ip514z/B8NdOev/vlG/cQgJzHlNdUX3PX
         ymDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734014024; x=1734618824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BBrLvr6HjGJp1yu9lITtpnsyc7AP2jr7FHUKP3kY8YQ=;
        b=nA5erIaLedke/xHYRaReOi3nJPZorI3wdqeRbGeyF/RiFV3hyLT33SVrxTsSTW8Abq
         EYS9ZVtZy0Q8DKj8ArlZaP5zJJzFxQL4nm6YOVR6AfR69NLbdiYLZlHwuPTHt6gOufEQ
         WeQ+upptOc8BionuHlkuG/b3bYC2RWEFn2Je6BPmblqedTejYrfoqm8bMe/wCXhSMM5k
         cPoS7QSVc7qdauLcftRDQoy+SiWbZ1efRfLckGX4ece6xtwq6h+Sx9jAYZoGpmP+VgRg
         rZ7gp+OFvZme8xP+3GpkvIRfxqdfBaJJ1o/JjJP9RIF+qEdR77/ykXVF1rP76D2aq71E
         46Sg==
X-Forwarded-Encrypted: i=1; AJvYcCWeGSBcUaZ3kLLeli7U8vFNPYmNpk0X8XiKgmrar5B+lwQyGVFlxyHAAdKgBNOlUAUSCYM=@lists.linux.dev
X-Gm-Message-State: AOJu0YwlgyZ4nZBQ0uEOHyGtJqr8nflepudYQakqo8HYZJY0IGsnRhwB
	IcNKUrcSBIIhg1d7uloR0Mkqr/WI5/mZcHqShiHfTcIBvvxmlwc96ETFzPwu6KMfq/Jf4lIeVbK
	FtaMEOsgk7SSIQmxzuREvIR4o1a4=
X-Gm-Gg: ASbGncsx/FzkU87iCUVqngi68yvzE1XgR/X/SWHo7PHdbgkVKuYfYSJOyZP0gqX/Y4N
	tWLFxmDRzpILDPuO9CYVcv1BCpGc14yPm3X+ZE+gW
X-Google-Smtp-Source: AGHT+IEGyOfDwaeaPcpHLyQfqqLRNdKbkFq6oaFmpugL4yAgyc8NGVu2Nj7UtCSLRptDqyUG8HK7XdV0lxuliAGqeCU=
X-Received: by 2002:a05:6a00:1887:b0:726:c23f:4e5c with SMTP id
 d2e1a72fcca58-72906940b73mr768871b3a.1.1734014024105; Thu, 12 Dec 2024
 06:33:44 -0800 (PST)
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
 <CAG17S_O1njCdiFaWUSh8N11DhiRBKhvnigCpLiNfkCp+JwuGJA@mail.gmail.com>
 <CAG17S_MVSrnyz_ctW8CU1HMvkzcU2ZYOzpTjKXzXESaSmzeEAw@mail.gmail.com> <CAE+F7TFpuoVEbY9eZzo=0d50bnjzstsypdoWeF0g8H7wP=o8=w@mail.gmail.com>
In-Reply-To: <CAE+F7TFpuoVEbY9eZzo=0d50bnjzstsypdoWeF0g8H7wP=o8=w@mail.gmail.com>
From: KeithG <ys3al35l@gmail.com>
Date: Thu, 12 Dec 2024 08:33:32 -0600
Message-ID: <CAG17S_NLzmx6USBvD8SQrhQQ8iXBU7QgFUROA=hXmixD5N6_dQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/2] External Auth support
To: Jeremy Blum <jeremy@shapertools.com>
Cc: Arend Van Spriel <arend.vanspriel@broadcom.com>, Denis Kenzior <denkenz@gmail.com>, 
	Yuxuan Shui <yshuiv7@gmail.com>, iwd@lists.linux.dev, prestwoj@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 5:00=E2=80=AFPM Jeremy Blum <jeremy@shapertools.com=
> wrote:
>
> Infineon has just released updated firmware for the 43455 chipset, and
> and updated brcmfmac driver. May be relevant to this conversation
> about getting IWD supporting WPA3 with the brcmfmac SAE offload
> implementation.
> https://community.infineon.com/t5/AIROC-Wi-Fi-and-Wi-Fi-Bluetooth/Cypress=
-Linux-WiFi-Driver-Release-FMAC-2024-11-21/td-p/902888
>
>
> On Thu, Oct 10, 2024 at 8:38=E2=80=AFAM KeithG <ys3al35l@gmail.com> wrote=
:
> >
> > Arend,
> >
> > Is there anything I can help with on this effort to get External Auth
> > working on a kernel that more of us are using? RPiOS is currently at
> > 6.6.51.
> >
> > Keith
> >
> > On Sun, Sep 22, 2024 at 11:29=E2=80=AFAM KeithG <ys3al35l@gmail.com> wr=
ote:
> > >
> > > On Sun, Sep 22, 2024 at 11:20=E2=80=AFAM Arend Van Spriel
> > > <arend.vanspriel@broadcom.com> wrote:
> > > >
> > > > On September 22, 2024 5:36:53 PM KeithG <ys3al35l@gmail.com> wrote:
> > > >
> > > > > On Sun, Sep 22, 2024 at 1:09=E2=80=AFAM Arend Van Spriel
> > > > > <arend.vanspriel@broadcom.com> wrote:
> > > > >>
> > > > >> On September 22, 2024 5:35:03 AM Denis Kenzior <denkenz@gmail.co=
m> wrote:
> > > > >>
> > > > >>> Hi Yuxuan Shui,
> > > > >>>
> > > > >>>>
> > > > >>>> I tested this on an RPi5 too, and indeed I am having the same =
problem as KeithG
> > > > >>>> as well. However I managed to get some debug information from =
brcmfmac when
> > > > >>>> running wpa_supplicant. Interestingly wpa_supplicant gets the =
same -52 error as
> > > > >>>> well, which it reports as an authentication timeout. But if I =
ask it to try
> > > > >>>> again, it will connect successfully, and there is no external =
auth related log
> > > > >>>> the second time around.
> > > > >>>
> > > > >>> Yep.  It looks like wpa_s puts the resulting PMKSA into the ker=
nel cache even
> > > > >>> though the initial connection using external auth fails.  I've =
only seen
> > > > >>> 2.10 do
> > > > >>> this, not 2.11.  Either way, it is a bug / lucky coincidence.
> > > > >>>
> > > > >>>>
> > > > >>>> So I suspect this is a firmware bug, but it should be relative=
ly easy to
> > > > >>>> workaround I think? Basically we also add a timeout and retry.
> > > > >>>
> > > > >>> It would be far nicer if the brcmfmac firmware + driver combina=
tion worked
> > > > >>> properly :)
> > > > >>
> > > > >> Indeed it would. So what's in the mix? What kernel is used? Upst=
ream or RPi
> > > > >> kernel? What firmware capabilities are listed in debugfs?
> > > > >>
> > > > >> Recently I submitted patches upstream to add external auth suppo=
rt. As I
> > > > >> ported downstream patch the results you see do not make me optim=
istic that
> > > > >> my patch is ready. Maybe you could help testing it?
> > > > >>
> > > > >> https://patchwork.kernel.org/project/linux-wireless/list/?series=
=3D891248&state=3D*
> > > > >>
> > > > >> Regards,
> > > > >> Arend
> > > > > Arend,
> > > > >
> > > > > I tried to apply the patch set to kernel 6.6.44-v8 and was unable=
 to patch it:
> > > > >
> > > > > $ patch -p1 <
> > > > > RFT-v2-1-3-wifi-brcmfmac-support-per-vendor-cfg80211-callbacks-an=
d-firmware-events.patch
> > > > > patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/cf=
g80211.c
> > > > > Hunk #1 FAILED at 6752.
> > > > > 1 out of 1 hunk FAILED -- saving rejects to file
> > > > > drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c.rej
> > > > > patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/co=
mmon.c
> > > > > Hunk #1 succeeded at 524 (offset 33 lines).
> > > > > patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/co=
re.c
> > > > > Hunk #1 FAILED at 1359.
> > > > > 1 out of 1 hunk FAILED -- saving rejects to file
> > > > > drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c.rej
> > > > > patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/fw=
eh.c
> > > > > Hunk #1 succeeded at 74 (offset -1 lines).
> > > > > Hunk #2 succeeded at 336 (offset -70 lines).
> > > > > patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/fw=
vid.h
> > > > > Hunk #1 FAILED at 15.
> > > > > Hunk #2 succeeded at 47 with fuzz 1 (offset -9 lines).
> > > > > 1 out of 2 hunks FAILED -- saving rejects to file
> > > > > drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.h.rej
> > > > >
> > > > > I did not try the other patches as this attempt failed. Do I need=
 to
> > > > > use a newer kernel? The latest kernel from RPiOS is 6.6.47.
> > > >
> > > > I did major rework to support multiple vendors with differing firmw=
are
> > > > APIs. So I can imagine you would need other patches that were submi=
tted
> > > > earlier. Easiest would be to use the backports project which allows=
 running
> > > > latest driver like wireless-next on older kernels.
> > > >
> > > > I can try. Do you have a URL of the RPiOS kernel repo?
> > > >
> > > > Regards,
> > > > Arend
> > > > > Keith
> > > >
> > > >
> > >
> > > Arend,
> > > It is either here as a git clone:
> > > git clone --depth=3D1 https://github.com/raspberrypi/linux
> > >
> > > or here as a gzip:
> > > https://github.com/raspberrypi/linux/archive/refs/tags/stable_2024052=
9.tar.gz
> > >
> > > Keith
Jeremy,

I tried this new firmware with the existing driver in the 6.6.xx
kernel on the Rpi3b+ over the weekend. It almost works. I posted a log
and such to the brcm80211, linux-wireless lists. I think those are the
best fit, but just let me know if I should send it elsewhere. I can
patch and test the brcm80211 driver as I have a kernel build ready to
add it to.

The error seems to be something with BCME, though I have no idea what that =
is:

brcmfmac: brcmf_fil_cmd_data Firmware error: BCME_BADADDR (-21)
brcmfmac: brcmf_fil_iovar_data_get ifidx=3D0, name=3Dsta_info, len=3D296, e=
rr=3D-52
ieee80211 phy0: brcmf_cfg80211_get_station: GET STA INFO failed, -52
brcmf_fil_cmd_data Firmware error: BCME_UNSUPPORTED (-23)
brcmf_fil_iovar_data_get ifidx=3D0, name=3Dtdls_sta_info, len=3D296, err=3D=
-52
brcmfmac: brcmf_fil_cmd_data Firmware error: BCME_BADADDR (-21)
brcmfmac: brcmf_fil_iovar_data_get ifidx=3D0, name=3Dsta_info, len=3D296, e=
rr=3D-52
ieee80211 phy0: brcmf_cfg80211_get_station: GET STA INFO failed, -52

Keith
