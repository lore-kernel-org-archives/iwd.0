Content-Type: multipart/mixed; boundary="===============1604345229950789150=="
MIME-Version: 1.0
From: Diego Santa Cruz <Diego.SantaCruz@spinetix.com>
Subject: RE: Compatibility problems with wired 802.1x
Date: Mon, 27 Apr 2020 17:10:17 +0000
Message-ID: <
 <VI1PR01MB5167199B7EA67786CC9D4A4888AF0@VI1PR01MB5167.eurprd01.prod.exchangelabs.com>>
In-Reply-To: <e68ebc03-a969-d5ee-bb07-c68602622baa@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1604345229950789150==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> From: Denis Kenzior <denkenz@gmail.com>
> Sent: 25 April 2020 04:49
> To: Diego Santa Cruz <Diego.SantaCruz@spinetix.com>; iwd(a)lists.01.org
> Subject: Re: Compatibility problems with wired 802.1x
> =

> Hi Diego,
> =

> On 4/27/20 4:52 AM, Diego Santa Cruz wrote:
> > Hi,
> >
> > I have been attempting to use ead do wired 802.1x authentication and I
> > am having problems with an HP V1910-48G switch (admittedly an old
> switch).
> >
> > The problem I see is that the switch never responds to the EAPOL packets
> > sent by ead. Investigating I saw that the protocol version in the EAPOL
> > packets sent by ead is set to 802.1X-2004 (2) but in the unsolicited
> > packets the switch sends it is set to 802.1X-2001 (1).
> =

> Hmm, its been a while since I looked into ead.  On the iwd side we
> default to replying with the same protocol version as the request, but
> looks like ead does indeed hard-code 2004 as the version.
> =


In ead context I think there is not always something to reply to, the EAPPO=
L-Start message is sent unsolicited, so there is no request to look at to g=
et the version. That may explain why it is hardcoded.

> >
> > I am new to 802.1X but I went through the specs and as I understand the
> > switch should respond even if it receives an EAPOL version higher that
> > what it uses, but this switch does not.
> >
> =

> Yes, it should.
> =

> > Looking through the ead sources I think the new 802.1X-2004 features are
> > not used, so I went ahead and changed ead to send 802.1X-2001 (1) in its
> > packets, and voil=C3=A0 it now works!
> >
> > Is there any reason that the packets sent by ead use version
> > 802.1X-2004? If not I can send a patch to change it to always use
> > 802.1X-2001. I suspect it is safer to use the older version of the
> > standard, as switches implementing 802.1X-2004 surely work with 802.1X-
> 2001.
> =

> There's really no particular reason.  And I pretty much concur that
> using 2001 is likely the safest choice for compatibility /
> interoperability reasons.  If you want to send a patch, I can take it in.

Good, I'll send a patch shortly.

> =

> >
> > Also, I see ead does not manipulate the link state and mode of the
> > interface, I would have expected it to put the interface into dormant
> > mode and the link state changed between up and dormant depending on
> the
> > authenticated state (like iwd does for WLAN links). Is there any reason
> > for this? I guess one could be the support of guest or auth-fail VLANs
> > in some switches.
> >
> =

> Yes, indeed it should.  I suspect the reason is that it sort of just
> happened to work even when the operstate wasn't set properly, but this
> should be fixed.
> =


I have second thoughts about this. At least in the switch I am playing with=
, it can be configured so that an unauthenticated supplicant is put into a =
guest VLAN and one which fails authentication into an auth-fail VLAN (but m=
y guess is that this is pretty common functionality). If ead were to put th=
e link into dormant state until authentication succeeded it would mean daem=
ons that look at the link's running flag would not attempt to communicate b=
efore authentication succeeded (e.g., DHCP client), thus loosing the possib=
ility to use the guest or auth-fail VLAN.

Best,
Diego
 =

> Regards,
> -Denis
--===============1604345229950789150==--

