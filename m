Content-Type: multipart/mixed; boundary="===============6105318014679752024=="
MIME-Version: 1.0
From: KeithG <ys3al35l at gmail.com>
To: iwd at lists.01.org
Subject: Re: Request for feature - Scan while AP
Date: Tue, 08 Feb 2022 16:01:48 -0600
Message-ID: <CAG17S_MOiNOZCfCq0mCyh=bbi4QEAJPhd9+U7rV-5NC96ZepxQ@mail.gmail.com>
In-Reply-To: 5dfd7cd47232625a4dc259679108c64b3309be16.camel@gmail.com

--===============6105318014679752024==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

James,

As far as I am concerned, yes, I think the same station scan command
would be compatible with what we have. As it is now we keep iwd up and
launch hostapd. iwctl complains when we do this but we still get a
list of available stations with current strength info that we can
provision and connect to. This is the error we get when we have both
hostapd and connman/iwd running and scanning.
```
Feb 08 15:45:42 alarm iwd[244]: WARNING:
src/station.c:station_autoconnect_start() condition
station->autoconnect_list failed
Feb 08 15:45:42 alarm iwd[244]: Received error during
CMD_TRIGGER_SCAN: Operation not supported (95)
```
I have cobbled together a config for our project that starts iwd in ap
mode (instead of launching hostapd) if there is not an IP address that
it connects to at boot. Since it initially starts in station mode and
we save the local SSIDs at boot, we can select and connect, but
current strength of that list of SSIDs is not available and if a new
SSID shows up, we will not catch that whereas with the current setup
of hostapd/iwd, we do. I do not know if it is reasonable or not but if
iwd is in ap mode and connman asks for a list of SSIDs and iwd just
provides them it would probably be easiest for us, but we could adapt
to another means of getting the SSIDs if it this is not an
acceptable/reasonable means of getting this info. I am not certain how
connman would deal with this.

As for DPP, I am unfamiliar with it. Is there an example of it we
could crib? If it is incompatible with apple, though, maybe not too
useful for us as we expect all devices can connect and provision. I
have been able to provision them with my phone or laptop.

Keith

On Tue, Feb 8, 2022 at 3:13 PM James Prestwood <prestwoj(a)gmail.com> wrote:
>
> Hi Keith,
>
> On Fri, 2022-02-04 at 17:10 -0600, KeithG wrote:
> > I mentioned this a while ago and am wondering if this is on the list
> > of features to add. Currently, we start as connman/iwd, but if we do
> > not get an IP address, we stop iwd then start hostapd and advertise
> > as
> > an AP for initial setup. When a user connects, he/she can scan for
> > availabel SSIDS and set then up.
> > I know iwd can run in AP mode, but it cannot scan while in AP mode.
> > As
> > it is, hostapd does this for us, so we have a work around. I was
> > wondering if this functionality is in the works.
>
> What exactly do you need/want for the API? Same thing as
> net.connman.iwd.Station.Scan() where you issue Scan() then
> GetOrderedNetworks() for the results?
>
> Also one thing that may interest you is DPP. This is significantly less
> overhead/hassle than having the device change to AP mode, scan, return
> results, go back to station, then connect. You would need some way of
> bootstrapping, and compatibility may be an issue e.g. Apple devices,
> just a thought.
>
> Thanks,
> James
>
> >
> > Regards,
> >
> > Keith
> > _______________________________________________
> > iwd mailing list -- iwd(a)lists.01.org
> > To unsubscribe send an email to iwd-leave(a)lists.01.org
>
>
--===============6105318014679752024==--

