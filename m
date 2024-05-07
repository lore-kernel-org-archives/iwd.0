Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EBC54BFB
	for <iwd@lists.linux.dev>; Tue,  7 May 2024 17:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715102162; cv=none; b=FeXc5R/DYGZrdq9oxQE8iXcFWsRxyvsyWMkgag6E/g4w8SJ9ZPkmyjZs6nMbCgt1S72tXTxUUbr14R4fGOv0OEzyfQUh6dLf796yBeOKWc7d6XmmEft0x1eoCvjn4B9QrFwu+6HGbHGqt/7CuACi+6VACTLcj+pfFIbI+r4z5RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715102162; c=relaxed/simple;
	bh=ODQ9x0qlnaG3vdAIVhSGLJL5tYyW+5te0NWVR7Pp+hs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j/UQ9KTKgsSmTr+dlUkWWs1YNq0i/Et5YOg8HvMKjpPdCChz0EvWPKbBeDYieLM7IC7euUjTFZWb7+B/65BXKjgu1Sjrxc/zOxTTnUwyWU/5A41l7CA12bKJkfa/ugd3EzQTV7kUYM/BZFrhOBxEp+VEj0eoGuEnY8v85MaejaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kTfvcstx; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kTfvcstx"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-43ab76cac73so31615581cf.1
        for <iwd@lists.linux.dev>; Tue, 07 May 2024 10:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715102159; x=1715706959; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hjfoD6dQF69cnqnkeVEpFMQd0hOoZGxWbiKNgs+1cMA=;
        b=kTfvcstxAsK2xPoYTYcMAoyd3wtqFwDjbDCB+uM5JpszVVWkARyChYQVGJ8E1hakCr
         0g5Ul/MausWp0T/p7RhMl6yyEhNON7RcjCi2/cgtvDqeuFfRmvvN72JhtrodJCf2APwt
         PgeU7CtQEijSUWKXyROUgOGs0XYZAz8PhB8z7NuweEjMBagSpPZefoErBFDLOdv58hOv
         IqOQ/v/uxNedO3OxDvF7+P90kttTqF0TkUnBnGfUhjS7TftD81l7asRCoAMZ7R94MzAX
         2VYx7MNJnOxBA6hhsewMnoIyUJixop/SO9qyeyhJ2B/Qi/sor4KtAeTrxpNuZU+lTpu5
         b8hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715102159; x=1715706959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hjfoD6dQF69cnqnkeVEpFMQd0hOoZGxWbiKNgs+1cMA=;
        b=NyqbMLqsbr/oXRIa1zhLWJDe/wT6mpTTw4Xb8/exOGhRvB6WxFuMRwT5SN37hrR4og
         7TSfTRG4NXCLE1pSOajuPCLH/rzaA9gsSQGx9CXsBXBAiHYngpu8c8RnQwy4DgD+8tJc
         3g6OuwhPkVRwX2Z9hn/E2DYrurF1FLsZf04eraD8ISecy95xwM/tHkX5K5D64g91DTPH
         JynAYwGqeatlVlX7LUmKDAydM6VNDpdhRrVZhALDPrh3Voieb/0rxtl/Un8wrtKQ6QRL
         tjaiCJfCbGS8RetTb1MigIsem36m6qi1cl0sYTCRH2kepWX2r76HgEE0xxXWcWdYUC/A
         Sr0Q==
X-Gm-Message-State: AOJu0Yx1+k11hajuLVGH66e+1a56wSTgyZ5h3zsKvd+hmZzCj8EsPfEy
	Z4Dn0SAMI4ey/xFJEzjV/upVr1E2tUaCcesqso3XziynRYcHByzTQ+yzCeZEamdv3dKkIG2zNFg
	9w728pKuLEOOQNGx+I1JYwnqYtYQ=
