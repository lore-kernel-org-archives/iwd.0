Content-Type: multipart/mixed; boundary="===============1034423747247074455=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v2 2/3] json: introduce JSON module
Date: Thu, 09 Dec 2021 11:52:41 -0600
Message-ID: <aee2f4f1-5912-025f-0930-8d84420f416f@gmail.com>
In-Reply-To: 20211208213636.1697316-2-prestwoj@gmail.com

--===============1034423747247074455==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 12/8/21 3:36 PM, James Prestwood wrote:
> This is a minimal wrapper around jsmn.h to make things a bit easier
> for iterating through a JSON object.
> =

> An iterator can be created/destroyed with json_iter_{new,free} and
> values can be parsed from this iterator using json_iter_parse.
> =


Have you considered using an intermediate object to hold the bits that need=
 to =

be opaque?  That way json_iter objects could be public and held on the stac=
k. =

Would make things easier to use / simpler to implement.

So roughly:

struct json_contents;

struct json_iter {
	struct json_contents *contents;
	int begin;
	int end;
};

also you could possibly track parent objects if needed.

> Arguments to json_iter_parse should use JSON_MANDATORY/JSON_OPTIONAL
> macros, and terminate the argument list with JSON_FLAG_INVALID.
> =

> The value pointer in the MANDATORY/OPTIONAL macros can be NULL, in
> which case the presence of the key/value is checked but no data is
> returned out.
> =

> Currently only JSON_STRING and JSON_OBJECT types are supported. String
> values should be of type struct iovec *, and objects should be of

Ok, I wonder if we could allocate the strings instead of having the caller =
do this.

> type struct json_iter **. These nested objects can be parsed again
> using json_iter_parse and should not be freed (the original iterator
> keeps track of nested object iterators).

It would be nice if these were simply on the stack to cut down the queue ma=
nagement.

> ---
>   Makefile.am |   1 +
>   src/json.c  | 222 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>   src/json.h  |  84 ++++++++++++++++++++
>   3 files changed, 307 insertions(+)
>   create mode 100644 src/json.c
>   create mode 100644 src/json.h
> =

> v2:
>   * Re-wrote to remove callback style parsing. Instead the expected values
>     are provided to the parser directly.
> =

> diff --git a/Makefile.am b/Makefile.am
> index 7fe4b5c3..1ae7e3c0 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -249,6 +249,7 @@ src_iwd_SOURCES =3D src/main.c linux/nl80211.h src/iw=
d.h src/missing.h \
>   					src/sysfs.h src/sysfs.c \
>   					src/offchannel.h src/offchannel.c \
>   					src/dpp-util.h src/dpp-util.c \
> +					src/json.h src/json.c \
>   					$(eap_sources) \
>   					$(builtin_sources)
>   =

