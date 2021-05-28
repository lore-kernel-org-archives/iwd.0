Content-Type: multipart/mixed; boundary="===============5026148384724163139=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/8] ip-pool: Track IPv4 addresses in use
Date: Fri, 28 May 2021 09:22:46 -0500
Message-ID: <2ee1050f-9077-dfc0-8326-b597a9149972@gmail.com>
In-Reply-To: <20210528004737.2878442-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5026148384724163139==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 5/27/21 7:47 PM, Andrew Zaborowski wrote:
> Add the ip-pool submodule that tracks IPv4 addresses in use on the
> system for use when selecting the address for a new AP.  l_rtnl_address
> is used internally because if we're going to return l_rtnl_address
> objects it would be misleading if we didn't fill in all of their
> properties like flags etc.
> ---
>   Makefile.am   |   1 +
>   src/ip-pool.c | 175 ++++++++++++++++++++++++++++++++++++++++++++++++++
>   src/ip-pool.h |  23 +++++++
>   3 files changed, 199 insertions(+)
>   create mode 100644 src/ip-pool.c
>   create mode 100644 src/ip-pool.h
> =


rc/ip-pool.c: In function =E2=80=98ip_pool_get_addr4=E2=80=99:
src/ip-pool.c:68:15: error: implicit declaration of function =

=E2=80=98l_rtnl_address_dup=E2=80=99; did you mean =E2=80=98l_rtnl_address_=
new=E2=80=99? =

[-Werror=3Dimplicit-function-declaration]
    68 |  return rec ? l_rtnl_address_dup(rec->addr) : 0;
       |               ^~~~~~~~~~~~~~~~~~
       |               l_rtnl_address_new
src/ip-pool.c:68:45: error: returning =E2=80=98int=E2=80=99 from a function=
 with return type =

=E2=80=98struct l_rtnl_address *=E2=80=99 makes pointer from integer withou=
t a cast =

[-Werror=3Dint-conversion]
    68 |  return rec ? l_rtnl_address_dup(rec->addr) : 0;
       |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~


Regards,
-Denis

--===============5026148384724163139==--

