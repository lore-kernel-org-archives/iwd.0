Content-Type: multipart/mixed; boundary="===============4259182264224932912=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: systemd startup notification for iwd?
Date: Thu, 10 Dec 2020 20:27:31 +0000
Message-ID: <5253e0bd-31f9-92cc-c566-ecc28fc7aebb@gmail.com>
In-Reply-To: <20201210201315.2885.69092@ml01.vlan13.01.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4259182264224932912==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bruce,

On 12/10/20 2:13 PM, Bruce Johnson wrote:
> I'm trying to figure out how to resolve what appears to be a race conditi=
on between iwd and my application that uses it through the API. Despite my =
attempts so far to tell systemd to start iwd before my application, the bes=
t I've gotten thus far is "Starting..." messages with the same timestamp fo=
r the two services. Has there been any consideration of adding a call to sy=
stemd's sd_notify function when iwd is ready to accept requests?

I'm not sure why systemd is involved in this actually?  There really isn't =
a =

single point in time where iwd is 'ready'.  It depends on the hardware bein=
g =

detected, initialized, etc.  So each interface / object would be signaled =

independently anyway.  I would suggest that your application should be list=
ening =

to D-Bus signals and figuring out what interfaces are becoming available (v=
ia =

InterfacesAdded signal, etc).

Regards,
-Denis
--===============4259182264224932912==--

