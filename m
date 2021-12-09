Content-Type: multipart/mixed; boundary="===============2532748653366448963=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v2 2/3] json: introduce JSON module
Date: Thu, 09 Dec 2021 13:23:02 -0600
Message-ID: <9a0a07d9-f2f3-217e-a432-1acf05a6dd75@gmail.com>
In-Reply-To: c663f358b9de6518e67a1bad3fb073d59815b7f6.camel@gmail.com

--===============2532748653366448963==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

>> Have you considered using an intermediate object to hold the bits
>> that need to
>> be opaque?=C2=A0 That way json_iter objects could be public and held on
>> the stack.
>> Would make things easier to use / simpler to implement.
>>
>> So roughly:
>>
>> struct json_contents;
>>
>> struct json_iter {
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct json_contents *c=
ontents;
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int begin;
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int end;
>> };
> =

> This didn't feel consistent with any other iterators on cleanup:
> =

> struct json_iter iter;
> =

> json_iter_init(&iter, json, json_len);
> =

> ...
> =

> json_iter_free(&iter);
> =


Well, you would do something like:

struct json_contents *c;
struct json_iter iter;
struct json_iter nested;
_auto_(l_free) char *foo =3D NULL;

c =3D json_contents_new(json, json_len);

json_iter_init(&iter, c);
json_iter_parse(&iter, JSON_STRING, "foo",
			&foo, JSON_FLAG_MANDATORY,
			JSON_OBJECT, "bar",
			&nested, JSON_FLAG_OPTIONAL,
			JSON_UNDEFINED);

json_iter_parse(&nested, ...);

json_contents_free(c);

>>
>> Do you need jsmn_init here?
> =

> Yes, below.

Ah right, sorry for the noise.

>>
>> So value->size =3D=3D 0 implies a basic type?
> =

> AFAIK any value that is not an object will have a size of zero, so this
> could include strings as well not just basic types.

So essentially anything that is not a container?  integers, strings, etc.

>>
>>> + > +=C2=A0=C2=A0=C2=A0for (i =3D 0; i < value->size; i++)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0value =3D next_key(iter, value);
>>
>> So this should be recursively skipping tokens when value is non-
>> basic.=C2=A0 The
>> naming is a bit confusing here
>>
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return value;
>>
>> Since you're returning 'value', but the reader expects a 'key'.
> =

> Yes, some re-naming is in order. This is actually returning a key
> though, I just reused 'value' rather than a new variable. Something
> like 'token' or 'tmp' would be better.

Right, this is doing the right thing, just nitpicking the variable naming.

>> May not be as big of a deal in this particular case, but this
>> approach is
>> side-effecting on failure.=C2=A0 You could parse the object part of the
>> way through,
>> then fail to find a key and bail, but you may have assigned stuff
>> along the way.
> =

> Yeah I could not think of a decent way to handle this without iterating
> twice (verification first, then assignment) since we lose reference to
> the previous set of arguments with each iteration.

You could iterate over the va_arg list, build a temporary structure and per=
form =

the parse.  If the parse succeeds, then assign the values in the final step.

Regards,
-Denis
--===============2532748653366448963==--

