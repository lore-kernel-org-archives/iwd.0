Content-Type: multipart/mixed; boundary="===============0426929463622278431=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] auto-t: work around race between ANQP and dbus
 Connect()
Date: Thu, 28 May 2020 15:53:44 +0000
Message-ID: <1f365826-2861-8848-b67a-4f25ebc407ab@gmail.com>
In-Reply-To: <20200527204559.2571-2-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0426929463622278431==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 5/27/20 3:45 PM, James Prestwood wrote:
> ANQP is performed as the scan results come in but scanning is still
> signaled as done regardless of if ANQP has finished. Autoconnect
> will wait for ANQP to complete, but as far as an explicit DBus call
> we are just assuming ANQP finished. For now, we can work around this
> in the autotest and wait a bit before issuing Connect(). The real
> fix would either be to delay setting scanning as done, or have
> network/station wait for ANQP to complete before checking the
> network settings.
> ---
>   autotests/testHotspot/hotspot_test.py | 3 +++
>   1 file changed, 3 insertions(+)
> =

> diff --git a/autotests/testHotspot/hotspot_test.py b/autotests/testHotspo=
t/hotspot_test.py
> index 0f18fae1..389038fd 100644
> --- a/autotests/testHotspot/hotspot_test.py
> +++ b/autotests/testHotspot/hotspot_test.py
> @@ -11,6 +11,7 @@ from iwd import PSKAgent
>   from iwd import NetworkType
>   from hostapd import HostapdCLI
>   import testutil
> +from time import sleep
>   =

>   class Test(unittest.TestCase):
>   =

> @@ -33,6 +34,8 @@ class Test(unittest.TestCase):
>           condition =3D 'not obj.scanning'
>           wd.wait_for_object_condition(device, condition)
>   =

> +        sleep(1)
> +

So you know this, but the issue with sleep is that you're completely at =

the mercy of the scheduler and the speed of qemu.  This might work for =

you most of the time, but then it will occasionally fail.  Or it might =

fail reliably on a slower machine running qemu.

In general I think we need to go in and eliminate all sleeps in the test =

scripts.  Or at least as many as we can.

>           ordered_network =3D device.get_ordered_network('Hotspot')
>   =

>           self.assertEqual(ordered_network.type, NetworkType.eap)
> =


Regards,
-Denis
--===============0426929463622278431==--

