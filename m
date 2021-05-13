Content-Type: multipart/mixed; boundary="===============3517095356077523577=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: Re: [PATCH 8/9] autotests: Update APRanges usage in testAP
Date: Thu, 13 May 2021 12:04:56 -0700
Message-ID: <f6419d030212a90dcae58f9e55731a5129e2a1c2.camel@gmail.com>
In-Reply-To: <20210513184718.265483-8-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3517095356077523577==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Thu, 2021-05-13 at 20:47 +0200, Andrew Zaborowski wrote:
> [General].APRange is now [IPv4].APAddressPool and the netmask is
> changed
> from 23 to 27 bits to make the test correctly assert that only two
> default-sized subnets are allowed by IWD simultaneously (default has
> changed from 24 to 28 bits)
> ---
> =C2=A0autotests/testAP/dhcp/main.conf |=C2=A0 4 +++-
> =C2=A0autotests/testAP/dhcp_test.py=C2=A0=C2=A0 | 12 +++++++++---
> =C2=A02 files changed, 12 insertions(+), 4 deletions(-)
> =

> diff --git a/autotests/testAP/dhcp/main.conf
> b/autotests/testAP/dhcp/main.conf
> index 667de23c..62ae782d 100644
> --- a/autotests/testAP/dhcp/main.conf
> +++ b/autotests/testAP/dhcp/main.conf
> @@ -3,4 +3,6 @@ DisableMacAddressRandomization=3Dtrue
> =C2=A0
> =C2=A0[General]
> =C2=A0EnableNetworkConfiguration=3Dtrue
> -APRanges=3D192.168.80.0/23
> +
> +[IPv4]
> +APAddressPool=3D192.168.80.0/27
> diff --git a/autotests/testAP/dhcp_test.py
> b/autotests/testAP/dhcp_test.py
> index bf52fb28..e69c4465 100644
> --- a/autotests/testAP/dhcp_test.py
> +++ b/autotests/testAP/dhcp_test.py
> @@ -58,8 +58,14 @@ class Test(unittest.TestCase):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
testutil.test_iface_operstate(dev2.name)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
testutil.test_ifaces_connected(dev1.name, dev2.name,
> group=3DFalse)
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 testu=
til.test_ip_address_match(dev1.name,
> "192.168.80.1")
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 testu=
til.test_ip_address_match(dev2.name,
> "192.168.80.2")
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 try:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 testutil.test_ip_address_match(dev1.name,
> "192.168.80.1")
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 testutil.test_ip_address_match(dev2.name,
> "192.168.80.2")
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ip =3D "192.168.80.1"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 excep=
t:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 testutil.test_ip_address_match(dev1.name,
> "192.168.80.17")
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 testutil.test_ip_address_match(dev2.name,
> "192.168.80.18")
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ip =3D "192.168.80.17"

Not really a huge fan of this try/except. Why is it not deterministic
which IP each station will have? I'm probably missing something with
the previous patches but with the new APAddressPool you set you should
have a range of .80.1 to .80.31 right? So why wouldn't the DHCP server
just choose 80.1 and 80.2 still?

> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
wd.unregister_psk_agent(psk_agent)
> =C2=A0
> @@ -76,7 +82,7 @@ class Test(unittest.TestCase):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
# got initially.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
dev4.start_ap('TestAP4', 'Password4')
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 testu=
til.test_ip_address_match(dev4.name,
> "192.168.80.1")
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 testu=
til.test_ip_address_match(dev4.name, ip)
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 finally:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
dev1.stop_ap()

Thanks,
James


--===============3517095356077523577==--

