Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5917B17AE1D
	for <iwd@lists.linux.dev>; Thu, 12 Jun 2025 16:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749747091; cv=none; b=aZGhtlhFM1L8QUrM3wM/OE+PzYXpFq4BxLBtGXRmeZFml1qjC4xTJwWrmrDU8sF3o9XqDUb2J3kGczaN+6QVXcxXfDwqeZBdmSLAOhk1tZMjahfOWXVbKo8wX0J0sBFRc4tCp3VzYuQAfS8GhaRhV7MB8JWdxGU1I8EAyntBEnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749747091; c=relaxed/simple;
	bh=lBCyluw+bIdcfYTt3BhOO7fMWg9m+PWJoVOEl+cYAJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PreQy5xyoBvYaUHYgeDVVXa8Cd+jnjGhsnRg4eBQB2dMKbvv1e1coFpx6SYrHjLUoSTR1Tlz+pTc2hI55+e5wFnZ8zSlljhDK1qAWeAjXT6P2e6mFq70II41exchICq4BAJU9kDaCbGl3dn6dVoHivIVdN06lE0VPQsFhcdz1E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lp7PpbG8; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lp7PpbG8"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e7d9d480e6cso945901276.2
        for <iwd@lists.linux.dev>; Thu, 12 Jun 2025 09:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749747089; x=1750351889; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EUqpAflsKL4VnUFIBuIZMLeTZmxR9iZSVN9UJPYAenQ=;
        b=lp7PpbG8bQmA4P1mtDar8djvsmPI+TrzB5dqoDwFFKzYC2bIW8BA5w4HSK3+ur+GPl
         GuEpO6J1BZunTJWuIDRv0J/WLsjatB1g6A3w0Ie07vqiZpnEn7q16oIquTU+ii+oK/nQ
         lvNyw/d4D7dtJWAX3KOpNVmgfxoi9oASn41KQR29yG/5E9hVLjIq/UYUmq7SLFKnx0y1
         tzzlVecJCyvOuqDDuydGblzxoMePD3hq+InTWb/upI8Rp0xTt+Kd0cUH3S5wBwFJh324
         VHQGryC7m2jKmnBu17MHpceRaRhUwmyRLBoGkIahIkG+4dV7cvKhfPW71YCB9G9sEHlb
         XfWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749747089; x=1750351889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EUqpAflsKL4VnUFIBuIZMLeTZmxR9iZSVN9UJPYAenQ=;
        b=XQINviysY52RUn2DTpP6aWEdgC60AhlGrlt0M2U4iFgWWyvO+HgUHVG6xHgQcqo46i
         JyzAIgBuNRiNELFE9GZyv8UAPIlvzSa1MgOMlrIoUZljRKl9Qen6/90VHd0HnC/28dXE
         oILDSXHDADy2w/e2JvB49LpcSkE80JdDE8HQt3DOsnx4dQRWAzqbVvvhif9f2lWVTU/Q
         JZoyj2Cjg3nI8R2njR2E/DmjZz38qKArolxkZFg2CTP0uB6Lwa/Q2vgS0q3g6nZGIFF+
         t157bDeyinDsodn8e1MqC6mbrSONlbxX4aVAfGKHY1exbL5K+uOoxAt7rXek4H1NDNPH
         jhKg==
X-Forwarded-Encrypted: i=1; AJvYcCVEDjT4hsKC2IO1Kipf8TXgItwl9xRP3oDEvQxR9G3BeYIvjYnzIH5d69K0rLQJbjCsWwQ=@lists.linux.dev
X-Gm-Message-State: AOJu0YweWTC2/MpMrSKqhutIBThLge5rnzsmEEtm/Wu/OSGnXjbEbGnm
	+1uHCJ8bN8gXqPBh86dj+NKcDzeFV/zC4Zls6cZYykgIdYzudnZXoo/o5xJvawgrIlRGRVOz9fV
	EWRLZD9AWSAVX6RMSbuUnzyZGbS8MFKE=
X-Gm-Gg: ASbGnctXngcm/i5nfyz20zAkEqQMX5VCKEhQ/1yFpYD6OLxuMyHDigB94lhaI6aSHs/
	rkoO0F8KgMSkChVUW3lbPn93VQ2311F7sCWRi9PoOu73ydUJFd300huNL96zNOPwjoBPRmRQBX1
	x1Za3zSFvg9x9q6fMfzr2py/SNlYJPffZTuq7QOEP8RG5Igw==
X-Google-Smtp-Source: AGHT+IHSXBSvByruanfe4Xb9pTd6PcG8w0VoQzlTKA8l5ZHRfUkpa9Pt6covEBPtkBmesUv7jB1RkbrcV5S6eE8XAOY=
X-Received: by 2002:a05:6902:102a:b0:e82:1072:de4f with SMTP id
 3f1490d57ef6-e821a77d0b0mr423428276.21.1749747089298; Thu, 12 Jun 2025
 09:51:29 -0700 (PDT)
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
 <CAG17S_PxYNxLpAMzXOuS6riv46G22zpOM0rT0D7Xp-usbWyo+A@mail.gmail.com>
 <196b5fd2b70.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CAG17S_PzWmDmFekBgtBj7VHPt-g2qU0+LSa9WzYi75aNR5Mb_g@mail.gmail.com>
 <CAG17S_NMk44gBa2B=xNyjhXVJuaeYVn-+T9u_8fid+r7k--56A@mail.gmail.com> <197649346d8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <197649346d8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
