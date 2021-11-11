Content-Type: multipart/mixed; boundary="===============7442818464772793225=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: iwd can start in AP mode
Date: Thu, 11 Nov 2021 14:43:29 -0600
Message-ID: <46180dc9-8e1b-4e85-6136-97dfbc904f33@gmail.com>
In-Reply-To: 20211108043518.2830.53187@ml01.vlan13.01.org

--===============7442818464772793225==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Salahaldeen,

On 11/7/21 10:35 PM, salahaldeen.altous(a)leica-camera.com wrote:
>  From e8357b81a20f44d3473f652ef233b6598f72273f Mon Sep 17 00:00:00 2001
> From: Salahaldeen Altous <salahaldeen.altous(a)leica-camera.com>
> Date: Mon, 8 Nov 2021 05:16:26 +0100
> Subject: [PATCH] iwd can start in AP mode
> =

> By default iwd starts in station mode.  This can be changed by setting the
> Mode parameter to ap in the main.conf General section. Example
> [General]
> Mode=3Dap

So does Mode=3Dap imply that we should only create AP interfaces, or does t=
hat =

imply AP + p2p?  Looks like the current implementation would still try and =

create p2p interfaces as well.

Perhaps we should name this ap+p2p for now until we implement other =

combinations?  Also, could you add a quick description of this setting in =

src/iwd.config.rst?

> ---
>   src/manager.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> =


Regards,
-Denis
--===============7442818464772793225==--

