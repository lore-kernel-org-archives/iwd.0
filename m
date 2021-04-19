Content-Type: multipart/mixed; boundary="===============5223335946096804391=="
MIME-Version: 1.0
From: Philip Stewart <philip.stewart.public@gmail.com>
Subject: Re: DEL_INTERFACE and CMD_SET_CQM failed; Could not register frame
 watch type 00d0: -95
Date: Mon, 19 Apr 2021 22:25:30 +0100
Message-ID: <I6YTRQ.1E4GL4W69MER2@gmail.com>
In-Reply-To: <f868e94a-0d2f-6f59-26af-69e0b90ffede@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5223335946096804391==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The joy of Broadcom...

Thanks a lot for the additional insight Denis, appreciate both of you =

having taken the time to look at this.

Cheers,
Phil

On Mon, 19 Apr, 2021 at 15:55, Denis Kenzior <denkenz@gmail.com> wrote:
> Hi James,
> =

>>> 	software interface modes (can always be added):
>>> 	interface combinations are not supported
>>> 	Device supports scan flush.
>>> 	max # scan plans: 1
>>> 	max scan plan interval: -1
>>> 	max scan plan iterations: 0
>>> 	Supported extended features:
>> =

>> No extended features could be due to an outdated iw version, though =

>> my
>> thought was that is would support handshake offloading which is
>> somewhat old at this point.
> =

> No, its just a really bad driver :)
> =

>> =

>> Since its working well for you I wouldn't worry about it, though I am
>> somewhat curious how exactly the 4-way handshake is working with a =

>> zero
>> MAC. Do you by chance see any eapol messages in your IWD logs =

>> (running
>> in debug mode):
> =

> See how the driver doesn't support any interface combinations?  It =

> just means this device is stuck in station mode with a single =

> interface.  So the driver doesn't even bother setting a permanent =

> address on the phy.  It only sets it on the default netdev that was =

> created.  Since mac randomization is disabled by default, we keep =

> using that one.
> =

> We probably should limit AddressRandomizationRange setting for such =

> drivers to 'full'.
> =

> No offloading either for this driver, so you're stuck with WPA2 only.
> =

> Regards,
> -Denis


--===============5223335946096804391==--

