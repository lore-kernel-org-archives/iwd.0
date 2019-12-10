Content-Type: multipart/mixed; boundary="===============8201001894783118556=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: EAP-Method=PEAP and tls_reset_handshake/authentication timeout
 results in core-dumped
Date: Tue, 10 Dec 2019 01:29:34 -0600
Message-ID: <3c1078d4-b64b-03a3-ef20-493527f2b35a@gmail.com>
In-Reply-To: <20191210045124.1cbd142d@hostpad>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8201001894783118556==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Simon,

On 12/9/19 10:51 PM, Simon Brand wrote:
> Hello,
> =

> I use a config with EAP-Method=3DPEAP and
> EAP-PEAP-Phase2-Method=3DMSCHAPV2, which results in (random?) core-dump.
> [0]

So from the log it appears as if you're able to authenticate and =

establish a connection successfully the first time after iwd starts. =

Right?  And the crash happens after the AP requests reauthentication.

> This happens after authentication timeout or tls_reset_handshake. [1]
> My system is an uptodate arch linux machine with iwd 1.2-1, Linux
> 5.4.2-arch1-1, glibc 2.30-3. If you need more information I am happy to
> provide it. There is no problem with PreSharedKey Wifis.
> Thank you for your time and this great tool.

Any chance you can send us a core dump, or compile iwd with debugging =

enabled (./bootstrap-configure --enable-debug --disable-optimization if =

building from git) and send us the backtrace?

Also, what hardware are you running this on?

Regards,
-Denis
--===============8201001894783118556==--

