Content-Type: multipart/mixed; boundary="===============0975240310997540705=="
MIME-Version: 1.0
From: Diego Santa Cruz <Diego.SantaCruz@spinetix.com>
Subject: RE: Compatibility problems with wired 802.1x
Date: Mon, 04 May 2020 12:03:48 +0000
Message-ID: <
 <VI1PR01MB516753BA80CB1D69536E291088A60@VI1PR01MB5167.eurprd01.prod.exchangelabs.com>>
In-Reply-To: <22cdfdc0-a1db-09ed-3ef1-34e6f1d60fd1@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0975240310997540705==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> -----Original Message-----
> From: Denis Kenzior <denkenz@gmail.com>
> Sent: 25 April 2020 05:04
> To: Diego Santa Cruz <Diego.SantaCruz@spinetix.com>; iwd(a)lists.01.org
> Subject: Re: Compatibility problems with wired 802.1x
> =

> Hi Diego,
> =

> <snip>
> =


Sorry for the (very) late reply, I just noticed this message sitting in my =
Junk folder... I have you whitelisted now.

> >> Hmm, its been a while since I looked into ead.  On the iwd side we
> >> default to replying with the same protocol version as the request, but
> >> looks like ead does indeed hard-code 2004 as the version.
> >>
> >
> > In ead context I think there is not always something to reply to, the
> EAPPOL-Start message is sent unsolicited, so there is no request to look =
at to
> get the version. That may explain why it is hardcoded.
> =

> Yes, with WiFi it is a bit simpler because 95% of the time the AP sends
> us a RequestIdentity right away with a protocol version set.  So we just
> use that one.  However, there have been instances where even this
> strategy fails.  For example, Time Warner / Spectrum hotspots send a
> RequestIdentity with 2004 version, but refuse to process any packets
> unless they're sent with 2001 version.  We do send EAPOL-Start with 2001
> in iwd, but for some reason ead uses 2004.
> =


Ah! I guess the adage "do whatever Windows does" ensures best compatibility=
, probably that the AP QA is often like "if it works with Windows then all =
is good" despite the Wi-Fi alliance efforts. Well now ead uses 2001 so I ho=
pe that works out well with all switches.

> <snip>
> =

> >> Yes, indeed it should.  I suspect the reason is that it sort of just
> >> happened to work even when the operstate wasn't set properly, but this
> >> should be fixed.
> >>
> >
> > I have second thoughts about this. At least in the switch I am playing =
with, it
> can be configured so that an unauthenticated supplicant is put into a gue=
st
> VLAN and one which fails authentication into an auth-fail VLAN (but my gu=
ess
> is that this is pretty common functionality). If ead were to put the link=
 into
> dormant state until authentication succeeded it would mean daemons that
> look at the link's running flag would not attempt to communicate before
> authentication succeeded (e.g., DHCP client), thus loosing the possibilit=
y to
> use the guest or auth-fail VLAN.
> =

> This area is tricky and not very well documented (on Linux and in
> general)  At least according to
> https://www.kernel.org/doc/Documentation/networking/operstates.txt,
> dhcp
> daemons expect the supplicant to take the interface out of dormant mode
> as a hint that DHCP requests can now be sent.  So ideally,
> EAP-RequestIdentity should trigger the interface going into OPER_DORMANT
> mode.  And EAP-Success should trigger it going into OPER_UP.
> =

> But, the complication is that there are implementations that send
> RequestIdentity / reply to EAPoL-Start only after the initial DHCP
> Discover has been sent out.  This is a big reason why we think it makes
> sense to put dhcp right into ead eventually.
> =

> I suspect ead will need to try to auto-detect (or have the user
> configure) if this 'guest-vlan' type scenario is supported.  And if it
> isn't, leave the interface in OPER_DORMANT state.
> =


As far as I have been able to test the current situation in ead works well =
in practice, so I am not sure adding complexity (implementation and configu=
ration) to handle setting the interface into dormant state and back up is p=
robably not needed. We will be including ead in the next firmware release f=
or our products to add 802.1x support so it will get wider testing, I will =
come back if we notice any problems. =


Best,
Diego

-- =

Diego Santa Cruz, PhD
Technology Architect
spinetix.com



--===============0975240310997540705==--

