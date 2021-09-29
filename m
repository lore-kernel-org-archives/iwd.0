Content-Type: multipart/mixed; boundary="===============2247998787280376554=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH] station: Move netconfig_reset() to common path
Date: Wed, 29 Sep 2021 17:07:26 -0500
Message-ID: <2e596fd9-c849-e3b2-f296-6fffadef29af@gmail.com>
In-Reply-To: CAOq732KHRh4HvDnGaKXqe4SPH=K=Hju=GJ-i9OJwap=jXQcKGA@mail.gmail.com

--===============2247998787280376554==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 9/29/21 5:05 PM, Andrew Zaborowski wrote:
> Hi Denis,
> =

> On Wed, 29 Sept 2021 at 22:06, Denis Kenzior <denkenz(a)gmail.com> wrote:
>> On 9/29/21 11:42 AM, Andrew Zaborowski wrote:
>>> Move the netconfig_reset calls to inside
>>> station_reset_connection_state() instead of having each caller do
>>
>> This is on purpose.  There should be no need to call netconfig_reset if
>> netconfig_configure wasn't called in the first place.
> =

> In this case it *was* called, then for some reason the driver
> deauthenticated when we requested a scan (from_ap is false), netdev

That would be useful info and should be in the commit description ;)

> emitted a NETDEV_EVENT_DISCONNECT_BY_SME and we end up in
> station_connect_cb.  You're right in that station_connect_cb also

Then that sounds like a bug or another side-effect of delaying the CONNECTE=
D =

state until netconfig is done.    NETDEV_EVENT_DISCONNECT_BY_SME should res=
ult =

in station_disassociated() and not station_connect_cb()

> handles failures before the netconfig_configure call, so if you want
> to avoid the potentially unneeded netconfig_reset() I can move it
> inside station_disconnect_event to avoid bigger changes.

Regards,
-Denis
--===============2247998787280376554==--

