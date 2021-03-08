Content-Type: multipart/mixed; boundary="===============5634026684592798904=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 04/10] ap: Add subnet address selection logic
Date: Mon, 08 Mar 2021 14:41:28 -0600
Message-ID: <2743d4b4-4aa5-b0ed-ed6a-c39e642b1fe8@gmail.com>
In-Reply-To: <CAOq732Jam3kepatBFqZt5YDeLY5a3CEtrr-2h+EfQELWV_KBSg@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5634026684592798904==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 3/5/21 5:28 PM, Andrew Zaborowski wrote:
> On Fri, 5 Mar 2021 at 23:35, Denis Kenzior <denkenz@gmail.com> wrote:
>>> +             /*
>>> +              * Ignore the subnet(s) set on the target interface, we'l=
l be
>>> +              * overwriting it if everything goes well.
>>> +              */
>>> +             if (rec->ifindex =3D=3D ifindex)
>>> +                     continue;
>>
>> Ok, I'm a bit confused here.  I thought we're adding on to the address l=
ist, not
>> flushing the addresses?  So shouldn't any addresses set on the target in=
terface
>> still be taken into account as 'used'?
> =

> So the comment is actually wrong as we're currently not overwriting
> (as in replacing) the addresses.  But keeping extra address space
> assigned to that interface is not an issue.  In the following patch I
> iterate over all the existing addresses on the interface and I only
> add the new subnet if none of the existing subnet addresses fully
> covers the new subnet.  So e.g. if the selected subnet is 10.0.5.0/24
> and the target interface has 10.0.0.0/16, I wouldn't add the new
> address because AFAIU it wouldn't make any difference.
> =

> So the 10.0.0.0/16 subnet doesn't make the 10.0.<0-255>.0/24 subnets
> unavailable for us if it's on the same interface.  If we did add the
> 10.0.5.0/24 subnet anyway, it wouldn't create a routing conflict, i.e.
> it wouldn't be simultaneously on two interfaces.
Okay...

> =

> By the way I think it's be a good idea to flush the existing
> addresses, I just don't want to tackle that simultaneously with this
> patchset, and I think it may not be worth our time being such a small
> feature.

Flushing addresses should be dead-simple to implement.  So, if I were doing =

this, I'd wipe all the addresses from ifindex, dump the other interfaces (t=
o =

check for conflicts) and pick from either the profile address pool or the g=
lobal =

one.  Would be simpler, probably more fool-proof and eliminate the extra =

parameters (that require 2 paragraphs to explain) from ap_select_addr4().

Regards,
-Denis
--===============5634026684592798904==--

