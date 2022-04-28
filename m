Content-Type: multipart/mixed; boundary="===============4079852352289764092=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: iwd stuck 'connecting', out-of-order wiphy work queue?
Date: Thu, 28 Apr 2022 13:06:31 -0500
Message-ID: <5dbf71dd-d792-c775-79a6-b4b3ef89ac5d@gmail.com>
In-Reply-To: 20220428172914.kj4ugnxbtkiakras@bang-olufsen.dk

--===============4079852352289764092==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alvin,

>> Fun stuff, have you looked at our auto-test framework? :)  There is now
>> support for User-Mode-Linux (UML) so tests run really fast.
> =

> My tests are not really meant to test iwd - I consider it pretty well tes=
ted
> already ;) - but to stress the driver/firmware of our wireless NICs. Ther=
e are
> plenty of edge cases where we observe firmware crashes or weird driver
> behaviour. A typical example is when we put the NIC in STA+AP mode with t=
he two
> interfaces on opposite bands. When the STA changes channel or band due to=
 a CSA
> from the infrastructure (or similar), the firmware could go splat. We hav=
e a
> long history of issues like this and it is a constant struggle to isolate=
 the
> bugs (which are often race conditions or unlikely to happen "in the wild"=
),
> hence the need for some automated (regression) testing. In the past I have
> mostly been trying these things out manually based on my experience with =
a given
> wireless chip, but with so many different configurations available in Wi-=
Fi it
> is really hard to have confidence that all bases are covered through manu=
al
> testing.

We do have a concept of hardware-passthrough in qemu mode.  So you could =

actually automate such testing with real hardware/kernel combination.

> =

> I had a look at the auto-test framework in the past, but I wonder if it is
> suitable for our use-case. In my tests I will need to control up to three
> separate hosts, each with potentially different wireless NICs. Is it not =
the
> case that auto-test normally uses the hwsim driver rather than a real NIC=
? Do
> you think it would be amenable to a networked topology, where iwd/hostapd=
 run on
> a separate host and commands are sent over the network?
> =


We have used it in a similar manner, maybe not quite as elaborate as what y=
ou =

describe.  Essentially a test environment consisting of DD-WRT routers and =
a =

test-box with specially written autotests running test-runner in hardware =

passthrough mode on a box with 3-4 pci & usb wifi adapters.  This allows us=
 to =

test / automate certain scenarios with real hardware.

I imagine you could extend this to multiple machines (or multiple namespace=
s as =

test-runner already supports this).

> I should add that I am just getting started with these tests, and right n=
ow I'm
> just playing around with bash scripts. But in the future we will migrate =
to a
> pytest-based setup, and I had in mind to borrow some of your auto-test co=
de when
> that day comes. :)

Sure, sounds like fun.

> =

>>
>>> The bug: sometimes the connect request will get stuck and iwd will stay=
 in
>>> 'connecting' state until I issue a disconnect.
>>>
>>> Looking closely at the logs, and also with iwmon, I noticed that no con=
nect
>>> command is actually sent over netlink to the kernel. So iwd is getting =
stuck
>>> before then.
>>>
>>> Moreover, it seems like it might be getting stuck because the wiphy wor=
k queue
>>> goes out-of-order somehow? Check this snippet from the logs:
>>>
>>
>> Yes, the work queue has a concept of priority.  So things like connect is
>> prioritized over scans.  Periodic scans are lowest priority.
>>
>>> ../iwd-1.26/src/wiphy.c:wiphy_radio_work_next() Starting work item 1
>>> ../iwd-1.26/src/wiphy.c:wiphy_radio_work_done() Work item 1 done
>>> ../iwd-1.26/src/wiphy.c:wiphy_radio_work_insert() Inserting work item 2
>>> ../iwd-1.26/src/wiphy.c:wiphy_radio_work_next() Starting work item 2
>>> ../iwd-1.26/src/wiphy.c:wiphy_radio_work_insert() Inserting work item 3
>>> ../iwd-1.26/src/wiphy.c:wiphy_radio_work_done() Work item 2 done
>>> ../iwd-1.26/src/wiphy.c:wiphy_radio_work_next() Starting work item 3
>>> ../iwd-1.26/src/wiphy.c:wiphy_radio_work_insert() Inserting work item 4
>>> ../iwd-1.26/src/wiphy.c:wiphy_radio_work_insert() Inserting work item 5
>>> ../iwd-1.26/src/wiphy.c:wiphy_radio_work_done() Work item 3 done
>>> ../iwd-1.26/src/wiphy.c:wiphy_radio_work_next() Starting work item 5 <-=
-- 5 is started...
>>> ../iwd-1.26/src/wiphy.c:wiphy_radio_work_done() Work item 4 done     <-=
-- 4 is done?!
>>> ../iwd-1.26/src/wiphy.c:wiphy_radio_work_insert() Inserting work item 6
>>>
>>
>> Hence why you're seeing this.  What happens is that you have a scan that=
 was
>> triggered over dbus using iwctl.  The fun part about this scan is that we
>> break it up into several scans each operating on a subset of the support=
ed
>> frequencies.  We run I think 2 out of 3 scans at which point the 'period=
ic
>> scan' is also triggered.  Since the 'dbus scan' is higher priority, it is
>> started prior to the 'periodic scan'.  Somehow the logic gets confused h=
ere.
> =

> Just so we are on the same page here: is it a bug that I see "work 5 star=
ted"
> followed by "work 4 done"? I get the part about the split scans but I sti=
ll
> don't understand how the work items can get scrambled like that.
> =


Thinking a bit more about this, I think the bug is actually not in the wiph=
y =

work queue at all.  It is in the scanning code.  But, yes, 'work 5 started' =

followed by 'work 4 done' is the manifestation of the bug.

My suspicion is that scan.c code uses its own queue for scan requests =

('sc->requests').  This code predates wiphy work queue code and looks like =
we =

didn't make it fully aware of the fact that wiphy work items might be start=
ed in =

a different order than the order added in 'sc->requests'.

I'll stare at this a bit more today to see if I can come up with a proper f=
ix.

Regards,
-Denis
--===============4079852352289764092==--

