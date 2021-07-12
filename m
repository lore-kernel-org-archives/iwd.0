Content-Type: multipart/mixed; boundary="===============8787878800550425604=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Bug with RoamThreshold5G
Date: Mon, 12 Jul 2021 11:22:37 -0500
Message-ID: <59b2891f-bd46-ee96-a734-3ebe5be7d066@gmail.com>
In-Reply-To: <CACsRnHXxRm=yNaPBzwGKkymvv9H3PDHfwGKbJnDc5VYcV0d=6w@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8787878800550425604==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On 7/12/21 8:17 AM, Michael Johnson wrote:
> Hi everyone,
> =

> I noticed that iwd wasn't roaming as much as I would expect given a
> modified RoamTheshold5G
> value. Looking into it, it seems like when the threshold is registered
> for updates in
> netdev_build_cmd_cqm_rssi_update we always use RoamThreshold. When
> this bit of code is
> called the frequency seems to always be 0 and so the non-5G variant is
> used. This in turn becomes an issue once the frequency is set and the
> correct threshold is used for other checks (at least if
> RoamThreshold5G is configured higher than RoamThreshold).
> =

> Code:
> netdev_build_cmd_cqm_rssi_update(...)
>      int threshold =3D netdev->frequency > 4000 ? LOW_SIGNAL_THRESHOLD_5G=
HZ :
> =

>     LOW_SIGNAL_THRESHOLD;
>      l_debug("frequency: %u, threshold: %d", netdev->frequency,
> threshold); // added for debug
> =

> Config:
> [General]
> EnableNetworkConfiguration=3Dtrue
> RoamThreshold=3D-60
> RoamThreshold5G=3D-65
> =

> Output:
> src/netdev.c:netdev_build_cmd_cqm_rssi_update() frequency: 0, threshold: =
-60
> =


Yep, seems we forgot to invoke netdev_cqm_rssi_update() in =

netdev_connect/netdev_reassociate/netdev_fast_transition*

> I'm not really sure what the right fix for this is. Can it just
> request notifications for both
> thresholds?

Probably not.  If the driver doesn't support NL80211_EXT_FEATURE_CQM_RSSI_L=
IST, =

then we can only set a single threshold and we want that to be the roaming =

threshold.

Regards,
-Denis
--===============8787878800550425604==--

