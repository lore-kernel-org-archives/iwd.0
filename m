Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4E118732F
	for <iwd@lists.linux.dev>; Tue,  7 May 2024 21:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715117219; cv=none; b=btwDXtYXfaBF6imBvwwvSap9tZjYvHQoiYhXy1wP7Ll4Kd3v7JVq+mNQ3SYITJRB2ounpSovs3TTmmSK4FA+M1nnfTZ6UEucOzJaQL5YG4L3sOp5//qFCAE+oCsJ+S0JatHSAmxi3HBJxH4+yJV4LNv1bHaC2DG9LheZqlC+xQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715117219; c=relaxed/simple;
	bh=PfldhUm2DvbM6Va/3BKlN8+LNY8APmTl01qB4pv7LMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bj340yParCh9Uw6/vzJOZDWMj76v5ZlrgmTV0kSRc/WrfV7VInRRvOHdPL9wHPkVvGfdF7VU4RGLrcVpmAThpd8JU6qnsJ5iz+AE89fJdoAY9Xo8+iDrD4qqMeBDslokTvvajfDGV9/M0JfFGKnbAr0O80ZpPT8MNPlxsDFvFXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k3L1Cpul; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k3L1Cpul"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-deb65b541faso3580618276.0
        for <iwd@lists.linux.dev>; Tue, 07 May 2024 14:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715117217; x=1715722017; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eQVfkJ3cgX84eTDLR/XB4PdrMal2HAaS9VWZ1hdLsFg=;
        b=k3L1CpulzxRXJzfQ3d9Ug+sqlNJDpQ5jv8nmavry/r6idg12UqAGBkNDspL0YXldZS
         bGrk/pb8iPY2jeJZ94fl3PBqtX5wnsWUpDxutmKI0xCYz1tnwBIoQfUB69QzNRQqemog
         HI2yi7VqY5m9Zn5UhIlztOoJbYec+zoJ1B69fNSOgAo87qEnxhJX7YDRQQKR5te6+pg+
         m2qkRmwRv8KB+PBfNjXUOYMqDc8SI1gO62zQNx6WWXOZ47HYCZuuU4oVy+Bu7/IthQ7U
         NmxoeqxdwPJrdPuGGc60P7rHaPJN83Q1vwnYrApJ+MbuDP1ZnTzvHyhs0pd1WlDgJNPJ
         5WGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715117217; x=1715722017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eQVfkJ3cgX84eTDLR/XB4PdrMal2HAaS9VWZ1hdLsFg=;
        b=dZeSdgPfRlDYKrXQhmRkOJTTsIOer2iBREtP2Zs0f6+nYyROYpD6NSisl3UOPY8l5e
         ZN/54P3divi6A9qU6LJfCFXFVVXrOYEliMpioB8H1k2OPNU83AvS4m+G3z5iR+j15awE
         lfJ5MIAfdHrjDM7bYfSjfKC9PYtzvAEWFW8I8PR+k43imy+tR39SBZ3ewog5PKekczCC
         6O3oH/EYUTcbGa0rI3A+lRZi00Aw/njEWnre5GVxgbPEwjmEnLtHm7ZnPaBenXLGOhSr
         gVisK5uhOB5LqDNdQXm3DaELwYRUtoZPYi1kC+paQoGqnZmtySX1xtezt40134ZWt+2m
         Cslg==
X-Gm-Message-State: AOJu0Ywzu042PJuQjk1APz0sA09T1pW4N42KMMR4pwV2oUP+49/tt6z0
	wH58RzKbT9BKfJZfVeyb7pdGceqbGcpQlV8iGjdPPWvAZA9FuXHkWUoVI03pvGFjg7rD2jYLSjn
	bE8LWs2NceUxSG+hYO8CHD09iBZJxuDAc
