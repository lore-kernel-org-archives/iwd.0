Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6043BBF0
	for <iwd@lists.linux.dev>; Thu, 24 Apr 2025 00:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745455948; cv=none; b=mVwURzukW3m7ogtDc8bQhuNkXMLYO58G7LZ4mclYUtJRYWztm04LN9+TGR9Ist4TYux1rQkRwu5awpvEIJ2lU2JSqwBIl9W+SwPfIYquEHLLMeVa58WQ9xfV2kB7K+Hk98AxvWRVY9Js4/5DOVW6N1HL9f+gH2jstbNbPbhEidA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745455948; c=relaxed/simple;
	bh=gTNB1ZLOUWb1J3xdRrD9gr5gHOgPSDp7AqJd2Yj0mco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bo6kcMF5HpLtJ4Q6d6e/c3f01R3j97edirh4rXpHirZiUdluPSTtznvo5Aj61qPoL+Q48fYDyZKLbo1jd5WPDHYKhj8kqH/ZhJwvzBJWwgl36sVpoj11sThjFCMeXu/+kULAnFl0YxPxKUd4AHm9aXTYntpuBlcYg54z1SH+QD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kcDJMhIz; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kcDJMhIz"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b0da25f5216so237908a12.1
        for <iwd@lists.linux.dev>; Wed, 23 Apr 2025 17:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745455946; x=1746060746; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uj2z2e+oE7rYouKv+P6HkQaVaH+suA8spqvUCXikc/g=;
        b=kcDJMhIzWr32IrqCw8H2J1A5tlyS2smxt+1Sl0Qsq7gDrLG0UKW/7KjBHE0XmQ0QHJ
         FA00fPQELgz6EtTOfNVHzCOYKRDfcxhqfwUwypibJHHtUaEvgjT4qXDG3x1ipd8NPWpB
         sPcyyzDkvLjZHsvYP34NKjohBUSNmd79f0faluCq24seFq/tSO/DCZ3LePIPXtcbOOqj
         8L+P+DIDSTRrvqSJsB0/5LSJvIcXYTvsLf3sjodD04HXIHg14NB796ggqA8aT6kIQwtm
         m2m/78zOSLZdeh+DmkasIT9wyXeZiuYM6SuScWcIEd+VznhnYuRbaujpToOHQTwtDC/P
         /MCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745455946; x=1746060746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uj2z2e+oE7rYouKv+P6HkQaVaH+suA8spqvUCXikc/g=;
        b=O0thBSdIURZCrMApEYxrRnu3xzan/gibwtRQYrh7MLfMYg2uAHO5InKcZ9bFiLBeqg
         RArFMoKO0Jc2YyBRmYtDlYIpv2n8/4j0+Eeo4iECHNEl5ttKqfAcPrVhIxsLXHrWLlA/
         GgzNudVRIh0fgXezEfw0Ypw2lAy+ZN0Sajqgme1dQs9qzwHgPg0kqUGw4zIspKc/uIEa
         gsTPo6nLmPy1sk/wLPY/ju3uxhyKQcmx00pMDIdZnlDkh36i7cm/gwCamzwPbo3/tGoP
         XsQhH5bB17AnOgWRyemylEFzr1403H7KR28yP+kSG6QiY+VqSvlHGcOIZsvXz+TgmM4n
         AyPA==
X-Gm-Message-State: AOJu0YxgTqn7q1re6yrGVJb6d6ny9GsWeREgA4zxaO7PzaNa4cqWUedi
	ZrHw0jvM4TL9C/sFYaKt6nnS0dtMRBn7x40gWs6pa3L8g0eytipOT42t88uvPqb3ojxA1caqq/p
	W3tWrg4O6rUWFUEBIjDoPgPcH+I0=
X-Gm-Gg: ASbGnctGESeiR3pbBQh4xQQftE91KLLT4AezVJxfN+mGp5uAgJ49SG5B3Pq9JAb5GVD
	d7O/iP5dUZPpYuc9MwVgCn4Z0rrUoVNa3guD4WgF2SSD+13UNDfMy1o2bB71ZHd3Rx18/KaQYtq
	CMuuBRZPStuF4Ft31bWRpApHAhKTT33YCeQTmUPyL+Qj3E1g==
X-Google-Smtp-Source: AGHT+IGMGwKIp/gCiwvWXcUXyssKSNhBVdUPwZgYlc+IMXqKjU4x3a/AzZtbG3n1zZCgqWPMccVnGLkSyvFqPe5w+N4=
X-Received: by 2002:a17:90b:2e42:b0:2fe:9581:fbea with SMTP id
 98e67ed59e1d1-309ed35b2f1mr1009584a91.29.1745455945798; Wed, 23 Apr 2025
 17:52:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAG17S_M4_+CR1uSsajyvHBjig6cfCuxegipnHREhk1sXjSyOsA@mail.gmail.com>
 <a0dcf03d-3bd3-43e5-9532-5a565d20930f@gmail.com>
