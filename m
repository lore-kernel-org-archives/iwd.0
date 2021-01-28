Content-Type: multipart/mixed; boundary="===============6941422201276499875=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 1/2] netdev: preserve cur_rssi_low across reassociation
Date: Thu, 28 Jan 2021 13:40:34 -0600
Message-ID: <11d16fbc-7e12-decc-fecf-ab3627c5a535@gmail.com>
In-Reply-To: <20210128132428.1402427-1-alsi@bang-olufsen.dk>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6941422201276499875==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alvin,

On 1/28/21 7:24 AM, Alvin =C5=A0ipraga wrote:
> Fix an issue with the recent changes to signal monitoring from commit
> f456501b ("station: retry roaming unless notified of a high RSSI"):
> =

>      1. driver sends NL80211_CQM_RSSI_THRESHOLD_EVENT_LOW
>      2. netdev->cur_rssi_low changes from FALSE to TRUE
>      3. netdev sends NETDEV_EVENT_RSSI_THRESHOLD_LOW to station
>      4. on roam reassociation, cur_rssi_low is reset to FALSE
>      5. station still assumes RSSI is low, periodically roams
>         until netdev sends NETDEV_EVENT_RSSI_THRESHOLD_HIGH
>      6. driver sends NL80211_CQM_RSSI_THRESHOLD_EVENT_HIGH
>      7. netdev->cur_rssi_low doesn't change (still FALSE)
>      8. netdev never sends NETDEV_EVENT_RSSI_THRESHOLD_HIGH
>      9. station remains stuck in an infinite roaming loop
> =

> The commit in question introduced the logic in (5). Previously the
> assumption in station was - like in netdev - that if the signal was
> still low, the driver would send a duplicate LOW event after
> reassociation. This change makes netdev follow the same new logic as
> station, i.e. assume the same signal state (LOW/HIGH) until told
> otherwise by the driver.
> ---
> v1 -> v2:
> - No changes to this patch, but added an autotest to the patch series to
>    validate the fix
>   src/netdev.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> =


Applied, thanks.

Regards,
-Denis

--===============6941422201276499875==--