X-Google-Smtp-Source: AGHT+IGzWYn/WdnluEyDDwEB2lHVTdBiJCUTmCyzBVga01IHvEIfst70GqZARL87pvFRibwVbHGhiw04aJlPtbBChvM=
X-Received: by 2002:a25:6fd6:0:b0:ddd:7456:d203 with SMTP id
 3f1490d57ef6-debb9e09be7mr932089276.41.1715117217048; Tue, 07 May 2024
 14:26:57 -0700 (PDT)
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
 <82696cf2-9bad-4cc6-a302-f3797efc6d1e@gmail.com> <CADvTj4rOr3p80nTg3ACqQMzse6HFWfijFQYwKj+eonyCLz_V2Q@mail.gmail.com>
 <8b2156c0-7b98-4bc8-ab1a-5009389e5e83@gmail.com>
In-Reply-To: <8b2156c0-7b98-4bc8-ab1a-5009389e5e83@gmail.com>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 7 May 2024 15:26:45 -0600
Message-ID: <CADvTj4pYPBbvEDBoTnEZacE-Ah7S7wgCBYkJoonUMfac1o64ag@mail.gmail.com>
Subject: Re: NetworkManager connection gets stuck in pending state when
 bringing up AP mode connection with IWD backend
To: James Prestwood <prestwoj@gmail.com>
Cc: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 11:50=E2=80=AFAM James Prestwood <prestwoj@gmail.com=
> wrote:
>
>
> On 5/7/24 10:47 AM, James Hilliard wrote:
> > On Tue, May 7, 2024 at 11:36=E2=80=AFAM James Prestwood <prestwoj@gmail=
.com> wrote:
> >>
> >> On 5/7/24 10:15 AM, James Hilliard wrote:
> >>> On Tue, May 7, 2024 at 5:41=E2=80=AFAM James Prestwood <prestwoj@gmai=
l.com> wrote:
> >>>> On 5/6/24 3:40 PM, James Hilliard wrote:
> >>>>> On Mon, May 6, 2024 at 2:49=E2=80=AFPM James Prestwood <prestwoj@gm=
ail.com> wrote:
> >>>>>> Hi,
> >>>>>>
> >>>>>> On 5/6/24 1:34 PM, James Hilliard wrote:
> >>>>>>> On Mon, May 6, 2024 at 2:15=E2=80=AFPM James Prestwood <prestwoj@=
gmail.com> wrote:
> >>>>>>>> Hi James,
> >>>>>>>>
> >>>>>>>> On 5/6/24 12:11 PM, James Hilliard wrote:
> >>>>>>>>> It's a bit unclear if this is a NetworkManager bug or an IWD bu=
g but
> >>>>>>>>> I'm unable to successfully bring up AP mode connection in
> >>>>>>>>> NetworkManager when using the IWD backend.
> >>>>>>>>>
> >>>>>>>>> It appears that NetworkManager fails to recognize that IWD has =
brought
> >>>>>>>>> up the AP successfully for some reason even though the AP is
> >>>>>>>>> active(i.e. devices can connect to the AP). This results in
> >>>>>>>>> NetworkManager failing to appropriately configure the routes ne=
eded
> >>>>>>>>> for the AP.
> >>>>>>>>>
> >>>>>>>>> Logs from NetworkManager:
> >>>>>>>>> <debug> [1709938743.1640] device[e4bcd76bde98e8a1] (wlan0):
> >>>>>>>>> Activation: (wifi) Called Start('APSSID').
> >>>>>>>>> <debug> [1709938743.1641] device[e4bcd76bde98e8a1] (wlan0):
> >>>>>>>>> Activation: (wifi) IWD Device.Mode set successfully
> >>>>>>>>> <debug> [1709938743.1644] device[e4bcd76bde98e8a1] (wlan0):
> >>>>>>>>> remove_pending_action (1): 'recheck-available'
> >>>>>>>>> <trace> [1709938743.2594] platform: (wlan0) emit signal
> >>>>>>>>> ip4-address-changed added: 192.168.45.129/28 brd 0.0.0.0 lft fo=
rever
> >>>>>>>>> pref forever lifetime 1235-0[4294967295,4294967295] dev 5 flags
> >>>>>>>>> permanent src kernel
> >>>>>>>>> <debug> [1709938743.2595] platform: (wlan0) signal: address 4  =
 added:
