Content-Type: multipart/mixed; boundary="===============7715490115579217330=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: Re: how to get info about connected clients when iwd runs in AP mode?
Date: Tue, 10 Aug 2021 11:24:43 -0700
Message-ID: <ec7907819b5632731573edf0b4ff02d7595c7e5e.camel@gmail.com>
In-Reply-To: <b8c4cf78c5fb83c53ba4c7fc1869813c3406e019.camel@leica-camera.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7715490115579217330==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> > =

> < Request: Get Station (0x11) len 8
> [ack,0x300]
> =

> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 58.821834
> =C2=A0=C2=A0=C2=A0 Interface Index: 4 (0x00000004)
> > Result: New Station (0x13) len 32
> [multi]
> =

> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 58.821939
> =C2=A0=C2=A0=C2=A0 Interface Index: 4 (0x00000004)
> =C2=A0=C2=A0=C2=A0 MAC Address 84:25:3F:9F:C2:54
> =C2=A0=C2=A0=C2=A0 Generation: 0 (0x00000000)
> =C2=A0=C2=A0=C2=A0 Station Info: len 0
> > Complete: Get Station (0x11) len 4
> [multi]
> =

> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 58.82=
2000
> =C2=A0=C2=A0=C2=A0 Status: 0
> =

> =

> At this time 2 clients were connected to this AP (2x Event: New
> Station)
> attached you can find the whole log before connecting the 2 clients

Any way I could just get the whole log? I don't see the GET_STATION in
the attached file, nor the response... Just the Event: New Station at
the very beginning which appears to be due to a recent connection not
IWD issuing GET_STATION.

Thanks,
James



--===============7715490115579217330==--

