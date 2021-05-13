Content-Type: multipart/mixed; boundary="===============0805212528933400691=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 8/9] autotests: Update APRanges usage in testAP
Date: Thu, 13 May 2021 21:47:50 +0200
Message-ID: <CAOq732LpxTmZNVu9OPdZxqBO=7XYADedW+_N+EEQXLkyaZci5w@mail.gmail.com>
In-Reply-To: <f6419d030212a90dcae58f9e55731a5129e2a1c2.camel@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0805212528933400691==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On Thu, 13 May 2021 at 21:05, James Prestwood <prestwoj@gmail.com> wrote:
> On Thu, 2021-05-13 at 20:47 +0200, Andrew Zaborowski wrote:
> > [General].APRange is now [IPv4].APAddressPool and the netmask is
> > changed
> > from 23 to 27 bits to make the test correctly assert that only two
> > default-sized subnets are allowed by IWD simultaneously (default has
> > changed from 24 to 28 bits)
> > ---
> >  autotests/testAP/dhcp/main.conf |  4 +++-
> >  autotests/testAP/dhcp_test.py   | 12 +++++++++---
> >  2 files changed, 12 insertions(+), 4 deletions(-)
> >
> > diff --git a/autotests/testAP/dhcp/main.conf
> > b/autotests/testAP/dhcp/main.conf
> > index 667de23c..62ae782d 100644
> > --- a/autotests/testAP/dhcp/main.conf
> > +++ b/autotests/testAP/dhcp/main.conf
> > @@ -3,4 +3,6 @@ DisableMacAddressRandomization=3Dtrue
> >
> >  [General]
> >  EnableNetworkConfiguration=3Dtrue
> > -APRanges=3D192.168.80.0/23
> > +
> > +[IPv4]
> > +APAddressPool=3D192.168.80.0/27
> > diff --git a/autotests/testAP/dhcp_test.py
> > b/autotests/testAP/dhcp_test.py
> > index bf52fb28..e69c4465 100644
> > --- a/autotests/testAP/dhcp_test.py
> > +++ b/autotests/testAP/dhcp_test.py
> > @@ -58,8 +58,14 @@ class Test(unittest.TestCase):
> >              testutil.test_iface_operstate(dev2.name)
> >              testutil.test_ifaces_connected(dev1.name, dev2.name,
> > group=3DFalse)
> >
> > -            testutil.test_ip_address_match(dev1.name,
> > "192.168.80.1")
> > -            testutil.test_ip_address_match(dev2.name,
> > "192.168.80.2")
> > +            try:
> > +                testutil.test_ip_address_match(dev1.name,
> > "192.168.80.1")
> > +                testutil.test_ip_address_match(dev2.name,
> > "192.168.80.2")
> > +                ip =3D "192.168.80.1"
> > +            except:
> > +                testutil.test_ip_address_match(dev1.name,
> > "192.168.80.17")
> > +                testutil.test_ip_address_match(dev2.name,
> > "192.168.80.18")
> > +                ip =3D "192.168.80.17"
>
> Not really a huge fan of this try/except. Why is it not deterministic
> which IP each station will have?

The new code selects a random subnet from the configured space on
purpose.  We can retrieve the actual address here and compare the 31
bits of it that we want to validate but it was easier to reuse the
testutil.test_ip_address_match API, I'll change this though if I have
to resend this another time.

> I'm probably missing something with
> the previous patches but with the new APAddressPool you set you should
> have a range of .80.1 to .80.31 right? So why wouldn't the DHCP server
> just choose 80.1 and 80.2 still?

The default subnet size is 16 addresses now so the code should select
one of the two subnets that fit in the .80.0 - .80.31 range and we
don't know which one it's going to be.

Best regards
--===============0805212528933400691==--

