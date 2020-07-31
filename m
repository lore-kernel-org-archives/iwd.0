Content-Type: multipart/mixed; boundary="===============5583732976054553697=="
MIME-Version: 1.0
From: Andreas Henriksson <andreas@fatal.se>
Subject: Re: build: hook up traditional dbus activation
Date: Fri, 31 Jul 2020 21:28:22 +0200
Message-ID: <20200731192822.junriliz2j2nb3wl@fatal.se>
In-Reply-To: <68660AED-EA63-4C5E-9FFD-88FA47571086@holtmann.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5583732976054553697==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Marcel,

On Fri, Jul 31, 2020 at 08:39:25PM +0200, Marcel Holtmann wrote:
[...]
> I am reluctant to go back to this since it is also not really working
> like this. This most likely needs a two-stage setup with an Alias
> (which we had at one point).

Thanks for your quick reply. (And no I didn't actually test if this
worked, just that the build generated the result I expected.)

With your hints about alias I looked at git history but only found
the systemd service using an alias in the past, never the Exec=3D
in the dbus configuration being anything else than /bin/false...
sure you're not mixing up past memories?

FWIW I was about to add that shipping the dbus configuration (and
mangling it to remove SystemdService=3D....) even when building with
--disable-systemd-service is also left as an excercise for those with
haptephobia.

(I have no personal interest in any of this.)

> And frankly the non-systemd distros can ship a modified file. We don=E2=
=80=99t
> have to make everybody happy.

Hopefully this discussion gives enough hints for them to figure out how
to get the dbus activation going for themselves...

Regards,
Andreas Henriksson
--===============5583732976054553697==--

