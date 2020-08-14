Content-Type: multipart/mixed; boundary="===============6759840287957516058=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 0/2] Fix the documented behaviour of GetOrderedNetworks
Date: Fri, 14 Aug 2020 10:58:59 -0500
Message-ID: <1479f364-054e-94fa-1579-eca6ccf1d34d@gmail.com>
In-Reply-To: <20200814134033.322752-1-alsi@bang-olufsen.dk>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6759840287957516058==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alvin,

On 8/14/20 8:40 AM, Alvin =C5=A0ipraga wrote:
> I noticed that the Station DBus method GetOrderedNetworks() was not
> respecting the behaviour documented in doc/station-api.txt, namely that:
> =

>      1. If the device is currently connected to a network, that network
>         is always first on the list,
>      2. followed by any known networks that have been used at least once
>         before [...]
> =

> These two patches should address the two points respectively.
> =

> ---
> =

> v1 -> v2:
>      - Fix a careless naming mistake which caused the first patch not to
>        compile.
> =

> Alvin =C5=A0ipraga (2):
>    station: refresh ordered network list on (dis)connect
>    treewide: guard compare functions against signed integer overflow
> =

>   src/network.c |  2 +-
>   src/scan.c    |  2 +-
>   src/station.c | 16 ++++++++++++++--
>   tools/hwsim.c |  2 +-
>   4 files changed, 17 insertions(+), 5 deletions(-)
> =


Looks like the bug fixed in patch 2 has been in there since the introductio=
n of =

that method.  We must have been (un)lucky that the scan is done prior to th=
e =

connection and the results look sort of correct.

Good catch and both applied.

Regards,
-Denis
--===============6759840287957516058==--