X-Google-Smtp-Source: AGHT+IH9TtUA1sljDRT4aqPz3ISp5emkrxzyzcdx+oioJUcB6vTst0IaqY0+BCLrtvNiEQiBHrHyP6rutVCaBlQLfc8=
X-Received: by 2002:ac8:5d43:0:b0:437:bedb:3ff with SMTP id
 d75a77b69052e-43d8f5b9940mr59833731cf.27.1715102158860; Tue, 07 May 2024
 10:15:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CADvTj4qmJm_Lyk5bR_WZE8TioVa5f0MHdtDghJdRX=9ZhivzjA@mail.gmail.com>
 <7fd93025-1bb2-46a9-aefc-3e74942164b9@gmail.com> <CADvTj4pHyYewHzSUF+546JPO6Y0Co+QfFcBbJEctNWQBNJmb=A@mail.gmail.com>
 <73d7295e-44e1-42ff-9d45-9effa65a0698@gmail.com> <CADvTj4oH4PjcD=0QXYT6BTEpQhtONr6QsT1mp+nmcG4Uc10c+g@mail.gmail.com>
 <3e5c8d35-b08c-4906-ae06-7a5d511d518a@gmail.com>
In-Reply-To: <3e5c8d35-b08c-4906-ae06-7a5d511d518a@gmail.com>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 7 May 2024 11:15:46 -0600
Message-ID: <CADvTj4qvEniwLnox8dZeqsDRbrBZfiqbKoCPxgRRNVu8sDBWBA@mail.gmail.com>
Subject: Re: NetworkManager connection gets stuck in pending state when
 bringing up AP mode connection with IWD backend
To: James Prestwood <prestwoj@gmail.com>
Cc: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 5:41=E2=80=AFAM James Prestwood <prestwoj@gmail.com>=
 wrote:
>
>
> On 5/6/24 3:40 PM, James Hilliard wrote:
> > On Mon, May 6, 2024 at 2:49=E2=80=AFPM James Prestwood <prestwoj@gmail.=
com> wrote:
> >> Hi,
> >>
> >> On 5/6/24 1:34 PM, James Hilliard wrote:
> >>> On Mon, May 6, 2024 at 2:15=E2=80=AFPM James Prestwood <prestwoj@gmai=
l.com> wrote:
> >>>> Hi James,
> >>>>
> >>>> On 5/6/24 12:11 PM, James Hilliard wrote:
> >>>>> It's a bit unclear if this is a NetworkManager bug or an IWD bug bu=
t
> >>>>> I'm unable to successfully bring up AP mode connection in
> >>>>> NetworkManager when using the IWD backend.
> >>>>>
> >>>>> It appears that NetworkManager fails to recognize that IWD has brou=
ght
> >>>>> up the AP successfully for some reason even though the AP is
> >>>>> active(i.e. devices can connect to the AP). This results in
> >>>>> NetworkManager failing to appropriately configure the routes needed
> >>>>> for the AP.
> >>>>>
> >>>>> Logs from NetworkManager:
> >>>>> <debug> [1709938743.1640] device[e4bcd76bde98e8a1] (wlan0):
> >>>>> Activation: (wifi) Called Start('APSSID').
> >>>>> <debug> [1709938743.1641] device[e4bcd76bde98e8a1] (wlan0):
> >>>>> Activation: (wifi) IWD Device.Mode set successfully
> >>>>> <debug> [1709938743.1644] device[e4bcd76bde98e8a1] (wlan0):
> >>>>> remove_pending_action (1): 'recheck-available'
> >>>>> <trace> [1709938743.2594] platform: (wlan0) emit signal
> >>>>> ip4-address-changed added: 192.168.45.129/28 brd 0.0.0.0 lft foreve=
r
> >>>>> pref forever lifetime 1235-0[4294967295,4294967295] dev 5 flags
> >>>>> permanent src kernel
> >>>>> <debug> [1709938743.2595] platform: (wlan0) signal: address 4   add=
ed:
> >>>>> 192.168.45.129/28 brd 0.0.0.0 lft forever pref forever lifetime
> >>>>> 1235-0[4294967295,4294967295] dev 5 flags permanent src kernel
> >>>>> <trace> [1709938743.2598] platform: (wlan0) emit signal
> >>>>> ip4-route-changed added: type local table 255 192.168.45.129/32 dev=
 5
