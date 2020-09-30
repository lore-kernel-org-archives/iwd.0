Content-Type: multipart/mixed; boundary="===============2031336345822768695=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 6/8] autotests: Add basic wpa_supplicant P2P python wrapper
Date: Wed, 30 Sep 2020 22:38:52 +0200
Message-ID: <CAOq732K3URPZfUipEY9FxEjUtbUeTp6N4B1XDUKtnTR5JzXmww@mail.gmail.com>
In-Reply-To: <87b24ae76e45b24d5e9439ff0519e4bd014ab115.camel@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2031336345822768695==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 30 Sep 2020 at 17:58, James Prestwood <prestwoj@gmail.com> wrote:
> On Tue, 2020-09-29 at 18:37 +0200, Andrew Zaborowski wrote:
> > +ctrl_count =3D 0
> > +mainloop =3D GLib.MainLoop()
>
> I think this is gonna end causing some weird behavior. Using
> ctx.mainloop should work better.

Ok.

> I had all kinds of strange issues due
> to test-runner and iwd.py both creating a mainloop.

It's not clear from
https://developer.gnome.org/pygobject/stable/class-glibmainloop.html
what creating multiple main loops implies, but the page says they'll
all refer to one "context" so maybe there's no issue... I copied this
part from hostapd.py assuming multiple GLib.MainLoop() calls would
return the same object.

Best regards
--===============2031336345822768695==--

