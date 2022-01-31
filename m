Content-Type: multipart/mixed; boundary="===============6997636516558108120=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: iwd 1.21 stuck on connecting state
Date: Mon, 31 Jan 2022 13:31:35 -0600
Message-ID: <c4ef8b50-db01-6f63-baca-823edcf751bf@gmail.com>
In-Reply-To: 5d57b20ed52e4d70d64ae3cba74adbd760b5891e.camel@gmail.com

--===============6997636516558108120==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

> - DHCP offers 192.168.1.33
> - IWD responds with a request for .33
> - 2 seconds go by and DHCP offers 192.168.1.35
> - IWD ignores offer as its already waiting for a reply from its
> original request
> - IWD continues to retransmit requests for .35 but the server ignores
> them.
> =

> It seems the server wants .35 as this is what works later when (I
> assume) you restarted IWD.
> =

> A quick fix could be that we automatically restart DHCP after some
> timeout (same effect as you restarting IWD). The proper fix would be to
> handle this multiple offer case.

The second .35 offer seems to come from the same DHCP server as the first o=
ne. =

So we may be able to handle this case by assuming the current offer superse=
des =

the last one we have from this server and restart the request.

Regards,
-Denis
--===============6997636516558108120==--

