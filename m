Content-Type: multipart/mixed; boundary="===============6221452230547072306=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v2 2/3] json: introduce JSON module
Date: Thu, 09 Dec 2021 11:10:34 -0800
Message-ID: <c663f358b9de6518e67a1bad3fb073d59815b7f6.camel@gmail.com>
In-Reply-To: aee2f4f1-5912-025f-0930-8d84420f416f@gmail.com

--===============6221452230547072306==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2021-12-09 at 11:52 -0600, Denis Kenzior wrote:
> Hi James,
> =

> On 12/8/21 3:36 PM, James Prestwood wrote:
> > This is a minimal wrapper around jsmn.h to make things a bit easier
> > for iterating through a JSON object.
> > =

> > An iterator can be created/destroyed with json_iter_{new,free} and
> > values can be parsed from this iterator using json_iter_parse.
> > =

> =

> Have you considered using an intermediate object to hold the bits
> that need to =

> be opaque?=C2=A0 That way json_iter objects could be public and held on
> the stack. =

> Would make things easier to use / simpler to implement.
> =

> So roughly:
> =

> struct json_contents;
> =

> struct json_iter {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct json_contents *con=
tents;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int begin;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int end;
> };

This didn't feel consistent with any other iterators on cleanup:

struct json_iter iter;

json_iter_init(&iter, json, json_len);

...

json_iter_free(&iter);

> =

> also you could possibly track parent objects if needed.
> =

> > Arguments to json_iter_parse should use
> > JSON_MANDATORY/JSON_OPTIONAL
> > macros, and terminate the argument list with JSON_FLAG_INVALID.
> > =

> > The value pointer in the MANDATORY/OPTIONAL macros can be NULL, in
> > which case the presence of the key/value is checked but no data is
> > returned out.
> > =

> > Currently only JSON_STRING and JSON_OBJECT types are supported.
> > String
> > values should be of type struct iovec *, and objects should be of
> =

> Ok, I wonder if we could allocate the strings instead of having the
> caller do this.

Sure. Initially this was supposed to be a minimal wrapper and the
allocation seemed like too much, but this has evolved :)

> =

> > type struct json_iter **. These nested objects can be parsed again
> > using json_iter_parse and should not be freed (the original
> > iterator
> > keeps track of nested object iterators).
> =

> It would be nice if these were simply on the stack to cut down the
> queue management.
> =

> > ---
> > =C2=A0 Makefile.am |=C2=A0=C2=A0 1 +
> > =C2=A0 src/json.c=C2=A0 | 222
> > ++++++++++++++++++++++++++++++++++++++++++++++++++++
> > =C2=A0 src/json.h=C2=A0 |=C2=A0 84 ++++++++++++++++++++
> > =C2=A0 3 files changed, 307 insertions(+)
> > =C2=A0 create mode 100644 src/json.c
> > =C2=A0 create mode 100644 src/json.h
> > =

> > v2:
> > =C2=A0 * Re-wrote to remove callback style parsing. Instead the expected
> > values
> > =C2=A0=C2=A0=C2=A0 are provided to the parser directly.
> > =

> > diff --git a/Makefile.am b/Makefile.am
> > index 7fe4b5c3..1ae7e3c0 100644
> > --- a/Makefile.am
> > +++ b/Makefile.am
> > @@ -249,6 +249,7 @@ src_iwd_SOURCES =3D src/main.c linux/nl80211.h
> > src/iwd.h src/missing.h \
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0src/sysfs.h src/sysfs.c \
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0src/offchannel.h
> > src/offchannel.c \
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0src/dpp-util.h src/dpp-
> > util.c \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0src/json.h src/json.c \
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0$(eap_sources) \
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0$(builtin_sources)
> > =C2=A0 =

