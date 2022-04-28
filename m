Content-Type: multipart/mixed; boundary="===============7689446571429188226=="
MIME-Version: 1.0
From: =?utf-8?q?Alvin_=C5=A0ipraga_=3CALSI_at_bang-olufsen=2Edk=3E?=
To: iwd at lists.01.org
Subject: Re: iwd stuck 'connecting', out-of-order wiphy work queue?
Date: Thu, 28 Apr 2022 17:29:15 +0000
Message-ID: <20220428172914.kj4ugnxbtkiakras@bang-olufsen.dk>
In-Reply-To: 413080da-4833-fcfd-f745-abbd618b5947@gmail.com

--===============7689446571429188226==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Thu, Apr 28, 2022 at 11:28:12AM -0500, Denis Kenzior wrote:
> Hi Alvin,
> =

> On 4/27/22 10:13, Alvin =E2=94=BC=C3=A1ipraga wrote:
> > Hi,
> > =

> =

> This somehow went into spam?  Not sure why.  Gmail is doing very strange
> things lately.
> =

> > While running some automated tests for our product, I managed to make i=
wd get
> > stuck in 'connecting' state. I haven't cracked open gdb just yet, but I=
 would
> > like to report my findings here in case somebody can give me some point=
ers as I
> > continue looking into it tomorrow.
> > =

> > The automated test essentially does some scans and requests iwd to conn=
ect to a
> > particular network. The network is not known, as iwd's saved data is er=
ased at
> > the start of the test sequence. I invoke instances of iwctl to run the =
scans and
> > request the connection.
> > =

> =

> Fun stuff, have you looked at our auto-test framework? :)  There is now
> support for User-Mode-Linux (UML) so tests run really fast.

My tests are not really meant to test iwd - I consider it pretty well tested
already ;) - but to stress the driver/firmware of our wireless NICs. There =
are
plenty of edge cases where we observe firmware crashes or weird driver
behaviour. A typical example is when we put the NIC in STA+AP mode with the=
 two
interfaces on opposite bands. When the STA changes channel or band due to a=
 CSA
from the infrastructure (or similar), the firmware could go splat. We have a
long history of issues like this and it is a constant struggle to isolate t=
he
bugs (which are often race conditions or unlikely to happen "in the wild"),
hence the need for some automated (regression) testing. In the past I have
mostly been trying these things out manually based on my experience with a =
given
wireless chip, but with so many different configurations available in Wi-Fi=
 it
is really hard to have confidence that all bases are covered through manual
testing.

I had a look at the auto-test framework in the past, but I wonder if it is
suitable for our use-case. In my tests I will need to control up to three
separate hosts, each with potentially different wireless NICs. Is it not the
case that auto-test normally uses the hwsim driver rather than a real NIC? =
Do
you think it would be amenable to a networked topology, where iwd/hostapd r=
un on
a separate host and commands are sent over the network?

I should add that I am just getting started with these tests, and right now=
 I'm
just playing around with bash scripts. But in the future we will migrate to=
 a
pytest-based setup, and I had in mind to borrow some of your auto-test code=
 when
that day comes. :)

> =

> > The bug: sometimes the connect request will get stuck and iwd will stay=
 in
> > 'connecting' state until I issue a disconnect.
> > =

> > Looking closely at the logs, and also with iwmon, I noticed that no con=
nect
> > command is actually sent over netlink to the kernel. So iwd is getting =
stuck
> > before then.
> > =

> > Moreover, it seems like it might be getting stuck because the wiphy wor=
k queue
> > goes out-of-order somehow? Check this snippet from the logs:
> > =

> =

> Yes, the work queue has a concept of priority.  So things like connect is
> prioritized over scans.  Periodic scans are lowest priority.
> =

> > ../iwd-1.26/src/wiphy.c:wiphy_radio_work_next() Starting work item 1
> > ../iwd-1.26/src/wiphy.c:wiphy_radio_work_done() Work item 1 done
> > ../iwd-1.26/src/wiphy.c:wiphy_radio_work_insert() Inserting work item 2
> > ../iwd-1.26/src/wiphy.c:wiphy_radio_work_next() Starting work item 2
> > ../iwd-1.26/src/wiphy.c:wiphy_radio_work_insert() Inserting work item 3
> > ../iwd-1.26/src/wiphy.c:wiphy_radio_work_done() Work item 2 done
> > ../iwd-1.26/src/wiphy.c:wiphy_radio_work_next() Starting work item 3
> > ../iwd-1.26/src/wiphy.c:wiphy_radio_work_insert() Inserting work item 4
> > ../iwd-1.26/src/wiphy.c:wiphy_radio_work_insert() Inserting work item 5
> > ../iwd-1.26/src/wiphy.c:wiphy_radio_work_done() Work item 3 done
> > ../iwd-1.26/src/wiphy.c:wiphy_radio_work_next() Starting work item 5 <-=
-- 5 is started...
> > ../iwd-1.26/src/wiphy.c:wiphy_radio_work_done() Work item 4 done     <-=
-- 4 is done?!
> > ../iwd-1.26/src/wiphy.c:wiphy_radio_work_insert() Inserting work item 6
> > =

> =

> Hence why you're seeing this.  What happens is that you have a scan that =
was
> triggered over dbus using iwctl.  The fun part about this scan is that we
> break it up into several scans each operating on a subset of the supported
> frequencies.  We run I think 2 out of 3 scans at which point the 'periodic
> scan' is also triggered.  Since the 'dbus scan' is higher priority, it is
> started prior to the 'periodic scan'.  Somehow the logic gets confused he=
re.

Just so we are on the same page here: is it a bug that I see "work 5 starte=
d"
followed by "work 4 done"? I get the part about the split scans but I still
don't understand how the work items can get scrambled like that.

> =

> > A brief look at the code and I can't really understand how work item 4 =
could be
> > done when it was never started. Moreover, work item 5 gets started, but=
 is never
> > done. Meanwhile, work item 6 (which I suspect to be the connect command=
) never
> > starts.
> > =

> > I've attached the logs, so any hints are very welcome. This is with iwd=
 v1.26.
> > =

> =

> Let me look at your suggested patch.

I'll follow up on your other mail tomorrow as some guests have just arrived=
...

> =

> Regards,
> -Denis
--===============7689446571429188226==--

