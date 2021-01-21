Content-Type: multipart/mixed; boundary="===============3025704664974720012=="
MIME-Version: 1.0
From: Alvin =?unknown-8bit?q?=C5=A0ipraga?= <ALSI@bang-olufsen.dk>
Subject: Re: CQM RSSI notification in station_roamed()
Date: Thu, 21 Jan 2021 15:13:24 +0000
Message-ID: <8e963559-960f-1739-83e6-8b3c9a4e2ddb@bang-olufsen.dk>
In-Reply-To: <CAOq732L2CDDeX1Gae_nQbEGu8Adb1OsAZnNJg5quRTjKZvituA@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3025704664974720012==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 1/21/21 12:46 AM, Andrew Zaborowski wrote:
> Hi,
> =

> On Tue, 19 Jan 2021 at 11:30, Alvin =C5=A0ipraga <ALSI@bang-olufsen.dk>=
 wrote:
>> I have been working on CQM RSSI notification support for the brcmfmac
>> driver so that roaming can be properly offloaded to iwd. I want to ask
>> about this particular behaviour in iwd's station code:
>>
>>       static void station_roamed(struct station *station)
>>       {
>>           /*
>>            * New signal high/low notification should occur on the next
>>            * beacon from new AP.
>>            */
>>           station->signal_low =3D false;
>>           station->roam_min_time.tv_sec =3D 0;
>>           station->roam_no_orig_ap =3D false;
>>           station->roam_scan_full =3D false;
>>
>>           ...
>>       }
>>
>> When I look at the kernel API, this doesn't seem quite right to me. At
>> least, there doesn't seem to be any onus on the driver to repeat itself.
> =

> Right, apparently there isn't.  I imagine a lot of the things we and
> wpa_supplicant rely on is not explicitly documented in
> include/net/cfg80211.h but the drivers do them perhaps to match
> mac80211.  I guess I assumed this was also the case here.  mac80211
> sets the IEEE80211_STA_RESET_SIGNAL_AVE flag in
> ieee80211_set_associated() which causes the beacon handler to always
> emit an RSSI event on the next run.
> =

>> This led me to experience the following scenario during my testing:
>>
>>       - station is connected to a BSS
>>       - driver notifies RSSI LOW
>>       - iwd roams to a new BSS
>>       - RSSI happens to remain LOW
>>       - driver doesn't notify RSSI LOW, because it never went HIGH
>>
>> This leads to us getting stuck with a low RSSI, even though iwd should
>> probably try roaming again because it was never informed that the RSSI
>> went HIGH. In practice, it means that we might sooner disconnect
>> entirely rather than roam to better BSS.
>>
>> Would it not be more prudent to continue assuming that signal_low =3D=3D
>> true, and schedule another roam in station_roamed() to cover for this
>> scenario?
> =

> Yes, this is probably the right fix.
> =

> We do want some delay before the next roam attempt because if we've
> just scanned and roamed to the best BSS in the scan results there's
> probably no point scanning again immediately.

OK, thanks for the clarification. I will prepare a patch and send it to =

the mailing list - probably tomorrow.

Kind regards,
Alvin
--===============3025704664974720012==--

