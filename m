Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955B21E492
	for <iwd@lists.linux.dev>; Mon,  6 May 2024 22:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715035264; cv=none; b=bSvA6TIzVtXhMjIcmuTNXtf3Li8EJV3YsSEoZ+oAbrnY+V+VMP6pf/ACwe/nQ9+SvnpMuQkCdaBi2K18i0uCIDLhfjjKglnVQDRMM7QjTCOaLGnJCIJOzEwETFwU953mGf/gPUhl3dAN0/LGAM+TIzKyKAyS60LQcs1I2SkYi2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715035264; c=relaxed/simple;
	bh=qD6jO3ahzORgrL69NWDZXE7+gxe1Z4EWUpTLaphjQ/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cNjtjymWXvGcTPBPCW/XbBxWRl6L1OmDIJX+q9xISuwLnIWlNhKrHA3I1cVtdlTDJgQEf4ZLlPqA8PLPL2Qcn8xBAB0tjEvKzwscLpkIRcMHQIPzMJo9Blg9TPYJa4l3DQ9IpghUgbOE0LCrNQIRzAIq5WbMpB1qLSjcaiwqpIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qi6WyYd0; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qi6WyYd0"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-de46b113a5dso2629272276.3
        for <iwd@lists.linux.dev>; Mon, 06 May 2024 15:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715035261; x=1715640061; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s5x58IP1wTlJv/cyjEmExlw7B0hDhJSP47ltwL77Gs0=;
        b=Qi6WyYd0MOpTgU8OxkF4fS8s3r3yx2BK6xsmfTgPVXhimBwK69+Y3eoMvLb/wexhpN
         8pTpVauy0yaNdT6OzzvkNkiAUYfeuhGorrblsMpQyOiv4tteYimqWHcye/0P9izs99i0
         NC1fdLmdnenICQj/p+07Bif3MFuGyFLURAukboBWTS2rK17L5dwM1J3PRM2hq0wyGbO8
         QWhalSpdIqaMppk/cZs9VklPZqr0eBNSmPtNSzDEEDUKTtlsSZtTqX1xLcuBQLa2Ubo1
         6wjkKZRBlzyXbWkqtg6B6KULvl4h09QhlZ9tM9ZaAR7QunVGNJr3JctZ2M8A1nfzlgug
         FGDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715035261; x=1715640061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s5x58IP1wTlJv/cyjEmExlw7B0hDhJSP47ltwL77Gs0=;
        b=WZgLi12MFxP2pEGK+lZ1K1fepoxckO7UEDMKFtzwQgGL1NbNL7NLXEJ8B41EnJUXTe
         MW+uoM04/V42/gNdOdTgNmX4wDBfbOOelDWjHUU58j6Kel90tUDvOzKGiP+q0glT8C1w
         CWOHX2IIod9nRapqUFNPR91SRZoVjNarCe51w2R9uRTadGY4/ZTwIM3XrP2xl3WEv21u
         vhgV30FTIFk5HbAVMO2yPbLH2ILxDLqHVV6VimQXcFwRuOoajKmRf15vRui4HYwbsgEd
         hqALsLNAapLOCikSIP4D+0s7LKzt5gbNhhkHpkJ/7ua7uaCih/Bq3sTsAb5giIzoQzqI
         65ig==
X-Gm-Message-State: AOJu0YzviN0aFZb65Qt7cFNL7z54rzSaKRULgcxvkix9SIk9T5YhG23r
	6sRiGPoMtNmoKjpDCp1/gu2OPv5ZnJxXsF5EE8cRdFOqFmWO5lRRgyJG7aNwVNUFsnsmhnVO12z
	41sw4NBcKHtlqMfCob+7owqd5RAzXn9Ht
X-Google-Smtp-Source: AGHT+IGjwtSrSkODfA6nBuCtbByzezCEWbRZnNCZIzvhBhhW1PNIdwyCu0gt0XuuNv7PfUGtvFv0ANocAVkbvz4jX/Y=
X-Received: by 2002:a25:dc8e:0:b0:dda:a550:4e92 with SMTP id
 y136-20020a25dc8e000000b00ddaa5504e92mr12046458ybe.46.1715035261106; Mon, 06
 May 2024 15:41:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CADvTj4qmJm_Lyk5bR_WZE8TioVa5f0MHdtDghJdRX=9ZhivzjA@mail.gmail.com>
 <7fd93025-1bb2-46a9-aefc-3e74942164b9@gmail.com> <CADvTj4pHyYewHzSUF+546JPO6Y0Co+QfFcBbJEctNWQBNJmb=A@mail.gmail.com>
 <73d7295e-44e1-42ff-9d45-9effa65a0698@gmail.com>
In-Reply-To: <73d7295e-44e1-42ff-9d45-9effa65a0698@gmail.com>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 6 May 2024 16:40:49 -0600
Message-ID: <CADvTj4oH4PjcD=0QXYT6BTEpQhtONr6QsT1mp+nmcG4Uc10c+g@mail.gmail.com>
Subject: Re: NetworkManager connection gets stuck in pending state when
 bringing up AP mode connection with IWD backend
