Content-Type: multipart/mixed; boundary="===============1359115336083346239=="
MIME-Version: 1.0
From: Alvin =?unknown-8bit?q?=C5=A0ipraga?= <ALSI@bang-olufsen.dk>
Subject: Re: [PATCH 1/3] station: retry roaming unless notified of a high RSSI
Date: Mon, 25 Jan 2021 09:29:03 +0000
Message-ID: <f669b89f-e8c9-6caf-88b9-0929f5ee1059@bang-olufsen.dk>
In-Reply-To: <83dfa7f3-d433-6278-82a4-a55952ddc727@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1359115336083346239==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 1/22/21 8:50 PM, Denis Kenzior wrote:
> Hi Alvin,
> =

> On 1/22/21 7:37 AM, Alvin =C5=A0ipraga wrote:
>> Following a successful roaming sequence, schedule another attempt unless
>> the driver has sent a high RSSI notification. This makes the behaviour
>> analogous to a failed roaming attempt where we remained connected to the
>> same BSS.
>>
>> This makes iwd compatible with wireless drivers which do not necessarily
>> send out a duplicate low RSSI notification upon reassociation. Without
>> this change, iwd risks getting indefinitely stuck to a BSS with low
>> signal strength, even though a better BSS might later become available.
>>
>> In the case of a high RSSI notification, the minimum roam time will also
>> be reset to zero. This preserves the original behaviour in the case
>> where a high RSSI notification is processed after station_roamed().
>> Doing so also gives a chance for faster roaming action in the following
>> example scenario:
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 1. RSSI LOW
>> =C2=A0=C2=A0=C2=A0=C2=A0 2. schedule roam in 5 seconds
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (5 seconds pass)
>> =C2=A0=C2=A0=C2=A0=C2=A0 3. try roaming
>> =C2=A0=C2=A0=C2=A0=C2=A0 4. roaming fails, same BSS
>> =C2=A0=C2=A0=C2=A0=C2=A0 5. schedule roam in 60 seconds
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (20 seconds pass)
>> =C2=A0=C2=A0=C2=A0=C2=A0 6. RSSI HIGH
>> =C2=A0=C2=A0=C2=A0=C2=A0 7. cancel scheduled roam
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (20 seconds pass)
>> =C2=A0=C2=A0=C2=A0=C2=A0 8. RSSI LOW
>> =C2=A0=C2=A0=C2=A0=C2=A0 9. schedule roam in 5 seconds or 20 seconds?
>>
>> By resetting the minimum roam time, we can avoid waiting 20 seconds when
>> the station may have moved considerably. And since the high/low RSSI
>> notifications are configured with a hysteresis, we should still be
>> protected against too frequent spurious roaming attempts.
>> ---
>> =C2=A0 src/station.c | 12 +++++++-----
>> =C2=A0 1 file changed, 7 insertions(+), 5 deletions(-)
>>
> =

> All applied, thanks!
> =

> Any chance you would be willing (or at least attempt) to add an auto =

> test for some of the above scenarios?

Sure, I'd be happy to. I haven't tried running the autotest suite =

before, so please have some patience with me as I try to figure things out.

Kind regards,
Alvin
--===============1359115336083346239==--

