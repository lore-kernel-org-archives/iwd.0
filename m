Content-Type: multipart/mixed; boundary="===============3640976852593451363=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: build: hook up traditional dbus activation
Date: Fri, 31 Jul 2020 13:52:35 -0500
Message-ID: <c697a3d6-6364-1df2-5193-b941e2199451@gmail.com>
In-Reply-To: <20200731182407.8209-1-andreas@fatal.se>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3640976852593451363==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andreas,

On 7/31/20 1:24 PM, Andreas Henriksson wrote:
> On systems using systemd dbus will use the SystemdServices=3D directive,
> but on non-systemd systems the so called "traditional dbus activation"
> method involves reading the Exec=3D directive. Setting that to /bin/false
> means this service is not relevant on non-systemd systems, but
> apparently there's an interest from users of such systems to use
> iwd (and possibly ead). Thus hook up the expansion of the paths in the
> Exec=3D directive of the dbus service files to allow the traditional dbus
> activation to start respective daemon.

Just curious.  Can you elaborate a bit on the reasons behind the request?

> =

> Signed-off-by: Andreas Henriksson <andreas@fatal.se>

We do not use SoB btw.

Regards,
-Denis
--===============3640976852593451363==--

