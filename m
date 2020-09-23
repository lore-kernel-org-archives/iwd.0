Content-Type: multipart/mixed; boundary="===============5525329142846790172=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/5] resolve: Exit methods if resolve is NULL
Date: Tue, 22 Sep 2020 20:48:06 -0500
Message-ID: <e14324b7-5b42-2f7b-4f1a-7cc7d284c81d@gmail.com>
In-Reply-To: <CAOq732LD5V_T8VynvuhoMzH4V8n64Hy0tUx8cCpKhq8zCtYbKg@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5525329142846790172==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 9/22/20 4:34 PM, Andrew Zaborowski wrote:
> Hi Denis,
> =

> On Tue, 22 Sep 2020 at 16:46, Denis Kenzior <denkenz@gmail.com> wrote:
>> On 9/22/20 9:28 AM, Andrew Zaborowski wrote:
>>> On Tue, 22 Sep 2020 at 16:19, Denis Kenzior <denkenz@gmail.com> wrote:
>>>> On 9/21/20 11:18 PM, Andrew Zaborowski wrote:
>>>>> I'm still using netconfig from P2P, I guess we shouldn't require
>>>>> General.EnableNetworkConfiguration to be set for P2P.  P2P doesn't
>>>>> (usually) have DNS so this should still work but maybe the checks
>>>>> should be in netconfig.c after all, not sure.
>>>>
>>>> I don't think it makes sense to have this asymmetry.  Why is P2P speci=
al
>>>> compared to normal station client?
>>>
>>> We also don't have any configuration for P2P netconfig because the
>>> spec mandates the use of DHCP.  There's also no legacy to worry about,
>>> so I don't see the point of making DHCP optional for P2P.
>>
>> That isn't exactly the point I was trying to make.  P2P would always use=
 DHCP or
>> network config KDEs, no disagreement there.  But from a user / system
>> configuration perspective I don't think this asymmetry is something that=
 one
>> would expect or would want.us
>>
>> So if the user has not enabled EnableNetworkConfiguration setting then
>> systemd-networkd (for example) expects to perform DHCP for all WiFi inte=
rfaces.
>> How would you tell systemd-networkd not to configure P2P devices?  They'=
re just
>> WiFi as far as it is concerned.
> =

> Ok, I wouldn't have expected that.  I wonder then if we should wait
> for the IP configuration to finish before returning from dbus calls so
> that the clients can expect consistent behaviour.  And the client
> still needs a way to get the peer's IP.
> =


I think what you're doing now makes sense (i.e methods succeed once IP =

configuration has finished).  I'm just worried about how we interact with =

services that are not NL80211 aware or ones that don't filter by IFTYPE.  N=
ot =

sure how big of an issue this will turn out to be, but I expect this to be =
a bit =

of a mess at first.

Perhaps a mitigating strategy might be for netconfig not to invoke resolve_=
* or =

set default routes if EnableNetworkConfiguration is disabled?  Or maybe jus=
t =

disable P2P if EnableNetworkConfiguration is off?

Long term I think that it makes sense for iwd to do everything related to I=
P =

configuration for P2P.  There might be cases where some external entity mig=
ht =

still want to manage this (I'm thinking NM and to a lesser extent ConnMan).=
  But =

until that is actually an issue I wouldn't worry too much about this yet.

Regards,
-Denis
--===============5525329142846790172==--

