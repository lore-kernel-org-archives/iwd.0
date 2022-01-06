Content-Type: multipart/mixed; boundary="===============6865029844282219677=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v2 4/9] json: add support for array iteration
Date: Thu, 06 Jan 2022 13:07:43 -0800
Message-ID: <5760604b8089144a3b34218d22499442caa41401.camel@gmail.com>
In-Reply-To: 26835ea5-3abb-f49f-7225-803711d3c973@gmail.com

--===============6865029844282219677==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2022-01-06 at 14:25 -0600, Denis Kenzior wrote:
> Hi James,
> =

> On 1/6/22 13:50, James Prestwood wrote:
> > Arrays can now be parsed using the JSON_ARRAY type (stored in
> > a struct json_iter) then iterated using json_iter_next. When
> > iterating the type can be checked with json_iter_get_type. For
> > each iteration the value can be obtained using any of the type
> > getters (int/uint/boolean/null).
> > ---
> > =C2=A0 src/json.c | 56
> > +++++++++++++++++++++++++++++++++++++++++++++++++++++-
> > =C2=A0 src/json.h |=C2=A0 4 ++++
> > =C2=A0 2 files changed, 59 insertions(+), 1 deletion(-)
> > =

> =

> =

> > diff --git a/src/json.c b/src/json.c
> > index 6c88ed3a..cf233e56 100644
> > --- a/src/json.c
> > +++ b/src/json.c
> > @@ -88,7 +88,17 @@ static void iter_recurse(struct json_iter *iter,
> > jsmntok_t *token,
> > =C2=A0 =

> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0child->contents =3D c;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0child->start =3D token =
- c->tokens;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0child->current =3D child->st=
art;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0child->count =3D count_=
tokens_in_container(iter, token);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Add one to include the ob=
ject/array token itself. This
> > is required
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * since 'current' points to=
 the container initially. Only
> > after a call
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * to json_iter_next() will =
'current' point to the first
> > token in the
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * container.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (token->type =3D=3D JSMN_=
OBJECT || token->type =3D=3D
> > JSMN_ARRAY)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0child->count++;
> > =C2=A0 }
> =

> This seems a bit dangerous since count is set based on ITER_END in
> patch 1.=C2=A0 Is =

> there a chance this ends up allowing going past the allocated tokens?
> =

> I'm guessing you are trying to account for a slight difference in
> behavior of =

> json_iter depending on what type it points to:
> - if json_iter points to JSMN_PRIMITIVE,
> then json_iter_next should not be called (and should fail)
> - if json_iter points to JSMN_OBJECT/ARRAY, then json_iter_next has
> to be called =

> prior to obtaining the first element
> =

> Am I right so far?

Yes that is exactly it. Consider this array:

["foo", "bar"]

count_tokens_in_container() will return 2 tokens. count++ gives us 3
and 'start' points to the array itself.

Call json_iter_next():
	'start' is advanced by 1, pointing to "foo"

Call json_iter_next():
	'start' is advanced by 1, pointing to "bar"

Call json_iter_next():
	'start' is advanced by 1, pointing to some token after "bar".

	We then check:

	if (c->tokens + iter->current + inc >=3D ITER_END(iter))
		return false;

	And in this case iter->current + inc will equal ITER_END

I do see your point, and accessing a token at [count] would indeed be
bad. But that never actually happens, we bail out once we see current
equal count.

> =

> > =C2=A0 =

> > =C2=A0 struct json_contents *json_contents_new(const char *json, size_t
> > json_len)
> =

> <snip>
> =

> > @@ -370,3 +382,45 @@ bool json_iter_get_null(struct json_iter
> > *iter)
> > =C2=A0 =

> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return false;
> > =C2=A0 }
> > +
> > +enum json_type json_iter_get_type(struct json_iter *iter)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct json_contents *c =3D =
iter->contents;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0jsmntok_t *t =3D c->tokens +=
 iter->current;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return (enum json_type) t->t=
ype;
> > +}
> > +
> > +bool json_iter_next(struct json_iter *iter)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct json_contents *c =3D =
iter->contents;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0jsmntok_t *t =3D c->tokens +=
 iter->current;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int inc =3D 1;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * If this is the initial it=
eration skip this and just
> > increment
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * current by 1 since this i=
terator points to a container
> > which needs to
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * be advanced to the first =
token..
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * In addition primitive typ=
es and empty containers will
> > have a size
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * of 1, so no special handl=
ing is needed there.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * For non-empty containers =
'current' needs to be advanced
> > by all the
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * containers child tokens, =
plus the container itself.
> =

> One idea might be to use the 'size' variable of the start token to
> know whether =

> the iterator can be advanced or not.=C2=A0 Alternatively, look up the base
> type of =

> the iterator at the start token and modify the behavior here
> accordingly.

Are you talking about preventing primitive iteration? Or just
altertering how iteration is done in general?

The check below ensures the token is an iterable container, and size is
used in that check if only to detect empty objects/arrays, which would
then be treated exactly like a primitive/string.

I'm not sure 'size' can be trusted soley to know if its an iterable
object. For example a key's size is 1. I'm not sure how an iterator
could end up pointing there, but checking OBJECT/ARRAY explicitly seems
like the safest bet to me.

> =

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * This check ensures:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0 1. It i=
s not the initial iteration
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0 2. This=
 is a container
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0 3. The =
container is not empty
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (iter->current !=3D iter-=
>start && ((t->type =3D=3D
> > JSMN_OBJECT ||
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0t->type =3D=3D JSMN_ARRAY) &&
> > t->size))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0inc =3D count_tokens_in_container(iter, t) + 1;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (c->tokens + iter->curren=
t + inc >=3D ITER_END(iter))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return false;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0iter->current +=3D inc;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return true;
> > +}
> =

> Regards,
> -Denis


--===============6865029844282219677==--