> >>>>> metric 0 mss 0 rt-src rt-kernel scope host pref-src 192.168.45.129
> >>>>> <debug> [1709938743.2599] platform: (wlan0) signal: route   4   add=
ed:
> >>>>> type local table 255 192.168.45.129/32 dev 5 metric 0 mss 0 rt-src
> >>>>> rt-kernel scope host pref-src 192.168.45.129
> >>>>> <trace> [1709938743.2602] platform: (wlan0) emit signal
> >>>>> ip4-route-changed added: type unicast 192.168.45.128/28 dev 5 metri=
c 0
> >>>>> mss 0 rt-src rt-kernel rtm_flags linkdown scope link pref-src
> >>>>> 192.168.45.129
> >>>>> <debug> [1709938743.2602] platform: (wlan0) signal: route   4   add=
ed:
> >>>>> type unicast 192.168.45.128/28 dev 5 metric 0 mss 0 rt-src rt-kerne=
l
> >>>>> rtm_flags linkdown scope link pref-src 192.168.45.129
> >>>>> <trace> [1709938743.2609] platform: (wlan0) emit signal link-change=
d
> >>>>> changed: 5: wlan0 <UP,LOWER_UP;broadcast,multicast,up,running,lower=
up>
> >>>>> mtu 1500 arp 1 wifi? init addrgenmode none addr BC:25:F0:1D:6A:03
> >>>>> permaddr BC:25:F0:1D:6A:03 brd FF:FF:FF:FF:FF:FF driver rtl8821ae
> >>>>> tx-queue-len 1000 gso-max-size 65536 gso-max-segs 65535 gro-max-siz=
e
> >>>>> 65536 rx:443,42144 tx:563,224232
> >>>>> <debug> [1709938743.2610] platform: (wlan0) signal: link changed: 5=
:
> >>>>> wlan0 <UP,LOWER_UP;broadcast,multicast,up,running,lowerup> mtu 1500
> >>>>> arp 1 wifi? init addrgenmode none addr BC:25:F0:1D:6A:03 permaddr
> >>>>> BC:25:F0:1D:6A:03 brd FF:FF:FF:FF:FF:FF driver rtl8821ae tx-queue-l=
en
> >>>>> 1000 gso-max-size 65536 gso-max-segs 65535 gro-max-size 65536
> >>>>> rx:443,42144 tx:563,224232
> >>>>> <debug> [1709938743.2611] device[e4bcd76bde98e8a1] (wlan0): queued
> >>>>> link change for ifindex 5
> >>>>> <info>  [1709938743.2657] device (wlan0): Activation: (wifi) Stage =
2
> >>>>> of 5 (Device Configure) successful.  Started 'APSSID'.
> >>>>> <debug> [1709938743.2658] device[e4bcd76bde98e8a1] (wlan0):
> >>>>> activation-stage: schedule activate_stage3_ip_config
> >>>>> <debug> [1709938743.2659] device[e4bcd76bde98e8a1] (wlan0):
> >>>>> activation-stage: invoke activate_stage3_ip_config
> >>>>> <debug> [1709938743.2660] device[e4bcd76bde98e8a1] (wlan0):
> >>>>> activation-stage: synchronously invoke activate_stage3_ip_config
> >>>>> <debug> [1709938743.2661] device[e4bcd76bde98e8a1] (wlan0): ip4:
> >>>>> required-timeout: disabled
> >>>>> <debug> [1709938743.2661] device[e4bcd76bde98e8a1] (wlan0): ip6:
> >>>>> required-timeout: disabled
> >>>>> <debug> [1709938743.2662] active-connection[c8d123b3d4d3f96d]: set
> >>>>> state-flags layer2-ready (was none)
> >>>>> <info>  [1709938743.2664] device (wlan0): state change: config ->
> >>>>> ip-config (reason 'none', sys-iface-state: 'managed')
> >>>>> <debug> [1709938743.2699] device[e4bcd76bde98e8a1] (wlan0):
> >>>>> add_pending_action (2): 'in-state-change'
> >>>>> <debug> [1709938743.2704] device[e4bcd76bde98e8a1] (wlan0):
> >>>>> remove_pending_action (1): 'in-state-change'
> >>>>> <info>  [1709938743.2709] device (wlan0): IWD AP/AdHoc state is now=
 Started
