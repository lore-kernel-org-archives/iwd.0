Content-Type: multipart/mixed; boundary="===============1687685118562669054=="
MIME-Version: 1.0
From: =?utf-8?q?Alvin_=C5=A0ipraga_=3CALSI_at_bang-olufsen=2Edk=3E?=
To: iwd at lists.01.org
Subject: Re: Possible bug when /var/lib/iwd is a symlink
Date: Thu, 14 Apr 2022 12:20:01 +0000
Message-ID: <20220414122000.bvzsws2gk2lyi6p2@bang-olufsen.dk>
In-Reply-To: CAELJisxEWR2dcZ9x4Xr3+r=myTv7X1ncD1wkx6rZ6O3YVJRMAA@mail.gmail.com

--===============1687685118562669054==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Joakim,

On Thu, Apr 14, 2022 at 10:17:26AM +0200, Joakim Lotseng=C4=82=E2=80=9Erd w=
rote:
> Hi,
> =

> Possible bug when /var/lib/iwd is a symlink:
> =

> I ran across a problem when the ending part of /var/lib/iwd is a symlink.
> In my case it points to /mnt/persistent/iwd.  We are an IoT device that r=
uns
> on UBIFS (+ tmpfs) and the entire rootfs partition of the NAND will be
> updated on FOTA.  Hence anything we want to save in an upgrade must be on=
 a
> persistent partition.  Our target is a Freescale i.MX6 Ultralite module
> running an ARM A7 core (if that matters).
> =

> Problem seems to be that the l_dir_watch_new() call in knownnetworks.c ne=
ver
> follows symlink.  l_dir_watch_new() uses IN_DONT_FOLLOW in its call to
> inotify_add_watch() in ell.
> =

> This will make the known network list misbehave.  If one forgets a
> known-network via iwctl, the list doesn't get updated.  The same goes for
> connecting to a not already known network.  It is easy to reproduce.  Just
> symlink /var/lib/iwd to another location and run some connect + forget in
> iwctl.  One can also note that adding a new /var/lib/iwd/my_ssid.psk, by
> manually creating the file, is not picked up by iwd automatically.
> =

> I've only tested this with iwd 1.17 and ell 0.43 due to the complexity to
> build another version using Yocto.  However, I've checked the source code

You can just keep a recipe in your own custom layer with a higher version.
Yocto actually makes this really easy - in practice all we do when bumping =
iwd
is to update the SRC_URI checksum and PV (in the filename), while the recip=
e is
otherwise the same as in meta-oe.

> for iwd on master and they don't seem to handle the fact that /var/lib/iwd
> is a symlink.  I've tried to search the mailing-list and google, but can't
> find anything about this.  It seems I can change the /var/lib/iwd directo=
ry
> during compilation by setting DAEMON_STORAGEDIR during configure/build.
> However, that is a bit unflexible as my system is Yocto based, and hacking
> the Yocto recipes for this seems wrong.  Normally you symlink things in y=
our
> file tree in IoT devices to point to persistent storage areas.
> =

> I don't have a solution, but at least iwd should detect that /var/lib/iwd=
 is
> a symlink and warn the user.  The implication is that the known-network l=
ist
> doesn't work at all.  The internal known-network list should work even if
> inotify doesn't.

The way we solve this problem in general is to bind mount a directory on ou=
r rw
filesystem to /var/lib/iwd. We also use Yocto, although we have a custom re=
cipe
for setting up our bind mounts. For inspiration, you can look at the
volatile-binds.bb recipe in poky, which does pretty much the same.

Perhaps iwd should tolerate symlinks, but iwd is not the only program that =
has
issues with symlinks, so often a bind mount is more robust :-)

Kind regards,
Alvin

> =

> Perhaps also it should be allowed to change the default storage dir in
> /etc/iwd/main.conf.
> =

> -- =

> Best regards,
> Joakim Lotseng=C4=82=E2=80=9Erd
> _______________________________________________
> iwd mailing list -- iwd(a)lists.01.org
> To unsubscribe send an email to iwd-leave(a)lists.01.org
--===============1687685118562669054==--

