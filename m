Content-Type: multipart/mixed; boundary="===============0316472032966454715=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 05/16] handshake: Convert handshake event callbacks
 variadic functions
Date: Thu, 31 Oct 2019 02:53:37 +0100
Message-ID: <CAOq732LV37-+Q4=cUT_reA85J9kU7xuYVPp8yO-amBea7RkohA@mail.gmail.com>
In-Reply-To: <fbccc6d7-58f3-138b-987c-df21abfc686c@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0316472032966454715==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 30 Oct 2019 at 20:16, Denis Kenzior <denkenz@gmail.com> wrote:
> On 10/28/19 9:04 AM, Andrew Zaborowski wrote:
> >       case HANDSHAKE_EVENT_FAILED:
> > -             netdev_handshake_failed(hs, l_get_u16(event_data));
> > +             netdev_handshake_failed(hs, l_get_u16(va_arg(args, void *=
)));
>
> So since you make the caller extract arguments via va_arg, I wonder if
> it would be cleaner to pass unsigned/int to va_arg directly instead of
> using void pointers?
>
> So do something like handshake_event(hs,
> HANDSHAKE_EVENT_FAILED, reason_code);

Done in the other patch ;)

>
> >               /* fall through */
> >       case HANDSHAKE_EVENT_SETTING_KEYS_FAILED:
> >               sta->sm =3D NULL;
> > @@ -399,6 +402,8 @@ static void ap_handshake_event(struct handshake_sta=
te *hs,
> >       default:
> >               break;
> >       }
> > +
> > +     va_end(args);
> >   }
> >
> >   static void ap_start_rsna(struct sta_state *sta, const uint8_t *gtk_r=
sc)
> > diff --git a/src/handshake.c b/src/handshake.c
> > index 8e1aeec9..a3e236bb 100644
> > --- a/src/handshake.c
> > +++ b/src/handshake.c
> > @@ -912,10 +912,3 @@ bool handshake_decode_fte_key(struct handshake_sta=
te *s, const uint8_t *wrapped,
> >
> >       return true;
> >   }
> > -
> > -void handshake_event(struct handshake_state *hs,
> > -                     enum handshake_event event, void *event_data)
> > -{
> > -     if (hs->event_func)
> > -             hs->event_func(hs, event, event_data, hs->user_data);
> > -}
> > diff --git a/src/handshake.h b/src/handshake.h
> > index 08503190..cd0c1dc9 100644
> > --- a/src/handshake.h
> > +++ b/src/handshake.h
> > @@ -54,7 +54,7 @@ enum handshake_event {
> >
> >   typedef void (*handshake_event_func_t)(struct handshake_state *hs,
> >                                       enum handshake_event event,
> > -                                     void *event_data, void *user_data=
);
> > +                                     void *user_data, ...);
> >
> >   typedef bool (*handshake_get_nonce_func_t)(uint8_t nonce[]);
> >   typedef void (*handshake_install_tk_func_t)(struct handshake_state *h=
s,
> > @@ -130,6 +130,14 @@ struct handshake_state {
> >       handshake_event_func_t event_func;
> >   };
> >
> > +#define handshake_event(hs, event, ...)      \
> > +     do {    \
> > +             if (!(hs)->event_func)  \
> > +                     break;  \
> > +     \
> > +             (hs)->event_func(hs, event, (hs)->user_data, ##__VA_ARGS_=
_); \
> second hs is not in ()s here?

Since it's surrounded by a ( and a , can this ever be a problem?  For
the record event isn't surrounded by ()s and the event-specific
arguments aren't either.

This reminds me I was gonna comment on that I intended to make sure
each argument is evaluated exactly once when using the handshake_event
macro, same as if it was a C function.  But there was no way to do
this for the event-specific arguments so I gave up and left the
responsibilty for this to the few callers, this may need a comment in
the code though.

Best regards
--===============0316472032966454715==--