> >>>>>>>>> 192.168.45.129/28 brd 0.0.0.0 lft forever pref forever lifetime
> >>>>>>>>> 1235-0[4294967295,4294967295] dev 5 flags permanent src kernel
> >>>>>>>>> <trace> [1709938743.2598] platform: (wlan0) emit signal
> >>>>>>>>> ip4-route-changed added: type local table 255 192.168.45.129/32=
 dev 5
> >>>>>>>>> metric 0 mss 0 rt-src rt-kernel scope host pref-src 192.168.45.=
129
> >>>>>>>>> <debug> [1709938743.2599] platform: (wlan0) signal: route   4  =
 added:
> >>>>>>>>> type local table 255 192.168.45.129/32 dev 5 metric 0 mss 0 rt-=
src
> >>>>>>>>> rt-kernel scope host pref-src 192.168.45.129
> >>>>>>>>> <trace> [1709938743.2602] platform: (wlan0) emit signal
> >>>>>>>>> ip4-route-changed added: type unicast 192.168.45.128/28 dev 5 m=
etric 0
> >>>>>>>>> mss 0 rt-src rt-kernel rtm_flags linkdown scope link pref-src
> >>>>>>>>> 192.168.45.129
> >>>>>>>>> <debug> [1709938743.2602] platform: (wlan0) signal: route   4  =
 added:
> >>>>>>>>> type unicast 192.168.45.128/28 dev 5 metric 0 mss 0 rt-src rt-k=
ernel
> >>>>>>>>> rtm_flags linkdown scope link pref-src 192.168.45.129
> >>>>>>>>> <trace> [1709938743.2609] platform: (wlan0) emit signal link-ch=
anged
> >>>>>>>>> changed: 5: wlan0 <UP,LOWER_UP;broadcast,multicast,up,running,l=
owerup>
> >>>>>>>>> mtu 1500 arp 1 wifi? init addrgenmode none addr BC:25:F0:1D:6A:=
03
> >>>>>>>>> permaddr BC:25:F0:1D:6A:03 brd FF:FF:FF:FF:FF:FF driver rtl8821=
ae
> >>>>>>>>> tx-queue-len 1000 gso-max-size 65536 gso-max-segs 65535 gro-max=
-size
> >>>>>>>>> 65536 rx:443,42144 tx:563,224232
> >>>>>>>>> <debug> [1709938743.2610] platform: (wlan0) signal: link change=
d: 5:
> >>>>>>>>> wlan0 <UP,LOWER_UP;broadcast,multicast,up,running,lowerup> mtu =
1500
> >>>>>>>>> arp 1 wifi? init addrgenmode none addr BC:25:F0:1D:6A:03 permad=
dr
> >>>>>>>>> BC:25:F0:1D:6A:03 brd FF:FF:FF:FF:FF:FF driver rtl8821ae tx-que=
ue-len
> >>>>>>>>> 1000 gso-max-size 65536 gso-max-segs 65535 gro-max-size 65536
> >>>>>>>>> rx:443,42144 tx:563,224232
> >>>>>>>>> <debug> [1709938743.2611] device[e4bcd76bde98e8a1] (wlan0): que=
ued
> >>>>>>>>> link change for ifindex 5
> >>>>>>>>> <info>  [1709938743.2657] device (wlan0): Activation: (wifi) St=
age 2
> >>>>>>>>> of 5 (Device Configure) successful.  Started 'APSSID'.
> >>>>>>>>> <debug> [1709938743.2658] device[e4bcd76bde98e8a1] (wlan0):
> >>>>>>>>> activation-stage: schedule activate_stage3_ip_config
> >>>>>>>>> <debug> [1709938743.2659] device[e4bcd76bde98e8a1] (wlan0):
> >>>>>>>>> activation-stage: invoke activate_stage3_ip_config
> >>>>>>>>> <debug> [1709938743.2660] device[e4bcd76bde98e8a1] (wlan0):
> >>>>>>>>> activation-stage: synchronously invoke activate_stage3_ip_confi=
g
> >>>>>>>>> <debug> [1709938743.2661] device[e4bcd76bde98e8a1] (wlan0): ip4=
:
> >>>>>>>>> required-timeout: disabled
> >>>>>>>>> <debug> [1709938743.2661] device[e4bcd76bde98e8a1] (wlan0): ip6=
:
> >>>>>>>>> required-timeout: disabled
> >>>>>>>>> <debug> [1709938743.2662] active-connection[c8d123b3d4d3f96d]: =
set
> >>>>>>>>> state-flags layer2-ready (was none)
> >>>>>>>>> <info>  [1709938743.2664] device (wlan0): state change: config =
->
> >>>>>>>>> ip-config (reason 'none', sys-iface-state: 'managed')
> >>>>>>>>> <debug> [1709938743.2699] device[e4bcd76bde98e8a1] (wlan0):
> >>>>>>>>> add_pending_action (2): 'in-state-change'
> >>>>>>>>> <debug> [1709938743.2704] device[e4bcd76bde98e8a1] (wlan0):
> >>>>>>>>> remove_pending_action (1): 'in-state-change'
> >>>>>>>>> <info>  [1709938743.2709] device (wlan0): IWD AP/AdHoc state is=
 now Started
