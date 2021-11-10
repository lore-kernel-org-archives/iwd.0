Content-Type: multipart/mixed; boundary="===============4262935739481003071=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH 8/9] autotests: Test DHCPv6 client in testNetconfig
Date: Wed, 10 Nov 2021 09:22:14 -0600
Message-ID: <e1bd9310-0aba-b205-9a52-a1d9f5d5f187@gmail.com>
In-Reply-To: 20211108112838.372416-8-andrew.zaborowski@intel.com

--===============4262935739481003071==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 11/8/21 5:28 AM, Andrew Zaborowski wrote:
> ---
>   autotests/testNetconfig/connection_test.py | 34 ++++++++++++++++++++--
>   autotests/testNetconfig/dhcpd-v6.conf      |  6 ++++
>   autotests/testNetconfig/main.conf          |  3 ++
>   3 files changed, 40 insertions(+), 3 deletions(-)
>   create mode 100644 autotests/testNetconfig/dhcpd-v6.conf
> =


I went ahead and applied this, but see below.  I also added a small fix =

afterwards to specify radvd pid file since radvd was refusing to start on m=
y =

setup (and the test was failing).

<snip>

> @@ -39,6 +39,10 @@ class Test(unittest.TestCase):
>           testutil.test_iface_operstate()
>           testutil.test_ifaces_connected()
>   =

> +        time.sleep(2)

Using time.sleep() isn't a great idea since the timing can be quite variabl=
e. =

Especially if qemu is running inside the VM (like the setup I have for exam=
ple). =

  In general, just forget that sleep() exists and listen for the right even=
ts.

> +        ret =3D os.system('ip addr show ' + device.name + ' | grep \'ine=
t6 3ffe:501:ffff:100::\'')
> +        self.assertEqual(os.waitstatus_to_exitcode(ret), 0)
> +

Note that os.waitstatus_to_exitcode is a python 3.9 feature.  I updated the=
 docs =

to reflect that.

>           device.disconnect()
>   =

>           condition =3D 'not obj.connected'

Regards,
-Denis
--===============4262935739481003071==--

