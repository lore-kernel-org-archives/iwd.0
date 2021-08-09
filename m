Content-Type: multipart/mixed; boundary="===============6965674420078756249=="
MIME-Version: 1.0
From: Altous, Salahaldeen <Salahaldeen.Altous@leica-camera.com>
Subject: Re: iwd provides only Legacy Access point (802.11b)
Date: Mon, 09 Aug 2021 11:30:43 +0000
Message-ID: <9dea2815e2aad153b1b14c540a25679c72872aad.camel@leica-camera.com>
In-Reply-To: <CAOq732L0F3VmCEn1A1US_DNfQi528+QJ6CtQqtpDwJR998BWfg@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6965674420078756249==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Mon, 2021-08-09 at 11:26 +0200, Andrew Zaborowski wrote:
> Hi Salahaldeen,
>
> On Mon, 9 Aug 2021 at 11:00, <salahaldeen.altous@leica-camera.com>
> wrote:
> > I have my device started as AP and when I connect to iPhone, this
> > warning comes (Legacy access Point 802.11b provides sub-optimal
> > performance!!).
> > Is that possible to run iwd with 802.11g/n mode? my hardware
> > support support all these modes.
>
> The code has no support for this yet because in many use cases the AP
> will not be the bottleneck, but we need to add it. Once added it
> would
> be enabled automatically.
>
> Best regards

how big effort is needed to add the 802.11g/n support for AP. I can start t=
o do that if you provide me with some hints. I will start to add 5GHz suppo=
rt for AP. Currently iwd support only 2.4 GHz. do you see any bottleneck in=
 iwd? I am still using iwd 1.13.
which modes are supported in case the iwd runs in client mode?

Regards,
Salahaldeen Altous
Leica Camera AG | Registergericht | District Court of Wetzlar: HRB966
Vorstand | Executive Board: Matthias Harsch (Vorsitzender) | Dr. Marita Paa=
sch
Aufsichtsratsvorsitzender | Chairman of the Supervisory Board: Dr. Andreas =
Kaufmann

This message may contain confidential and privileged information. If it has=
 been sent to you in error, please notify the sender immediately by replyin=
g to the message and please delete it from your computer.

--===============6965674420078756249==--

