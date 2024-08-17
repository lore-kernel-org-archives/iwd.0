Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505AA9460
	for <iwd@lists.linux.dev>; Sat, 17 Aug 2024 20:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723927808; cv=none; b=R2Fj6qKQz0vyTar7WZ4fG7IAJdR6MchVP6lppV4od/rGna7ixnlW3ewMmYsIN7q30pBcB1k0Ca3d7+pg6gkIbbNFZx+gLGrR5t26czrox4FjwYprBNfPDKwxCDoC1oI3emmXpBcpwvqugai6usI1duFhMnTJqZRjGbYjpu4INGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723927808; c=relaxed/simple;
	bh=TgXo9ouEWv4MIABtCewfjclnOGlcZtPBuEVwjvoA/qg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r4p6oaSrEoQwBURA9BAzIdXUxe9vL+4TZZ2RaAAPqEVnkuJ46G/oxSUQWzDjx8FG4xYrURfOPRb5sL2Wqnjfj0MpJMnOxLrxiXrmZEgu8FcsT2BacSsBDdtRXxhtSWATD3oLnyxg94bNuM+yo2gD+fVhfDxi/Xy6E67gBpH1I+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LbECxB05; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LbECxB05"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2d1daa2577bso2368858a91.2
        for <iwd@lists.linux.dev>; Sat, 17 Aug 2024 13:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723927806; x=1724532606; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=svwiOMSb5IPYcSpVmtPzg/VZsplQokoIeCYimbNfBaY=;
        b=LbECxB05dkW0M1MwJPI9KcH1e0skgscmvOq9yLaJeYoKqlL+a/MI+/rnaEkyJbmpTA
         +Z38aZrH32NoWzVfTtD2ZhCGtf0CieHsizUXg9KXt8m9Ci55DU8unvksI2jGH8PLs3OR
         eXcO6PrHxnqU+4tDXAoDDUpyU1unDnivIwi1IM4oLbo4Tt1xPCwzw0GhoTRdrlDfitsK
         0aKkkKJTQeP2IbLagdI6qeNg4EbU0nfkRN0FRlOEQ/zWIWq/FZjU0hyQY3S7q9FKZFJT
         R89+JdEqbqiug+oWAXWdnRyy18FEJG1YpPjnWlt7oG95EtTD7Bkm6pDXT8daQkWLCvBY
         8Mug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723927806; x=1724532606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=svwiOMSb5IPYcSpVmtPzg/VZsplQokoIeCYimbNfBaY=;
        b=I2rAzOysSb8+odrKrxf6EQSdALi9aLm9m3nKif9KVed4drEKVqiTUKx+Ib9SeM+DMb
         mxqEjuKv40Vg/taV8A6XQg4FShKnFtooveq/22D8HeQEfVIryR81twCQ73gC0+FAJTMu
         zVAKCe80afQcGFSn6toTEU8t+wCT+0DqZhLtMFeq8qZA/JVJrVi/I4VddBxsdqMqU+mu
         8NNEoAICT4PcmwK5NBYCHh1HHEYwHSMeMWTM6z4mJyh3ly4tmGfNAeNI59ZoB7vKX67p
         AnsOs+XXCqI98qtBI61uVG4bsPQwgHbN+rf3N9gSV4yADZSR/PntGF7WSGeAbEeSE/47
         AioA==
X-Forwarded-Encrypted: i=1; AJvYcCUgM4rZ//6MOv4hxMRtkyxRz6jKf+Uw/kBCnPsSrElsZJE/TE6GeYTGycprbU+W1oFbRfI/V/9DWB38qtyfznPNJJ7l
X-Gm-Message-State: AOJu0YzES3uHc6UYZHlACcq67tOlo7vu74dZT+sexwWixf8TkcDnIPcI
	LNdmIZ45AB5kPGlOrCwLKyFeZXGLoeTZk2tO6tuO+BJtZu/p0AKjkc6xeaeMJqW7tZPm1nv85Lj
	DtNGgi4PK+ZlYd5TAQGyNBSRXGGQ=
X-Google-Smtp-Source: AGHT+IFq29WY3gV8m7dN7NyH/9gilf6AaQQN7DOI2x5TRU9R7pvAYeqY/bC5nZ0NRVtP0/Lo+DB4voV+8Q+q8bWO6gg=
X-Received: by 2002:a17:90b:1807:b0:2d3:caa7:cf8f with SMTP id
 98e67ed59e1d1-2d3dffe3fc2mr7950520a91.24.1723927805238; Sat, 17 Aug 2024
 13:50:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAG17S_N+Hjt2c8t8hN4VMx79QsQ3hiiE_cwOErg6fKoyHkr67A@mail.gmail.com>
 <ef38aa12-634e-4870-888c-219c961f301c@gmail.com> <b0ef10a2-c30b-4b6c-8370-66f9e0ace7b1@gmail.com>
 <CAG17S_P_MO4_BZYTCp4WDkJ_q4j=0s_s3azCOWrsvqmLD0ravw@mail.gmail.com>
 <de951e97-547f-4c14-841c-267f64b0020b@gmail.com> <CAG17S_Oh_1NS9SUSadAJkMXtJ3s_AjMhnUDSqrKMzEiO69jBPA@mail.gmail.com>
 <cf5ba208-58d9-44e8-bd91-0639ea062d5d@gmail.com>
