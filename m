Content-Type: multipart/mixed; boundary="===============3235371379813301348=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v2 4/9] json: add support for array iteration
Date: Thu, 06 Jan 2022 14:25:48 -0600
Message-ID: <26835ea5-3abb-f49f-7225-803711d3c973@gmail.com>
In-Reply-To: 20220106195007.528618-4-prestwoj@gmail.com

--===============3235371379813301348==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 1/6/22 13:50, James Prestwood wrote:
> Arrays can now be parsed using the JSON_ARRAY type (stored in
> a struct json_iter) then iterated using json_iter_next. When
> iterating the type can be checked with json_iter_get_type. For
> each iteration the value can be obtained using any of the type
> getters (int/uint/boolean/null).
> ---
>   src/json.c | 56 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
>   src/json.h |  4 ++++
>   2 files changed, 59 insertions(+), 1 deletion(-)
> =



> diff --git a/src/json.c b/src/json.c
> index 6c88ed3a..cf233e56 100644
> --- a/src/json.c
> +++ b/src/json.c
> @@ -88,7 +88,17 @@ static void iter_recurse(struct json_iter *iter, jsmnt=
ok_t *token,
>   =

>   	child->contents =3D c;
>   	child->start =3D token - c->tokens;
> +	child->current =3D child->start;
>   	child->count =3D count_tokens_in_container(iter, token);
> +
> +	/*
> +	 * Add one to include the object/array token itself. This is required
> +	 * since 'current' points to the container initially. Only after a call
> +	 * to json_iter_next() will 'current' point to the first token in the
> +	 * container.
> +	 */
> +	if (token->type =3D=3D JSMN_OBJECT || token->type =3D=3D JSMN_ARRAY)
> +		child->count++;
>   }

This seems a bit dangerous since count is set based on ITER_END in patch 1.=
  Is =

there a chance this ends up allowing going past the allocated tokens?

I'm guessing you are trying to account for a slight difference in behavior =
of =

json_iter depending on what type it points to:
- if json_iter points to JSMN_PRIMITIVE,
then json_iter_next should not be called (and should fail)
- if json_iter points to JSMN_OBJECT/ARRAY, then json_iter_next has to be c=
alled =

prior to obtaining the first element

Am I right so far?

>   =

>   struct json_contents *json_contents_new(const char *json, size_t json_l=
en)

<snip>

> @@ -370,3 +382,45 @@ bool json_iter_get_null(struct json_iter *iter)
>   =

>   	return false;
>   }
> +
> +enum json_type json_iter_get_type(struct json_iter *iter)
> +{
> +	struct json_contents *c =3D iter->contents;
> +	jsmntok_t *t =3D c->tokens + iter->current;
> +
> +	return (enum json_type) t->type;
> +}
> +
> +bool json_iter_next(struct json_iter *iter)
> +{
> +	struct json_contents *c =3D iter->contents;
> +	jsmntok_t *t =3D c->tokens + iter->current;
> +	int inc =3D 1;
> +
> +	/*
> +	 * If this is the initial iteration skip this and just increment
> +	 * current by 1 since this iterator points to a container which needs to
> +	 * be advanced to the first token..
> +	 *
> +	 * In addition primitive types and empty containers will have a size
> +	 * of 1, so no special handling is needed there.
> +	 *
> +	 * For non-empty containers 'current' needs to be advanced by all the
> +	 * containers child tokens, plus the container itself.

One idea might be to use the 'size' variable of the start token to know whe=
ther =

the iterator can be advanced or not.  Alternatively, look up the base type =
of =

the iterator at the start token and modify the behavior here accordingly.

> +	 *
> +	 * This check ensures:
> +	 *    1. It is not the initial iteration
> +	 *    2. This is a container
> +	 *    3. The container is not empty
> +	 */
> +	if (iter->current !=3D iter->start && ((t->type =3D=3D JSMN_OBJECT ||
> +					t->type =3D=3D JSMN_ARRAY) && t->size))
> +		inc =3D count_tokens_in_container(iter, t) + 1;
> +
> +	if (c->tokens + iter->current + inc >=3D ITER_END(iter))
> +		return false;
> +
> +	iter->current +=3D inc;
> +
> +	return true;
> +}

Regards,
-Denis
--===============3235371379813301348==--

