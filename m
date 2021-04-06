Content-Type: multipart/mixed; boundary="===============4572406455651803456=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: iwd as AP "Couldn't connect to network"
Date: Tue, 06 Apr 2021 11:23:18 -0500
Message-ID: <cfaa7b3e-1451-eed7-491e-26b07be62d85@gmail.com>
In-Reply-To: <9802c9682b37c01bbb83552254d3c94dbc7a920c.camel@leica-camera.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4572406455651803456==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Salahaldeen,

On 4/6/21 4:41 AM, Altous, Salahaldeen wrote:
> Hi everyone!
> =

> I am running iwd 1.9 (dunfell Yocto Project 3.1) with ell 0.33 with
> Linux kernel 4.4.236.

This version is quite old, can you upgrade to 1.13 ?

> =

> when I try to start iwd in AP mode (ap wlan0 start myssid mypassword
> ) and try to establish a connection to my AP I get the error "Couldn't
> connect to network"
> =


What hardware are you running?  Is it Broadcom by any chance?  If so, you n=
eed =

iwd version >=3D 1.12 for AP mode to work.

Regards,
-Denis
--===============4572406455651803456==--