> > diff --git a/src/json.c b/src/json.c
> > new file mode 100644
> > index 00000000..9f6c744f
> > --- /dev/null
> > +++ b/src/json.c
> > @@ -0,0 +1,222 @@
> > +/*
> > + *
> > + *=C2=A0 Wireless daemon for Linux
> > + *
> > + *=C2=A0 Copyright (C) 2013-2019=C2=A0 Intel Corporation. All rights
> > reserved.
> =

> Please update this
> =

> > + *
> > + *=C2=A0 This library is free software; you can redistribute it and/or
> > + *=C2=A0 modify it under the terms of the GNU Lesser General Public
> > + *=C2=A0 License as published by the Free Software Foundation; either
> > + *=C2=A0 version 2.1 of the License, or (at your option) any later
> > version.
> > + *
> > + *=C2=A0 This library is distributed in the hope that it will be
> > useful,
> > + *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 Se=
e the
> > GNU
> > + *=C2=A0 Lesser General Public License for more details.
> > + *
> > + *=C2=A0 You should have received a copy of the GNU Lesser General
> > Public
> > + *=C2=A0 License along with this library; if not, write to the Free
> > Software
> > + *=C2=A0 Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA=C2=
=A0
> > 02110-1301=C2=A0 USA
> > + *
> > + */
> > +
> > +#ifdef HAVE_CONFIG_H
> > +#include <config.h>
> > +#endif
> > +
> > +#include <errno.h>
> > +
> > +#include <ell/ell.h>
> > +
> > +#include "src/json.h"
> > +
> > +#include "shared/jsmn.h"
> > +
> > +/* Max number of tokens supported. Increase if larger objects are
> > expected */
> > +#define JSON_DEFAULT_TOKENS 30
> > +
> > +#define TOK_LEN(token) (token)->end - (token)->start
> > +#define TOK_PTR(json, token) (void *)((json) + (token)->start)
> > +
> > +struct json_iter {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const char *json;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0size_t json_len;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0jsmntok_t *tokens;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int tokens_len;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0jsmn_parser *p;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct l_queue *children;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool root : 1;
> > +};
> > +
> > +static struct json_iter *iter_recurse(struct json_iter *parent,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0jsmntok_t *object)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct json_iter *iter =3D l=
_new(struct json_iter, 1);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0iter->json =3D parent->json;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0iter->json_len =3D parent->j=
son_len;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0iter->tokens =3D object;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0iter->children =3D l_queue_n=
ew();
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Since object->size only i=
ndicates the number of keys in
> > an object
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * we cannot easily calculat=
e the number of tokens
> > remaining (for this
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * object) since each object=
 may have nested objects. Set
> > tokens_len to
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the number of tokens rema=
ining in the overall list after
> > 'object'
> =

> This seems brittle.=C2=A0 Can we recursively count the number of tokens
> for each child?

So this is really only for bounds checking, which may not actually be
requred as that comment below suggests. I think so long as we trust
JSMN we can guarantee its parsed tokens will always contain key/value
pairs. Still, a maximum bounds probably doesn't hurt. So yes we can
limit the bounds of these recursive iterators to only the child object.

> =

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0iter->tokens_len =3D parent-=
>tokens_len -
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0((object - parent->tokens) %
> > sizeof(jsmntok_t));
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0l_queue_push_head(parent->ch=
ildren, iter);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return iter;
> > +}
> > +
> > +struct json_iter *json_iter_new(const char *json, size_t json_len)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct json_iter *iter =3D l=
_new(struct json_iter, 1);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0iter->json =3D json;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0iter->json_len =3D json_len;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0iter->p =3D l_new(jsmn_parse=
r, 1);
> =

> Do you need jsmn_init here?

Yes, below.

> =

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0iter->tokens =3D l_new(jsmnt=
ok_t, JSON_DEFAULT_TOKENS);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0iter->root =3D true;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0jsmn_init(iter->p);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0iter->tokens_len =3D jsmn_pa=
rse(iter->p, iter->json, iter-
> > >json_len,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0iter->tokens,
> > JSON_DEFAULT_TOKENS);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (iter->tokens_len < 0) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0json_iter_free(iter);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return NULL;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0iter->children =3D l_queue_n=
ew();
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return iter;
> > +}
> > +
> > +static void json_iter_destroy(void *data)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct json_iter *iter =3D d=
ata;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0json_iter_free(iter);
> > +}
> > +
> > +void json_iter_free(struct json_iter *iter)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (iter->root) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0l_free(iter->p);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0l_free(iter->tokens);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0l_queue_destroy(iter->childr=
en, json_iter_destroy);
> =

> You could do:
> l_queue_destroy(iter->children,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(l_queue_destroy_func_t *=
) json_iter_free);
> =

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0l_free(iter);
> > +}
> > +
> > +static jsmntok_t *next_key(struct json_iter *iter, jsmntok_t
> > *current)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0jsmntok_t *value;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int i;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * In theory JSMN should pre=
vent any of these bounds checks
> > from failing
> =

