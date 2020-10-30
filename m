Content-Type: multipart/mixed; boundary="===============7198583446999054511=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] frame-xchg: fix invalid read
Date: Thu, 29 Oct 2020 20:18:06 -0500
Message-ID: <58a34b9a-ed26-8a4a-cab2-eb374b368337@gmail.com>
In-Reply-To: <CAOq732Lii2QXV5-P-ec22wDZd4iQ53SRGErGgDjJyx_mP==w3g@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7198583446999054511==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 10/29/20 8:16 PM, Andrew Zaborowski wrote:
> On Fri, 30 Oct 2020 at 02:01, Denis Kenzior <denkenz@gmail.com> wrote:
>>>> So it looks like frame-xchg has got some order of operations backwards.
>>>> Every single call to l_genl_family_cancel fails. And this isn't really
>>>> surprising because in normal case we are canceling after we are already
>>>> in the callback so there is really nothing to cancel right?
>>>
>>> Oh okay, that's why it's not cancelling the destroy callback.  I
>>> definitely think there should be a way to make ell forget the genl
>>> command at any phase including in the callback.  So I'd be in favour
>>> of changing l_genl_family_cancel to do this.  Denis, what do you think
>>> is better?
>>
>> I don't know the code path in question all that well... But what is it t=
hat
>> you're proposing?  That l_genl_family_cancel would not call the destroy
>> callback?  I don't think we should do that, since the caller who provide=
d the
>> user data might not be the same as the one calling cancel.  And that wou=
ld be
>> different to just about every other use of the cancel method.
> =

> I guess I propose that l_genl_family_cancel, when called from inside
> the callback:
> * calls the destroy function and removes any references to the genl comma=
nd,
> * returns true.
> =

> So same as outside of the callback.  The current behaviour is to return f=
alse.

That is sort of on purpose.  I mean sure, we can try to 'fix' this by not t=
aking =

the request off the pending_list prior to calling the callback and adding s=
ome =

flags if cancel is called recursively.  But no other class provides any sor=
t of =

guarantees on such behavior and up until now I would have considered behavi=
or in =

such situations as 'undefined'.

Maybe you have a valid use case here, but I know I would never consider usi=
ng =

_cancel this way.

> =

>>
>> We can certainly try and detect whether cancel is being called on a comm=
and that
>> is already in the callback stage to prevent calling destroy twice.  But =
I would
>> almost say that such behavior should trigger a L_WARN_ON and the proper =
solution
>> would be to fix the logic flow.  In other words, why are you triggering =
a cancel
>> for a command that is in the callback path?
> =

> I think it's useful to have a way to ensure all references to the
> provided callbacks/userdata are dropped right now.

Useful how?  Wouldn't it be easier to change the logic flow to conform to t=
he =

general API conventions instead?

Regards,
Denis
--===============7198583446999054511==--

