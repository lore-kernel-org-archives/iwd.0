Content-Type: multipart/mixed; boundary="===============0893212408686079217=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 01/17] ap: Fix iteration over ap->rates
Date: Wed, 09 Sep 2020 11:47:55 -0500
Message-ID: <5be3f883-2c9f-f69b-af33-fdd90d8618fb@gmail.com>
In-Reply-To: <CAOq732Ko9cO5+htHGvh9aRNFYYkqjJh_Fr3t6HzX15C6er1RFw@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0893212408686079217==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 9/9/20 11:51 AM, Andrew Zaborowski wrote:
> Hi Denis,
> =

> On Wed, 9 Sep 2020 at 17:37, Denis Kenzior <denkenz@gmail.com> wrote:
>> On 9/8/20 6:49 PM, Andrew Zaborowski wrote:
>>> In the for loops use a condition that works even if the uint32_t values
>>> overflow since l_uintset_find_min/max() return UINT_MAX for empty sets.
>>
>> So it only returns UINT_MAX for set objects that are NULL, not empty.
> =

> Ah, true.  If it's empty we'll get 201 as set->max is 200.

So why is the set 200 anyway when the max is 127? ;)

> =

>> How are
>> you even passing in NULL objects that you're hitting this condition?  Th=
at seems
>> to be a logic error?
> =

> It is/was, this is the other fix in this patch.

Okay, then the rest of it is a big hammer for no good reason.  I'd just fix=
 the =

logic error where ap->rates was NULL and leave the rest as is.

Or use l_uintset_foreach...

>>> -     for (r =3D minr; r <=3D maxr && count < 8; r++)
>>> +     for (r =3D minr; (int32_t) (maxr - r) >=3D 0 && count < 8; r++)
>>>                if (l_uintset_contains(ap->rates, r)) {
>>>                        uint8_t flag =3D 0;
>>
>> Looking at this code closely I totally hate how this is done.  You are o=
nly
>> going to be calling l_uintset_contains a few million times even though y=
ou know
>> the basic rates are only 7 bits and the set cannot have more than 127 en=
tries.
> =

> If the set contains rates between 2 and 22 we only make 11 calls, the
> loop iterates from l_uintset_find_min(ap->rates) to
> l_uintset_find_max(ap->rates), or am I missing something?  If the set
> is empty we make one call... we could replace that with an isempty()
> call if needed.

If the set is valid, sure.  But if the set wasn't valid you're iterating 2 =

billion times or something, when a static 0..127 would have been enough.

> =

> Granted we're iterating over values that don't correspond to standard
> rates, we could store indexes into the array of known rates to save
> some iterations.
> =


Maybe consider just using wiphy_get_supported_rates() instead.

Regards,
-Denis
--===============0893212408686079217==--

