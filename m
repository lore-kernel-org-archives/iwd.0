Content-Type: multipart/mixed; boundary="===============6365891446566584076=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/5] ap: Refactor IP address selection
Date: Wed, 03 Mar 2021 14:30:08 -0600
Message-ID: <2db91093-4b60-ebc8-37aa-d9a446d905a7@gmail.com>
In-Reply-To: <CAOq732J6m4g83b0TpYbXWGx3927bn=Lu=eDmLHfNOOjGR2AQ=Q@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6365891446566584076==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

>> One thing I don't like about this is that the primary IP selection is do=
ne
>> elsewhere, but then Netmask/IPRange settings are parsed after the fact.
> =

> Actually I'm not a fan of that either but that's how the existing (and
> reviewed?) code does it. In this patch I'm moving the Netconfig
> handling together with the subnet selection but I didn't touch the
> IPRange parsing, the change is already big as you noted.
> =


Still... The existing code could only work with a single subnet, you're doi=
ng =

something more flexible...

I think the fix for this is to break up your changes up into more manageabl=
e =

chunks instead of blaming that the 'change is too big' ;)

>>   I'm not
>> sure if it makes sense for a profile to have Netmask/IPRange settings if=
 it also
>> doesn't have the Address set to a single subnet.
> =

> Agreed about IPRange, but for Netmask I see it as a way to specify the
> prefix length basically, i.e. how much address space the AP wants.

Sure, I get that.  And you added some sanity checking for IPRange.  But the=
re's =

no point doing all the work of dumping addresses, selecting ranges if the =

IPRange / Netmask settings make no sense in the first place.  Fail early.

> =

>>   l_dhcp_server probably only
>> works with prefixes >=3D 24 when allocating addresses.
> =

> I haven't looked at it but even then you may want to specify your own
> value between 24 - 28 or 29... 28 being the new default.

These will work, but I'm not sure a prefix length of 23 would work for exam=
ple.

> =

> (Obviously all of these are very specific settings... I assume there's
> some reason why we have them)
> =


Mostly testing, but we've documented them, so you can't just handwave them =
away :)

>>   Shouldn't we load the
>> profile and verify it mostly in one place?
> =

> I haven't really checked but my assumption was that the existing code
> skips some of the verification because the l_dhcp_* methods would
> verify the values passed to it and we avoid duplicating that work.
> =


It skips verification because the assumption was that only a single class C =

subnet would be setup in the profile.  This is no longer the case...  I don=
't =

think l_dhcp_server_* does much verification, if any.

>>
>> Also, I'm a bit lost why ap->profile might be NULL.  Shouldn't we simply=
 create
>> an empty profile instead to simplify the logic?
> =

> I'm not sure how much this is going to simplify the logic but we can
> do that, again that wasn't my choice.
> =


Anything that simplifies the logic helps.  And besides, this could be a sim=
ple =

cleanup commit that you build up on.

>>
>> So we decided not to remove any existing addresses?
> =

> I didn't decide it ;-) but I think it's safe to not remove them if
> we're lazy.  You said:
> =

> 21:51 <@denkenz_> add something like l_rtnl_ifaddr_flush
> 21:53 <@denkenz_> or simply assign multiple addresses, that works too
> =

> So you seemed to be ok with this, in any case it's orthogonal to this pat=
chset.
> =


That's fine.  We had discussed removing the old addresses as well, so I'm j=
ust =

checking what you decided on.

>> It seems to me the logic should go something like this:
>>
>> 1. Load the profile
>> 2. If the profile contains a single address / subnet, go to step 6
> =

> So the current logic retrieves the current address anyway just to
> check if it's the same as the one we want to set, I think it doesn't
> harm to do this and the only difference is steps 2 and 3 are reversed.
> =


Yeah I thought you'd say that ;)  Anyway, I'm fine doing it this way too.

>> 3. Issue ifaddr4_dump and record any used ranges
>> 4. If an address is set on the interface and IPv4.Address isn't set, pic=
k one
>> (non secondary address), doesn't matter which one and use it as the DHCP
>> address.  Goto step 7.
>> 5. Pick an address from the pool taking into account used ranges found i=
n step 3.
>> 6. Set the address picked in step 2, or step 5
>> 7. Start DHCP & AP
> =


Regards,
-Denis
--===============6365891446566584076==--

