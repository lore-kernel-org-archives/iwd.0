Content-Type: multipart/mixed; boundary="===============4235656838903731770=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: EAP-Method=PEAP and tls_reset_handshake/authentication timeout
 results in core-dumped
Date: Thu, 12 Dec 2019 10:46:08 -0600
Message-ID: <7e33164a-3504-6d9e-2a23-f70d9327db57@gmail.com>
In-Reply-To: <20191212073724.502108b9@hostpad>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4235656838903731770==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Simon,

On 12/12/19 1:37 AM, Simon Brand wrote:
> Hi,
> =

> I build iwd 1.2 with the mentioned options, got 4 backtraces and the
> journalctl and iwmon logs.
> I tried to reproduce with another device, but was not able to, so
> probably device related (or just easier to reproduce with this device).
> =

> https://www.dropbox.com/s/w2xs4oggf0zognf/logs.tar.xz?dl=3D1
> =

> If I can provide anything else, please let me know.
> =


So looking at your traces, it seems you've hit the same bug that was =

fixed upstream recently.  Can you apply this fix (or just run iwd git =

HEAD) and see if the issue persists?

https://git.kernel.org/pub/scm/network/wireless/iwd.git/commit/?id=3Dd2556a=
48b7d65eb670fb0ce20e3f929bf9839a20

We should have iwd 1.3 out in the next few days.

Regards,
-Denis
--===============4235656838903731770==--

