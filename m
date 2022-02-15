Content-Type: multipart/mixed; boundary="===============5893833998732824809=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v2 1/2] hwsim: allow concurrent radio creations
Date: Tue, 15 Feb 2022 13:40:58 -0600
Message-ID: <6831ecc0-9251-339e-856b-d9d2ac9d669f@gmail.com>
In-Reply-To: 556a79f1b541f77dc4a7b147935b216170425b49.camel@gmail.com

--===============5893833998732824809==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 2/15/22 13:16, James Prestwood wrote:
> Hi Denis,
> =

>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0} else if (!rec)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return;
>>
>> This part seems suspicious.=C2=A0 What if the radio is being created
>> outside hwsim?
> =

> I guess this is changing behavior... Currently we would still create
> the radio info object if the radio was created externally. Keeping this
> behavior will end up requiring creating the radio here and in
> CreateRadio(), nearly the same as what we had before.
> =


CreateRadio really only creates a stub.  What is there to duplicate besides =

l_new and setting the name/id?

> I guess its up to you. Either we don't support external radio creation
> for cleaner code, or we go back to the way it was (or some variant of
> it).
> =


Clearly we want to support this since hwsim might start with radios already =

created and this path is being used by the initial radio dump (started in =

hwsim_ready).

Regards,
-Denis
--===============5893833998732824809==--

