Content-Type: multipart/mixed; boundary="===============7446612403866083577=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: Re: [PATCH 1/8] test-runner: Reserve radios for wpa_supplicant
Date: Wed, 30 Sep 2020 08:56:32 -0700
Message-ID: <c9401769e0aaa70a51e8f374c75630329fe14073.camel@gmail.com>
In-Reply-To: <CAOq732JGAWTCQB17xuKet3ZhLb9AyDDSWBCXY9HOo6thvHefCg@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7446612403866083577==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-09-30 at 01:29 +0200, Andrew Zaborowski wrote:
> Hi James,
> =

> Thanks for reviewing the changes.
> =

> On Tue, 29 Sep 2020 at 19:15, James Prestwood <prestwoj@gmail.com>
> wrote:
> > On Tue, 2020-09-29 at 18:37 +0200, Andrew Zaborowski wrote:
> > > Add the "wpa_supplicant_radios=3D<radio_name_list>" option in
> > > hw.conf's
> > > SETUP section that only reserves radios for the autotest to be
> > > able
> > > to
> > > start wpa_supplicant on them, i.e. prevents iwd or hostapd from
> > > being
> > > started on them.
> > =

> > Instead could we just add a new group [WPA_S] or [WPA_SUPPLICANT]
> > and
> > have radN=3D<config>. This would be consistent with how hostapd
> > works,
> > and still allows you to reserve radios for wpa_supplicant. And if
> > we
> > ever require wpa_s specific options in the future we may want a
> > group
> > for it.
> =

> That's doable, but with wpa_supplicant we have to specify the control
> socket path inside the config file, so the setting would have to be
> something like "radN=3D<config>,<ctrl_socket>".  I think I'd rather
> avoid creating separate Wpas and WpasCLI classes, we could have one
> class handle both things whether it's created by test-runner or by
> the
> individual test, are you ok with that?

After looking at the wpa_s help yeah your right, when providing a
config file you cannot provide a control socket via the command line.
But I still dont see how doing radN=3D<config>,<ctrl_socket> would aid in
that since <ctrl_socket> would need to be in <config> anyways. Or are
you saying having it in both places and <ctrl_socket> is merely to tell
test-runner what value is already inside the config?

We could append the control socket to the config file like I did with
hostapd (see _rewrite_config), although I'll admit this is somewhat of
a hack. But this does allow you to generate a control socket on the fly
without the test or config file knowing about it.

> =

> I also thought of using something like "reserved_radios=3D<radN>, ..."
> so that individual tests in one directory can decide which config
> file
> and even which daemon to run in each pass.  They could also generate
> the config files as needed.
> =

> Best regards

--===============7446612403866083577==--

