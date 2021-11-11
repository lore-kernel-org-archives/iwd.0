Content-Type: multipart/mixed; boundary="===============8537115499445823286=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH] Set retain attribute on C identifier name sections
 referenced by __start_/__stop_
Date: Thu, 11 Nov 2021 14:29:30 -0600
Message-ID: <11325cb5-9904-55d3-a694-bae497643669@gmail.com>
In-Reply-To: 20211111030758.2005309-1-i@maskray.me

--===============8537115499445823286==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fangrui,

On 11/10/21 9:07 PM, Fangrui Song wrote:
> LLD 13 and GNU ld 2.37 support -z start-stop-gc which allows garbage
> collection of C identifier name sections despite the __start_/__stop_
> references. GNU ld before 2015-10 had the behavior as well. Simply set
> the retain attribute so that GCC 11 (if configure-time binutils is 2.36
> or newer)/Clang 13 will set the SHF_GNU_RETAIN section attribute to
> prevent garbage collection.
> =

> Without the patch, there are linker errors with -z start-stop-gc (LLD def=
ault)
> when -Wl,--gc-sections is used:
> =

> ```
> ld.lld: error: undefined symbol: __start___eap
>>>> referenced by eap.c
>>>>                src/eap.o:(eap_init)
> ```
> =

> The remain attribute will not be needed if the metadata sections are
> referenced by code directly.
> ---
>   client/command.h    | 12 +++++++-----
>   client/dbus-proxy.h | 13 ++++++++-----
>   src/eap-private.h   |  6 +++++-
>   src/module.h        | 20 +++++++++++++-------
>   4 files changed, 33 insertions(+), 18 deletions(-)
> =


I changed some whitespace formatting slightly to make the diff slightly mor=
e =

compact and to use tabs instead of spaces in some places.

Applied, thanks!

Regards,
-Denis

--===============8537115499445823286==--