To: James Prestwood <prestwoj@gmail.com>
Cc: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 2:49=E2=80=AFPM James Prestwood <prestwoj@gmail.com>=
 wrote:
>
> Hi,
>
> On 5/6/24 1:34 PM, James Hilliard wrote:
> > On Mon, May 6, 2024 at 2:15=E2=80=AFPM James Prestwood <prestwoj@gmail.=
com> wrote:
> >> Hi James,
> >>
> >> On 5/6/24 12:11 PM, James Hilliard wrote:
> >>> It's a bit unclear if this is a NetworkManager bug or an IWD bug but
> >>> I'm unable to successfully bring up AP mode connection in
> >>> NetworkManager when using the IWD backend.
> >>>
> >>> It appears that NetworkManager fails to recognize that IWD has brough=
t
> >>> up the AP successfully for some reason even though the AP is
> >>> active(i.e. devices can connect to the AP). This results in
> >>> NetworkManager failing to appropriately configure the routes needed
> >>> for the AP.
> >>>
> >>> Logs from NetworkManager:
> >>> <debug> [1709938743.1640] device[e4bcd76bde98e8a1] (wlan0):
> >>> Activation: (wifi) Called Start('APSSID').
> >>> <debug> [1709938743.1641] device[e4bcd76bde98e8a1] (wlan0):
> >>> Activation: (wifi) IWD Device.Mode set successfully
> >>> <debug> [1709938743.1644] device[e4bcd76bde98e8a1] (wlan0):
> >>> remove_pending_action (1): 'recheck-available'
> >>> <trace> [1709938743.2594] platform: (wlan0) emit signal
> >>> ip4-address-changed added: 192.168.45.129/28 brd 0.0.0.0 lft forever
> >>> pref forever lifetime 1235-0[4294967295,4294967295] dev 5 flags
> >>> permanent src kernel
> >>> <debug> [1709938743.2595] platform: (wlan0) signal: address 4   added=
:
> >>> 192.168.45.129/28 brd 0.0.0.0 lft forever pref forever lifetime
> >>> 1235-0[4294967295,4294967295] dev 5 flags permanent src kernel
> >>> <trace> [1709938743.2598] platform: (wlan0) emit signal
> >>> ip4-route-changed added: type local table 255 192.168.45.129/32 dev 5
> >>> metric 0 mss 0 rt-src rt-kernel scope host pref-src 192.168.45.129
> >>> <debug> [1709938743.2599] platform: (wlan0) signal: route   4   added=
:
> >>> type local table 255 192.168.45.129/32 dev 5 metric 0 mss 0 rt-src
> >>> rt-kernel scope host pref-src 192.168.45.129
> >>> <trace> [1709938743.2602] platform: (wlan0) emit signal
> >>> ip4-route-changed added: type unicast 192.168.45.128/28 dev 5 metric =
0
> >>> mss 0 rt-src rt-kernel rtm_flags linkdown scope link pref-src
> >>> 192.168.45.129
> >>> <debug> [1709938743.2602] platform: (wlan0) signal: route   4   added=
:
> >>> type unicast 192.168.45.128/28 dev 5 metric 0 mss 0 rt-src rt-kernel
> >>> rtm_flags linkdown scope link pref-src 192.168.45.129
> >>> <trace> [1709938743.2609] platform: (wlan0) emit signal link-changed
> >>> changed: 5: wlan0 <UP,LOWER_UP;broadcast,multicast,up,running,lowerup=
>
> >>> mtu 1500 arp 1 wifi? init addrgenmode none addr BC:25:F0:1D:6A:03
> >>> permaddr BC:25:F0:1D:6A:03 brd FF:FF:FF:FF:FF:FF driver rtl8821ae
> >>> tx-queue-len 1000 gso-max-size 65536 gso-max-segs 65535 gro-max-size
> >>> 65536 rx:443,42144 tx:563,224232
> >>> <debug> [1709938743.2610] platform: (wlan0) signal: link changed: 5:
> >>> wlan0 <UP,LOWER_UP;broadcast,multicast,up,running,lowerup> mtu 1500
> >>> arp 1 wifi? init addrgenmode none addr BC:25:F0:1D:6A:03 permaddr
> >>> BC:25:F0:1D:6A:03 brd FF:FF:FF:FF:FF:FF driver rtl8821ae tx-queue-len
> >>> 1000 gso-max-size 65536 gso-max-segs 65535 gro-max-size 65536
> >>> rx:443,42144 tx:563,224232
> >>> <debug> [1709938743.2611] device[e4bcd76bde98e8a1] (wlan0): queued
> >>> link change for ifindex 5
> >>> <info>  [1709938743.2657] device (wlan0): Activation: (wifi) Stage 2
> >>> of 5 (Device Configure) successful.  Started 'APSSID'.
> >>> <debug> [1709938743.2658] device[e4bcd76bde98e8a1] (wlan0):
> >>> activation-stage: schedule activate_stage3_ip_config
> >>> <debug> [1709938743.2659] device[e4bcd76bde98e8a1] (wlan0):
> >>> activation-stage: invoke activate_stage3_ip_config
> >>> <debug> [1709938743.2660] device[e4bcd76bde98e8a1] (wlan0):
> >>> activation-stage: synchronously invoke activate_stage3_ip_config
> >>> <debug> [1709938743.2661] device[e4bcd76bde98e8a1] (wlan0): ip4:
> >>> required-timeout: disabled
> >>> <debug> [1709938743.2661] device[e4bcd76bde98e8a1] (wlan0): ip6:
> >>> required-timeout: disabled
> >>> <debug> [1709938743.2662] active-connection[c8d123b3d4d3f96d]: set
> >>> state-flags layer2-ready (was none)
> >>> <info>  [1709938743.2664] device (wlan0): state change: config ->
> >>> ip-config (reason 'none', sys-iface-state: 'managed')
> >>> <debug> [1709938743.2699] device[e4bcd76bde98e8a1] (wlan0):
> >>> add_pending_action (2): 'in-state-change'
> >>> <debug> [1709938743.2704] device[e4bcd76bde98e8a1] (wlan0):
> >>> remove_pending_action (1): 'in-state-change'
> >>> <info>  [1709938743.2709] device (wlan0): IWD AP/AdHoc state is now S=
tarted
> >>> <trace> [1709938743.2710] device[e4bcd76bde98e8a1] (wlan0): ip4:
> >>> check-state: state pending =3D> pending, is_failed=3D0, is_pending=3D=
0,
> >>> is_started=3D0 temp_na=3D0, may-fail-4=3D1, may-fail-6=3D1;;;
> >>> <trace> [1709938743.2710] device[e4bcd76bde98e8a1] (wlan0): ip:
> >>> check-state: (combined) state pending =3D> pending
> >>> <trace> [1709938743.2711] device[e4bcd76bde98e8a1] (wlan0): ip6:
> >>> check-state: state pending =3D> pending, is_failed=3D0, is_pending=3D=
0,
> >>> is_started=3D0 temp_na=3D0, may-fail-4=3D1, may-fail-6=3D1;;;
> >>> <trace> [1709938743.2711] device[e4bcd76bde98e8a1] (wlan0): ip:
> >>> check-state: (combined) state pending =3D> pending
> >>>
> >>> NetworkManager bug report with some more details:
> >>> https://gitlab.freedesktop.org/NetworkManager/NetworkManager/-/issues=
/1498
> >> This does seem like an NM bug if your able to connect to the AP. That
> >> means IWD is doing its part. Fwiw I just tried using NM 1.36.6 and IWD
> >> 2.16 and was able to connect with my phone, saw it had an IP etc.
> > Yeah, it does get an IP for me as well, but routes are not configured s=
o
> > no internet for the connecting device. What's unclear is how NM is supp=
osed
> > to detect this state change, does it do that over dbus or something?
> >
> > Does NM also report a pending state for you?
>
> I'm not very familiar with NM to be honest, but is this what your
> looking for?

