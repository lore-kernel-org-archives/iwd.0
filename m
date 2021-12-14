Content-Type: multipart/mixed; boundary="===============5591206104885125484=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: iwd configure location and files
Date: Tue, 14 Dec 2021 14:42:19 -0600
Message-ID: <b4e82a5c-5ab2-7f32-e54e-a5cb04877766@gmail.com>
In-Reply-To: CAA=hcWTGQ4+9Vm+Srog0KtQ85R2-o61WT0uPjw+GwB=G9mrXMg@mail.gmail.com

--===============5591206104885125484==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jupiter,

On 12/12/21 10:39 PM, Jupiter wrote:
> Thanks all for your advice.
> =

> Further debugging it, it seems failing DHCP was caused by an error of
> Deauthentication even, not clear if the iwd error caused mwifiex
> disconnected from WiFi modem or the mwifiex cause iwd fall:

You probably need to share full logs.  From what I remember from your previ=
ous =

logs, iwd was connecting successfully to the AP but DHCP client was not abl=
e to =

start.  I think you need to determine why that happens.  I suspect an strac=
e or =

additional logging will be required on your system.  Perhaps permissions ar=
e not =

setup correctly?

<snip>

> Aug 04 15:26:03 solar iwd[345]: Received Deauthentication event,
> reason: 2, from_ap: true

That just means the AP has deauthenticated us.  This may be because we're n=
ot =

able to 4-Way handshake properly, or because we aren't requesting a DHCP =

address, or any other reason.

> I followed the document to enable all CRYPTO setup so I don't think it
> is a CRYPTO configured issue in the kernel.
> =


iwd would refuse to start if these options are not present.  So this is mos=
t =

likely not the culprit.

> Also searching the Internet to find someone added
> ControlPortOverNL80211=3DFalse to resolve that issue on kernel 5.9.2,
> but it did not work on my kernel 5.10.59:
> =

> # cat /etc/iwd/main.conf
> [General]
> EnableNetworkConfiguration=3DTrue
> ControlPortOverNL80211=3DFalse

If EnableNetworkConfiguration is set to False, does iwctl show you as =

successfully connected?

> =

> The other issue is the error from_ap, but I am connecting to a home
> WiFi modem, it should use a station, not ap, right? Or doesn't matter?

No, this is fine.  The message just states that AP was the initiator of the =

disconnect and not the local (iwd) device.

Regards,
-Denis
--===============5591206104885125484==--

