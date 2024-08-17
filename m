Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF68C14601F
	for <iwd@lists.linux.dev>; Sat, 17 Aug 2024 23:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723937790; cv=none; b=KnDn3xe146eZKuih4F1w0HjvXyLK+qjagAYs8ZpwJOvuoGWLLv+zgeWoea50dxBXg2VS2hcCYtHHdWVbarFuo45BmNvCXlAj+XBWBPYEqmrAXJ6iiXSl5GUFDjL9jh882jOvmX4ryNDtbVI/5IfayZ9k0s4NkS8xlu5foay2zEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723937790; c=relaxed/simple;
	bh=/jqoex17jxETI8d+gGk5L6D5/2usMKSGUuleczn6Cow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GeKPfe1YafIS8z5lGBmrX90JdYeeoKVRXBmC/w43o4T44b20ecPgN+JeaJyCBFd88lTYAKxkySajAQiU9bmR5GYVTOQr8Hy92BcBSLmTGZCKvRsbiRXVxZsF/jXU0AM1YIwzuV0mCpkEMD/yze6LslgduW3A6kZyKIeXtSV3h5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Amel8441; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Amel8441"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-709346604a7so1556005a34.1
        for <iwd@lists.linux.dev>; Sat, 17 Aug 2024 16:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723937788; x=1724542588; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rlG5qzOXFkAzXk2l2BMhU+goMqvqcH9RZkD2y9oaKA0=;
        b=Amel8441CmjVNl3zF8c47Nxn2QiPmgtRs29u144/hwDyXqAYBpC1g/ckMt+D+IJGzR
         8XnP1Q4+7ER1QSSmjyngsj1MDBFZHno1nHU4qd1/AILPkBMwMB2+1gIW1+YQ5uUZMCLU
         4mEmSGqqAUXg0dd8ZEZ3NhL0O7JLSEieLWwL4CY56PpQ2Dlr0HVl9N/XwlV8O9I9dbsD
         x5JDSMrb+X2LGHXgrJNO7gD6/4M74pfq8sGqmHYvN29JVsrd1LBMwfj80t58ngCSIR3P
         N5tFgDqwinR/R9dKak75n19pS8OL9anB7S02ZJNs+pwP7eZFPwI0YJktbuBuhawoMwWB
         sIWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723937788; x=1724542588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rlG5qzOXFkAzXk2l2BMhU+goMqvqcH9RZkD2y9oaKA0=;
        b=MnaiPPFXhqSiKWOuyCdeLlBgZxG07c02WWiAzG6/8rmL20G8OKPHVEXCMMS9sPjnp+
         WIwGLlVDejsyny3inyBx9rHmes5Ie4MYnufwIvO4InrrCU5aSIAcY+WI1G4dvyS0Eump
         eF87Hjqv5+ow6FEPRdHyXK+Ja5m7MuGtpiShJ1RMxRcROFBcC0hBYPOJv+w+AlfyfOC1
         haH9jamgMDFvXkABdecINMb/uNdhgsGAfWYo6PzvW+iK95LtHr3d5hi257RVHFSr8EN8
         aivNbtgytf8G0QFT4rZXf55TgelJ77ujGF/kcSqWZISOFPdsf+z2N25CMYgIrhfo3CNj
         Oh2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXai0FjLNr3ipZuzY73FtyGpvI5PBiuymH9zs6XfA9TXkXcl9qUb8/L91dw5Z/hzWSV92rOf5eG7wEyQu5MSdwgCwYi
X-Gm-Message-State: AOJu0YxJKAS0OGYTmo+ZubPk28eLkjC1m3RAvGVZ50X0Z10YhbIMNtnW
	rRzjTAx/8NUq7USBSOTqt3RiyTYRhGR6VHrhF0UfCy3kDoMTzKtyM3FFGw7Iz0O9xbR3hfjIdpV
	Xm74qrcn4fgijh5SYJHWWY9V5mKtVxpYFW1Y=
X-Google-Smtp-Source: AGHT+IE+du/SE2TDUFcuV7GsADuIyqlS7OhhDyu9LbrWB7bApRWuH+NQa0G+CnkJb4DCx2kjlEb05hOgQpVt+zOIk0c=
X-Received: by 2002:a05:6830:610e:b0:703:783a:dad5 with SMTP id
 46e09a7af769-70cac8c1e16mr9015956a34.27.1723937787459; Sat, 17 Aug 2024
 16:36:27 -0700 (PDT)
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
 <cf5ba208-58d9-44e8-bd91-0639ea062d5d@gmail.com> <CAG17S_P_QS4wjqrMgtLryrmx2eoJAYJF7SE1AJdOces-cFPacg@mail.gmail.com>
 <CAG17S_PtFp6OWMYAuYouy-ohpAOKNWYafhBamMAg2EnmU5eCuA@mail.gmail.com>
