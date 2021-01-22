Content-Type: multipart/mixed; boundary="===============2816674891410801064=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/3] station: retry roaming unless notified of a high RSSI
Date: Fri, 22 Jan 2021 13:50:38 -0600
Message-ID: <83dfa7f3-d433-6278-82a4-a55952ddc727@gmail.com>
In-Reply-To: <20210122133659.577139-1-alsi@bang-olufsen.dk>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2816674891410801064==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alvin,

On 1/22/21 7:37 AM, Alvin =C5=A0ipraga wrote:
> Following a successful roaming sequence, schedule another attempt unless
> the driver has sent a high RSSI notification. This makes the behaviour
> analogous to a failed roaming attempt where we remained connected to the
> same BSS.
> =

> This makes iwd compatible with wireless drivers which do not necessarily
> send out a duplicate low RSSI notification upon reassociation. Without
> this change, iwd risks getting indefinitely stuck to a BSS with low
> signal strength, even though a better BSS might later become available.
> =

> In the case of a high RSSI notification, the minimum roam time will also
> be reset to zero. This preserves the original behaviour in the case
> where a high RSSI notification is processed after station_roamed().
> Doing so also gives a chance for faster roaming action in the following
> example scenario:
> =

>      1. RSSI LOW
>      2. schedule roam in 5 seconds
>          (5 seconds pass)
>      3. try roaming
>      4. roaming fails, same BSS
>      5. schedule roam in 60 seconds
>          (20 seconds pass)
>      6. RSSI HIGH
>      7. cancel scheduled roam
>          (20 seconds pass)
>      8. RSSI LOW
>      9. schedule roam in 5 seconds or 20 seconds?
> =

> By resetting the minimum roam time, we can avoid waiting 20 seconds when
> the station may have moved considerably. And since the high/low RSSI
> notifications are configured with a hysteresis, we should still be
> protected against too frequent spurious roaming attempts.
> ---
>   src/station.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> =


All applied, thanks!

Any chance you would be willing (or at least attempt) to add an auto test f=
or =

some of the above scenarios?

Regards,
-Denis
--===============2816674891410801064==--

