Content-Type: multipart/mixed; boundary="===============7190577292489434569=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] station: Split DBus scans into 3 frequency subsets
Date: Thu, 17 Dec 2020 20:29:14 -0600
Message-ID: <46adf29a-8311-a8f7-e350-f7034e14d3d2@gmail.com>
In-Reply-To: <20201217012859.820525-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7190577292489434569==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 12/16/20 7:28 PM, Andrew Zaborowski wrote:
> A scan normally takes about 2 seconds on my dual-band wifi adapter when
> connected.  The drivers will normally probe on each supported channel in
> some unspecified order and will have new partial results after each step
> but the kernel sends NL80211_CMD_NEW_SCAN_RESULTS only when the full
> scan request finishes, and for segmented scans we will wait for all
> segments to finish before calling back from scan_active() or
> scan_passive().
> =

> To improve user experience define our own channel order favouring the
> 2.4 channels 1, 6 and 11 and probe those as an individual scan request
> so we can update most our DBus org.connman.iwd.Network objects more
> quickly, before continuing with 5GHz band channels, updating DBus
> objects again and finally the other 2.4GHz band channels.
> =

> The overall DBus-triggered scan on my wifi adapter takes about the same
> time but my measurements were not very strict, and were not very
> consistent with and without this change.  With the change most Network
> objects are updated after about 200ms though, meaning that I get most
> of the network updates in the nm-applet UI 200ms from opening the
> network list.  The 5GHz band channels take another 1 to 1.5s to scan and
> remaining 2.4GHz band channels another ~300ms.
> =

> Hopefully this is similar when using other drivers although I can easily
> imagine a driver that parallelizes 2.4GHz and 5GHz channel probing using
> two radios, or uses 2, 4 or another number of dual-band radios to probe
> 2, 4, ... channels simultanously.  We'd then lose some of the
> performance benefit.  The faster scan results may be worth the longer
> overall scan time anyway.
> I'm also assuming that the wiphy's supported frequency list is exactly
> what was scanned when we passed no frequency list to
> NL80211_CMD_TRIGGER_SCAN and we won't get errors for passing some
> frequency that shouldn't have been scanned.
> ---
>   src/station.c | 120 ++++++++++++++++++++++++++++++++++++++++++++------
>   1 file changed, 107 insertions(+), 13 deletions(-)
> =


Both applied, thanks.

Regards,
-Denis

--===============7190577292489434569==--

