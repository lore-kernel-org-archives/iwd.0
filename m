Content-Type: multipart/mixed; boundary="===============7630650551944150524=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: iwd stuck 'connecting', out-of-order wiphy work queue?
Date: Thu, 28 Apr 2022 11:28:12 -0500
Message-ID: <413080da-4833-fcfd-f745-abbd618b5947@gmail.com>
In-Reply-To: 20220427151322.nfxuelvtdwc73oah@bang-olufsen.dk

--===============7630650551944150524==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alvin,

On 4/27/22 10:13, Alvin =C5=A0ipraga wrote:
> Hi,
> =


This somehow went into spam?  Not sure why.  Gmail is doing very strange th=
ings =

lately.

> While running some automated tests for our product, I managed to make iwd=
 get
> stuck in 'connecting' state. I haven't cracked open gdb just yet, but I w=
ould
> like to report my findings here in case somebody can give me some pointer=
s as I
> continue looking into it tomorrow.
> =

> The automated test essentially does some scans and requests iwd to connec=
t to a
> particular network. The network is not known, as iwd's saved data is eras=
ed at
> the start of the test sequence. I invoke instances of iwctl to run the sc=
ans and
> request the connection.
> =


Fun stuff, have you looked at our auto-test framework? :)  There is now sup=
port =

for User-Mode-Linux (UML) so tests run really fast.

> The bug: sometimes the connect request will get stuck and iwd will stay in
> 'connecting' state until I issue a disconnect.
> =

> Looking closely at the logs, and also with iwmon, I noticed that no conne=
ct
> command is actually sent over netlink to the kernel. So iwd is getting st=
uck
> before then.
> =

> Moreover, it seems like it might be getting stuck because the wiphy work =
queue
> goes out-of-order somehow? Check this snippet from the logs:
>

Yes, the work queue has a concept of priority.  So things like connect is =

prioritized over scans.  Periodic scans are lowest priority.

> ../iwd-1.26/src/wiphy.c:wiphy_radio_work_next() Starting work item 1
> ../iwd-1.26/src/wiphy.c:wiphy_radio_work_done() Work item 1 done
> ../iwd-1.26/src/wiphy.c:wiphy_radio_work_insert() Inserting work item 2
> ../iwd-1.26/src/wiphy.c:wiphy_radio_work_next() Starting work item 2
> ../iwd-1.26/src/wiphy.c:wiphy_radio_work_insert() Inserting work item 3
> ../iwd-1.26/src/wiphy.c:wiphy_radio_work_done() Work item 2 done
> ../iwd-1.26/src/wiphy.c:wiphy_radio_work_next() Starting work item 3
> ../iwd-1.26/src/wiphy.c:wiphy_radio_work_insert() Inserting work item 4
> ../iwd-1.26/src/wiphy.c:wiphy_radio_work_insert() Inserting work item 5
> ../iwd-1.26/src/wiphy.c:wiphy_radio_work_done() Work item 3 done
> ../iwd-1.26/src/wiphy.c:wiphy_radio_work_next() Starting work item 5 <---=
 5 is started...
> ../iwd-1.26/src/wiphy.c:wiphy_radio_work_done() Work item 4 done     <---=
 4 is done?!
> ../iwd-1.26/src/wiphy.c:wiphy_radio_work_insert() Inserting work item 6
> =


Hence why you're seeing this.  What happens is that you have a scan that wa=
s =

triggered over dbus using iwctl.  The fun part about this scan is that we b=
reak =

it up into several scans each operating on a subset of the supported =

frequencies.  We run I think 2 out of 3 scans at which point the 'periodic =
scan' =

is also triggered.  Since the 'dbus scan' is higher priority, it is started =

prior to the 'periodic scan'.  Somehow the logic gets confused here.

> A brief look at the code and I can't really understand how work item 4 co=
uld be
> done when it was never started. Moreover, work item 5 gets started, but i=
s never
> done. Meanwhile, work item 6 (which I suspect to be the connect command) =
never
> starts.
> =

> I've attached the logs, so any hints are very welcome. This is with iwd v=
1.26.
> =


Let me look at your suggested patch.

Regards,
-Denis
--===============7630650551944150524==--

