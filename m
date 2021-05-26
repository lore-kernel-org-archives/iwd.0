Content-Type: multipart/mixed; boundary="===============4312024246004852379=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/7] ip-pool: Track IPv4 addresses in use
Date: Wed, 26 May 2021 17:55:05 -0500
Message-ID: <83306935-fb0e-ef46-0384-79975b6627e1@gmail.com>
In-Reply-To: <CAOq732+Q65PkJyfS_PZ+e9GJ9wRhtkJMvf6eg92fHebqJn5bhw@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4312024246004852379==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 5/26/21 5:36 PM, Andrew Zaborowski wrote:
> On Wed, 26 May 2021 at 23:56, Denis Kenzior <denkenz@gmail.com> wrote:
>>> Again, convenience, readability, better fit for the use case.  But
>>
>> readability? Yeah I don't buy that one ;)
> =

> If you can write
>    ret_val =3D ip_pool_select_addr4(...);
> =

>    do_some_maths(ret_val->addr)
> =


What maths are you performing and why?

The whole point of the API is to have the caller request an address/prefix =
combo =

that can be set directly on the interface and the dhcp_server object.  If y=
ou're =

doing any maths afterward, your API has failed, no?

> instead of:
> =

>    struct in_addr ia;
>    char addr[INET_ADDRSTRLEN];
> =

>    ret_val =3D ip_pool_select_addr4(...);
> =

>    if (!l_rtnl_address_get_address(ret_val, addr) || inet_aton(addr, &ia)=
 < 0) {
>          l_rtnl_address_free(ret_val);
>          goto error;
>    }
> =

>    do_some_maths(ntohl(ia.s_addr));
> =

> I call that readable vs. unreadable ;-)

And I would question the entire design?

> =

>>   You were doing stuff like storing the
>> ip address in host order for whatever reason.  And you expect someone re=
ading
>> ap.c to remember / know that?
> =

> Whenever you're going to store the IP as an uint32_t (rather than e.g.
> in_addr) it's probably because you want to do some arithmetics and
> you'll want the host byte order.
> =

> Besides you can generally assume that a plain integer variable is in
> host byte order.

For a uint32 that is called 'addr' coming from a module called ip_pool?  I =
would =

assume the opposite.  Hence, for a public API, just don't do it this way.

Regards,
-Denis
--===============4312024246004852379==--

