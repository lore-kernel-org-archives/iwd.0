Content-Type: multipart/mixed; boundary="===============6582068670468394902=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v3 02/10] dpp-util: add URI parsing
Date: Wed, 16 Feb 2022 16:20:15 -0600
Message-ID: <580b75e8-a75a-d6e1-8c68-d47de7005f5f@gmail.com>
In-Reply-To: 912a107f64ac9178ac20bb5e1701dbaf95eeb083.camel@gmail.com

--===============6582068670468394902==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 2/16/22 14:39, James Prestwood wrote:
> Hi Denis,
> =

> <snip>
>>> + */
>>> +struct dpp_uri_info *dpp_parse_uri(const char *uri)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct dpp_uri_info *info;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const char *pos =3D uri;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const char *end =3D uri + st=
rlen(uri) - 1;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int ret =3D 0;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (strncmp(pos, "DPP:", 4))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return NULL;
>>
>> strncmp?=C2=A0 If the string has already been validated to be a valid
>> string, then
>> strcmp is probably just fine.
> =

> Since we're only checking a substring of 'pos' (that the first 4
> characters are DPP:) strncmp is needed.

Ah yes, ignore that comment.

Do note that l_str_has_prefix() exists, so that might be even nicer to use =
here.

>>
>> Unclear here?
> =

> This one is tricky because l_base64_decode doesn't give back the number
> of characters consumed... Maybe l_base64_decode should fail if the
> bytes consumed !=3D length? I don't see any such checks in there.
> =


Yes, we probably should.

Regards,
-Denis
--===============6582068670468394902==--