> diff --git a/src/json.c b/src/json.c
> new file mode 100644
> index 00000000..9f6c744f
> --- /dev/null
> +++ b/src/json.c
> @@ -0,0 +1,222 @@
> +/*
> + *
> + *  Wireless daemon for Linux
> + *
> + *  Copyright (C) 2013-2019  Intel Corporation. All rights reserved.

Please update this

> + *
> + *  This library is free software; you can redistribute it and/or
> + *  modify it under the terms of the GNU Lesser General Public
> + *  License as published by the Free Software Foundation; either
> + *  version 2.1 of the License, or (at your option) any later version.
> + *
> + *  This library is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + *  Lesser General Public License for more details.
> + *
> + *  You should have received a copy of the GNU Lesser General Public
> + *  License along with this library; if not, write to the Free Software
> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-130=
1  USA
> + *
> + */
> +
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
> +#include <errno.h>
> +
> +#include <ell/ell.h>
> +
> +#include "src/json.h"
> +
> +#include "shared/jsmn.h"
> +
> +/* Max number of tokens supported. Increase if larger objects are expect=
ed */
> +#define JSON_DEFAULT_TOKENS 30
> +
> +#define TOK_LEN(token) (token)->end - (token)->start
> +#define TOK_PTR(json, token) (void *)((json) + (token)->start)
> +
> +struct json_iter {
> +	const char *json;
> +	size_t json_len;
> +	jsmntok_t *tokens;
> +	int tokens_len;
> +	jsmn_parser *p;
> +	struct l_queue *children;
> +	bool root : 1;
> +};
> +
> +static struct json_iter *iter_recurse(struct json_iter *parent,
> +					jsmntok_t *object)
> +{
> +	struct json_iter *iter =3D l_new(struct json_iter, 1);
> +
> +	iter->json =3D parent->json;
> +	iter->json_len =3D parent->json_len;
> +	iter->tokens =3D object;
> +	iter->children =3D l_queue_new();
> +
> +	/*
> +	 * Since object->size only indicates the number of keys in an object
> +	 * we cannot easily calculate the number of tokens remaining (for this
> +	 * object) since each object may have nested objects. Set tokens_len to
> +	 * the number of tokens remaining in the overall list after 'object'

This seems brittle.  Can we recursively count the number of tokens for each=
 child?

> +	 */
> +	iter->tokens_len =3D parent->tokens_len -
> +				((object - parent->tokens) % sizeof(jsmntok_t));
> +
> +	l_queue_push_head(parent->children, iter);
> +
> +	return iter;
> +}
> +
> +struct json_iter *json_iter_new(const char *json, size_t json_len)
> +{
> +	struct json_iter *iter =3D l_new(struct json_iter, 1);
> +
> +	iter->json =3D json;
> +	iter->json_len =3D json_len;
> +	iter->p =3D l_new(jsmn_parser, 1);

Do you need jsmn_init here?

> +	iter->tokens =3D l_new(jsmntok_t, JSON_DEFAULT_TOKENS);
> +	iter->root =3D true;
> +
> +	jsmn_init(iter->p);
> +	iter->tokens_len =3D jsmn_parse(iter->p, iter->json, iter->json_len,
> +					iter->tokens, JSON_DEFAULT_TOKENS);
> +	if (iter->tokens_len < 0) {
> +		json_iter_free(iter);
> +		return NULL;
> +	}
> +
> +	iter->children =3D l_queue_new();
> +
> +	return iter;
> +}
> +
> +static void json_iter_destroy(void *data)
> +{
> +	struct json_iter *iter =3D data;
> +
> +	json_iter_free(iter);
> +}
> +
> +void json_iter_free(struct json_iter *iter)
> +{
> +	if (iter->root) {
> +		l_free(iter->p);
> +		l_free(iter->tokens);
> +	}
> +
> +	l_queue_destroy(iter->children, json_iter_destroy);

You could do:
l_queue_destroy(iter->children,
	(l_queue_destroy_func_t *) json_iter_free);

> +	l_free(iter);
> +}
> +
> +static jsmntok_t *next_key(struct json_iter *iter, jsmntok_t *current)
> +{
> +	jsmntok_t *value;
> +	int i;
> +
> +	/*
> +	 * In theory JSMN should prevent any of these bounds checks from failing

Not very reassuring :)

> +	 */
> +	if (current + 1 > iter->tokens + iter->tokens_len)
> +		return NULL;
> +
> +	value =3D current + 1;
> +
> +	if (value->size =3D=3D 0)
> +		return value + 1;

So value->size =3D=3D 0 implies a basic type?

> + > +	for (i =3D 0; i < value->size; i++)
> +		value =3D next_key(iter, value);

So this should be recursively skipping tokens when value is non-basic.  The =

naming is a bit confusing here

> +
> +	return value;

Since you're returning 'value', but the reader expects a 'key'.

> +}
> +
> +/*
> + * Checks that the keys value (t + 1) is in bounds, the value type match=
es,
> + * key length matches, and key string match
> + */
> +#define TOKEN_MATCHES(iter, t, key, type) \
> +	(t) + 1 < iter->tokens + iter->tokens_len && \
> +	(jsmntype_t)(type) =3D=3D ((t) + 1)->type && \
> +	TOK_LEN((t)) =3D=3D (int)strlen((key)) && \
> +	!memcmp(TOK_PTR((iter)->json, (t)), (key), TOK_LEN((t)))
> +
> +bool json_iter_parse(struct json_iter *iter, ...)
> +{
> +	va_list va;
> +	int i;
> +	int num =3D iter->tokens->size;
> +	jsmntok_t *next;
> +	struct iovec *sval;
> +	struct json_iter **oval;
> +
> +	/* Empty object {} */
> +	if (iter->tokens_len < 1)
> +		return false;
> +
> +	va_start(va, iter);
> +
> +	while (true) {
> +		enum json_flag flag;
> +		char *key;
> +		enum json_type type;
> +		void *value;
> +		jsmntok_t *v =3D NULL;
> +
> +		flag =3D va_arg(va, enum json_flag);
> +
> +		if (flag =3D=3D JSON_FLAG_INVALID)
> +			break;
> +
> +		key =3D va_arg(va, char *);
> +		type =3D va_arg(va, enum json_type);
> +		value =3D va_arg(va, void *);
> +
> +		next =3D iter->tokens + 1;
> +
> +		/* Iterate over this objects keys */
> +		for (i =3D 0; i < num; i++) {
> +			if (TOKEN_MATCHES(iter, next, key, type)) {
> +				v =3D next + 1;
> +				break;

What if the key matches but the type doesn't?  Shouldn't we bail early?

> +			}
> +
> +			next =3D next_key(iter, next);
> +			if (!next)
> +				return false;

May not be as big of a deal in this particular case, but this approach is =

side-effecting on failure.  You could parse the object part of the way thro=
ugh, =

then fail to find a key and bail, but you may have assigned stuff along the=
 way.

> +		}
> +
> +		if (flag =3D=3D JSON_FLAG_MANDATORY && !v)
> +			return false;
> +
> +		switch (type) {
> +		case JSON_STRING:
> +			if (!value)
> +				continue;
> +
> +			sval =3D value;
> +			sval->iov_base =3D v ? TOK_PTR(iter->json, v) : NULL;
> +			sval->iov_len =3D v ? TOK_LEN(v) : 0;
> +
> +			break;
> +		case JSON_OBJECT:
> +			if (!value)
> +				continue;
> +
> +			oval =3D value;
> +			*oval =3D v ? iter_recurse(iter, v) : NULL;
> +
> +			break;
> +		default:
> +			return false;
> +		}
> +	}
> +
> +	va_end(va);
> +
> +	return true;
> +}
> diff --git a/src/json.h b/src/json.h
> new file mode 100644
> index 00000000..202445ee
> --- /dev/null
> +++ b/src/json.h
> @@ -0,0 +1,84 @@
> +/*
> + *
> + *  Wireless daemon for Linux
> + *
> + *  Copyright (C) 2021  Intel Corporation. All rights reserved.
> + *
> + *  This library is free software; you can redistribute it and/or
> + *  modify it under the terms of the GNU Lesser General Public
> + *  License as published by the Free Software Foundation; either
> + *  version 2.1 of the License, or (at your option) any later version.
> + *
> + *  This library is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + *  Lesser General Public License for more details.
> + *
> + *  You should have received a copy of the GNU Lesser General Public
> + *  License along with this library; if not, write to the Free Software
> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-130=
1  USA
> + *
> + */
> +
> +struct json_iter;
> +
> +/*
> + * Identical to JSMN types
> + */
> +enum json_type {
> +	JSON_UNDEFINED =3D 0,
> +	JSON_OBJECT =3D 1 << 0,
> +	JSON_ARRAY =3D 1 << 1,
> +	JSON_STRING =3D 1 << 2,
> +	JSON_PRIMITIVE =3D 1 << 3
> +};
> +
> +enum json_flag {
> +	JSON_FLAG_INVALID =3D 0,
> +	JSON_FLAG_MANDATORY =3D 1,
> +	JSON_FLAG_OPTIONAL =3D 2,
> +};
> +
> +#define JSON_MANDATORY(key, type, out) \
> +	JSON_FLAG_MANDATORY, (key), (type), (out)
> +
> +#define JSON_OPTIONAL(key, type, out) \
> +	JSON_FLAG_OPTIONAL, (key), (type), (out)
> +
> +#define JSON_STR_EQ(iov, s) \
> +	((iov)->iov_len =3D=3D strlen((s)) && \
> +	!memcmp((iov)->iov_base, (s), (iov)->iov_len))
> +
> +#define JSON_TO_STR(iov) \
> +({ \
> +	char *_tmp =3D l_malloc((iov)->iov_len + 1); \
> +	memcpy(_tmp, (iov)->iov_base, (iov)->iov_len); \
> +	_tmp[(iov)->iov_len] =3D '\0'; \
> +	_tmp; \
> +})
> +
> +struct json_iter *json_iter_new(const char *json, size_t json_len);
> +void json_iter_free(struct json_iter *iter);
> +
> +/*
> + * Parse an arbitrary number of key/value pairs from a JSON iterator. In=
itially
> + * a new JSON iterator should be created with json_iter_new() and, when =
done,
> + * freed with json_iter_free. Nested objects are also parsed with this f=
unction
> + * but these iterators should not be freed and are tracked by the origin=
al
> + * iterator.
> + *
> + * Arguments should be specified using JSON_MANDATORY or JSON_OPTIONAL:
> + *
> + * r =3D json_iter_parse(iter, JSON_MANDATORY("mykey", JSON_STRING, &str=
value),
> + * 			JSON_OPTIONAL("optkey", JSON_STRING, &optvalue));
> + *
> + * String values should be of type struct iovec *
> + * Object values should be of type struct json_iter **
> + *
> + * No other types are supported at this time, and json_iter_parse will f=
ail if
> + * other types are encountered.
> + *
> + * JSON_OPTIONAL string values will have a NULL/0 iov_base/iov_len if th=
ey were
> + * not found. JSON_OPTIONAL object value iterators will be NULL if not f=
ound.
> + */
> +bool json_iter_parse(struct json_iter *iter, ...);

Just a nit, but it is a bit clearer to start the '...' after either a =

printf-style string or an argument that could carry the sentintel value.  F=
or =

example:

int nl80211_parse_attrs(struct l_genl_msg *msg, int tag, ...);

It isn't much, but gives just a bit extra context for how the API is suppos=
ed to =

be used.  So in the case of json_iter_parse it would be enum json_flag.

Though really, I wonder why json_iter_parse doesn't use the sequence of:

(json_type, key, value, flags) ?

Regards,
-Denis
--===============1034423747247074455==--

