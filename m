Content-Type: multipart/mixed; boundary="===============1464458384280827490=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: EAP-Method=PEAP and tls_reset_handshake/authentication timeout
 results in core-dumped
Date: Wed, 11 Dec 2019 00:45:35 -0600
Message-ID: <15e8050e-52e8-1ce1-522d-eaf665cdd784@gmail.com>
In-Reply-To: <20191211085102.00d158ac@hostpad>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1464458384280827490==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Simon,

On 12/11/19 2:51 AM, Simon Brand wrote:
> Hello Denis,
> =

> exactly, sometimes I am able to establish a connection and use it for a
> long time.

Interesting.  I'm starting to suspect that the firmware / driver sends =

something unexpected, confusing iwd.  If you can get us a backtrace and =

iwd debug log, that would be great.  An iwmon trace would also be very =

helpful to pinpoint what the kernel/driver is sending us.  See =

https://iwd.wiki.kernel.org/debugging.

> I am using Intel Corporation Wireless 8265 / 8275 (rev 78). [0]
> Is there any authentication data stored in the core dump?

Yes, in theory there is.  Really all we want is the backtrace, so no =

need to share the core dump if you can provide that instead.

> I will compile it with debugging enabled, but I probably wont get to it
> the next two days.

No worries.

> =

> Best and thanks,
> Simon
> =

> [0] http://sprunge.us/Gyjrbx
> =

> =


Regards,
-Denis
--===============1464458384280827490==--

