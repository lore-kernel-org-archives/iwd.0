Content-Type: multipart/mixed; boundary="===============1085949974529644436=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 01/17] ap: Fix iteration over ap->rates
Date: Wed, 09 Sep 2020 19:37:20 -0500
Message-ID: <04b8b097-cb98-41c8-9a2a-7ee630b5e958@gmail.com>
In-Reply-To: <CAOq732LB43FNzRyfmm5OE9BdRiZDc3jg-tJpgdhy-x3DeZFn-A@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1085949974529644436==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> Oh ok, yes, the original code contained an overflow bug, once I
> understood it I didn't like it either ;-)  Hence the fix.

Ok, I'm not following now.  Are you saying there was a possibility of an em=
pty =

(not NULL) set somehow?  If so, shouldn't this have been caught in ap_start =

somewhere?  In the end, a NULL or empty set would produce an invalid IE. =

Assuming a set is valid, then I don't see anything wrong with the current c=
ode? =

Or am I missing something?

i.e. what is wrong with
if (L_WARN_ON(!ap->rates || l_uintset_isempty(ap->rates))
	return 0;

.. proceed as before.

> =

>> when a static 0..127 would have been enough.
> =

> For an invalid set, 0..127 is still wasteful ;-)
> =


Of course, but at least you don't have to think about the cast and the =

arithmetic and go 'what in the world is that doing'...

But really, l_uintset_foreach seems to be the better candidate here.

>>
>>>
>>> Granted we're iterating over values that don't correspond to standard
>>> rates, we could store indexes into the array of known rates to save
>>> some iterations.
>>>
>>
>> Maybe consider just using wiphy_get_supported_rates() instead.
> =

> Right, but we're giving the user (of the ap.h API) some control over
> which rates to support so the plan is to eventually call it but during
> ap_start only.

You're giving a no_cck hint, not control over the rates, right? So the rate=
s =

should still come from wiphy_get_supported_rates().  If you want to stuff t=
hese =

into the uintset or just carry the no_cck hint into the IE builders is a =

different question.  I would think the latter would be easier.

Regards,
-Denis
--===============1085949974529644436==--

