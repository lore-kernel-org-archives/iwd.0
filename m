Content-Type: multipart/mixed; boundary="===============7509643246576412488=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: Re: Request for feature - Scan while AP
Date: Tue, 08 Feb 2022 13:13:53 -0800
Message-ID: <5dfd7cd47232625a4dc259679108c64b3309be16.camel@gmail.com>
In-Reply-To: CAG17S_M-Je-bSmxJ8PjUqip5o+rEFKQhxXWodnWayUhTzxYgJA@mail.gmail.com

--===============7509643246576412488==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Keith,

On Fri, 2022-02-04 at 17:10 -0600, KeithG wrote:
> I mentioned this a while ago and am wondering if this is on the list
> of features to add. Currently, we start as connman/iwd, but if we do
> not get an IP address, we stop iwd then start hostapd and advertise
> as
> an AP for initial setup. When a user connects, he/she can scan for
> availabel SSIDS and set then up.
> I know iwd can run in AP mode, but it cannot scan while in AP mode.
> As
> it is, hostapd does this for us, so we have a work around. I was
> wondering if this functionality is in the works.

What exactly do you need/want for the API? Same thing as
net.connman.iwd.Station.Scan() where you issue Scan() then
GetOrderedNetworks() for the results?

Also one thing that may interest you is DPP. This is significantly less
overhead/hassle than having the device change to AP mode, scan, return
results, go back to station, then connect. You would need some way of
bootstrapping, and compatibility may be an issue e.g. Apple devices,
just a thought.

Thanks,
James

> =

> Regards,
> =

> Keith
> _______________________________________________
> iwd mailing list -- iwd(a)lists.01.org
> To unsubscribe send an email to iwd-leave(a)lists.01.org


--===============7509643246576412488==--

