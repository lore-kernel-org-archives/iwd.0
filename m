Content-Type: multipart/mixed; boundary="===============5630208683720068628=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/7] ip-pool: Track IPv4 addresses in use
Date: Wed, 26 May 2021 16:56:27 -0500
Message-ID: <5b4e127b-33a4-545a-8041-98a1db8430df@gmail.com>
In-Reply-To: <CAOq732+O4wegunRRYFKg5eUA-_-E=KkbZrTkE8k=Xhwaj9Ydyg@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5630208683720068628==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

>> I mean in
>> theory ip-pool can be reused by netconfig for example, which also tracks=
 IPv4/v6
>> addresses (for some unknown reason, but one thing at a time...)
> =

> That shouldn't be a problem but ok, I'll drop the netdev usage.
> =


netconfig depends on netdev right now, but it really shouldn't.  The only r=
eason =

is that it needs the device name, which really belongs elsewhere since netc=
onfig =

will end up being used by ead, which will not even come with netconfig modu=
le at =

all.

So the looser you make this coupling, the easier it will be for us to reuse=
 this =

stuff in other projects.  Start thinking along those lines please.

>>
>>> +
>>> +struct ip_pool_addr4_record {
>>> +     uint32_t addr;
>>> +     uint8_t prefix_len;
>>> +     uint32_t ifindex;
>>> +     bool secondary;
>>> +};
>>
>> Is there a compelling reason to use a dedicated structure (leaking
>> implementation details) instead of returning a newly allocated l_rtnl_ad=
dress
>> instead?
> =

> Again, convenience, readability, better fit for the use case.  But

readability? Yeah I don't buy that one ;)  You were doing stuff like storin=
g the =

ip address in host order for whatever reason.  And you expect someone readi=
ng =

ap.c to remember / know that?

> like I said I can move to using l_rtnl_address, I didn't do it this
> time because it sounded like I convinced you against it.  I'll switch
> to l_rtnl_address though.

I'm fine if you use a custom type inside ip-pool for ease of implementation=
, but =

you should make the public API 'nice'.

> =

> Using l_rtnl_address here is like using a class for a simple integer
> or boolean value (Java style), I wouldn't call directly accessing the
> actual value "leaking implementation details."

You're returning a const struct foo * back, which basically screams 'I'm se=
nding =

internal details out'.  Also see my comment about host/network ordering.

If you think l_rtnl_address isn't suitable for whatever reason, then lets f=
ix =

that instead.

Regards,
-Denis
--===============5630208683720068628==--

