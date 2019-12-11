Content-Type: multipart/mixed; boundary="===============0659052930224135245=="
MIME-Version: 1.0
From: Simon Brand <simon.brand@postadigitale.de>
Subject: Re: EAP-Method=PEAP and tls_reset_handshake/authentication timeout
 results in core-dumped
Date: Wed, 11 Dec 2019 14:58:24 +0100
Message-ID: <20191211135824.7b8b4206@hostpad>
In-Reply-To: <20191211085102.00d158ac@hostpad>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0659052930224135245==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

today I noticed that the same happend with a PSK WPA2 Network.
iwd log: http://sprunge.us/7CJCtJ
dmesg: http://sprunge.us/aeUNQa

I looked through the log and I had the same behaviour with kernel 4.19
and also iwd 0.23.

Regards,
Simon


On Wed, 11 Dec 2019 09:51:02 +0100
Simon Brand <simon.brand@postadigitale.de> wrote:

> Hello Denis,
> =

> exactly, sometimes I am able to establish a connection and use it for
> a long time.
> I am using Intel Corporation Wireless 8265 / 8275 (rev 78). [0]
> Is there any authentication data stored in the core dump?
> I will compile it with debugging enabled, but I probably wont get to
> it the next two days.
> =

> Best and thanks,
> Simon
> =

> [0] http://sprunge.us/Gyjrbx
> =

> =

> On Tue, 10 Dec 2019 01:29:34 -0600
> Denis Kenzior <denkenz@gmail.com> wrote:
> =

> > Hi Simon,
> > =

> > On 12/9/19 10:51 PM, Simon Brand wrote:  =

> > > Hello,
> > > =

> > > I use a config with EAP-Method=3DPEAP and
> > > EAP-PEAP-Phase2-Method=3DMSCHAPV2, which results in (random?)
> > > core-dump. [0]    =

> > =

> > So from the log it appears as if you're able to authenticate and =

> > establish a connection successfully the first time after iwd
> > starts. Right?  And the crash happens after the AP requests
> > reauthentication. =

> > > This happens after authentication timeout or tls_reset_handshake.
> > > [1] My system is an uptodate arch linux machine with iwd 1.2-1,
> > > Linux 5.4.2-arch1-1, glibc 2.30-3. If you need more information I
> > > am happy to provide it. There is no problem with PreSharedKey
> > > Wifis. Thank you for your time and this great tool.    =

> > =

> > Any chance you can send us a core dump, or compile iwd with
> > debugging enabled (./bootstrap-configure --enable-debug
> > --disable-optimization if building from git) and send us the
> > backtrace?
> > =

> > Also, what hardware are you running this on?
> > =

> > Regards,
> > -Denis
> > _______________________________________________
> > iwd mailing list -- iwd(a)lists.01.org
> > To unsubscribe send an email to iwd-leave(a)lists.01.org  =

> _______________________________________________
> iwd mailing list -- iwd(a)lists.01.org
> To unsubscribe send an email to iwd-leave(a)lists.01.org

--===============0659052930224135245==--

