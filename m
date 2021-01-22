Content-Type: multipart/mixed; boundary="===============5488465812877082038=="
MIME-Version: 1.0
From: Alvin =?unknown-8bit?q?=C5=A0ipraga?= <ALSI@bang-olufsen.dk>
Subject: Re: [PATCH] build: add After=network-pre.target to service files
Date: Fri, 22 Jan 2021 14:30:23 +0000
Message-ID: <ca018619-8f97-a95b-a326-8059e9a3f9e0@bang-olufsen.dk>
In-Reply-To: <977EC844-07CA-4C62-9D07-ED47C97A52E8@holtmann.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5488465812877082038==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

On 1/22/21 3:23 PM, Marcel Holtmann wrote:
> Hi Alvin,
> =

>>>> systemd specifies a special passive target unit 'network-pre.target'
>>>> which may be pulled in by services that want to run before any network
>>>> interface is brought up or configured. Correspondingly, network
>>>> management services such as iwd and ead should specify
>>>> After=3Dnetwork-pre.target to ensure a proper ordering with respect to
>>>> this special target.
>>>>
>>>> For more information, see systemd.special(7) and [1].
>>>>
>>>> [1] https://eur02.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%=
2Fwww.freedesktop.org%2Fwiki%2FSoftware%2Fsystemd%2FNetworkTarget%2F&amp;da=
ta=3D04%7C01%7CALSI%40bang-olufsen.dk%7C4a32db4d987e4efc7d6308d8bee156bf%7C=
210d08b883f7470abc96381193ca14a1%7C0%7C0%7C637469222325018888%7CUnknown%7CT=
WFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%=
3D%7C1000&amp;sdata=3D6%2F2JTpn33jTcD%2FxAO2shrzplIB1Tvh0SgZOyXMD%2FiII%3D&=
amp;reserved=3D0
>>>
>>> so what does this really do in practice. Both daemons are fully hotplug=
 aware and it makes no difference when they are started.
>>
>> I can give two examples.
>>
>> The first is practical and we encountered it in our embedded system. The
>> second is hypothetical, but perhaps a little more convincing.
>>
>> 1. We have a oneshot service which must run to perform some platform
>> specific configuration of our wireless network interface before it is
>> ready to be used. One such thing is does is set the MAC address
>> according to some data in an EEPROM. While restructuring the service
>> file for this oneshot service I removed the line:
>>
>> 	Before=3Diwd.service systemd-networkd.service
>>
>> and replaced it with:
>>
>> 	Before=3Dnetwork-pre.target
>>
>> ... as is suggested in systemd's documentation. This seemed good to me
>> because it is more generic.
>>
>> I then noticed that during boot, iwd would run before this service and
>> connect to an AP. The AP was then kicking us off during the MAC address
>> change. This is how I noticed that iwd was not respecting the
>> network-pre.target order.
>>
>> FYI we are using a driver (brcmfmac) which doesn't allow
>> creating/destroying the primary interface.
>>
>> 2. Since iwd (and ead? never used it) can also do IP network
>> configuration, it's possible that it runs and does this stuff before
>> certain firewall rules are applied. This is the rationale given in the
>> systemd documentation.
> =

> fair points. Please put them into the commit message so that when we ever=
 git blame this change, we know why it made sense.

Sure, I'll send a v2 patch in a moment.

> =

> Just to note, I always hate that if you have to delay a service from star=
ting up as early as possible and get the hardware ready to be used. Nobody =
worried about these things until we made it so blazing fast that WiFi will =
be ready and connected before you need it. They way how it should have been=
 from the start.

Yeah I am also not a fan. The real truth is that the oneshot service I =

described is an ugly hack that we have to put up with, which is why I =

thought the firewall argument is rather more convincing.

If it makes you feel any better, this change only has an effect if the =

system administrator has actually configured such a service which =

specifies Before=3Dnetwork-pre.target and Wants=3Dnetwork-pre.target. The =

network-pre.target on its own is passive and doesn't get pulled in just =

because iwd says it should start After=3Dnetwork-pre.target. So the ideal =

world you describe is hopefully not affected by this change.

Kind regards,
Alvin
--===============5488465812877082038==--

