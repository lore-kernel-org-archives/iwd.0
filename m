Content-Type: multipart/mixed; boundary="===============0708570075772187833=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Compatibility problems with wired 802.1x
Date: Mon, 27 Apr 2020 16:45:25 +0000
Message-ID: <e68ebc03-a969-d5ee-bb07-c68602622baa@gmail.com>
In-Reply-To: <VI1PR01MB51671669EFF00516B60B1FBE88AF0@VI1PR01MB5167.eurprd01.prod.exchangelabs.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0708570075772187833==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Diego,

On 4/27/20 4:52 AM, Diego Santa Cruz wrote:
> Hi,
> =

> I have been attempting to use ead do wired 802.1x authentication and I =

> am having problems with an HP V1910-48G switch (admittedly an old switch).
> =

> The problem I see is that the switch never responds to the EAPOL packets =

> sent by ead. Investigating I saw that the protocol version in the EAPOL =

> packets sent by ead is set to 802.1X-2004 (2) but in the unsolicited =

> packets the switch sends it is set to 802.1X-2001 (1).

Hmm, its been a while since I looked into ead.  On the iwd side we =

default to replying with the same protocol version as the request, but =

looks like ead does indeed hard-code 2004 as the version.

> =

> I am new to 802.1X but I went through the specs and as I understand the =

> switch should respond even if it receives an EAPOL version higher that =

> what it uses, but this switch does not.
> =


Yes, it should.

> Looking through the ead sources I think the new 802.1X-2004 features are =

> not used, so I went ahead and changed ead to send 802.1X-2001 (1) in its =

> packets, and voil=C3=A0 it now works!
> =

> Is there any reason that the packets sent by ead use version =

> 802.1X-2004? If not I can send a patch to change it to always use =

> 802.1X-2001. I suspect it is safer to use the older version of the =

> standard, as switches implementing 802.1X-2004 surely work with 802.1X-20=
01.

There's really no particular reason.  And I pretty much concur that =

using 2001 is likely the safest choice for compatibility / =

interoperability reasons.  If you want to send a patch, I can take it in.

> =

> Also, I see ead does not manipulate the link state and mode of the =

> interface, I would have expected it to put the interface into dormant =

> mode and the link state changed between up and dormant depending on the =

> authenticated state (like iwd does for WLAN links). Is there any reason =

> for this? I guess one could be the support of guest or auth-fail VLANs =

> in some switches.
> =


Yes, indeed it should.  I suspect the reason is that it sort of just =

happened to work even when the operstate wasn't set properly, but this =

should be fixed.

Regards,
-Denis
--===============0708570075772187833==--

