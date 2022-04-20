Content-Type: multipart/mixed; boundary="===============5942971550478965658=="
MIME-Version: 1.0
From: =?utf-8?q?Joakim_Lotseng=C3=A5rd_=3Cjoakim=2El_at_orbital-systems=2Ecom?=
 =?utf-8?q?=3E?=
To: iwd at lists.01.org
Subject: Re: Possible bug when /var/lib/iwd is a symlink
Date: Wed, 20 Apr 2022 09:33:57 +0200
Message-ID: <CAELJisz+CqqGUnh_oX6yxQGYvucOJtX8=FYL0up5VtSeN6WgRQ@mail.gmail.com>
In-Reply-To: 594A53B3-A60F-46FF-A957-4678102977B4@holtmann.org

--===============5942971550478965658==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

No, I have not tested STATE_DIRECTORY. I used bind mount (as
suggested) instead, and before that the patch with realname() I sent
in as a demo-fix.

See this rather as a bug report. You get an incorrect behaviour from
iwd if /var/lib/iwd is a symlink. It will not update the known network
list correctly. Sadly I do not have a patch for it as it might be a
discussion on how to solve it. I am not part of iwd core team and I
feel I have no say in how to solve it.

The problem is very easy to reproduce. Just point /var/lib/iwd with a
symlink to somewhere else. Run iwctl and do some "station wlanX
connect Y" and "known-networks X forget" and watch how the
known-networks list won't get updated correctly. In fact, the easiest
way to reproduce is probably to just copy any ssid.psk file to
ssid_copy.psk. Start iwd (it will then find both 'ssid' and
'ssid_copy'). Now run a "known-networks ssid_copy forget". It will
remove the file in /var/lib/iwd but it will not remove it from the
'known-networks list'.

[iwd]# known-networks list
                                 Known Networks
---------------------------------------------------------------------------=
-----
  Name                            Security   Hidden   Last connected
---------------------------------------------------------------------------=
-----
  Orbital                         psk                 Apr 20,  7:29 AM
  Copy                            psk                 Apr 20,  7:29 AM

[iwd]# known-networks Copy forget
[iwd]# known-networks list
                                 Known Networks
---------------------------------------------------------------------------=
-----
  Name                            Security   Hidden   Last connected
---------------------------------------------------------------------------=
-----
  Orbital                         psk                 Apr 20,  7:29 AM
  Copy                            psk                 Apr 20,  7:29 AM
   <----- Should now be removed, but is still here!

On Tue, 19 Apr 2022 at 10:53, Marcel Holtmann <marcel(a)holtmann.org> wrote:
>
> Hi Joakim,
>
> > Possible bug when /var/lib/iwd is a symlink:
> >
> > I ran across a problem when the ending part of /var/lib/iwd is a symlin=
k.
> > In my case it points to /mnt/persistent/iwd.  We are an IoT device that=
 runs
> > on UBIFS (+ tmpfs) and the entire rootfs partition of the NAND will be
> > updated on FOTA.  Hence anything we want to save in an upgrade must be =
on a
> > persistent partition.  Our target is a Freescale i.MX6 Ultralite module
> > running an ARM A7 core (if that matters).
> >
> > Problem seems to be that the l_dir_watch_new() call in knownnetworks.c =
never
> > follows symlink.  l_dir_watch_new() uses IN_DONT_FOLLOW in its call to
> > inotify_add_watch() in ell.
> >
> > This will make the known network list misbehave.  If one forgets a
> > known-network via iwctl, the list doesn't get updated.  The same goes f=
or
> > connecting to a not already known network.  It is easy to reproduce.  J=
ust
> > symlink /var/lib/iwd to another location and run some connect + forget =
in
> > iwctl.  One can also note that adding a new /var/lib/iwd/my_ssid.psk, by
> > manually creating the file, is not picked up by iwd automatically.
> >
> > I've only tested this with iwd 1.17 and ell 0.43 due to the complexity =
to
> > build another version using Yocto.  However, I've checked the source co=
de
> > for iwd on master and they don't seem to handle the fact that /var/lib/=
iwd
> > is a symlink.  I've tried to search the mailing-list and google, but ca=
n't
> > find anything about this.  It seems I can change the /var/lib/iwd direc=
tory
> > during compilation by setting DAEMON_STORAGEDIR during configure/build.
> > However, that is a bit unflexible as my system is Yocto based, and hack=
ing
> > the Yocto recipes for this seems wrong.  Normally you symlink things in=
 your
> > file tree in IoT devices to point to persistent storage areas.
> >
> > I don't have a solution, but at least iwd should detect that /var/lib/i=
wd is
> > a symlink and warn the user.  The implication is that the known-network=
 list
> > doesn't work at all.  The internal known-network list should work even =
if
> > inotify doesn't.
> >
> > Perhaps also it should be allowed to change the default storage dir in
> > /etc/iwd/main.conf.
>
> have you tried to set the STATE_DIRECTORY environment variable?
>
> Regards
>
> Marcel
>
--===============5942971550478965658==--

