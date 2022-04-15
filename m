Content-Type: multipart/mixed; boundary="===============7445522073193760255=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: Possible bug when /var/lib/iwd is a symlink
Date: Fri, 15 Apr 2022 09:33:51 -0500
Message-ID: <e96d5864-dacb-54d4-e159-5563bc011d0d@gmail.com>
In-Reply-To: CAELJisxEWR2dcZ9x4Xr3+r=myTv7X1ncD1wkx6rZ6O3YVJRMAA@mail.gmail.com

--===============7445522073193760255==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Joakim,

On 4/14/22 03:17, Joakim Lotseng=C3=A5rd wrote:
> Hi,
> =

> Possible bug when /var/lib/iwd is a symlink:

iwd assumes that it will create the storage directory on first start.  So i=
t =

should never be a symlink.  How/why are you creating the symlink in the fir=
st place?

> =

> I ran across a problem when the ending part of /var/lib/iwd is a symlink.
> In my case it points to /mnt/persistent/iwd.  We are an IoT device that r=
uns
> on UBIFS (+ tmpfs) and the entire rootfs partition of the NAND will be
> updated on FOTA.  Hence anything we want to save in an upgrade must be on=
 a
> persistent partition.  Our target is a Freescale i.MX6 Ultralite module
> running an ARM A7 core (if that matters).

Can you mount /var/lib/iwd directly?

> =

> Problem seems to be that the l_dir_watch_new() call in knownnetworks.c ne=
ver
> follows symlink.  l_dir_watch_new() uses IN_DONT_FOLLOW in its call to
> inotify_add_watch() in ell.

Right, along with some other flags that are on purpose for security reasons.

> =

> This will make the known network list misbehave.  If one forgets a
> known-network via iwctl, the list doesn't get updated.  The same goes for
> connecting to a not already known network.  It is easy to reproduce.  Just
> symlink /var/lib/iwd to another location and run some connect + forget in
> iwctl.  One can also note that adding a new /var/lib/iwd/my_ssid.psk, by
> manually creating the file, is not picked up by iwd automatically.

Looks like we do not check that the inotify watch creation failed.  So we s=
hould =

fix that.

> =

> I've only tested this with iwd 1.17 and ell 0.43 due to the complexity to
> build another version using Yocto.  However, I've checked the source code
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

I think iwd should fail to start if /var/lib/iwd is a symlink...

> =

> Perhaps also it should be allowed to change the default storage dir in
> /etc/iwd/main.conf.
> =


I think that is probably the best approach.  Patches are always welcome of =
course.

Regards,
-Denis
--===============7445522073193760255==--

