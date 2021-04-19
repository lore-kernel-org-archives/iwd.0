Content-Type: multipart/mixed; boundary="===============5229677307935084627=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: DEL_INTERFACE and CMD_SET_CQM failed; Could not register frame
 watch type 00d0: -95
Date: Mon, 19 Apr 2021 15:55:08 -0500
Message-ID: <f868e94a-0d2f-6f59-26af-69e0b90ffede@gmail.com>
In-Reply-To: <2fe3ffc75401a5ce154b87ecafbd9d9a77c7483b.camel@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5229677307935084627==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

>> 	software interface modes (can always be added):
>> 	interface combinations are not supported
>> 	Device supports scan flush.
>> 	max # scan plans: 1
>> 	max scan plan interval: -1
>> 	max scan plan iterations: 0
>> 	Supported extended features:
> =

> No extended features could be due to an outdated iw version, though my
> thought was that is would support handshake offloading which is
> somewhat old at this point.

No, its just a really bad driver :)

> =

> Since its working well for you I wouldn't worry about it, though I am
> somewhat curious how exactly the 4-way handshake is working with a zero
> MAC. Do you by chance see any eapol messages in your IWD logs (running
> in debug mode):

See how the driver doesn't support any interface combinations?  It just mea=
ns =

this device is stuck in station mode with a single interface.  So the drive=
r =

doesn't even bother setting a permanent address on the phy.  It only sets i=
t on =

the default netdev that was created.  Since mac randomization is disabled b=
y =

default, we keep using that one.

We probably should limit AddressRandomizationRange setting for such drivers=
 to =

'full'.

No offloading either for this driver, so you're stuck with WPA2 only.

Regards,
-Denis
--===============5229677307935084627==--