Can you see what the NM logs show when bringing up the connection?

I think you may need to enable trace logging like this or something:
nmcli general logging level TRACE domains ALL

>
> jprestwood@LOCLAP699:~$ nmcli device show wlan0
> GENERAL.DEVICE:                       wlan0
> GENERAL.TYPE:                           wifi
> GENERAL.HWADDR:                    <MAC>
> GENERAL.MTU:                           1500
> GENERAL.STATE:                         100 (connected)
> GENERAL.CONNECTION:             Hotspot
> GENERAL.CON-PATH: /org/freedesktop/NetworkManager/ActiveConnection/12
> IP4.ADDRESS[1]:                        10.42.0.1/24
> IP4.ADDRESS[2]:                        192.168.135.17/28
> IP4.GATEWAY:                              --
> IP4.ROUTE[1]:                            dst =3D 10.42.0.0/24, nh =3D
> 0.0.0.0, mt =3D 600
> IP4.ROUTE[2]:                            dst =3D 169.254.0.0/16, nh =3D
> 0.0.0.0, mt =3D 1000
> IP4.ROUTE[3]:                            dst =3D 192.168.135.16/28, nh =
=3D
> 0.0.0.0, mt =3D 0
> IP6.ADDRESS[1]: fe80::ae2e:3bf6:3828:d928/64
> IP6.GATEWAY:                             --
> IP6.ROUTE[1]:                            dst =3D fe80::/64, nh =3D ::, mt=
 =3D 1024
>
> My phone has a 192. address so I assume ROUTE[3] is the right route?

Hmm, can it reach the internet or devices not on the 192 network?

>
> Thanks,
>
> James
>
> >
> >> Thanks,
> >>
> >> James
> >>