In-Reply-To: <CAG17S_PtFp6OWMYAuYouy-ohpAOKNWYafhBamMAg2EnmU5eCuA@mail.gmail.com>
From: KeithG <ys3al35l@gmail.com>
Date: Sat, 17 Aug 2024 18:36:16 -0500
Message-ID: <CAG17S_N_1pZ74-Rnbm3V1wf8uQb45K_ji=ssbnNwJ1yOANOgQg@mail.gmail.com>
Subject: Re: [Request] iwd to support brcmfmac 'SAE with AUTHENTICATE'
To: James Prestwood <prestwoj@gmail.com>
Cc: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 17, 2024 at 5:03=E2=80=AFPM KeithG <ys3al35l@gmail.com> wrote:
>
> On Sat, Aug 17, 2024 at 3:49=E2=80=AFPM KeithG <ys3al35l@gmail.com> wrote=
:
> >
> > On Mon, Aug 12, 2024 at 6:36=E2=80=AFAM James Prestwood <prestwoj@gmail=
.com> wrote:
> > >
> > > Hi Keith,
> > >
> > > On 8/11/24 6:19 PM, KeithG wrote:
> > > > On Sun, Aug 11, 2024 at 2:38=E2=80=AFPM Denis Kenzior <denkenz@gmai=
l.com> wrote:
> > > >> Hi Keith,
> > > >>
> > > >>>       Supported extended features:
> > > >>>           * [ CQM_RSSI_LIST ]: multiple CQM_RSSI_THOLD records
> > > >>>           * [ DFS_OFFLOAD ]: DFS offload
> > > >>>
> > > >> <snip>
> > > >>
> > > >>> The pcap is uploaded to my gdrive:
> > > >>> https://drive.google.com/file/d/1vIuje60MGFPklcXtSNMi9-IOlV_6sBJ8=
/view?usp=3Ddrivesdk
> > > >> What is the PCAP supposed to show?  There's no Connection attempt =
in there.
> > > >>
> > > >>> Hopefully, this helps to get started.
> > > >>>
> > > >> Anyway, I was curious and snooped on wpa_s from git trying to conn=
ect to an
> > > >> iPhone 12 Personal Hotspot (Maximum Compatibility option off, so i=
t uses SAE).
> > > >> Not a pretty sight.  Firmware fails with errno=3D-52, Invalid exch=
ange.  Has
> > > >> anyone from RPI team actually tested this firmware before pushing =
it out?
> > > >>
> > > >> I also tried the old firmware with SAE_OFFLOAD bits, and that does=
n't work with
> > > >> wpa_s or iwd either.
> > > >>
> > > >> Until someone sends me a iwmon trace showing CMD_EXTERNAL_AUTH exc=
hange working
> > > >> on an WPA3-Personal Only network, I remain skeptical that any of t=
he Cypress
> > > >> firmwares actually work.
> > > >>
> > > >> Regards,
> > > >> -Denis
> > > > Denis,
> > > >
> > > > I did not attempt a connect with that first log. I misunderstood wh=
at
> > > > James was asking for.
> > >
> > > You didn't misunderstand :) I was confused by what I thought brcmfmac
> > > supported but Denis pointed out that the "Device supports SAE with
> > > AUTHENTICATE command" only mean NL80211_FEATURE_SAE was set, not that
> > > CMD_AUTHENTICATE is actually supported (really dumb and confusing, I =
know).
> > >
> > > What is interesting though is even in your pcap CMD_EXTERNAL_AUTH isn=
't
> > > showing up as a supported command.
> > >
> > >      Supported Commands:
> > >          New Interface [7]
> > >          Set Interface [6]
> > >          New Key [11]
> > >          Start AP [15]
> > >          Join IBSS [43]
> > >          Set PMKSA [52]
> > >          Del PMKSA [53]
> > >          Flush PMKSA [54]
> > >          Remain on Channel [55]
> > >          Frame [59]
> > >          Set Wiphy Netns [49]
> > >          Set Channel [65]
> > >          Start Sched Scan [75]
> > >          Start P2P Device [89]
> > >          Connect [46]
> > >          Disconnect [48]
> > >          Crit Protocol Start [98]
> > >          Crit Protocol Stop [99]
> > >          Update Connect Params [122]
> > >
> > > So I'm even more confused now. But as Denis said, we do need a iwmon
> > > pcap of wpa_supplicant working I think to see how its actually
> > > connecting successfully.
> > >
> > > Thanks,
> > >
> > > James
> > >
> > > >   I tried connecting
> > > > with my Samsung phone and was able to connect so it seems that the =
AP
> > > > is working and allows a
> > > > connection from my phone.
> > > >
> > > > I tried to connect from the Pi with iwctl:
> > > > https://drive.google.com/file/d/1f1jnD0EUOJSaJXd8l7uYG9nisAxCPeo4/v=
iew?usp=3Ddrivesdk
> > > >
> > > > I uninstalled iwd, installed wpa_supplicant (built from git) reboot=
ed
> > > > and tried to connect with connman and collected another pcap and it
> > > > did not connect:
> > > > https://drive.google.com/file/d/1zuVSF0xu4Nk2fN9ketBSv1tiquT-Sc-p/v=
iew?usp=3Ddrivesdk
> > > >
> > > > I then tried from wpa_cli and did not connect. I tried again with a
> > > > wpa_supplicant.conf and also could not connect.
> > > >
> > > > Now I am trying to figure out what I did to allow this connection t=
o a
> > > > sae AP... Now that I have nlmon
> > > > module and iwmon, I will see if I can re-connect, somehow.
> > > > The brcmfmac is such a pain.
> > > > When I get a wpa3/SAE connection, I will make a pcap and post it.
> > > > I actually was able to make one with wpa_supplicant once and actual=
ly
> > > > passed data, but it does not seem to work today.
> > > >
> > > > Keith
> >
> > I am back at this. Messed around for a *lot* trying to get it to
> > connect via wpa_cli and connman and was unable to get it to connect. I
> > find both connman and wpa_supplicant so tough to figure out what I am
> > supposed to do to get it to work. I was able to, once, get wpa_cli to
> > connect via wpa3 a while back, but no more. It does not appear that
> > the current git version nor the default version of connman allow an
> > SAE connection on the Pi...
> >
> > Finally, I was able to get it to connect using the current, default
> > RPiOS wpa_supplicant and nmcli on a Pi5. No purpose built packages.
> > just the defaults. Now to see if I can get it to work on the one I
> > built using the later kernel that I built with the nlmon module. If I
> > have luck, I'll post a log.
> >
> > On the hostapd computer:
> > Aug 17 15:36:25 jackson hostapd[2204]: ap0: AP-STA-CONNECTED d8:3a:dd:d=
2:ae:3c
> > Aug 17 15:36:25 jackson hostapd[2204]: ap0: STA d8:3a:dd:d2:ae:3c
> > RADIUS: starting accounting session ACB7F795BBC8FF5E
> > Aug 17 15:36:25 jackson hostapd[2204]: ap0: STA d8:3a:dd:d2:ae:3c WPA:
> > pairwise key handshake completed (RSN)
> > Aug 17 15:36:25 jackson hostapd[2204]: ap0: EAPOL-4WAY-HS-COMPLETED
> > d8:3a:dd:d2:ae:3c
> > Aug 17 15:36:25 jackson hostapd[2204]: ap0: STA d8:3a:dd:d2:ae:3c
> > RADIUS: starting accounting session ACB7F795BBC8FF5E
> > Aug 17 15:36:25 jackson hostapd[2204]: ap0: STA d8:3a:dd:d2:ae:3c WPA:
> > pairwise key handshake completed (RSN)
> >
> > and on the Pi:
> > Aug 17 15:36:25 pi5 wpa_supplicant[669]: wlan0: Trying to associate
> > with SSID 'deskSAE'
> > Aug 17 15:36:25 pi5 NetworkManager[2142]: <info>  [1723926985.4925]
> > device (wlan0): supplicant interface state: scanning -> associating
> > Aug 17 15:36:25 pi5 NetworkManager[2142]: <info>  [1723926985.4925]
> > device (p2p-dev-wlan0): supplicant management interface state:
> > scanning -> a>
> > Aug 17 15:36:25 pi5 wpa_supplicant[669]: wlan0: Associated with
> > d8:3a:dd:60:a3:0c
> > Aug 17 15:36:25 pi5 wpa_supplicant[669]: wlan0:
> > CTRL-EVENT-SUBNET-STATUS-UPDATE status=3D0
> > Aug 17 15:36:25 pi5 wpa_supplicant[669]: wlan0: WPA: Key negotiation
> > completed with d8:3a:dd:60:a3:0c [PTK=3DCCMP GTK=3DCCMP]
> > Aug 17 15:36:25 pi5 wpa_supplicant[669]: wlan0: CTRL-EVENT-CONNECTED -
> > Connection to d8:3a:dd:60:a3:0c completed [id=3D0 id_str=3D]
> > Aug 17 15:36:25 pi5 NetworkManager[2142]: <info>  [1723926985.6431]
> > device (wlan0): supplicant interface state: associating -> completed
> > Aug 17 15:36:25 pi5 NetworkManager[2142]: <info>  [1723926985.6432]
> > device (wlan0): Activation: (wifi) Stage 2 of 5 (Device Configure)
> > successfu>
> > Aug 17 15:36:25 pi5 NetworkManager[2142]: <info>  [1723926985.6433]
> > device (p2p-dev-wlan0): supplicant management interface state:
> > associating ->
> > Aug 17 15:36:25 pi5 NetworkManager[2142]: <info>  [1723926985.6441]
> > device (wlan0): state change: config -> ip-config (reason 'none',
> > sys-iface->
> > Aug 17 15:36:25 pi5 NetworkManager[2142]: <info>  [1723926985.6452]
> > dhcp4 (wlan0): activation: beginning transaction (timeout in 45
> > seconds)
> > Aug 17 15:36:25 pi5 avahi-daemon[542]: Registering new address record
> > for fe80::d8bd:98f9:b458:1f79 on wlan0.*.
> > Aug 17 15:36:25 pi5 NetworkManager[2142]: <info>  [1723926985.6629]
> > dhcp4 (wlan0): state changed new lease, address=3D192.168.5.177
> >
> > root@pi5(rw):~# wpa_supplicant -v
> > wpa_supplicant v2.10
> > Copyright (c) 2003-2022, Jouni Malinen <j@w1.fi> and contributors
> > root@pi5(rw):~# NetworkManager -V
> > 1.42.4
>
> So with that same configuration but on the Pi3B+ running the kernel
> with the proper module, I was able to get a pcap of a connection to an
> wpa3/sae SSID.
> It is attached. So, the current default install on the RPis that run
> the brcmfmac card identified as this:
>
> [    6.473673] brcmfmac: brcmf_fw_alloc_request: using
> brcm/brcmfmac43455-sdio for chip BCM4345/6
> [    6.841681] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4345/6
> wl0: Aug 29 2023 01:47:08 version 7.45.265 (28bca26 CY) FWID
> 01-b677b91b
>
> will connect to an SAE authenticated ssid with nmcli and wpa_supplicant
>
> Keith

Also, just noticed this in the log:
Aug 17 18:33:04 pi5 iwd[2089]: SAE unsupported: brcmfmac needs
CMD_EXTERNAL_AUTH for SAE
Aug 17 18:33:18 pi5 iwd[2089]: SAE unsupported: brcmfmac needs
CMD_EXTERNAL_AUTH for SAE
Aug 17 18:33:25 pi5 iwd[2089]: SAE unsupported: brcmfmac needs
CMD_EXTERNAL_AUTH for SAE
Aug 17 18:33:48 pi5 iwd[2089]: SAE unsupported: brcmfmac needs
CMD_EXTERNAL_AUTH for SAE
Aug 17 18:33:54 pi5 iwd[2089]: SAE unsupported: brcmfmac needs
CMD_EXTERNAL_AUTH for SAE
Aug 17 18:34:04 pi5 iwd[2089]: SAE unsupported: brcmfmac needs
CMD_EXTERNAL_AUTH for SAE
Aug 17 18:34:34 pi5 iwd[2089]: SAE unsupported: brcmfmac needs
CMD_EXTERNAL_AUTH for SAE
Aug 17 18:34:41 pi5 iwd[2089]: SAE unsupported: brcmfmac needs
CMD_EXTERNAL_AUTH for SAE
Aug 17 18:34:47 pi5 iwd[2089]: SAE unsupported: brcmfmac needs
CMD_EXTERNAL_AUTH for SAE
