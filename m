Content-Type: multipart/mixed; boundary="===============1216184555554798653=="
MIME-Version: 1.0
From: Alvin =?unknown-8bit?q?=C5=A0ipraga?= <ALSI@bang-olufsen.dk>
Subject: Re: [PATCH] build: add After=network-pre.target to service files
Date: Fri, 22 Jan 2021 14:21:23 +0000
Message-ID: <ba885a68-a885-5d73-eab5-2cf744681e81@bang-olufsen.dk>
In-Reply-To: <eea8d062-2ffb-a1d9-8bbc-5b9b7eafca5b@bang-olufsen.dk>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1216184555554798653==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi again,

On 1/22/21 3:17 PM, Alvin =C5=A0ipraga wrote:
> Hi Marcel,
> =


<snip>

> =

> and replaced it with:
> =

>  =C2=A0=C2=A0=C2=A0=C2=A0Before=3Dnetwork-pre.target

... and also Wants=3Dnetwork-pre.target, but you get the idea.

Kind regards,
Alvin

> =

> ... as is suggested in systemd's documentation. This seemed good to me =

> because it is more generic.
> =

> I then noticed that during boot, iwd would run before this service and =

> connect to an AP. The AP was then kicking us off during the MAC address =

> change. This is how I noticed that iwd was not respecting the =

> network-pre.target order.
> =

> FYI we are using a driver (brcmfmac) which doesn't allow =

> creating/destroying the primary interface.
> =

> 2. Since iwd (and ead? never used it) can also do IP network =

> configuration, it's possible that it runs and does this stuff before =

> certain firewall rules are applied. This is the rationale given in the =

> systemd documentation.
> =

> Kind regards,
> Alvin
> =

>>
>> Regards
>>
>> Marcel
>>
--===============1216184555554798653==--

