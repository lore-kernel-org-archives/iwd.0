Content-Type: multipart/mixed; boundary="===============7229311991465331614=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v2 3/5] tools: add decrypt-profile tool
Date: Wed, 02 Feb 2022 14:06:50 -0600
Message-ID: <4f9b41d8-b1fc-10b1-972e-be15064d7a17@gmail.com>
In-Reply-To: 0f83741e9822343bc98e47d3074f8061588f7847.camel@gmail.com

--===============7229311991465331614==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

>>> +#include <stdio.h>
>>> +#include <unistd.h>
>>> +#include <libgen.h> > +#include <fcntl.h>
>>
>> Isn't sys/stat.h enough? In any case, you might want to group related
>> #includes
>> together.
> =

> libgen.h is for basename(). The pattern I usually follow groups all

I meant for fcntl.h and stat.h.  They usually go together.  Having libgen.h=
 in =

between was sort of unusual.

>>
>> Note that you will also get errors from this function as well.=C2=A0 So
>> I'm not sure
>> if you want to re-design it to not print unnecessarily.
> =

> __storage_decrypt() shouldn't print anything in this context since I
> haven't enabled logging (previous patch sets did though).

Ok fair enough.  I couldn't recall whether l_error was always printed or no=
t. =

Still, it may be better to return a -ERRNO and print based on that from a h=
igher =

level function.

Regards,
-Denis
--===============7229311991465331614==--

