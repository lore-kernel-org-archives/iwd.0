Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F32FE570
	for <iwd@lists.linux.dev>; Tue,  7 May 2024 17:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715104063; cv=none; b=WiXnbfoo2WUUZLWcLReIpSXQ7d2h20+kjEAwxkqywi62oY/6a1uTtOwqc/Aal0xtQOr1GT9TN0kr+q5HKgEw4K6uIFNzf2KJ3WDFhD3y4pCnqo9rFry24SIUGw3o1Z6Kz8h9kBtDSbg2XvpUbDvbyb9Im/e5zV2OiWlYdGHg3KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715104063; c=relaxed/simple;
	bh=oIfXDvfJiDBgQ5j4bwBiST2VeAnsAhvyRjXc1p6mV6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N+kVjnv2KRLk3+EaBLs3wJwE/Ay6twRy+4BYlyjb1E1dRtnVfntea10yiU4sbztR/qSL0COppKalnrSk5ZqRpfaQRGgheLRZbapnjtDXHwz+7Sk5jx/m2+EpoH0xNfqSQestDmEtaB6wUd5D7rw6Xa5qhCrHjHoqrFAr3U5wr+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WXPWTDxC; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXPWTDxC"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-deb99fa47c3so1905808276.2
        for <iwd@lists.linux.dev>; Tue, 07 May 2024 10:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715104061; x=1715708861; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G/avt37PQxvtzBPq84wFHxYoNXiu5k5KHLxmRsIFORk=;
        b=WXPWTDxCNqgAoYHHXHcIclaCZgQ2T2KCrvunsMu9o+HVjCAvHrEZbns3v5TVLvxvAR
         3W6OjGsvMj4b+o4gJcJXSRnPrMtZDCmjWEz73+uJnTJQXqEXjJxagocFIyBmJcjf6hCy
         Nl0P8NsUAyW4fJB/Qq3cTfuGFQ6aa8tKVe4P50CHAABRPcyQCVnZG9CDcf+GaTv/pM5E
         T5mXvvt+kF4Pah1VfI95fpF9k/pI3ae1FhhIZca1QMJOMIFZrk7tMbshbDMXHbXxS01C
         UUHdsCCmo3g7a6+S4r70mSNrBWmxS92LvCiXd7LQQZNUpqEzTrjIp0zog6McbNUFTcr5
         sJIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715104061; x=1715708861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G/avt37PQxvtzBPq84wFHxYoNXiu5k5KHLxmRsIFORk=;
        b=H2k9Si8ZiFTVMM0Yh/4yNuygieEDaLheV2A3JFpBgFARuiYME4UV8M2XBGEkLNspUK
         NfLNhFVTInBiARJ85ztmBY7akiUPNeXEvdMKRVo/1FC3RHliManhyOkX8p7mDs9R8Nm/
         ZUP5y4iIlpauTPKefsD0kXRXXvtpy7/G2rnK/HX920M/SBTuFvDyHLtj7mOxnrkbwYmy
         PmHrtvjI9BQW8OvON1gp/s7WJwqx37PO7uWy919cVo83qQkE+LflEJfX807Iq0awbn0P
         Z348UowHyovOExV/5Y6ryMD2r3pxMAguymGfng9x+gBtSS1XYkhyehZ3X2N6kgB3ASHP
         OayA==
X-Gm-Message-State: AOJu0YwTg8xJnORlDePkjXiNqAnDcCYHuwuCqUVBa/I6D1h6AvPqqdIC
	vJZIGPACPfmWBpxROiEgbNpZ9oaNW/tX0RCs+058r0DLL551kP3Ky3s4gMTi1nMMn80ErXGiOlk
	5Huei98lAUVwsVx1pHU2CRyVeC0KdhA==
X-Google-Smtp-Source: AGHT+IGbsG5uVVUOtAeoPwdE2TATyLtJgHNiGRDdWkx2j5JS4VRPenXZM7tPfYV7LZORyShlJ8dtlH/jynFysIqkDTw=
X-Received: by 2002:a25:6988:0:b0:dcf:f9bd:fe05 with SMTP id
 3f1490d57ef6-debb9e2c4d4mr373200276.48.1715104060889; Tue, 07 May 2024
 10:47:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CADvTj4qmJm_Lyk5bR_WZE8TioVa5f0MHdtDghJdRX=9ZhivzjA@mail.gmail.com>
 <7fd93025-1bb2-46a9-aefc-3e74942164b9@gmail.com> <CADvTj4pHyYewHzSUF+546JPO6Y0Co+QfFcBbJEctNWQBNJmb=A@mail.gmail.com>
 <73d7295e-44e1-42ff-9d45-9effa65a0698@gmail.com> <CADvTj4oH4PjcD=0QXYT6BTEpQhtONr6QsT1mp+nmcG4Uc10c+g@mail.gmail.com>
 <3e5c8d35-b08c-4906-ae06-7a5d511d518a@gmail.com> <CADvTj4qvEniwLnox8dZeqsDRbrBZfiqbKoCPxgRRNVu8sDBWBA@mail.gmail.com>
 <82696cf2-9bad-4cc6-a302-f3797efc6d1e@gmail.com>