In-Reply-To: <cf5ba208-58d9-44e8-bd91-0639ea062d5d@gmail.com>
From: KeithG <ys3al35l@gmail.com>
Date: Sat, 17 Aug 2024 15:49:54 -0500
Message-ID: <CAG17S_P_QS4wjqrMgtLryrmx2eoJAYJF7SE1AJdOces-cFPacg@mail.gmail.com>
Subject: Re: [Request] iwd to support brcmfmac 'SAE with AUTHENTICATE'
To: James Prestwood <prestwoj@gmail.com>
Cc: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 6:36=E2=80=AFAM James Prestwood <prestwoj@gmail.com=
> wrote:
>
> Hi Keith,
>
> On 8/11/24 6:19 PM, KeithG wrote:
> > On Sun, Aug 11, 2024 at 2:38=E2=80=AFPM Denis Kenzior <denkenz@gmail.co=
m> wrote:
> >> Hi Keith,
> >>
> >>>       Supported extended features:
> >>>           * [ CQM_RSSI_LIST ]: multiple CQM_RSSI_THOLD records
> >>>           * [ DFS_OFFLOAD ]: DFS offload
> >>>
> >> <snip>
> >>
> >>> The pcap is uploaded to my gdrive:
> >>> https://drive.google.com/file/d/1vIuje60MGFPklcXtSNMi9-IOlV_6sBJ8/vie=
w?usp=3Ddrivesdk
> >> What is the PCAP supposed to show?  There's no Connection attempt in t=
here.
> >>
> >>> Hopefully, this helps to get started.
> >>>
> >> Anyway, I was curious and snooped on wpa_s from git trying to connect =
to an
> >> iPhone 12 Personal Hotspot (Maximum Compatibility option off, so it us=
es SAE).
> >> Not a pretty sight.  Firmware fails with errno=3D-52, Invalid exchange=
.  Has
> >> anyone from RPI team actually tested this firmware before pushing it o=
ut?
> >>
> >> I also tried the old firmware with SAE_OFFLOAD bits, and that doesn't =
work with
> >> wpa_s or iwd either.
> >>
> >> Until someone sends me a iwmon trace showing CMD_EXTERNAL_AUTH exchang=
e working
> >> on an WPA3-Personal Only network, I remain skeptical that any of the C=
ypress
> >> firmwares actually work.
> >>
> >> Regards,
> >> -Denis
> > Denis,
> >
> > I did not attempt a connect with that first log. I misunderstood what
> > James was asking for.
>
> You didn't misunderstand :) I was confused by what I thought brcmfmac
> supported but Denis pointed out that the "Device supports SAE with
> AUTHENTICATE command" only mean NL80211_FEATURE_SAE was set, not that
> CMD_AUTHENTICATE is actually supported (really dumb and confusing, I know=
).
>
> What is interesting though is even in your pcap CMD_EXTERNAL_AUTH isn't
> showing up as a supported command.
>
>      Supported Commands:
>          New Interface [7]
>          Set Interface [6]
>          New Key [11]
>          Start AP [15]
>          Join IBSS [43]
>          Set PMKSA [52]
>          Del PMKSA [53]
>          Flush PMKSA [54]
>          Remain on Channel [55]
>          Frame [59]
>          Set Wiphy Netns [49]
>          Set Channel [65]
>          Start Sched Scan [75]
>          Start P2P Device [89]
>          Connect [46]
>          Disconnect [48]
>          Crit Protocol Start [98]
>          Crit Protocol Stop [99]
>          Update Connect Params [122]
>
> So I'm even more confused now. But as Denis said, we do need a iwmon
> pcap of wpa_supplicant working I think to see how its actually
> connecting successfully.
>
> Thanks,
>
> James
>
> >   I tried connecting
> > with my Samsung phone and was able to connect so it seems that the AP
> > is working and allows a
> > connection from my phone.
> >
> > I tried to connect from the Pi with iwctl:
> > https://drive.google.com/file/d/1f1jnD0EUOJSaJXd8l7uYG9nisAxCPeo4/view?=
usp=3Ddrivesdk
> >
> > I uninstalled iwd, installed wpa_supplicant (built from git) rebooted
> > and tried to connect with connman and collected another pcap and it
> > did not connect:
> > https://drive.google.com/file/d/1zuVSF0xu4Nk2fN9ketBSv1tiquT-Sc-p/view?=
usp=3Ddrivesdk
> >
> > I then tried from wpa_cli and did not connect. I tried again with a
> > wpa_supplicant.conf and also could not connect.
> >
> > Now I am trying to figure out what I did to allow this connection to a
> > sae AP... Now that I have nlmon
> > module and iwmon, I will see if I can re-connect, somehow.
> > The brcmfmac is such a pain.
> > When I get a wpa3/SAE connection, I will make a pcap and post it.
> > I actually was able to make one with wpa_supplicant once and actually
> > passed data, but it does not seem to work today.
> >
> > Keith

