Content-Type: multipart/mixed; boundary="===============7824812940282273516=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 1/7] ip-pool: Track IPv4 addresses in use
Date: Thu, 27 May 2021 00:36:03 +0200
Message-ID: <CAOq732+Q65PkJyfS_PZ+e9GJ9wRhtkJMvf6eg92fHebqJn5bhw@mail.gmail.com>
In-Reply-To: <5b4e127b-33a4-545a-8041-98a1db8430df@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7824812940282273516==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 26 May 2021 at 23:56, Denis Kenzior <denkenz@gmail.com> wrote:
> > Again, convenience, readability, better fit for the use case.  But
>
> readability? Yeah I don't buy that one ;)

If you can write
  ret_val =3D ip_pool_select_addr4(...);

  do_some_maths(ret_val->addr)

instead of:

  struct in_addr ia;
  char addr[INET_ADDRSTRLEN];

  ret_val =3D ip_pool_select_addr4(...);

  if (!l_rtnl_address_get_address(ret_val, addr) || inet_aton(addr, &ia) < =
0) {
        l_rtnl_address_free(ret_val);
        goto error;
  }

  do_some_maths(ntohl(ia.s_addr));

I call that readable vs. unreadable ;-)

>  You were doing stuff like storing the
> ip address in host order for whatever reason.  And you expect someone rea=
ding
> ap.c to remember / know that?

Whenever you're going to store the IP as an uint32_t (rather than e.g.
in_addr) it's probably because you want to do some arithmetics and
you'll want the host byte order.

Besides you can generally assume that a plain integer variable is in
host byte order.

Best regards
--===============7824812940282273516==--

