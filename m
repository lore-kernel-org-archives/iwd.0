Content-Type: multipart/mixed; boundary="===============8516839092892922513=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: Re: How to monitor signal strenght
Date: Sat, 18 Jan 2020 18:10:54 +0100
Message-ID: <20200118171054.vm2xfgpz66pq4ttk@beryllium.lan>
In-Reply-To: <4e33ab87-76e3-8b51-d781-59da227e85aa@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8516839092892922513==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Sat, Jan 18, 2020 at 11:02:27AM -0600, Denis Kenzior wrote:
> On 1/18/20 10:50 AM, Daniel Wagner wrote:
> > Another question pop up while updating the iwd plugin for ConnMan.
> > =

> > Currently, the plugin listens for scanning signal. Whenever iwd has
> > finished with scanning the plugin calls GetOrderedNetworks in order to
> > update the signal strengths. Is this still the right way to do it?
> =

> Yes.

Cool, that means no work for me :)

> > I see in the docs that there is a SignalLevelAgent hierarchy. I am not
> > entirely sure if I need it or what it's the purpose of it. The docs
> > talks about an array for thresholds and references
> > net.connman.iwd.Device.RegisterSignalLevelAgent in device-api.txt. But
> > there is no documentation about it.
> =

> Strange.  This entire hierarchy should be under doc/station-api.txt?  I
> guess you mean there's a typo and it should be
> net.connman.iwd.Station.RegisterSignalLevelAgent.  Fixed that now.

Ah, now I found it. Was properly confused :)

Thanks,
Daniel
--===============8516839092892922513==--

