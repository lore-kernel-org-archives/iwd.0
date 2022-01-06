Content-Type: multipart/mixed; boundary="===============4490185940191384239=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v2 4/9] json: add support for array iteration
Date: Thu, 06 Jan 2022 15:59:51 -0600
Message-ID: <4210b6c5-8411-fc54-859a-ad1512f0e042@gmail.com>
In-Reply-To: 5760604b8089144a3b34218d22499442caa41401.camel@gmail.com

--===============4490185940191384239==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

>> Am I right so far?
> =

> Yes that is exactly it. Consider this array:
> =

> ["foo", "bar"]
> =

> count_tokens_in_container() will return 2 tokens. count++ gives us 3
> and 'start' points to the array itself.
> =


Ok, I think I managed to convince myself this is indeed okay, particularly =
since =

it is consistent with json_iter_init() behavior.

One thing you may to do is add a check to json_iter_parse to make sure it i=
s =

operating on iterators of type JSMN_OBJECT and nothing else.  That function=
's =

use of ITER_END is what made me suspicious.

> Call json_iter_next():
> 	'start' is advanced by 1, pointing to "foo"
> =

> Call json_iter_next():
> 	'start' is advanced by 1, pointing to "bar"
> =


So in theory, you could use 'size' as a limit counter.  So for primitives, =
set =

pos to 1 and have iter_next check whether pos + 1 <=3D size.

For arrays/objects, set size to 0 and don't allow getters to work if pos is=
 0. =

Or something to that effect.  Not sure if this makes things easier or not.

> Call json_iter_next():
> 	'start' is advanced by 1, pointing to some token after "bar".
> =

> 	We then check:
> =

> 	if (c->tokens + iter->current + inc >=3D ITER_END(iter))
> 		return false;
> =

> 	And in this case iter->current + inc will equal ITER_END
> =


Yes, this all makes sense.  Why do we increment by count_tokens_in_containe=
r() + =

1 though?

<snip>

>> One idea might be to use the 'size' variable of the start token to
>> know whether
>> the iterator can be advanced or not.=C2=A0 Alternatively, look up the ba=
se
>> type of
>> the iterator at the start token and modify the behavior here
>> accordingly.
> =

> Are you talking about preventing primitive iteration? Or just
> altertering how iteration is done in general?

I think both.

> =

> The check below ensures the token is an iterable container, and size is
> used in that check if only to detect empty objects/arrays, which would
> then be treated exactly like a primitive/string.
> =

> I'm not sure 'size' can be trusted soley to know if its an iterable
> object. For example a key's size is 1. I'm not sure how an iterator
> could end up pointing there, but checking OBJECT/ARRAY explicitly seems
> like the safest bet to me.

I would assume (hope?) that size can be trusted.  I could be wrong, but see=
ms to =

me like it would make some checks easier.

Are empty objects/arrays really of size 1?  How does one distinguish betwee=
n an =

array with 1 element and an empty array?

Regards,
-Denis
--===============4490185940191384239==--