> >>>>>>>>> <trace> [1709938743.2710] device[e4bcd76bde98e8a1] (wlan0): ip4=
:
> >>>>>>>>> check-state: state pending =3D> pending, is_failed=3D0, is_pend=
ing=3D0,
> >>>>>>>>> is_started=3D0 temp_na=3D0, may-fail-4=3D1, may-fail-6=3D1;;;
> >>>>>>>>> <trace> [1709938743.2710] device[e4bcd76bde98e8a1] (wlan0): ip:
> >>>>>>>>> check-state: (combined) state pending =3D> pending
> >>>>>>>>> <trace> [1709938743.2711] device[e4bcd76bde98e8a1] (wlan0): ip6=
:
> >>>>>>>>> check-state: state pending =3D> pending, is_failed=3D0, is_pend=
ing=3D0,
> >>>>>>>>> is_started=3D0 temp_na=3D0, may-fail-4=3D1, may-fail-6=3D1;;;
> >>>>>>>>> <trace> [1709938743.2711] device[e4bcd76bde98e8a1] (wlan0): ip:
> >>>>>>>>> check-state: (combined) state pending =3D> pending
> >>>>>>>>>
> >>>>>>>>> NetworkManager bug report with some more details:
> >>>>>>>>> https://gitlab.freedesktop.org/NetworkManager/NetworkManager/-/=
issues/1498
> >>>>>>>> This does seem like an NM bug if your able to connect to the AP.=
 That
> >>>>>>>> means IWD is doing its part. Fwiw I just tried using NM 1.36.6 a=
nd IWD
> >>>>>>>> 2.16 and was able to connect with my phone, saw it had an IP etc=
.
> >>>>>>> Yeah, it does get an IP for me as well, but routes are not config=
ured so
> >>>>>>> no internet for the connecting device. What's unclear is how NM i=
s supposed
> >>>>>>> to detect this state change, does it do that over dbus or somethi=
ng?
> >>>>>>>
> >>>>>>> Does NM also report a pending state for you?
> >>>>>> I'm not very familiar with NM to be honest, but is this what your
> >>>>>> looking for?
> >>>>> Can you see what the NM logs show when bringing up the connection?
> >>>>>
> >>>>> I think you may need to enable trace logging like this or something=
:
> >>>>> nmcli general logging level TRACE domains ALL
> >>>>>
> >>>>>> jprestwood@LOCLAP699:~$ nmcli device show wlan0
> >>>>>> GENERAL.DEVICE:                       wlan0
> >>>>>> GENERAL.TYPE:                           wifi
> >>>>>> GENERAL.HWADDR:                    <MAC>
> >>>>>> GENERAL.MTU:                           1500
> >>>>>> GENERAL.STATE:                         100 (connected)
> >>>>>> GENERAL.CONNECTION:             Hotspot
> >>>>>> GENERAL.CON-PATH: /org/freedesktop/NetworkManager/ActiveConnection=
/12
> >>>>>> IP4.ADDRESS[1]:                        10.42.0.1/24
> >>>>>> IP4.ADDRESS[2]:                        192.168.135.17/28
> >>>>>> IP4.GATEWAY:                              --
> >>>>>> IP4.ROUTE[1]:                            dst =3D 10.42.0.0/24, nh =
=3D
> >>>>>> 0.0.0.0, mt =3D 600
> >>>>>> IP4.ROUTE[2]:                            dst =3D 169.254.0.0/16, n=
h =3D
> >>>>>> 0.0.0.0, mt =3D 1000
> >>>>>> IP4.ROUTE[3]:                            dst =3D 192.168.135.16/28=
, nh =3D
> >>>>>> 0.0.0.0, mt =3D 0
> >>>>>> IP6.ADDRESS[1]: fe80::ae2e:3bf6:3828:d928/64
> >>>>>> IP6.GATEWAY:                             --
> >>>>>> IP6.ROUTE[1]:                            dst =3D fe80::/64, nh =3D=
 ::, mt =3D 1024
