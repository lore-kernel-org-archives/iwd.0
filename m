Content-Type: multipart/mixed; boundary="===============7393951024789506492=="
MIME-Version: 1.0
From: Alvin =?unknown-8bit?q?=C5=A0ipraga?= <ALSI@bang-olufsen.dk>
Subject: Re: [PATCH 1/5] auto-t: add test for roaming retry timing
Date: Thu, 28 Jan 2021 09:31:21 +0000
Message-ID: <b5982ad0-edba-81c2-c79c-f9803dd3450e@bang-olufsen.dk>
In-Reply-To: <fa98593e-a8b6-3151-61a7-eb1252df50ea@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7393951024789506492==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 1/27/21 8:19 PM, Denis Kenzior wrote:
> Hi Alvin,
> =

> On 1/27/21 4:05 AM, Alvin =C5=A0ipraga wrote:
>> From: Alvin =C5=A0ipraga <alvin@pqrs.dk>
>>
>> Recent changes make iwd more eager to retry roaming if it has detected a
>> high RSSI since the last attempt. Add an autotest to verify this
>> behaviour.
>> ---
>> =C2=A0 autotests/testRoamRetry/fast_retry_test.py | 145 ++++++++++++++++=
+++++
>> =C2=A0 autotests/testRoamRetry/hw.conf=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 7 +
>> =C2=A0 autotests/testRoamRetry/ssid1.conf=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 11 ++
>> =C2=A0 autotests/testRoamRetry/ssid2.conf=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 11 ++
>> =C2=A0 4 files changed, 174 insertions(+)
>> =C2=A0 create mode 100644 autotests/testRoamRetry/fast_retry_test.py
>> =C2=A0 create mode 100644 autotests/testRoamRetry/hw.conf
>> =C2=A0 create mode 100644 autotests/testRoamRetry/ssid1.conf
>> =C2=A0 create mode 100644 autotests/testRoamRetry/ssid2.conf
>>
> =

> I went ahead and applied this after running dos2unix to fix the weird =

> Windows style line endings.

Hmm, that's strange. Was it just for this patch? I prepared the initial =

commit on a separate machine, but I would be surprised about Windows =

line endings. Just wondering if my outgoing mail is getting modified or =

if my setup is busted in some other way. Could not detect anything wrong =

on my end though...

Kind regards,
Alvin
--===============7393951024789506492==--

