Content-Type: multipart/mixed; boundary="===============5423048919528511443=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 7/9] netconfig: Move loading settings to new method,
 refactor
Date: Wed, 25 Aug 2021 17:37:09 -0500
Message-ID: <5fc5be3c-b015-6fa1-bae4-34a06ab8436f@gmail.com>
In-Reply-To: <CAOq732+DLLQqFcEzpJ+hZR1ucCXE8=iMdCU4xCproJhO96eKqw@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5423048919528511443==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

>>> +     l_strfreev(netconfig->dns4_overrides);
>>
>> ? shouldn't this be taken care of by netconfig_reset?
> =

> I thought we might have a future use case for calling
> netconfig_load_settings() multiple times without netconfig_reset
> between, but no strong motivation for that.
> =


Can you elaborate on why we would want that?  But even more reason not to =

side-effect.

>>   We generally don't like
>> side-effects in our APIs.
> =

> I wouldn't call avoiding a leak a side effect ;)
> =


My point is, you shouldn't be setting anything inside netconfig until you k=
now =

the operation will succeed completely.  Doing otherwise makes error handlin=
g a =

nightmare.

netconfig_configure would never fail since it would ignore invalid input.  =
In =

fact, I'm not sure why it had a bool return in the first place.

In this patch you're changing the contract such that netconfig_load_setting=
s =

checks up-front if the networking settings are correct or not.  Side-effect=
ing =

is not desirable in this case.

Regards,
-Denis
--===============5423048919528511443==--

