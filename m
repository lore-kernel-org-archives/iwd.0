Content-Type: multipart/mixed; boundary="===============5453591187498605181=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: EAP server tried method 25 while client was configured for method
 26
Date: Thu, 12 May 2022 15:25:40 -0500
Message-ID: <0fa43dec-26d2-6515-1b42-8db3bce19bdc@gmail.com>
In-Reply-To: 6fc4a1a0c9cea52a46c5645cc33c2036@univie.ac.at

--===============5453591187498605181==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Axel,

On 5/12/22 06:43, Axel Kittenberger wrote:
> Hello, I can't get iwd to connect to a 802.1x (university) network.
> =

> $ cat /var/lib/iwd/eduroam.8021x
> [Security]
> EAP-Method=3DPEAP
> EAP-PEAP-Phase2-Method=3DMSCHAPV2
> EAP-PEAP-Phase2-Identity=3Dxxx
> EAP-PEAP-Phase2-Password=3Dxxx
> =


This configuration looks pretty typical for a PEAP+MSCHAPv2.

> produces following iwd output (started on console)
> ""
> Wiphy: 0, Name: phy0
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Permanent Address: 64:6c:80:e=
d:91:b9
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Bands: 2.4 GHz 5 GHz
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Ciphers: CCMP TKIP BIP
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Supported iftypes: ad-hoc sta=
tion ap p2p-client p2p-go p2p-device
> EAP server tried method 25 while client was configured for method 26

This is very strange.  We're configured for MSCHAPv2 (method=3D26) inside t=
he PEAP =

tunnel.  It seems that the server is sending us EAP-PEAP (method=3D25) pack=
ets =

within the tunnel, which doesn't make sense from what I remember of the pro=
tocol.

Can you run with IWD_TLS_DEBUG=3D1 environment variable set and share the l=
og? =

You can send it to me privately.  See [1]

> PEAP: Tunnel has disconnected with alert: close_notify
> ""

<snip>

> /usr/libexec/iwd --version
> 1.14

Have you tried a later version of iwd? 1.14 is about a year old now.

[1] https://iwd.wiki.kernel.org/debugging#enabling_tls_debugging

Regards,
-Denis
--===============5453591187498605181==--