> >>>>>>
> >>>>>> My phone has a 192. address so I assume ROUTE[3] is the right rout=
e?
> >>>>> Hmm, can it reach the internet or devices not on the 192 network?
> >>>> I wasn't able to test this yesterday, but with my laptop now on eth =
I
> >>>> see the same behavior. I get not internet connection from the hotspo=
t.
> >>>> Still, this does seem like a NM bug because in this context IWD isn'=
t
> >>>> doing anything with IPs/routes. As far as wifi is concerned IWD is
> >>>> operating correctly. Does this work with wpa_supplicant for you?
> >>> Yeah, I suspect it's a NM bug but I'm thinking it could in theory be =
an IWD
> >>> issue if NM is expecting some sort of notification from IWD that IWD =
isn't
> >>> sending correctly(I don't really understand how the applications inte=
rface
> >>> with each other well enough however to say one way or another with an=
y
> >>> reasonable degree of confidence).
> >> Yeah perhaps. The only notification IWD provides is after it starts th=
e
> >> AP, just via the DBus reply. From what I could see the route did exist
> >> when I tested it maybe it just wasn't set up correctly.
> >>> I've tested with wpa_supplication which does not have this issue, alt=
hough
> >>> I've seen an unrelated issue with wpa_supplication(encryption doesn't=
 work)
> >>> but when creating an unencrypted AP network everything seems to work =
ok
> >>> with wpa_supplicant as the routes do get set up there.
> >> Hmm, its probably a NM/IWD interaction issue then. I'd have to take a
> >> look at the NM code, but from what I could see it seemed to be acting
> >> like IWD was working. Said the hotspot was running and everything...
> > Is there any detailed documentation/references on how the DBus API
> > interface between NM/IWD is supposed to work?
>
> NM is just using:
>
> https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/doc/access-p=
oint-api.txt
>
> Should only be using the Start(ssid, psk) method. Its really that simple
> so I don't see how it could really get anything wrong as far as being
> notified. But again, I'm not too familiar with NM.

Looking into this that doesn't appear to be entirely accurate, that method
seems to be working fine but is not the only API NM uses to interface with
IWD.

It looks like NM is also using this for interface configuration:
https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/doc/agent-api.=
txt

During iwd startup NM registers an agent like this:
method call time=3D1715116624.786278 sender=3D:1.6 -> destination=3D:1.55
serial=3D1587 path=3D/net/connman/iwd;
interface=3Dnet.connman.iwd.AgentManager;
member=3DRegisterNetworkConfigurationAgent
   object path "/org/freedesktop/NetworkManager/iwd/agent"

The documentation indicates:
If no network configuration agent is
present, IWD immediately writes (commits) those
values to the corresponding interface, the routing
table and communicates them to the resolver.  If such
agent is registered, IWD requests the agent to do
this last step.

From what I can tell the pending state issue is due to IWD failing to fire
a request to the NetworkConfigurationAgent registered by NM at all as
I'm not seeing any NetworkConfigurationAgent requests when bringing
up the AP interface when monitoring dbus using "dbus-monitor --system".

So I think this may be an IWD bug after all.

>
> >
> >>>>>> Thanks,
> >>>>>>
> >>>>>> James
> >>>>>>
> >>>>>>>> Thanks,
> >>>>>>>>
> >>>>>>>> James
> >>>>>>>>
