Content-Type: multipart/mixed; boundary="===============1853768399136998527=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 04/10] ap: Add subnet address selection logic
Date: Sat, 06 Mar 2021 00:28:34 +0100
Message-ID: <CAOq732Jam3kepatBFqZt5YDeLY5a3CEtrr-2h+EfQELWV_KBSg@mail.gmail.com>
In-Reply-To: <175612f5-354f-a076-d601-a2590125aba4@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1853768399136998527==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 5 Mar 2021 at 23:35, Denis Kenzior <denkenz@gmail.com> wrote:
> > +             /*
> > +              * Ignore the subnet(s) set on the target interface, we'l=
l be
> > +              * overwriting it if everything goes well.
> > +              */
> > +             if (rec->ifindex =3D=3D ifindex)
> > +                     continue;
>
> Ok, I'm a bit confused here.  I thought we're adding on to the address li=
st, not
> flushing the addresses?  So shouldn't any addresses set on the target int=
erface
> still be taken into account as 'used'?

So the comment is actually wrong as we're currently not overwriting
(as in replacing) the addresses.  But keeping extra address space
assigned to that interface is not an issue.  In the following patch I
iterate over all the existing addresses on the interface and I only
add the new subnet if none of the existing subnet addresses fully
covers the new subnet.  So e.g. if the selected subnet is 10.0.5.0/24
and the target interface has 10.0.0.0/16, I wouldn't add the new
address because AFAIU it wouldn't make any difference.

So the 10.0.0.0/16 subnet doesn't make the 10.0.<0-255>.0/24 subnets
unavailable for us if it's on the same interface.  If we did add the
10.0.5.0/24 subnet anyway, it wouldn't create a routing conflict, i.e.
it wouldn't be simultaneously on two interfaces.

By the way I think it's be a good idea to flush the existing
addresses, I just don't want to tackle that simultaneously with this
patchset, and I think it may not be worth our time being such a small
feature.

Best regards
--===============1853768399136998527==--

