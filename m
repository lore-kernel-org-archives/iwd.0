Content-Type: multipart/mixed; boundary="===============5481609392352676194=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: Re: [PATCH v3 2/2] auto-t: add AP test with DHCP server
Date: Thu, 22 Oct 2020 10:14:22 -0700
Message-ID: <db27cf65e36a07c02d51fd2ba233b0d69c9c3535.camel@gmail.com>
In-Reply-To: <CAOq732+PLLgXL4JPOY7PdOAJamXp7bBwr=pdhod2FPm6YSAOfQ@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5481609392352676194==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Thu, 2020-10-22 at 19:08 +0200, Andrew Zaborowski wrote:
> Hi James,
> =

> On Thu, 22 Oct 2020 at 18:39, James Prestwood <prestwoj@gmail.com>
> wrote:
> > ---
> >  autotests/testAP-DHCP/connection_test.py | 73
> > ++++++++++++++++++++++++
> >  autotests/testAP-DHCP/failure_test.py    | 54 ++++++++++++++++++
> >  autotests/testAP-DHCP/hw.conf            |  3 +
> >  autotests/testAP-DHCP/main.conf          |  5 ++
> =

> I wonder if DHCP should simply be enabled in testAP so the two tests
> could be merged or just sit in one directory.  I don't think we
> benefit from testing the no-DHCP scenario.  The extra hostapd radio
> can be ignored in this test.

Yeah your right, this makes more sense. I can just add another test to
testAP that includes DHCP.

> =

> >  4 files changed, 135 insertions(+)
> >  create mode 100644 autotests/testAP-DHCP/connection_test.py
> >  create mode 100644 autotests/testAP-DHCP/failure_test.py
> >  create mode 100644 autotests/testAP-DHCP/hw.conf
> >  create mode 100644 autotests/testAP-DHCP/main.conf
> > =

> > v3:
> >  * Removed setting the IP since this is now done automatically
> > =

> > diff --git a/autotests/testAP-DHCP/connection_test.py
> > b/autotests/testAP-DHCP/connection_test.py
> > new file mode 100644
> > index 00000000..dd4466cd
> > --- /dev/null
> > +++ b/autotests/testAP-DHCP/connection_test.py
> > @@ -0,0 +1,73 @@
> > +#! /usr/bin/python3
> > +
> > +import unittest
> > +import sys, os
> > +
> > +import iwd
> > +from iwd import IWD
> > +from iwd import PSKAgent
> > +from iwd import NetworkType
> > +from config import ctx
> > +import testutil
> > +
> > +class Test(unittest.TestCase):
> > +    def test_connection_success(self):
> > +        wd =3D IWD(True)
> > +
> > +        dev1, dev2 =3D wd.list_devices(2)
> > +
> > +        dev1.start_ap('TestAP2', "Password2")
> > +
> > +        try:
> > +            condition =3D 'not obj.scanning'
> > +            wd.wait_for_object_condition(dev2, condition)
> > +            dev2.scan()
> > +            condition =3D 'obj.scanning'
> > +            wd.wait_for_object_condition(dev2, condition)
> > +            condition =3D 'not obj.scanning'
> > +            wd.wait_for_object_condition(dev2, condition)
> > +
> > +            ordered_networks =3D dev2.get_ordered_networks()
> > +
> > +            networks =3D { n.name: n for n in ordered_networks }
> > +            self.assertEqual(networks['TestAP2'].type,
> > NetworkType.psk)
> > +
> > +            psk_agent =3D PSKAgent('Password2')
> > +            wd.register_psk_agent(psk_agent)
> > +
> > +            try:
> > +                dev2.disconnect()
> > +
> > +                condition =3D 'not obj.connected'
> > +                wd.wait_for_object_condition(dev2, condition)
> > +            except:
> > +                pass
> > +
> > +            networks['TestAP2'].network_object.connect()
> > +
> > +            condition =3D 'obj.state =3D=3D DeviceState.connected'
> > +            wd.wait_for_object_condition(dev2, condition)
> > +
> > +            testutil.test_iface_operstate(dev2.name)
> > +            testutil.test_ifaces_connected(dev1.name, dev2.name,
> > group=3DFalse)
> =

> You could also call ifconfig here to check that DHCP worked and both
> interfaces have IPs in the same subnet.

Good point. I do plan on adding a utility (or extending testutil) for
testing IP communication as well. But in the interim I will just sanity
check the IPs/subnet.

Thanks,
James

> =

> Best regards

--===============5481609392352676194==--

