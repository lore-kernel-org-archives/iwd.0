Content-Type: multipart/mixed; boundary="===============7699015440101047714=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: Re: [PATCH 1/2] auto-t: remove scanning wait from
 testConnectAutoconnect
Date: Wed, 06 May 2020 09:52:35 -0700
Message-ID: <CAPv5Ue65n+fHNQterpTc2GTnr9bKh_8k8OKjqd1nCuyU8h-hrg@mail.gmail.com>
In-Reply-To: <6e243830-9cc5-233f-6203-26533324b52a@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7699015440101047714==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tim,

On Wed, May 6, 2020 at 9:46 AM Kourt, Tim A <tim.a.kourt@linux.intel.com>=
 wrote:
>
> Hi James,
>
> On 5/6/2020 8:58 AM, James Prestwood wrote:
> > In certain cases the test was reaching this point once already finished
> > with a scan. This caused the wait for 'scanning' to time out. At this p=
oint
> > in the test we don't need to wait for scanning and only need to wait for
> > scanning to finish. If scanning is already finished before validation we
> > can simply validate at that time.
> > ---
> >   autotests/testConnectAutoconnect/validation.py | 3 ---
> >   1 file changed, 3 deletions(-)
> >
> > diff --git a/autotests/testConnectAutoconnect/validation.py b/autotests=
/testConnectAutoconnect/validation.py
> > index 43cbaf02..b1e3accc 100644
> > --- a/autotests/testConnectAutoconnect/validation.py
> > +++ b/autotests/testConnectAutoconnect/validation.py
> > @@ -54,9 +54,6 @@ class TestConnectAutoConnect(unittest.TestCase):
> >           self.assertIsNotNone(devices)
> >           device =3D devices[0]
> >
> > -        condition =3D 'obj.scanning'
> > -        wd.wait_for_object_condition(device, condition)
> > -
> What if the scan has never started yet? Since iwd is started from
> Python, it looks suspicious that it goes through the scan before it hits
> the conditional wait a few lines down the script. Perhaps changing to
> wd.list_devices(1) API has introduced this issue. Would it help to
> increase the conditional wait time out so it goes into the second round
> of scans for these certain cases?

I can try increasing the timeout, but I think relying on periodic
scans for this autotest isn't the best way to go about it. I will try
explicitly scanning via dbus, otherwise you are just hoping that a
periodic scan was started. This timing will vary slightly between
systems which is why I think I am hitting this.

>
> >           condition =3D 'not obj.scanning'
> >           wd.wait_for_object_condition(device, condition)
> >
> Best,
> Tim
--===============7699015440101047714==--