In-Reply-To: <a0dcf03d-3bd3-43e5-9532-5a565d20930f@gmail.com>
From: KeithG <ys3al35l@gmail.com>
Date: Wed, 23 Apr 2025 19:52:14 -0500
X-Gm-Features: ATxdqUH6zhcel7Rbzd8Qm44zms-IsS1wbOu70zu6KscrJXpSAmOJNZAxamP9Dsc
Message-ID: <CAG17S_MKZXf3vC0zgaK_MUrA1nqRzhGcPGUho873KU3jYVShXw@mail.gmail.com>
Subject: Re: brcmfmac disconnects when iwd scans
To: Denis Kenzior <denkenz@gmail.com>
Cc: iwd@lists.linux.dev, James Prestwood <prestwoj@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2025 at 9:42=E2=80=AFAM Denis Kenzior <denkenz@gmail.com> w=
rote:
>
> Hi Keith,
>
> On 4/22/25 8:00 PM, KeithG wrote:
> > I ran into this a while back and James came up with a few patches that
> > I have been using to keep it from restarting the AP0 interface.
> > [PATCH 1/3] station: remove scan subsets for dbus scans
> > [PATCH 2/3] eap: fix compile issue on ARM/GCC 12
> > [PATCH 3/3] scan: use ifindex and only active scans
>
> Likely this is the fix.  Passive scans take too long to remain off-channe=
l.
>
> >
> > These no longer seem to work with current builds of iwd from git. I am
> > running iwd 3.6.r10.g4ded663e. My kernel is 6.12.20. The firmware is:
> > [    3.496006] brcmfmac: brcmf_fw_alloc_request: using
> > brcm/brcmfmac43455-sdio for chip BCM4345/6
> > [    3.839254] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4345/6
> > wl0: Oct 28 2024 23:27:00 version 7.45.286 (be70ab3 CY) FWID
> > 01-95efe7fa
> >
> > I get the same response with the firmware that ships with RPiOS,
> > 7.45.265 as well. I am building a fresh kernel to be able to get iwmon
> > data and should be able to do so tomorrow.
> >
> > This flakiness of ap0 happens regardless if I use iwd or hostap to
> > bring up ap0. When I use hostapd, I use this to bring up the
> > interface:
> >
> > iw dev wlan0 interface add ap0 type __ap
> > ip link set dev ap0 address d8:3a:dd:60:a3:cg
> > systemctl start hostapd
> > systemctl start dnsmasq
> > ip addr add 192.168.5.1/24 broadcast 192.168.5.255 dev ap0
> >
> > With this, I can have the ap0 up and can scan on wlan0 with the single
> > brcmfmac card. If I use wpa_supplicant, ap0 does not go down when
> > wpa_supplicant scans for ssids.
> > iw wlan0 scan
>
> This uses an active scan.  See what happens with
> 'iw wlan0 scan passive'
>
> > It is only with iwd that the network goes down when iwd scans for ssids=
.
> > iwctl station wlan0 scan
>
> iwd uses active scans when connected or if the hardware is capable of
> anonymizing the active scan.   Otherwise it uses a passive scan.
>
> Regards,
> -Denis

Denis,

I am building iwd from git with those 3 patches and every time it
scans, it disconnects the AP.
When I use wpa_supplicant, it does not disconnect regardless of using:
iw wlan0 scan passive
or
iw wlan0 scan

it is only with iwd that it disconnects and only with iwctl. If I run
'iw wlan0 scan passive' or
'iw wlan0 scan' when iwd is running and wpa_aupplicant is removed, It
seems to be OK.
My laptop shows a disconnect, sometimes, but when I check the wlan0 on
the laptop
it is still connected to the ap running on the RPi. I think it looses
the connection for a
second but reconnects. If I run the 'iwctl station wlan0 scan' it will
disconnect and not reconnect.
When it does, the ap0 gets to a strange state as it takes a number of
attempts to get it to
reconnect and sometimes it requires a tear down and restart of ap0
before I can reconnect

This is an iwmon log of my RPi.
https://drive.google.com/file/d/1WNZz0dOip0XZZVIOs7RGcYIeLY2W4bXC/view?usp=
=3Dsharing
I had connected to it from my laptop. I then ran:

# iw wlan0 scan
# iw wlan0 scan passive
# iwctl station wlan0 scan

after I ran the last command, the Pi's ap0 disconnected from my laptop.

Keith
