Content-Type: multipart/mixed; boundary="===============0853393429796993594=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH v2] auto-t: explicitly scan in testConnectAutoconnect
Date: Wed, 06 May 2020 19:48:09 +0200
Message-ID: <CAOq732Jzn=X2Aw=SOneRRiBEyE_S--PgEL7pSJJn5Hemo6Co-w@mail.gmail.com>
In-Reply-To: <20200506173948.8581-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0853393429796993594==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On Wed, 6 May 2020 at 19:40, James Prestwood <prestwoj@gmail.com> wrote:
> In certain cases the autoconnect portion of each subtest was connecting
> to the network so fast that the check for obj.scanning was never successf=
ul
> since IWD was already connected (and in turn not scanning). Since the
> autoconnect path will wait for the device to be connected there really is=
n't
> a reason to wait for any scanning conditions. The normal connect path does
> need to wait for scanning though, and for this an explicit call to scan w=
as
> added to ensure the network list gets populated.

You might want to reuse the logic in testEAP-TLS etc. where it first
checks if the scan is needed and then does what you did here,

        condition =3D 'not obj.scanning'
        wd.wait_for_object_condition(device, condition)

        if not device.get_ordered_networks():
            device.scan()
            condition =3D 'obj.scanning'
            wd.wait_for_object_condition(device, condition)
            condition =3D 'not obj.scanning'
            wd.wait_for_object_condition(device, condition)

        ordered_network =3D device.get_ordered_network(ssid)

On the other hand when Scan() returns "Scanning" is supposed be true
immediately or a millisecond later, so we might want to add a short
timeout or convert this to an assert.

Best regards
--===============0853393429796993594==--

