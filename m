Content-Type: multipart/mixed; boundary="===============4797905406901816989=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: CQM RSSI notification in station_roamed()
Date: Thu, 21 Jan 2021 00:46:54 +0100
Message-ID: <CAOq732L2CDDeX1Gae_nQbEGu8Adb1OsAZnNJg5quRTjKZvituA@mail.gmail.com>
In-Reply-To: <8794f161-2852-2056-80cd-172263426028@bang-olufsen.dk>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4797905406901816989==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, 19 Jan 2021 at 11:30, Alvin =C5=A0ipraga <ALSI@bang-olufsen.dk> w=
rote:
> I have been working on CQM RSSI notification support for the brcmfmac
> driver so that roaming can be properly offloaded to iwd. I want to ask
> about this particular behaviour in iwd's station code:
>
>      static void station_roamed(struct station *station)
>      {
>          /*
>           * New signal high/low notification should occur on the next
>           * beacon from new AP.
>           */
>          station->signal_low =3D false;
>          station->roam_min_time.tv_sec =3D 0;
>          station->roam_no_orig_ap =3D false;
>          station->roam_scan_full =3D false;
>
>          ...
>      }
>
> When I look at the kernel API, this doesn't seem quite right to me. At
> least, there doesn't seem to be any onus on the driver to repeat itself.

Right, apparently there isn't.  I imagine a lot of the things we and
wpa_supplicant rely on is not explicitly documented in
include/net/cfg80211.h but the drivers do them perhaps to match
mac80211.  I guess I assumed this was also the case here.  mac80211
sets the IEEE80211_STA_RESET_SIGNAL_AVE flag in
ieee80211_set_associated() which causes the beacon handler to always
emit an RSSI event on the next run.

> This led me to experience the following scenario during my testing:
>
>      - station is connected to a BSS
>      - driver notifies RSSI LOW
>      - iwd roams to a new BSS
>      - RSSI happens to remain LOW
>      - driver doesn't notify RSSI LOW, because it never went HIGH
>
> This leads to us getting stuck with a low RSSI, even though iwd should
> probably try roaming again because it was never informed that the RSSI
> went HIGH. In practice, it means that we might sooner disconnect
> entirely rather than roam to better BSS.
>
> Would it not be more prudent to continue assuming that signal_low =3D=3D
> true, and schedule another roam in station_roamed() to cover for this
> scenario?

Yes, this is probably the right fix.

We do want some delay before the next roam attempt because if we've
just scanned and roamed to the best BSS in the scan results there's
probably no point scanning again immediately.

> Something like what is already done in station_roam_failed():>
>      static void station_roam_failed(struct station *station)
>      {
>          ...
>
>      delayed_retry:
>          /*
>           * If we're still connected to the old BSS, only clear
> preparing_roam
>           * and reattempt in 60 seconds if signal level is still low at t=
hat
>           * time.
>           */
>          station->preparing_roam =3D false;
>          station->roam_scan_full =3D false;
>          station->ap_directed_roaming =3D false;
>
>          if (station->signal_low)
>              station_roam_timeout_rearm(station, 60);
>      }
>
> If you like the suggestion then I can prepare a patch. But perhaps I
> have misunderstood the requirements of the CQM RSSI notification API in
> the kernel, and it should indeed always send a notification upon
> association to a new BSS, even if that happens to be redundant (e.g. LOW
> followed by LOW). In any case I would be happy to have some
> clarification on this.

It doesn't seem to be documented so probably no one knows, it's also a
question of how many drivers do emit the event and how many don't.

Best regards
--===============4797905406901816989==--

