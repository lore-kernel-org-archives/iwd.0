Content-Type: multipart/mixed; boundary="===============5619697879032360577=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 1/8] test-runner: Reserve radios for wpa_supplicant
Date: Wed, 30 Sep 2020 01:29:02 +0200
Message-ID: <CAOq732JGAWTCQB17xuKet3ZhLb9AyDDSWBCXY9HOo6thvHefCg@mail.gmail.com>
In-Reply-To: <e9e7515d2c2f4afe1b401ffdfcfd8aca79e5e95d.camel@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5619697879032360577==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

Thanks for reviewing the changes.

On Tue, 29 Sep 2020 at 19:15, James Prestwood <prestwoj@gmail.com> wrote:
> On Tue, 2020-09-29 at 18:37 +0200, Andrew Zaborowski wrote:
> > Add the "wpa_supplicant_radios=3D<radio_name_list>" option in hw.conf's
> > SETUP section that only reserves radios for the autotest to be able
> > to
> > start wpa_supplicant on them, i.e. prevents iwd or hostapd from being
> > started on them.
>
> Instead could we just add a new group [WPA_S] or [WPA_SUPPLICANT] and
> have radN=3D<config>. This would be consistent with how hostapd works,
> and still allows you to reserve radios for wpa_supplicant. And if we
> ever require wpa_s specific options in the future we may want a group
> for it.

That's doable, but with wpa_supplicant we have to specify the control
socket path inside the config file, so the setting would have to be
something like "radN=3D<config>,<ctrl_socket>".  I think I'd rather
avoid creating separate Wpas and WpasCLI classes, we could have one
class handle both things whether it's created by test-runner or by the
individual test, are you ok with that?

I also thought of using something like "reserved_radios=3D<radN>, ..."
so that individual tests in one directory can decide which config file
and even which daemon to run in each pass.  They could also generate
the config files as needed.

Best regards
--===============5619697879032360577==--

