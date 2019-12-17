Content-Type: multipart/mixed; boundary="===============8776458289425834470=="
MIME-Version: 1.0
From: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: [PATCH 1/1] doc: describe hardware passthrough feature
Date: Tue, 17 Dec 2019 10:18:44 +0100
Message-ID: <a274a1a8-e81a-c735-5ed8-7b781fad53bc@molgen.mpg.de>
In-Reply-To: <20191217000606.3081-2-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8776458289425834470==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Dear James,


Thank you for writing documentation.

Am 17.12.19 um 01:06 schrieb James Prestwood:
> There are wiki's floating around, but I have consolidated the steps for
> USB passthough into our internal docs.

th*r*ough

> ---
>   doc/test-runner.txt | 62 +++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 62 insertions(+)
> =

> diff --git a/doc/test-runner.txt b/doc/test-runner.txt
> index 1bc02ced..2d45bedc 100644
> --- a/doc/test-runner.txt
> +++ b/doc/test-runner.txt
> @@ -389,6 +389,68 @@ if __name__ =3D=3D '__main__':
>   	unittest.main()
>   #~~~~~~~~~~~~~~~~~~ end of alwaysFailingTest.py ~~~~~~~~~~~~~~~~~~~~~~~=
~~
>   =

> +Using hardware passthrough
> +---------------------------
> +
> +The --hw, -w flag lets you pass in a config file containing USB/PCI adap=
ter
> +addresses, which can then be used as radios inside the test/VM just as t=
he
> +virtual mac80211_hwsim radios are used. Note: physical radios cannot be =
used at
> +the same time as mac80211_hwsim radios.
> +
> +Using this option, in some cases, does require some pre-configuration th=
at won't
> +be described in this document. Specifically, PCI adapters are very invol=
ved to
> +get setup, and require special kernel boot options (on the host), BIOS c=
hanges,

The verb *set up* with a space.

> +and most likely a lot of time to get the system working reliably. Becaus=
e of
> +this only USB adapters will be discussed in this document.
> +
> +If PCI passthrough is something you need, it would be best to follow thi=
s guide:
> +
> +https://wiki.archlinux.org/index.php/PCI_passthrough_via_OVMF
> +
> +First, whatever kernel you are using must contain the adapters driver an=
d, if
> +required, firmware built in. The driver can be built in using 'make menu=
config'
> +and finding the correct driver for your adapter:
> +
> +Device Driver -> Network Device Support -> Wireless LAN
> +
> +Enable [*] the driver(s) you need, save, and exit.
> +
> +The firmware also needs to be built in, and this will require you findin=
g the
> +right firmware file (/lib/firmware/) required for your adapter and addin=
g it to
> +CONFIG_EXTRA_FIRMWARE in your .config file. It is sometimes not very obv=
ious
> +what firmware you need. I have found that during the kernel boot some ad=
apters
> +will print out if the firmware was not found, and the name of the firmwa=
re file
> +they expect. If you are having trouble finding the firmware file try con=
tinuing
> +on and see what happens when test-runner starts. Google is also your fri=
end.

s/Google/A search engine/

> +
> +Once you have the kernel built you can write your hardware config file f=
or
> +test-runner. Find the USB bus and device for the adapter:
> +
> +$ lsusb
> +
> +You should see your device listed with a 'Bus' and 'Device' number:
> +
> +$ Bus 001 Device 002: ........
> +
> +Put these into your passthrough config file under a 'USBAdapters' group:
> +
> +[USBAdapters]
> +rad0=3D1,2
> +
> +Note: The 'rad#' does not matter at this time. These named keys will not
> +correspond to rad0, rad1, etc in your test config file. This may change =
in the
> +future.
> +
> +You can then run test-runner using this config file:
> +
> +./test-runner -k <kernel> --hw passthrough.conf ...
> +
> +If running specific tests you need to ensure you have enough adapters de=
fined
> +in the config file, and that the adapters support the features you expec=
t. For
> +example, some adapters cannot go into AP mode, or use certain channels. =
If your
> +test expects these features and the adapters do not support them, the te=
st will
> +fail in sometimes unexpected ways.
> +
>   Using the 'shell' feature
>   ---------------------------

The rest looks good.


Kind regards,

Paul
--===============8776458289425834470==--

