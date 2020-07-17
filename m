Content-Type: multipart/mixed; boundary="===============6405379830021188367=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [Feature] Send hostname in DHCP request
Date: Fri, 17 Jul 2020 11:03:09 -0500
Message-ID: <3cf44fe5-155e-f514-7f6e-3c1b84efea97@gmail.com>
In-Reply-To: <e155a0e1f4ef46fcb78ae4f3041dab9d2890c083.camel@roobre.es>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6405379830021188367==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Roberto,

On 7/17/20 9:58 AM, Roberto "Roobre" Santalla wrote:
> Hello,
> =

> This is my first time submitting a patch/feature request over email, I
> hope I do not mess up :)

We prefer git send-email, similar to how kernel patches are submitted.  See =

HACKING document for more details.

> =

> First of all, thank you for your work on iwd, I have recently started
> to use it on my laptop and seems to be working very well.
> I have, however, noticed that when using the built-in IP management, my
> hostname was not being sent to the DHCP server. This is unfortunate
> since it breaks my home network, which uses dnsmasq to build dns
> records on-the-fly for hosts.

Right.  We chose not to send the hostname in order to comply with RFC 7844 =
[1]. =

For networks where this is required (like yours) we should probably have an =

'opt-in' method.  Perhaps the easy way to start is by adding another settin=
g to =

the network IPv4 settings.  Maybe a boolean setting named 'SendHostname' un=
der =

the 'DHCPv4' group.

> =

> I have written and extremely simple, PoC patch which calls gethostname
> and pass the returned string to the ell dhcp client.
> =

> What are your thoughts about this feature?

This looks fine, but needs to check the 'opt-in' setting as discussed above.

Regards,
-Denis

[1] https://tools.ietf.org/html/rfc7844#section-3.7

> =

> Regards,
> - =E2=84=9D
> =

> =E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=
=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=
=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=
=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=
=E2=95=90=E2=95=90=E2=95=90=E2=95=90
>   =F0=9F=91=A4 Roberto Santalla Fern=C3=A1ndez
> =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80
>   =F0=9F=94=91 https://keybase.io/roobre/key.asc
>   =F0=9F=94=91  0E19 86A3 593E 6226
> =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80
>   =F0=9F=8C=8D https://roobre.es
> =E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=
=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=
=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=
=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=
=E2=95=90=E2=95=90=E2=95=90=E2=95=90
>=20
--===============6405379830021188367==--