> Not very reassuring :)

This was more paranoia than anything.

> =

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (current + 1 > iter->toke=
ns + iter->tokens_len)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return NULL;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0value =3D current + 1;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (value->size =3D=3D 0)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return value + 1;
> =

> So value->size =3D=3D 0 implies a basic type?

AFAIK any value that is not an object will have a size of zero, so this
could include strings as well not just basic types.
> =

> > + > +=C2=A0=C2=A0=C2=A0for (i =3D 0; i < value->size; i++)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0value =3D next_key(iter, value);
> =

> So this should be recursively skipping tokens when value is non-
> basic.=C2=A0 The =

> naming is a bit confusing here
> =

> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return value;
> =

> Since you're returning 'value', but the reader expects a 'key'.

Yes, some re-naming is in order. This is actually returning a key
though, I just reused 'value' rather than a new variable. Something
like 'token' or 'tmp' would be better. =


> =

> > +}
> > +
> > +/*
> > + * Checks that the keys value (t + 1) is in bounds, the value type
> > matches,
> > + * key length matches, and key string match
> > + */
> > +#define TOKEN_MATCHES(iter, t, key, type) \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(t) + 1 < iter->tokens + ite=
r->tokens_len && \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(jsmntype_t)(type) =3D=3D ((=
t) + 1)->type && \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0TOK_LEN((t)) =3D=3D (int)str=
len((key)) && \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0!memcmp(TOK_PTR((iter)->json=
, (t)), (key), TOK_LEN((t)))
> > +
> > +bool json_iter_parse(struct json_iter *iter, ...)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0va_list va;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int i;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int num =3D iter->tokens->si=
ze;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0jsmntok_t *next;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct iovec *sval;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct json_iter **oval;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Empty object {} */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (iter->tokens_len < 1)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return false;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0va_start(va, iter);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0while (true) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0enum json_flag flag;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0char *key;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0enum json_type type;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0void *value;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0jsmntok_t *v =3D NULL;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0flag =3D va_arg(va, enum json_flag);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if (flag =3D=3D JSON_FLAG_INVALID)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0break;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0key =3D va_arg(va, char *);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0type =3D va_arg(va, enum json_type);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0value =3D va_arg(va, void *);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0next =3D iter->tokens + 1;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0/* Iterate over this objects keys */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0for (i =3D 0; i < num; i++) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (TO=
KEN_MATCHES(iter, next, key, type)) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0v =3D next + 1;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0break;
> =

> What if the key matches but the type doesn't?=C2=A0 Shouldn't we bail
> early?

Yep, I'll add some extra checks.

> =

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0next =
=3D next_key(iter, next);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!n=
ext)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return false;
> =

> May not be as big of a deal in this particular case, but this
> approach is =

> side-effecting on failure.=C2=A0 You could parse the object part of the
> way through, =

> then fail to find a key and bail, but you may have assigned stuff
> along the way.

Yeah I could not think of a decent way to handle this without iterating
twice (verification first, then assignment) since we lose reference to
the previous set of arguments with each iteration.

> =

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0}
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if (flag =3D=3D JSON_FLAG_MANDATORY && !v)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return=
 false;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0switch (type) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0case JSON_STRING:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!v=