In-Reply-To: <82696cf2-9bad-4cc6-a302-f3797efc6d1e@gmail.com>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 7 May 2024 11:47:29 -0600
Message-ID: <CADvTj4rOr3p80nTg3ACqQMzse6HFWfijFQYwKj+eonyCLz_V2Q@mail.gmail.com>
Subject: Re: NetworkManager connection gets stuck in pending state when
 bringing up AP mode connection with IWD backend
To: James Prestwood <prestwoj@gmail.com>
Cc: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 11:36=E2=80=AFAM James Prestwood <prestwoj@gmail.com=
> wrote:
>
>
> On 5/7/24 10:15 AM, James Hilliard wrote:
> > On Tue, May 7, 2024 at 5:41=E2=80=AFAM James Prestwood <prestwoj@gmail.=
com> wrote:
> >>
> >> On 5/6/24 3:40 PM, James Hilliard wrote:
> >>> On Mon, May 6, 2024 at 2:49=E2=80=AFPM James Prestwood <prestwoj@gmai=
l.com> wrote:
> >>>> Hi,
> >>>>
> >>>> On 5/6/24 1:34 PM, James Hilliard wrote:
> >>>>> On Mon, May 6, 2024 at 2:15=E2=80=AFPM James Prestwood <prestwoj@gm=
ail.com> wrote:
> >>>>>> Hi James,
> >>>>>>
> >>>>>> On 5/6/24 12:11 PM, James Hilliard wrote:
> >>>>>>> It's a bit unclear if this is a NetworkManager bug or an IWD bug =
but
> >>>>>>> I'm unable to successfully bring up AP mode connection in
> >>>>>>> NetworkManager when using the IWD backend.
> >>>>>>>
> >>>>>>> It appears that NetworkManager fails to recognize that IWD has br=
ought
> >>>>>>> up the AP successfully for some reason even though the AP is
> >>>>>>> active(i.e. devices can connect to the AP). This results in
> >>>>>>> NetworkManager failing to appropriately configure the routes need=
ed
> >>>>>>> for the AP.
> >>>>>>>
> >>>>>>> Logs from NetworkManager:
> >>>>>>> <debug> [1709938743.1640] device[e4bcd76bde98e8a1] (wlan0):
> >>>>>>> Activation: (wifi) Called Start('APSSID').
> >>>>>>> <debug> [1709938743.1641] device[e4bcd76bde98e8a1] (wlan0):
> >>>>>>> Activation: (wifi) IWD Device.Mode set successfully
> >>>>>>> <debug> [1709938743.1644] device[e4bcd76bde98e8a1] (wlan0):
> >>>>>>> remove_pending_action (1): 'recheck-available'
> >>>>>>> <trace> [1709938743.2594] platform: (wlan0) emit signal
> >>>>>>> ip4-address-changed added: 192.168.45.129/28 brd 0.0.0.0 lft fore=
ver
> >>>>>>> pref forever lifetime 1235-0[4294967295,4294967295] dev 5 flags
> >>>>>>> permanent src kernel
> >>>>>>> <debug> [1709938743.2595] platform: (wlan0) signal: address 4   a=
dded:
> >>>>>>> 192.168.45.129/28 brd 0.0.0.0 lft forever pref forever lifetime
> >>>>>>> 1235-0[4294967295,4294967295] dev 5 flags permanent src kernel
> >>>>>>> <trace> [1709938743.2598] platform: (wlan0) emit signal
> >>>>>>> ip4-route-changed added: type local table 255 192.168.45.129/32 d=
ev 5
> >>>>>>> metric 0 mss 0 rt-src rt-kernel scope host pref-src 192.168.45.12=
9
> >>>>>>> <debug> [1709938743.2599] platform: (wlan0) signal: route   4   a=
dded:
> >>>>>>> type local table 255 192.168.45.129/32 dev 5 metric 0 mss 0 rt-sr=
c
> >>>>>>> rt-kernel scope host pref-src 192.168.45.129
> >>>>>>> <trace> [1709938743.2602] platform: (wlan0) emit signal
> >>>>>>> ip4-route-changed added: type unicast 192.168.45.128/28 dev 5 met=
ric 0
> >>>>>>> mss 0 rt-src rt-kernel rtm_flags linkdown scope link pref-src
> >>>>>>> 192.168.45.129
> >>>>>>> <debug> [1709938743.2602] platform: (wlan0) signal: route   4   a=
dded:
> >>>>>>> type unicast 192.168.45.128/28 dev 5 metric 0 mss 0 rt-src rt-ker=
nel
> >>>>>>> rtm_flags linkdown scope link pref-src 192.168.45.129
> >>>>>>> <trace> [1709938743.2609] platform: (wlan0) emit signal link-chan=
ged
> >>>>>>> changed: 5: wlan0 <UP,LOWER_UP;broadcast,multicast,up,running,low=
erup>
> >>>>>>> mtu 1500 arp 1 wifi? init addrgenmode none addr BC:25:F0:1D:6A:03
> >>>>>>> permaddr BC:25:F0:1D:6A:03 brd FF:FF:FF:FF:FF:FF driver rtl8821ae
> >>>>>>> tx-queue-len 1000 gso-max-size 65536 gso-max-segs 65535 gro-max-s=
ize
> >>>>>>> 65536 rx:443,42144 tx:563,224232
> >>>>>>> <debug> [1709938743.2610] platform: (wlan0) signal: link changed:=
 5:
