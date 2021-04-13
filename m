Content-Type: multipart/mixed; boundary="===============5203847232405834392=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: virtual interface isn't available in iwd
Date: Mon, 12 Apr 2021 22:15:40 -0500
Message-ID: <bf19948f-db3a-a03c-42ed-5eb1445b0204@gmail.com>
In-Reply-To: <CABuKQihA8_VMsG4Rm02QyWSD9MQnag_K9kSWC=cGzDXYu0zFkg@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5203847232405834392==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 4/12/21 8:59 PM, WU RUXU wrote:
> hi all
> =

>  =C2=A0=C2=A0=C2=A0 I have create a virtual interface by following command
> =

>  =C2=A0/sbin/iw phy phy0 interface add wlan0_ap type managed
> /sbin/ip addr add 192.168.18.1/24 <http://192.168.18.1/24> dev wlan0_ap
> =

> but it's not available in=C2=A0 device list in iwctl

Right now iwd ignores any interfaces created after iwd has been initialized=
. =

This allows one to start iwd (in station mode) and then create a virtual =

interface for use by hostapd for example.

Having a main.conf setting that would tell iwd to pre-create multiple inter=
faces =

and combinations thereof is something that is still on the TODO list.  See =
my =

reply to the thread (from earlier today) 'Start iwd device in ap mode by =

default'.  Ideally we could teach iwd to initialize phys in station + ap mo=
de =

for example.

Another possibility, if you're in a pinch, would be to pre-create the inter=
faces =

you need (using iw, or similar) and then start iwd with =

'UseDefaultInterface=3Dtrue' setting.  This should then force iwd to manage=
 all of =

them.  However, this will not work for devices that can be hot-plugged.

See https://iwd.wiki.kernel.org/interface_lifecycle for more details.

Regards,
-Denis
--===============5203847232405834392==--