From: KeithG <ys3al35l@gmail.com>
Date: Thu, 12 Jun 2025 11:51:18 -0500
X-Gm-Features: AX0GCFuEWGARX4ggHidDWI8kHhWS-9UDB7jicWTELMsR6BwVHSfHVUnnU-t1MmE
Message-ID: <CAG17S_PcYOFqbfKPnaNUsQ0AsJzWGRgGDRYrq9SgewUskqck_w@mail.gmail.com>
Subject: Re: brcmfmac disconnects when iwd scans
To: Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev, 
	James Prestwood <prestwoj@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

...

On Thu, Jun 12, 2025 at 9:37=E2=80=AFAM Arend Van Spriel
<arend.vanspriel@broadcom.com> wrote:
>
> On June 12, 2025 3:51:34 PM KeithG <ys3al35l@gmail.com> wrote:
>
> > Arend,
> >
> > I am still seeing this:
> > wpa_supplicant[431]: wlan0: Failed to initiate sched scan
> >
> > I tried the brcmfmac options listed above and got no change? Still
> > getting this every 6 seconds in the log.
> > Did I get the command in the modprobe conf wrong?
>
> Maybe. You could try to merge the two value so one line with 0x200002.
> Could be that wpa_supplicant determines support for scheduled scan in an
> unexpected way. Have not looked at the wpa_supplicant code for that.
>
> Regards,
> Arend
>
> >
> > On Fri, May 9, 2025 at 1:01=E2=80=AFPM KeithG <ys3al35l@gmail.com> wrot=
e:
> >>
> >>>>
> >>>> With this setup, things work really well and the only strange thing =
I
> >>>> am getting is a 'failed scheduled scan' message in the log every ~6
> >>>> sec.
> >>>>
> >>>> May 09 08:53:50 pi4 wpa_supplicant[2254218]: wlan0: Failed to initia=
te
> >>>> sched scan
> >>>> May 09 08:53:57 pi4 wpa_supplicant[2254218]: wlan0: Failed to initia=
te
> >>>> sched scan
> >>>> May 09 08:54:03 pi4 wpa_supplicant[2254218]: wlan0: Failed to initia=
te
> >>>> sched scan
> >>>> May 09 08:54:09 pi4 wpa_supplicant[2254218]: wlan0: Failed to initia=
te
> >>>> sched scan
> >>>> May 09 08:54:16 pi4 wpa_supplicant[2254218]: wlan0: Failed to initia=
te
> >>>> sched scan
> >>>> May 09 08:54:22 pi4 wpa_supplicant[2254218]: wlan0: Failed to initia=
te
> >>>> sched scan
> >>>
> >>> I thought wpa_supplicant had a config option to disable scheduled sca=
n, but
> >>> can not find it. You can disable it in brcmfmac using feature_disable=
=3D2
> >>> modparam.
> >>>
> >>> Regards,
> >>> Arend
> >> Arend,
> >>
> >> Thanks. I must be doing something wrong as I still get the 'Failed to
> >> initiate scan' spammed in the log with this config:
> >>
> >> # cat /etc/modprobe.d/brcmfmac.conf
> >> options brcmfmac feature_disable=3D0x200000
> >> options brcmfmac feature_disable=3D2
> >>
> >> Do I have it formatted wrong?
> >>
> >> Keith
> >>
> >> I think you suggested the the first line due to a different log
> >> spamming message.
>
>
Arend,

Thanks for the help, but that does not seem to change anything. My
modprobe.conf:

# cat /etc/modprobe.d/brcmfmac.conf
options brcmfmac feature_disable=3D0x200002

Still lost of the same "wpa_supplicant[423]: wlan0: Failed to initiate
sched scan" every 6 seconds.

When I reboot, I get these mesages wrt wpa_supplicant (journalctl | grep wp=
a):
Jun 12 11:05:48 pi4 systemd[1]: Created slice
system-wpa_supplicant.slice - Slice /system/wpa_supplicant.
Jun 12 11:05:51 pi4 systemd[1]: Started wpa_supplicant@wlan0.service -
WPA supplicant daemon (interface-specific version).
Jun 12 11:05:53 pi4 wpa_supplicant[423]: Successfully initialized wpa_suppl=
icant
Jun 12 11:05:54 pi4 wpa_supplicant[423]: nl80211: kernel reports:
Registration to specific type not supported
Jun 12 11:06:07 pi4 wpa_supplicant[423]: wlan0: Failed to initiate sched sc=
an
lots more...
Jun 12 11:07:51 pi4 wpa_supplicant[423]: wlan0:
CTRL-EVENT-REGDOM-CHANGE init=3DUSER type=3DCOUNTRY alpha2=3DUS
Jun 12 11:06:07 pi4 wpa_supplicant[423]: wlan0: Failed to initiate sched sc=
an
lots more...

yet when I look, it seems it has scanned and are there SSIDs:

# wpa_cli scan_results
Selected interface 'wlan0'
bssid / frequency / signal level / flags / ssid
c0:94:35:54:bb:10       5220    -59     [WPA2-PSK-CCMP][WPS][ESS]
 AlignedHedronNetwork
d2:94:35:54:bb:10       5220    -69     [WPA2-EAP-CCMP][ESS][HS20]
 Xfinity Mobile
c6:4f:d5:4b:36:c0       5785    -68     [WPA2-PSK-CCMP][ESS]
c6:4f:d5:4b:36:c2       5785    -68     [WPA2-PSK+SAE-CCMP][ESS]
 ameliafanclub