I am back at this. Messed around for a *lot* trying to get it to
connect via wpa_cli and connman and was unable to get it to connect. I
find both connman and wpa_supplicant so tough to figure out what I am
supposed to do to get it to work. I was able to, once, get wpa_cli to
connect via wpa3 a while back, but no more. It does not appear that
the current git version nor the default version of connman allow an
SAE connection on the Pi...

Finally, I was able to get it to connect using the current, default
RPiOS wpa_supplicant and nmcli on a Pi5. No purpose built packages.
just the defaults. Now to see if I can get it to work on the one I
built using the later kernel that I built with the nlmon module. If I
have luck, I'll post a log.

On the hostapd computer:
Aug 17 15:36:25 jackson hostapd[2204]: ap0: AP-STA-CONNECTED d8:3a:dd:d2:ae=
:3c
Aug 17 15:36:25 jackson hostapd[2204]: ap0: STA d8:3a:dd:d2:ae:3c
RADIUS: starting accounting session ACB7F795BBC8FF5E
Aug 17 15:36:25 jackson hostapd[2204]: ap0: STA d8:3a:dd:d2:ae:3c WPA:
pairwise key handshake completed (RSN)
Aug 17 15:36:25 jackson hostapd[2204]: ap0: EAPOL-4WAY-HS-COMPLETED
d8:3a:dd:d2:ae:3c
Aug 17 15:36:25 jackson hostapd[2204]: ap0: STA d8:3a:dd:d2:ae:3c
RADIUS: starting accounting session ACB7F795BBC8FF5E
Aug 17 15:36:25 jackson hostapd[2204]: ap0: STA d8:3a:dd:d2:ae:3c WPA:
pairwise key handshake completed (RSN)

and on the Pi:
Aug 17 15:36:25 pi5 wpa_supplicant[669]: wlan0: Trying to associate
with SSID 'deskSAE'
Aug 17 15:36:25 pi5 NetworkManager[2142]: <info>  [1723926985.4925]
device (wlan0): supplicant interface state: scanning -> associating
Aug 17 15:36:25 pi5 NetworkManager[2142]: <info>  [1723926985.4925]
device (p2p-dev-wlan0): supplicant management interface state:
scanning -> a>
Aug 17 15:36:25 pi5 wpa_supplicant[669]: wlan0: Associated with
d8:3a:dd:60:a3:0c
Aug 17 15:36:25 pi5 wpa_supplicant[669]: wlan0:
CTRL-EVENT-SUBNET-STATUS-UPDATE status=3D0
Aug 17 15:36:25 pi5 wpa_supplicant[669]: wlan0: WPA: Key negotiation
completed with d8:3a:dd:60:a3:0c [PTK=3DCCMP GTK=3DCCMP]
Aug 17 15:36:25 pi5 wpa_supplicant[669]: wlan0: CTRL-EVENT-CONNECTED -
Connection to d8:3a:dd:60:a3:0c completed [id=3D0 id_str=3D]
Aug 17 15:36:25 pi5 NetworkManager[2142]: <info>  [1723926985.6431]
device (wlan0): supplicant interface state: associating -> completed
Aug 17 15:36:25 pi5 NetworkManager[2142]: <info>  [1723926985.6432]
device (wlan0): Activation: (wifi) Stage 2 of 5 (Device Configure)
successfu>
Aug 17 15:36:25 pi5 NetworkManager[2142]: <info>  [1723926985.6433]
device (p2p-dev-wlan0): supplicant management interface state:
associating ->
Aug 17 15:36:25 pi5 NetworkManager[2142]: <info>  [1723926985.6441]
device (wlan0): state change: config -> ip-config (reason 'none',
sys-iface->
Aug 17 15:36:25 pi5 NetworkManager[2142]: <info>  [1723926985.6452]
dhcp4 (wlan0): activation: beginning transaction (timeout in 45
seconds)
Aug 17 15:36:25 pi5 avahi-daemon[542]: Registering new address record
for fe80::d8bd:98f9:b458:1f79 on wlan0.*.
Aug 17 15:36:25 pi5 NetworkManager[2142]: <info>  [1723926985.6629]
dhcp4 (wlan0): state changed new lease, address=3D192.168.5.177

root@pi5(rw):~# wpa_supplicant -v
wpa_supplicant v2.10
Copyright (c) 2003-2022, Jouni Malinen <j@w1.fi> and contributors
root@pi5(rw):~# NetworkManager -V
1.42.4
