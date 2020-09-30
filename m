Content-Type: multipart/mixed; boundary="===============1753355589190214102=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 1/8] test-runner: Reserve radios for wpa_supplicant
Date: Wed, 30 Sep 2020 22:34:56 +0200
Message-ID: <CAOq732LAePEcSV+0fTBp0YiDoUFo8MDL9sC2qX=F11azGkMvdw@mail.gmail.com>
In-Reply-To: <c9401769e0aaa70a51e8f374c75630329fe14073.camel@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1753355589190214102==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 30 Sep 2020 at 17:56, James Prestwood <prestwoj@gmail.com> wrote:
> On Wed, 2020-09-30 at 01:29 +0200, Andrew Zaborowski wrote:
> > On Tue, 29 Sep 2020 at 19:15, James Prestwood <prestwoj@gmail.com>
> > wrote:
> > > Instead could we just add a new group [WPA_S] or [WPA_SUPPLICANT]
> > > and
> > > have radN=3D<config>. This would be consistent with how hostapd
> > > works,
> > > and still allows you to reserve radios for wpa_supplicant. And if
> > > we
> > > ever require wpa_s specific options in the future we may want a
> > > group
> > > for it.
> >
> > That's doable, but with wpa_supplicant we have to specify the control
> > socket path inside the config file, so the setting would have to be
> > something like "radN=3D<config>,<ctrl_socket>".  I think I'd rather
> > avoid creating separate Wpas and WpasCLI classes, we could have one
> > class handle both things whether it's created by test-runner or by
> > the
> > individual test, are you ok with that?
>
> After looking at the wpa_s help yeah your right, when providing a
> config file you cannot provide a control socket via the command line.
> But I still dont see how doing radN=3D<config>,<ctrl_socket> would aid in
> that since <ctrl_socket> would need to be in <config> anyways. Or are
> you saying having it in both places and <ctrl_socket> is merely to tell
> test-runner what value is already inside the config?

Yes, the Wpas class needs to know what value was in the config file so
that it can connect to the right socket, so I thought of providing it
through this setting.

>
> We could append the control socket to the config file like I did with
> hostapd (see _rewrite_config), although I'll admit this is somewhat of
> a hack. But this does allow you to generate a control socket on the fly
> without the test or config file knowing about it.

Oh, I didn't realize we were doing this.  It makes more sense because
we don't duplicate the socket path information.  We could use the same
mechanism to avoid duplicating other information like the device name
and type in case of P2P or the SSID in case of hostapd but I wonder if
it's easier to let the test generate the whole wpa_supplicant config
file.

Best regards
--===============1753355589190214102==--