> >>>>> <trace> [1709938743.2710] device[e4bcd76bde98e8a1] (wlan0): ip4:
> >>>>> check-state: state pending =3D> pending, is_failed=3D0, is_pending=
=3D0,
> >>>>> is_started=3D0 temp_na=3D0, may-fail-4=3D1, may-fail-6=3D1;;;
> >>>>> <trace> [1709938743.2710] device[e4bcd76bde98e8a1] (wlan0): ip:
> >>>>> check-state: (combined) state pending =3D> pending
> >>>>> <trace> [1709938743.2711] device[e4bcd76bde98e8a1] (wlan0): ip6:
> >>>>> check-state: state pending =3D> pending, is_failed=3D0, is_pending=
=3D0,
> >>>>> is_started=3D0 temp_na=3D0, may-fail-4=3D1, may-fail-6=3D1;;;
> >>>>> <trace> [1709938743.2711] device[e4bcd76bde98e8a1] (wlan0): ip:
> >>>>> check-state: (combined) state pending =3D> pending
> >>>>>
> >>>>> NetworkManager bug report with some more details:
> >>>>> https://gitlab.freedesktop.org/NetworkManager/NetworkManager/-/issu=
es/1498
> >>>> This does seem like an NM bug if your able to connect to the AP. Tha=
t
> >>>> means IWD is doing its part. Fwiw I just tried using NM 1.36.6 and I=
WD
> >>>> 2.16 and was able to connect with my phone, saw it had an IP etc.
> >>> Yeah, it does get an IP for me as well, but routes are not configured=
 so
> >>> no internet for the connecting device. What's unclear is how NM is su=
pposed
> >>> to detect this state change, does it do that over dbus or something?
> >>>
> >>> Does NM also report a pending state for you?
> >> I'm not very familiar with NM to be honest, but is this what your
> >> looking for?
> > Can you see what the NM logs show when bringing up the connection?
> >
> > I think you may need to enable trace logging like this or something:
> > nmcli general logging level TRACE domains ALL
> >
> >> jprestwood@LOCLAP699:~$ nmcli device show wlan0
> >> GENERAL.DEVICE:                       wlan0
> >> GENERAL.TYPE:                           wifi
> >> GENERAL.HWADDR:                    <MAC>
> >> GENERAL.MTU:                           1500
> >> GENERAL.STATE:                         100 (connected)
> >> GENERAL.CONNECTION:             Hotspot
> >> GENERAL.CON-PATH: /org/freedesktop/NetworkManager/ActiveConnection/12
> >> IP4.ADDRESS[1]:                        10.42.0.1/24
> >> IP4.ADDRESS[2]:                        192.168.135.17/28
> >> IP4.GATEWAY:                              --
> >> IP4.ROUTE[1]:                            dst =3D 10.42.0.0/24, nh =3D
> >> 0.0.0.0, mt =3D 600
> >> IP4.ROUTE[2]:                            dst =3D 169.254.0.0/16, nh =
=3D
> >> 0.0.0.0, mt =3D 1000
> >> IP4.ROUTE[3]:                            dst =3D 192.168.135.16/28, nh=
 =3D
> >> 0.0.0.0, mt =3D 0
> >> IP6.ADDRESS[1]: fe80::ae2e:3bf6:3828:d928/64
> >> IP6.GATEWAY:                             --
> >> IP6.ROUTE[1]:                            dst =3D fe80::/64, nh =3D ::,=
 mt =3D 1024
> >>
> >> My phone has a 192. address so I assume ROUTE[3] is the right route?
> > Hmm, can it reach the internet or devices not on the 192 network?
> I wasn't able to test this yesterday, but with my laptop now on eth I
> see the same behavior. I get not internet connection from the hotspot.
> Still, this does seem like a NM bug because in this context IWD isn't
> doing anything with IPs/routes. As far as wifi is concerned IWD is
> operating correctly. Does this work with wpa_supplicant for you?

Yeah, I suspect it's a NM bug but I'm thinking it could in theory be an IWD
issue if NM is expecting some sort of notification from IWD that IWD isn't
sending correctly(I don't really understand how the applications interface
with each other well enough however to say one way or another with any
reasonable degree of confidence).

I've tested with wpa_supplication which does not have this issue, although
I've seen an unrelated issue with wpa_supplication(encryption doesn't work)
but when creating an unencrypted AP network everything seems to work ok
with wpa_supplicant as the routes do get set up there.

> >
> >> Thanks,
> >>
> >> James
> >>
> >>>> Thanks,
> >>>>
> >>>> James
> >>>>
