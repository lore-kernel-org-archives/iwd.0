Content-Type: multipart/mixed; boundary="===============4362705905258729522=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: iwctl force autoconnect
Date: Mon, 29 Mar 2021 13:11:19 -0500
Message-ID: <63c707d6-ee4b-f334-3a97-ce26162f3227@gmail.com>
In-Reply-To: <f5fa26ae-90b5-2e88-1931-512dac405f11@mclink.it>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4362705905258729522==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mauro,

>> So while connected, it should just be 'station wlan0 connect <some other=
 network>'.=C2=A0 iwd will gracefully switch networks=C2=A0 (disconnect fro=
m old + connect to new) for you.
> That is not exactly what I asked.
> This is for use case "I want to connect to a specific network".
> =

> I asked for the "negated": "please connect to *any* net=C2=A0 *but* the c=
urrent one".
> =


That is not a usecase we support and I'm not sure I understand why that wou=
ld =

even be wanted.  Patches are always welcome of course.

> There are also cases where you want to temporarily disconnect and later r=
econnect to the same or other net, without necessarily having preferences.

That is what rfkill is for.

> =

> This would be particularly useful for "unattended servers" where there's =
nobody to actually chose.
> =

> I think a "enter autoconnect state" command could be useful, at the very =
least for testing/fallback.

Perhaps.  We've been contemplating doing this and are quite open to the ide=
a. =

But no one has yet formulated a concrete and compelling use case for us to =
do so.

Regards,
-Denis
--===============4362705905258729522==--

