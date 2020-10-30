Content-Type: multipart/mixed; boundary="===============3821562114439886420=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] frame-xchg: fix invalid read
Date: Thu, 29 Oct 2020 19:47:28 -0500
Message-ID: <5dbe1ff6-d611-d9e2-d2d6-0d67cfd6b98a@gmail.com>
In-Reply-To: <CAOq732JrWNncQJceok3mH5uCUsMRrTFocwTePdnF=2t_T5WHLw@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3821562114439886420==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

>> So it looks like frame-xchg has got some order of operations backwards.
>> Every single call to l_genl_family_cancel fails. And this isn't really
>> surprising because in normal case we are canceling after we are already
>> in the callback so there is really nothing to cancel right?
> =

> Oh okay, that's why it's not cancelling the destroy callback.  I
> definitely think there should be a way to make ell forget the genl
> command at any phase including in the callback.  So I'd be in favour
> of changing l_genl_family_cancel to do this.  Denis, what do you think
> is better?

I don't know the code path in question all that well... But what is it that =

you're proposing?  That l_genl_family_cancel would not call the destroy =

callback?  I don't think we should do that, since the caller who provided t=
he =

user data might not be the same as the one calling cancel.  And that would =
be =

different to just about every other use of the cancel method.

We can certainly try and detect whether cancel is being called on a command=
 that =

is already in the callback stage to prevent calling destroy twice.  But I w=
ould =

almost say that such behavior should trigger a L_WARN_ON and the proper sol=
ution =

would be to fix the logic flow.  In other words, why are you triggering a c=
ancel =

for a command that is in the callback path?

Regards,
-Denis
--===============3821562114439886420==--