alue)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0continue;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sval =
=3D value;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sval->=
iov_base =3D v ? TOK_PTR(iter->json, v)
> > : NULL;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sval->=
iov_len =3D v ? TOK_LEN(v) : 0;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0break;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0case JSON_OBJECT:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!v=
alue)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0continue;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0oval =
=3D value;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*oval =
=3D v ? iter_recurse(iter, v) : NULL;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0break;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0default:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return=
 false;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0}
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0va_end(va);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return true;
> > +}
> > diff --git a/src/json.h b/src/json.h
> > new file mode 100644
> > index 00000000..202445ee
> > --- /dev/null
> > +++ b/src/json.h
> > @@ -0,0 +1,84 @@
> > +/*
> > + *
> > + *=C2=A0 Wireless daemon for Linux
> > + *
> > + *=C2=A0 Copyright (C) 2021=C2=A0 Intel Corporation. All rights reserv=
ed.
> > + *
> > + *=C2=A0 This library is free software; you can redistribute it and/or
> > + *=C2=A0 modify it under the terms of the GNU Lesser General Public
> > + *=C2=A0 License as published by the Free Software Foundation; either
> > + *=C2=A0 version 2.1 of the License, or (at your option) any later
> > version.
> > + *
> > + *=C2=A0 This library is distributed in the hope that it will be
> > useful,
> > + *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 Se=
e the
> > GNU
> > + *=C2=A0 Lesser General Public License for more details.
> > + *
> > + *=C2=A0 You should have received a copy of the GNU Lesser General
> > Public
> > + *=C2=A0 License along with this library; if not, write to the Free
> > Software
> > + *=C2=A0 Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA=C2=
=A0
> > 02110-1301=C2=A0 USA
> > + *
> > + */
> > +
> > +struct json_iter;
> > +
> > +/*
> > + * Identical to JSMN types
> > + */
> > +enum json_type {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0JSON_UNDEFINED =3D 0,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0JSON_OBJECT =3D 1 << 0,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0JSON_ARRAY =3D 1 << 1,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0JSON_STRING =3D 1 << 2,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0JSON_PRIMITIVE =3D 1 << 3
> > +};
> > +
> > +enum json_flag {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0JSON_FLAG_INVALID =3D 0,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0JSON_FLAG_MANDATORY =3D 1,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0JSON_FLAG_OPTIONAL =3D 2,
> > +};
> > +
> > +#define JSON_MANDATORY(key, type, out) \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0JSON_FLAG_MANDATORY, (key), =
(type), (out)
> > +
> > +#define JSON_OPTIONAL(key, type, out) \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0JSON_FLAG_OPTIONAL, (key), (=
type), (out)
> > +
> > +#define JSON_STR_EQ(iov, s) \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0((iov)->iov_len =3D=3D strle=
n((s)) && \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0!memcmp((iov)->iov_base, (s)=
, (iov)->iov_len))
> > +
> > +#define JSON_TO_STR(iov) \
> > +({ \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0char *_tmp =3D l_malloc((iov=
)->iov_len + 1); \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0memcpy(_tmp, (iov)->iov_base=
, (iov)->iov_len); \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0_tmp[(iov)->iov_len] =3D '\0=
'; \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0_tmp; \
> > +})
> > +
> > +struct json_iter *json_iter_new(const char *json, size_t
> > json_len);
> > +void json_iter_free(struct json_iter *iter);
> > +
> > +/*
> > + * Parse an arbitrary number of key/value pairs from a JSON
> > iterator. Initially
> > + * a new JSON iterator should be created with json_iter_new() and,
> > when done,
> > + * freed with json_iter_free. Nested objects are also parsed with
> > this function
> > + * but these iterators should not be freed and are tracked by the
> > original
> > + * iterator.
> > + *
> > + * Arguments should be specified using JSON_MANDATORY or
> > JSON_OPTIONAL:
> > + *
> > + * r =3D json_iter_parse(iter, JSON_MANDATORY("mykey", JSON_STRING,
> > &strvalue),
> > + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0JSON_OPTIONAL("=
optkey", JSON_STRING,
> > &optvalue));
> > + *
> > + * String values should be of type struct iovec *
> > + * Object values should be of type struct json_iter **
> > + *
> > + * No other types are supported at this time, and json_iter_parse
> > will fail if
> > + * other types are encountered.
> > + *
> > + * JSON_OPTIONAL string values will have a NULL/0 iov_base/iov_len
> > if they were
> > + * not found. JSON_OPTIONAL object value iterators will be NULL if
> > not found.
> > + */
> > +bool json_iter_parse(struct json_iter *iter, ...);
> =

> Just a nit, but it is a bit clearer to start the '...' after either a
> printf-style string or an argument that could carry the sentintel
> value.=C2=A0 For =

> example:
> =

> int nl80211_parse_attrs(struct l_genl_msg *msg, int tag, ...);
> =

> It isn't much, but gives just a bit extra context for how the API is
> supposed to =

> be used.=C2=A0 So in the case of json_iter_parse it would be enum
> json_flag.
> =

> Though really, I wonder why json_iter_parse doesn't use the sequence
> of:
> =

> (json_type, key, value, flags) ?

Yeah this is fine, I can reorder them like this and add a new
JSON_INVALID type to signal the end.

> =

> Regards,
> -Denis


--===============6221452230547072306==--

