Content-Type: multipart/mixed; boundary="===============3285218420111337259=="
MIME-Version: 1.0
From: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: [PATCH] build: add After=network-pre.target to service files
Date: Fri, 22 Jan 2021 15:43:54 +0100
Message-ID: <d460d9e4-f648-ef62-8cb2-1065ba3f3951@molgen.mpg.de>
In-Reply-To: <ca018619-8f97-a95b-a326-8059e9a3f9e0@bang-olufsen.dk>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3285218420111337259==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Dear Alvin,


Am 22.01.21 um 15:30 schrieb Alvin =C5=A0ipraga:

> On 1/22/21 3:23 PM, Marcel Holtmann wrote:

>>>>> systemd specifies a special passive target unit 'network-pre.target'
>>>>> which may be pulled in by services that want to run before any network
>>>>> interface is brought up or configured. Correspondingly, network
>>>>> management services such as iwd and ead should specify
>>>>> After=3Dnetwork-pre.target to ensure a proper ordering with respect to
>>>>> this special target.
>>>>>
>>>>> For more information, see systemd.special(7) and [1].
>>>>>
>>>>> [1] https://eur02.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F=
%2Fwww.freedesktop.org%2Fwiki%2FSoftware%2Fsystemd%2FNetworkTarget%2F&amp;d=
ata=3D04%7C01%7CALSI%40bang-olufsen.dk%7C4a32db4d987e4efc7d6308d8bee156bf%7=
C210d08b883f7470abc96381193ca14a1%7C0%7C0%7C637469222325018888%7CUnknown%7C=
TWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0=
%3D%7C1000&amp;sdata=3D6%2F2JTpn33jTcD%2FxAO2shrzplIB1Tvh0SgZOyXMD%2FiII%3D=
&amp;reserved=3D0

Good job Outlook. ;-)

>>>> so what does this really do in practice. Both daemons are fully hotplu=
g aware and it makes no difference when they are started.
>>>
>>> I can give two examples.
>>>
>>> The first is practical and we encountered it in our embedded system. The
>>> second is hypothetical, but perhaps a little more convincing.
>>>
>>> 1. We have a oneshot service which must run to perform some platform
>>> specific configuration of our wireless network interface before it is
>>> ready to be used. One such thing is does is set the MAC address
>>> according to some data in an EEPROM. While restructuring the service
>>> file for this oneshot service I removed the line:
>>>
>>> 	Before=3Diwd.service systemd-networkd.service
>>>
>>> and replaced it with:
>>>
>>> 	Before=3Dnetwork-pre.target
>>>
>>> ... as is suggested in systemd's documentation. This seemed good to me
>>> because it is more generic.
>>>
>>> I then noticed that during boot, iwd would run before this service and
>>> connect to an AP. The AP was then kicking us off during the MAC address
>>> change. This is how I noticed that iwd was not respecting the
>>> network-pre.target order.
>>>
>>> FYI we are using a driver (brcmfmac) which doesn't allow
>>> creating/destroying the primary interface.
>>>
>>> 2. Since iwd (and ead? never used it) can also do IP network
>>> configuration, it's possible that it runs and does this stuff before
>>> certain firewall rules are applied. This is the rationale given in the
>>> systemd documentation.
>>
>> fair points. Please put them into the commit message so that when
>> we ever git blame this change, we know why it made sense.
> =

> Sure, I'll send a v2 patch in a moment.
> =

>> Just to note, I always hate that if you have to delay a service =

>> from starting up as early as possible and get the hardware ready to
>> be used. Nobody worried about these things until we made it so =

>> blazing fast that WiFi will be ready and connected before you need
>> it. They way how it should have been from the start.

Marcel, do you have a suggestion for the firewall rules issue? Should =

iwd check it itself, though that wouldn=E2=80=99t be as general?

> Yeah I am also not a fan. The real truth is that the oneshot service I
> described is an ugly hack that we have to put up with, which is why I
> thought the firewall argument is rather more convincing.

I am not sure, but shouldn=E2=80=99t udev provide a way to only mark a devi=
ce as =

activated, if certain conditions are met, in this case your hack was run?

> If it makes you feel any better, this change only has an effect if the
> system administrator has actually configured such a service which
> specifies Before=3Dnetwork-pre.target and Wants=3Dnetwork-pre.target. The
> network-pre.target on its own is passive and doesn't get pulled in just
> because iwd says it should start After=3Dnetwork-pre.target. So the ideal
> world you describe is hopefully not affected by this change.

Yes, good to point that out again. Also, maybe note, that =

systemd-networkd and NetworkManager do the same ordering.


Kind regards,

Paul


PS: I am always pleased to see companies participating in FLOSS development.
--===============3285218420111337259==--

