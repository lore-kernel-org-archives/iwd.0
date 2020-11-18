Content-Type: multipart/mixed; boundary="===============8734389564614948186=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/4] test-runner: introduce network namespaces
Date: Wed, 18 Nov 2020 11:01:34 -0600
Message-ID: <17532115-dfc1-aa3a-3e7a-1d7c6c4b71e8@gmail.com>
In-Reply-To: <20201117205304.3542997-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8734389564614948186==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 11/17/20 2:53 PM, James Prestwood wrote:
> Our simulated environment was really only meant to test air-to-air
> communication by using mac80211_hwsim. Protocols like DHCP use IP
> communication which starts to fall apart when using hwsim radios.
> Mainly unicast sockets do not work since there is no underlying
> network infrastructure.
> =

> In order to simulate a more realistic environment network namespaces
> are introduced in this patch. This allows wireless phy's to be added
> to a network namespace and unique IWD instances manage those phys.
> This is done automatically when 'NameSpaces' entries are configured
> in hw.conf:
> =

> [SETUP]
> num_radios=3D2
> =

> [NameSpaces]
> ns0=3Drad1,...
> =

> This will create a namespace named ns0, and add rad1 to that
> namespace. rad1 will not appear as a phy in what's being called the
> 'root' namespace (the default namespace).
> =

> As far as a test is concerned you can create a new IWD() class and
> pass the namespace in. This will start a new IWD instance in that
> namespace:
> =

> ns0 =3D ctx.get_namespace('ns0')
> wd_ns0 =3D IWD(start_iwd=3DTrue, namespace=3Dns0)
> =

> 'wd_ns0' can now be used to interact with IWD in that namespace, just
> like any other IWD class object.
> ---
>   tools/test-runner | 298 ++++++++++++++++++++++++++++++----------------
>   1 file changed, 196 insertions(+), 102 deletions(-)
> =


All applied, thanks.

Regards,
-Denis

--===============8734389564614948186==--

