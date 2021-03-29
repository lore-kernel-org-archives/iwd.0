Content-Type: multipart/mixed; boundary="===============4641054101863808462=="
MIME-Version: 1.0
From: Mauro Condarelli <mc5686@mclink.it>
Subject: Re: iwctl force autoconnect
Date: Mon, 29 Mar 2021 21:44:32 +0200
Message-ID: <9cc67c48-9868-cb83-1a75-372e1cbdfe08@mclink.it>
In-Reply-To: <63c707d6-ee4b-f334-3a97-ce26162f3227@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4641054101863808462==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 3/29/21 8:11 PM, Denis Kenzior wrote:
> Hi Mauro,
>
>>> So while connected, it should just be 'station wlan0 connect <some othe=
r network>'.=C2=A0 iwd will gracefully switch networks=C2=A0 (disconnect fr=
om old + connect to new) for you.
>> That is not exactly what I asked.
>> This is for use case "I want to connect to a specific network".
>>
>> I asked for the "negated": "please connect to *any* net=C2=A0 *but* the =
current one".
>>
>
> That is not a usecase we support and I'm not sure I understand why that w=
ould even be wanted.=C2=A0 Patches are always welcome of course.
My "real use case" (I don't know how "compelling" it may be since workaroun=
ds are available) is:
- I am maintaining a small headless device that's sold through a net of "in=
stallers".
- Installer gets a bunch of devices and preconfigures them "at home", often=
 using his cellphone hotspot as A.P.
- Preconfigured devices are then taken to customer where the customer netwo=
rk is set-up.
- A physical pushbutton switches device in "production mode" (switching fro=
m cellphone HS to whatever else).
- if something goes wrong same PB can revert in "programming mode" (should =
go back to installer HS).

Currently switching involves powering down either cellphone HS (easy) or cu=
stomer AP (a nuisance).

Having a way to "cycle through available" without actually having the names=
 would be handy.

>
>> There are also cases where you want to temporarily disconnect and later =
reconnect to the same or other net, without necessarily having preferences.
>
> That is what rfkill is for.
I'm unsure if it could be made available on our target; I'll check. Thanks =
for the hint.

>
>>
>> This would be particularly useful for "unattended servers" where there's=
 nobody to actually chose.
>>
>> I think a "enter autoconnect state" command could be useful, at the very=
 least for testing/fallback.
>
> Perhaps.=C2=A0 We've been contemplating doing this and are quite open to =
the idea. But no one has yet formulated a concrete and compelling use case =
for us to do so.
Please see above.
That is my real use-case.

>
> Regards,
> -Denis
> _______________________________________________
> iwd mailing list -- iwd(a)lists.01.org
> To unsubscribe send an email to iwd-leave(a)lists.01.org
Regards
Mauro

--===============4641054101863808462==--