> >>>>>>> wlan0 <UP,LOWER_UP;broadcast,multicast,up,running,lowerup> mtu 15=
00
> >>>>>>> arp 1 wifi? init addrgenmode none addr BC:25:F0:1D:6A:03 permaddr
> >>>>>>> BC:25:F0:1D:6A:03 brd FF:FF:FF:FF:FF:FF driver rtl8821ae tx-queue=
-len
> >>>>>>> 1000 gso-max-size 65536 gso-max-segs 65535 gro-max-size 65536
> >>>>>>> rx:443,42144 tx:563,224232
> >>>>>>> <debug> [1709938743.2611] device[e4bcd76bde98e8a1] (wlan0): queue=
d
> >>>>>>> link change for ifindex 5
> >>>>>>> <info>  [1709938743.2657] device (wlan0): Activation: (wifi) Stag=
e 2
> >>>>>>> of 5 (Device Configure) successful.  Started 'APSSID'.
> >>>>>>> <debug> [1709938743.2658] device[e4bcd76bde98e8a1] (wlan0):
> >>>>>>> activation-stage: schedule activate_stage3_ip_config
> >>>>>>> <debug> [1709938743.2659] device[e4bcd76bde98e8a1] (wlan0):
> >>>>>>> activation-stage: invoke activate_stage3_ip_config
> >>>>>>> <debug> [1709938743.2660] device[e4bcd76bde98e8a1] (wlan0):
> >>>>>>> activation-stage: synchronously invoke activate_stage3_ip_config
> >>>>>>> <debug> [1709938743.2661] device[e4bcd76bde98e8a1] (wlan0): ip4:
> >>>>>>> required-timeout: disabled
> >>>>>>> <debug> [1709938743.2661] device[e4bcd76bde98e8a1] (wlan0): ip6:
> >>>>>>> required-timeout: disabled
> >>>>>>> <debug> [1709938743.2662] active-connection[c8d123b3d4d3f96d]: se=
t
> >>>>>>> state-flags layer2-ready (was none)
> >>>>>>> <info>  [1709938743.2664] device (wlan0): state change: config ->
> >>>>>>> ip-config (reason 'none', sys-iface-state: 'managed')
> >>>>>>> <debug> [1709938743.2699] device[e4bcd76bde98e8a1] (wlan0):
> >>>>>>> add_pending_action (2): 'in-state-change'
> >>>>>>> <debug> [1709938743.2704] device[e4bcd76bde98e8a1] (wlan0):
> >>>>>>> remove_pending_action (1): 'in-state-change'
> >>>>>>> <info>  [1709938743.2709] device (wlan0): IWD AP/AdHoc state is n=
ow Started
> >>>>>>> <trace> [1709938743.2710] device[e4bcd76bde98e8a1] (wlan0): ip4:
> >>>>>>> check-state: state pending =3D> pending, is_failed=3D0, is_pendin=
g=3D0,
> >>>>>>> is_started=3D0 temp_na=3D0, may-fail-4=3D1, may-fail-6=3D1;;;
> >>>>>>> <trace> [1709938743.2710] device[e4bcd76bde98e8a1] (wlan0): ip:
> >>>>>>> check-state: (combined) state pending =3D> pending
> >>>>>>> <trace> [1709938743.2711] device[e4bcd76bde98e8a1] (wlan0): ip6:
> >>>>>>> check-state: state pending =3D> pending, is_failed=3D0, is_pendin=
g=3D0,
> >>>>>>> is_started=3D0 temp_na=3D0, may-fail-4=3D1, may-fail-6=3D1;;;
> >>>>>>> <trace> [1709938743.2711] device[e4bcd76bde98e8a1] (wlan0): ip:
> >>>>>>> check-state: (combined) state pending =3D> pending
> >>>>>>>
> >>>>>>> NetworkManager bug report with some more details:
> >>>>>>> https://gitlab.freedesktop.org/NetworkManager/NetworkManager/-/is=
sues/1498
> >>>>>> This does seem like an NM bug if your able to connect to the AP. T=
hat
> >>>>>> means IWD is doing its part. Fwiw I just tried using NM 1.36.6 and=
 IWD
