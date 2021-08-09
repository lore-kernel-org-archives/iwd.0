Content-Type: multipart/mixed; boundary="===============3831770042550749240=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: iwd provides only Legacy Access point (802.11b)
Date: Mon, 09 Aug 2021 11:26:22 +0200
Message-ID: <CAOq732L0F3VmCEn1A1US_DNfQi528+QJ6CtQqtpDwJR998BWfg@mail.gmail.com>
In-Reply-To: <20210809090050.2797.71989@ml01.vlan13.01.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3831770042550749240==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Salahaldeen,

On Mon, 9 Aug 2021 at 11:00, <salahaldeen.altous@leica-camera.com> wrote:
> I have my device started as AP and when I connect to iPhone, this warning=
 comes (Legacy access Point 802.11b provides sub-optimal performance!!).
> Is that possible to run iwd with 802.11g/n mode? my hardware support supp=
ort all these modes.

The code has no support for this yet because in many use cases the AP
will not be the bottleneck, but we need to add it. Once added it would
be enabled automatically.

Best regards
--===============3831770042550749240==--

