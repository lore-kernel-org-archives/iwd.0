Content-Type: multipart/mixed; boundary="===============5297289020713099039=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH] frame-xchg: fix invalid read
Date: Fri, 30 Oct 2020 02:16:09 +0100
Message-ID: <CAOq732Lii2QXV5-P-ec22wDZd4iQ53SRGErGgDjJyx_mP==w3g@mail.gmail.com>
In-Reply-To: <5dbe1ff6-d611-d9e2-d2d6-0d67cfd6b98a@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5297289020713099039==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 30 Oct 2020 at 02:01, Denis Kenzior <denkenz@gmail.com> wrote:
> >> So it looks like frame-xchg has got some order of operations backwards.
> >> Every single call to l_genl_family_cancel fails. And this isn't really
> >> surprising because in normal case we are canceling after we are already
> >> in the callback so there is really nothing to cancel right?
> >
> > Oh okay, that's why it's not cancelling the destroy callback.  I
> > definitely think there should be a way to make ell forget the genl
> > command at any phase including in the callback.  So I'd be in favour
> > of changing l_genl_family_cancel to do this.  Denis, what do you think
> > is better?
>
> I don't know the code path in question all that well... But what is it th=
at
> you're proposing?  That l_genl_family_cancel would not call the destroy
> callback?  I don't think we should do that, since the caller who provided=
 the
> user data might not be the same as the one calling cancel.  And that woul=
d be
> different to just about every other use of the cancel method.

I guess I propose that l_genl_family_cancel, when called from inside
the callback:
* calls the destroy function and removes any references to the genl command,
* returns true.

So same as outside of the callback.  The current behaviour is to return fal=
se.

>
> We can certainly try and detect whether cancel is being called on a comma=
nd that
> is already in the callback stage to prevent calling destroy twice.  But I=
 would
> almost say that such behavior should trigger a L_WARN_ON and the proper s=
olution
> would be to fix the logic flow.  In other words, why are you triggering a=
 cancel
> for a command that is in the callback path?

I think it's useful to have a way to ensure all references to the
provided callbacks/userdata are dropped right now.

Best regards
--===============5297289020713099039==--

