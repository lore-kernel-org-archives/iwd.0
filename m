Content-Type: multipart/mixed; boundary="===============1168070004722714433=="
MIME-Version: 1.0
From: Michael Johnson <mjohnson459@gmail.com>
Subject: Re: Failing to resolve after roams
Date: Thu, 12 Aug 2021 18:41:38 +0100
Message-ID: <CACsRnHW3Gnm3G8z4YtuLzgk-qaU31Nu4mm9ij3x7H0LseC6Dog@mail.gmail.com>
In-Reply-To: <c11a18de-19a8-54c9-19f6-6593a5537833@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1168070004722714433==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

I don't have iwmon logs but I can try to get some. I'm not sure how
long it will take but I started a rolling capture and will let you
know when I get something.
Thanks for helping with this.

Regards,
Michael

On Thu, 12 Aug 2021 at 18:32, Denis Kenzior <denkenz@gmail.com> wrote:
>
> Hi Michael,
>
> On 8/12/21 11:57 AM, Michael Johnson wrote:
> > Hi Denis,
> >
> > Using dbus-monitor I can see that networkd is sending out messages
> > during a roam despite being set to "Unmanaged" for this interface.
> > This appears to trigger a resolved message which I'm guessing is where
> > the problem is.
>
> So carrier disappearing is expected.  Kernel/driver takes away the carrie=
r when
> it disassociates from the current AP.  Carrier should be restored once we
> associate to the new AP and iwd should be setting the device back up afte=
r the
> roam.  This happens in netdev_connect_ok(), l_rtnl_set_linkmode_and_opers=
tate()
> invocation.
>
> What is unclear is why the carrier is sometimes not restored according to
> networkd.  Looking at the log in your first post on this topic I see that
> station_fast_transition_cb() is called and station goes from roaming to
> connected state.  So that would imply that netdev_connect_ok is called in=
 the
> 'failure' case (since connect_cb would be set to station_fast_transition_=
cb) and
> we should have restored carrier earlier.
>
> Any chance you have iwmon logs of this happening?
>
> Regards,
> -Denis
--===============1168070004722714433==--

