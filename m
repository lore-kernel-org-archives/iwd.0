Content-Type: multipart/mixed; boundary="===============5944438333889457379=="
MIME-Version: 1.0
From: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: [PATCH 8/9] sae: don't send commit in confirmed state
Date: Wed, 08 Sep 2021 15:24:40 +0200
Message-ID: <8cdacee8-07ca-1451-55ca-0c24656d8a1c@molgen.mpg.de>
In-Reply-To: <abf40bb3b4b2d309b5a19343388c308b54a4a3bb.camel@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5944438333889457379==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Dear James,


Am 08.09.21 um 01:34 schrieb James Prestwood:

> On Wed, 2021-09-08 at 01:02 +0200, Paul Menzel wrote:

>> Am 07.09.21 um 23:14 schrieb James Prestwood:
>>> This works around a hostapd bug (described more in the TODO
>>> comment)
>>
>> It=E2=80=99d be great, if you listed the hostapd version, you reproduced=
 this
>> with, and, if you did, add a reference to the hostapd bug report.
> =

> Sure. I did send an email to the hostapd ML if that is considered a bug
> report.

Thank you for doing that. In my book it is. Please add the URL to the =

commit message.

https://lists.infradead.org/pipermail/hostap/2021-September/039842.html

>>> that deaths IWD if the initial commit is not acked. This behavior
>>> has been identified in consumer access points and likely won't ever
>>> be patched for older devices. Because of this IWD must work around
>>> the problem which can be eliminated by not sending out this commit
>>> message.
>>
>> Excuse my ignorance, but how likely is it, that non-hostapd setups
>> keep working?
> =

> Do non-hostapd setups even exist? :) But in reality no it shouldn't
> effect anything. I do need to amend this commit slightly, but v2 will
> have identical behavior as wpa_supplicant, i.e. ignore the commit
> message completely.

Great, it=E2=80=99d be great if you mentioned that.

Also, from the other thread *Re: Cannot connect to SAE protected AP with =

iwd 1.16 and beyond*, if the ell commit really introduced the =

regression, it=E2=80=99d be great if you mentioned that too.


Kind regards,

Paul
--===============5944438333889457379==--

