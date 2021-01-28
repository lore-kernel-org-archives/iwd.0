Content-Type: multipart/mixed; boundary="===============5720274890842701075=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/5] auto-t: add test for roaming retry timing
Date: Thu, 28 Jan 2021 09:17:25 -0600
Message-ID: <562a3df9-dae0-6786-d531-f64e5cc9ee7c@gmail.com>
In-Reply-To: <b5982ad0-edba-81c2-c79c-f9803dd3450e@bang-olufsen.dk>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5720274890842701075==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alvin,

On 1/28/21 3:31 AM, Alvin =C5=A0ipraga wrote:
> Hi Denis,
> =

> On 1/27/21 8:19 PM, Denis Kenzior wrote:
>> Hi Alvin,
>>
>> On 1/27/21 4:05 AM, Alvin =C5=A0ipraga wrote:
>>> From: Alvin =C5=A0ipraga <alvin@pqrs.dk>
>>>
>>> Recent changes make iwd more eager to retry roaming if it has detected a
>>> high RSSI since the last attempt. Add an autotest to verify this
>>> behaviour.
>>> ---
>>>  =C2=A0 autotests/testRoamRetry/fast_retry_test.py | 145 ++++++++++++++=
+++++++
>>>  =C2=A0 autotests/testRoamRetry/hw.conf=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 7 +
>>>  =C2=A0 autotests/testRoamRetry/ssid1.conf=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 11 ++
>>>  =C2=A0 autotests/testRoamRetry/ssid2.conf=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 11 ++
>>>  =C2=A0 4 files changed, 174 insertions(+)
>>>  =C2=A0 create mode 100644 autotests/testRoamRetry/fast_retry_test.py
>>>  =C2=A0 create mode 100644 autotests/testRoamRetry/hw.conf
>>>  =C2=A0 create mode 100644 autotests/testRoamRetry/ssid1.conf
>>>  =C2=A0 create mode 100644 autotests/testRoamRetry/ssid2.conf
>>>
>>
>> I went ahead and applied this after running dos2unix to fix the weird
>> Windows style line endings.
> =

> Hmm, that's strange. Was it just for this patch? I prepared the initial
> commit on a separate machine, but I would be surprised about Windows

Yes, just for that patch.  The others were fine.  These were all new files;=
 were =

they somehow treated differently?

> line endings. Just wondering if my outgoing mail is getting modified or
> if my setup is busted in some other way. Could not detect anything wrong
> on my end though...

Could be the mail server is mangling them.  Doesn't explain why the rest wa=
s =

fine though.

Regards,
-Denis
--===============5720274890842701075==--

