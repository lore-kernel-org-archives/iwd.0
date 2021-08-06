Content-Type: multipart/mixed; boundary="===============7231875506790714664=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: Re: how to get info about connected clients when iwd runs in AP mode?
Date: Fri, 06 Aug 2021 09:32:15 -0700
Message-ID: <cb60f7c9a8cdcfac082e95ba3cbfa5ce95c3523e.camel@gmail.com>
In-Reply-To: <20210806063051.2797.40602@ml01.vlan13.01.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7231875506790714664==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, 2021-08-06 at 06:30 +0000, salahaldeen.altous(a)leica-camera.com
wrote:
> Hi,
> =

> I have a device which running as AP point. I would like to know every
> time there is a new connection/discounntion for this access point.
> Does iwd API support this? DHCP is enable in AP configuration
> (EnableNetworkConfiguration=3DTrue)

There is an access point API, GetDiagnostics(), which returns an array
of clients (including some info about each client):

https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/doc/access-poi=
nt-diagnostic-api.txt

Unfortunately you cant get notified for this via PropertyChanged since
its a DBus method rather than properties. This was done because some of
the client info can change quite frequently (RSSI, Tx/Rx rates/modes
etc) and we didn't want to flood DBus with these messages constantly.

In iwctl we actually poll this information every second.

Thanks,
James

> =

> Regards,
> Salahaldeen Altous
> _______________________________________________
> iwd mailing list -- iwd(a)lists.01.org
> To unsubscribe send an email to iwd-leave(a)lists.01.org


--===============7231875506790714664==--