> >>>>>> 2.16 and was able to connect with my phone, saw it had an IP etc.
> >>>>> Yeah, it does get an IP for me as well, but routes are not configur=
ed so
> >>>>> no internet for the connecting device. What's unclear is how NM is =
supposed
> >>>>> to detect this state change, does it do that over dbus or something=
?
> >>>>>
> >>>>> Does NM also report a pending state for you?
> >>>> I'm not very familiar with NM to be honest, but is this what your
> >>>> looking for?
> >>> Can you see what the NM logs show when bringing up the connection?
> >>>
> >>> I think you may need to enable trace logging like this or something:
> >>> nmcli general logging level TRACE domains ALL
> >>>
> >>>> jprestwood@LOCLAP699:~$ nmcli device show wlan0
> >>>> GENERAL.DEVICE:                       wlan0
> >>>> GENERAL.TYPE:                           wifi
> >>>> GENERAL.HWADDR:                    <MAC>
> >>>> GENERAL.MTU:                           1500
> >>>> GENERAL.STATE:                         100 (connected)
> >>>> GENERAL.CONNECTION:             Hotspot
> >>>> GENERAL.CON-PATH: /org/freedesktop/NetworkManager/ActiveConnection/1=
2
> >>>> IP4.ADDRESS[1]:                        10.42.0.1/24
> >>>> IP4.ADDRESS[2]:                        192.168.135.17/28
> >>>> IP4.GATEWAY:                              --
> >>>> IP4.ROUTE[1]:                            dst =3D 10.42.0.0/24, nh =
=3D
> >>>> 0.0.0.0, mt =3D 600
> >>>> IP4.ROUTE[2]:                            dst =3D 169.254.0.0/16, nh =
=3D
> >>>> 0.0.0.0, mt =3D 1000
> >>>> IP4.ROUTE[3]:                            dst =3D 192.168.135.16/28, =
nh =3D
> >>>> 0.0.0.0, mt =3D 0
> >>>> IP6.ADDRESS[1]: fe80::ae2e:3bf6:3828:d928/64
> >>>> IP6.GATEWAY:                             --
> >>>> IP6.ROUTE[1]:                            dst =3D fe80::/64, nh =3D :=
:, mt =3D 1024
> >>>>
> >>>> My phone has a 192. address so I assume ROUTE[3] is the right route?
> >>> Hmm, can it reach the internet or devices not on the 192 network?
> >> I wasn't able to test this yesterday, but with my laptop now on eth I
> >> see the same behavior. I get not internet connection from the hotspot.
> >> Still, this does seem like a NM bug because in this context IWD isn't
> >> doing anything with IPs/routes. As far as wifi is concerned IWD is
> >> operating correctly. Does this work with wpa_supplicant for you?
> > Yeah, I suspect it's a NM bug but I'm thinking it could in theory be an=
 IWD
> > issue if NM is expecting some sort of notification from IWD that IWD is=
n't
> > sending correctly(I don't really understand how the applications interf=
ace
> > with each other well enough however to say one way or another with any
> > reasonable degree of confidence).
> Yeah perhaps. The only notification IWD provides is after it starts the
> AP, just via the DBus reply. From what I could see the route did exist
> when I tested it maybe it just wasn't set up correctly.
> > I've tested with wpa_supplication which does not have this issue, altho=
ugh
> > I've seen an unrelated issue with wpa_supplication(encryption doesn't w=
ork)
> > but when creating an unencrypted AP network everything seems to work ok
> > with wpa_supplicant as the routes do get set up there.
> Hmm, its probably a NM/IWD interaction issue then. I'd have to take a
> look at the NM code, but from what I could see it seemed to be acting
> like IWD was working. Said the hotspot was running and everything...

Is there any detailed documentation/references on how the DBus API
interface between NM/IWD is supposed to work?

> >
> >>>> Thanks,
> >>>>
> >>>> James
> >>>>
> >>>>>> Thanks,
> >>>>>>
> >>>>>> James
> >>>>>>
