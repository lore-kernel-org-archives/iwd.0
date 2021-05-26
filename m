Content-Type: multipart/mixed; boundary="===============7627078513343232022=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 1/7] ip-pool: Track IPv4 addresses in use
Date: Wed, 26 May 2021 23:37:43 +0200
Message-ID: <CAOq732+O4wegunRRYFKg5eUA-_-E=KkbZrTkE8k=Xhwaj9Ydyg@mail.gmail.com>
In-Reply-To: <18de2797-b3fd-fd9f-7843-e34faf382278@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7627078513343232022==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Wed, 26 May 2021 at 21:43, Denis Kenzior <denkenz@gmail.com> wrote:
> On 5/25/21 7:55 AM, Andrew Zaborowski wrote:
> > +struct netdev;
>
> Is there a strong reason for making this tighly-coupled to netdev?

Other than convenience, no.

> I mean in
> theory ip-pool can be reused by netconfig for example, which also tracks =
IPv4/v6
> addresses (for some unknown reason, but one thing at a time...)

That shouldn't be a problem but ok, I'll drop the netdev usage.

>
> > +
> > +struct ip_pool_addr4_record {
> > +     uint32_t addr;
> > +     uint8_t prefix_len;
> > +     uint32_t ifindex;
> > +     bool secondary;
> > +};
>
> Is there a compelling reason to use a dedicated structure (leaking
> implementation details) instead of returning a newly allocated l_rtnl_add=
ress
> instead?

Again, convenience, readability, better fit for the use case.  But
like I said I can move to using l_rtnl_address, I didn't do it this
time because it sounded like I convinced you against it.  I'll switch
to l_rtnl_address though.

Using l_rtnl_address here is like using a class for a simple integer
or boolean value (Java style), I wouldn't call directly accessing the
actual value "leaking implementation details."

Best regards
--===============7627078513343232022==--

