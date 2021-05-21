Content-Type: multipart/mixed; boundary="===============2469230723051175691=="
MIME-Version: 1.0
From: KeithG <ys3al35l@gmail.com>
Subject: Re: How to configure an IoT wifi setup
Date: Thu, 20 May 2021 19:29:36 -0500
Message-ID: <CAG17S_OnKkzs0rZtS+tr3s8SCJiQ==TQ0zOc2nML8ZLNXb4gMA@mail.gmail.com>
In-Reply-To: <d027b362-9ed8-efae-0dd3-efb5e0e0c067@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2469230723051175691==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, May 20, 2021 at 1:36 PM Denis Kenzior <denkenz@gmail.com> wrote:
>
> Hi Diego,
>
> >>> In theory 2 can be done today, either by iwd or combo iwd/hostapd with
> >> some
> >>> manual magic.
> >
> > We do exactly this on our devices, when we explored things a while back=
 it was not really an option to do it all with iwd, so we use iwd for the c=
lient part, create a new interface on the same WiFi adapter and fire up a h=
ostapd + dnsmasq combo on it as a "configuration AP", if the device is not =
configured yet.  The advantage is that iwd works in parallel in client mode=
 so we can get the list of available networks and test that the configurati=
on provided by the user really works without having to disconnect the user =
from the "configuration AP" until configuration is complete.
>
> Awesome, thanks for confirming that this can be done.  In theory iwd shou=
ld be
> getting to the point where our AP mode support should be good enough for =
simple
> scenarios like this one.
>
> >
> > Creating a second interface in AP mode works on all the WiFi adapters w=
e have encountered, which are mainly Intel and Qualcomm.
> >
>
> Keith,
>
> Any P2P capable adapter should be able to do this (so pretty much any mod=
ern
> hardware).  There was an earlier discussion on the list where I suggested=
 that
> we add a config option to main.conf to start iwd either in station + p2p =
or
> station + ap mode.
>
> Patches are always welcome!
>
> Regards,
> -Denis
Denis,

I appreciate the confidence but this is way out of my depth! I will
wait and hope that someone can contribute to this capability. I can
confirm that the AP mode works quite well even with the broadcom fmac
card. As I said, we are set up to start in station mode, collect the
local ssids, put them in a redis key then switch to AP mode and allow
the user to select one of the previously collected SSIDs to configure.
I was just hoping for a real time scan capability when in AP mode.

Regards,

Keith
--===============2469230723051175691==--

