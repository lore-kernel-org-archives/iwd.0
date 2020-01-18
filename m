Content-Type: multipart/mixed; boundary="===============1320194540430720325=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: How to monitor signal strenght
Date: Sat, 18 Jan 2020 11:02:27 -0600
Message-ID: <4e33ab87-76e3-8b51-d781-59da227e85aa@gmail.com>
In-Reply-To: <20200118165008.xjnclomubjzaysko@beryllium.lan>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1320194540430720325==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On 1/18/20 10:50 AM, Daniel Wagner wrote:
> Hi,
> =

> Another question pop up while updating the iwd plugin for ConnMan.
> =

> Currently, the plugin listens for scanning signal. Whenever iwd has
> finished with scanning the plugin calls GetOrderedNetworks in order to
> update the signal strengths. Is this still the right way to do it?

Yes.

> =

> I see in the docs that there is a SignalLevelAgent hierarchy. I am not
> entirely sure if I need it or what it's the purpose of it. The docs
> talks about an array for thresholds and references
> net.connman.iwd.Device.RegisterSignalLevelAgent in device-api.txt. But
> there is no documentation about it.

Strange.  This entire hierarchy should be under doc/station-api.txt?  I =

guess you mean there's a typo and it should be =

net.connman.iwd.Station.RegisterSignalLevelAgent.  Fixed that now.

The SignalLevelAgent is meant for UI tray / task bar apps.  It allows =

you to easily implement the 'strength bar' type functionality.  The app =

basically chooses the thresholds and what number of bars each threshold =

corresponds to.  iwd does the rest.

> =

> Also there is an empty signal-level-agent-api.txt file.

And fixed that as well.

> =

> So far the GetOrderednetworks approach works but I'd love to hear if I
> am doing it wrong.
> =


Regards,
-Denis
--===============1320194540430720325==--

