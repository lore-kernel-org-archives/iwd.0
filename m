Content-Type: multipart/mixed; boundary="===============5734442459692222727=="
MIME-Version: 1.0
From: Alvin =?unknown-8bit?q?=C5=A0ipraga?= <ALSI@bang-olufsen.dk>
Subject: Re: [PATCH] build: add After=network-pre.target to service files
Date: Fri, 22 Jan 2021 15:10:36 +0000
Message-ID: <c366d97a-2a05-7a37-6354-0e99bce8bda0@bang-olufsen.dk>
In-Reply-To: <d460d9e4-f648-ef62-8cb2-1065ba3f3951@molgen.mpg.de>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5734442459692222727==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On 1/22/21 3:43 PM, Paul Menzel wrote:
> Dear Alvin,
> =

> =

> Am 22.01.21 um 15:30 schrieb Alvin =C5=A0ipraga:
> =

>> On 1/22/21 3:23 PM, Marcel Holtmann wrote:
> =

>>>>>> systemd specifies a special passive target unit 'network-pre.target'
>>>>>> which may be pulled in by services that want to run before any =

>>>>>> network
>>>>>> interface is brought up or configured. Correspondingly, network
>>>>>> management services such as iwd and ead should specify
>>>>>> After=3Dnetwork-pre.target to ensure a proper ordering with respect =
to
>>>>>> this special target.
>>>>>>
>>>>>> For more information, see systemd.special(7) and [1].
>>>>>>
>>>>>> [1] =

>>>>>> https://eur02.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F=
www.freedesktop.org%2Fwiki%2FSoftware%2Fsystemd%2FNetworkTarget%2F&amp;data=
=3D04%7C01%7Calsi%40bang-olufsen.dk%7C595d0a9d10594598176108d8bee42888%7C21=
0d08b883f7470abc96381193ca14a1%7C0%7C0%7C637469234430945966%7CUnknown%7CTWF=
pbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D=
%7C1000&amp;sdata=3D1E%2FOj8Mzznx%2BuccUtO2P0ThRLeGv%2FOBvTeZ2d3rIES8%3D&am=
p;reserved=3D0 =

>>>>>>
> =

> Good job Outlook. ;-)

Ugh, don't get me started... :-)

> =

>>>>> so what does this really do in practice. Both daemons are fully =

>>>>> hotplug aware and it makes no difference when they are started.
>>>>
>>>> I can give two examples.
>>>>
>>>> The first is practical and we encountered it in our embedded system. =

>>>> The
>>>> second is hypothetical, but perhaps a little more convincing.
>>>>
>>>> 1. We have a oneshot service which must run to perform some platform
>>>> specific configuration of our wireless network interface before it is
>>>> ready to be used. One such thing is does is set the MAC address
>>>> according to some data in an EEPROM. While restructuring the service
>>>> file for this oneshot service I removed the line:
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0Before=3Diwd.service systemd-networkd.service
>>>>
>>>> and replaced it with:
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0Before=3Dnetwork-pre.target
>>>>
>>>> ... as is suggested in systemd's documentation. This seemed good to me
>>>> because it is more generic.
>>>>
>>>> I then noticed that during boot, iwd would run before this service and
>>>> connect to an AP. The AP was then kicking us off during the MAC address
>>>> change. This is how I noticed that iwd was not respecting the
>>>> network-pre.target order.
>>>>
>>>> FYI we are using a driver (brcmfmac) which doesn't allow
>>>> creating/destroying the primary interface.
>>>>
>>>> 2. Since iwd (and ead? never used it) can also do IP network
>>>> configuration, it's possible that it runs and does this stuff before
>>>> certain firewall rules are applied. This is the rationale given in the
>>>> systemd documentation.
>>>
>>> fair points. Please put them into the commit message so that when
>>> we ever git blame this change, we know why it made sense.
>>
>> Sure, I'll send a v2 patch in a moment.
>>
>>> Just to note, I always hate that if you have to delay a service from =

>>> starting up as early as possible and get the hardware ready to
>>> be used. Nobody worried about these things until we made it so =

>>> blazing fast that WiFi will be ready and connected before you need
>>> it. They way how it should have been from the start.
> =

> Marcel, do you have a suggestion for the firewall rules issue? Should =

> iwd check it itself, though that wouldn=E2=80=99t be as general?
> =

>> Yeah I am also not a fan. The real truth is that the oneshot service I
>> described is an ugly hack that we have to put up with, which is why I
>> thought the firewall argument is rather more convincing.
> =

> I am not sure, but shouldn=E2=80=99t udev provide a way to only mark a de=
vice as =

> activated, if certain conditions are met, in this case your hack was run?

In our case I don't think so... the driver we use automatically creates =

a primary interface and iwd will detect it and start its business right =

away. While I am using systemd's sys-subsystem-net-devices-wlan0.device =

target to trigger the oneshot configuration service, I could equally =

well just use udev. But in both cases it will still be racing against =

iwd. I am not aware of any way to have a network interface in a state =

where it may have its MAC address changed, yet be marked "not ready" in =

a generic way for iwd to detect.

Happy to hear otherwise, though.

> =

>> If it makes you feel any better, this change only has an effect if the
>> system administrator has actually configured such a service which
>> specifies Before=3Dnetwork-pre.target and Wants=3Dnetwork-pre.target. The
>> network-pre.target on its own is passive and doesn't get pulled in just
>> because iwd says it should start After=3Dnetwork-pre.target. So the ideal
>> world you describe is hopefully not affected by this change.
> =

> Yes, good to point that out again. Also, maybe note, that =

> systemd-networkd and NetworkManager do the same ordering.

Yes, I was also motivated by the behaviour of systemd-networkd.

Kind regards,
Alvin

> =

> =

> Kind regards,
> =

> Paul
> =

> =

> PS: I am always pleased to see companies participating in FLOSS =

> development.
> _______________________________________________
> iwd mailing list -- iwd(a)lists.01.org
> To unsubscribe send an email to iwd-leave(a)lists.01.org
--===============5734442459692222727==--

