Content-Type: multipart/mixed; boundary="===============1445360427520447367=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 07/11] ap: Stop ongoing handshake on reassociation
Date: Thu, 27 Aug 2020 22:40:39 +0200
Message-ID: <CAOq732K42GNxvRw2t7yvi+=qMPshknDBHa4c17rn09Khxsb4Ag@mail.gmail.com>
In-Reply-To: <6b5eaab9-a7fd-ca7d-1f3a-c8dab2a8263c@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1445360427520447367==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Thu, 27 Aug 2020 at 21:15, Denis Kenzior <denkenz@gmail.com> wrote:
> On 8/27/20 1:14 PM, Andrew Zaborowski wrote:
> > On a new association or re-association, in addition to forgetting a
> > complete RSN Association, also stop the EAPoL SM to stop any ongoing
> > handshake.
> >
> > Do this in a new function ap_stop_handshake that is now used in a few
> > places that had copies of the same few lines.  I'll be adding some more
> > lines to this function for WSC support.
> > ---
> >   src/ap.c | 51 +++++++++++++++++++++++++--------------------------
> >   1 file changed, 25 insertions(+), 26 deletions(-)
> >
> > diff --git a/src/ap.c b/src/ap.c
> > index aef2e1dd..5cd2b717 100644
> > --- a/src/ap.c
> > +++ b/src/ap.c
>
> No real concerns on the first three uses, but...
>
> <snip>
>
> > @@ -938,6 +933,12 @@ static void ap_assoc_reassoc(struct sta_state *sta=
, bool reassoc,
> >               goto unsupported;
> >       }
> >
> > +     /* 802.11-2016 11.3.5.3 j) */
> > +     if (sta->rsna)
> > +             ap_drop_rsna(sta);
> > +
> > +     ap_stop_handshake(sta);
> > +
>
> ap_drop_rsna also destroys eapol_sm and the handshake object.  So perhaps=
 you
> need to track the authorized state to choose the right cleanup action?

Ok, good catch, in fact it calls ap_stop_handshake() after this patch.
I didn't see this because conceptually ap_drop_rsna is a transition
from State 4 to State 3 while ap_stop_handshake sort of stops an
ongoing transition State 4.

I guess this will make sense:
if (sta->rsna)
    ap_drop_rsna(sta);
else
    ap_stop_handshake(sta);

Best regards
--===============1445360427520447367==--

