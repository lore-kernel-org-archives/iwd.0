Content-Type: multipart/mixed; boundary="===============4630387962686040086=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: Re: [PATCH] monitor: Add message length check to nlmon_receice
Date: Wed, 22 Jan 2020 10:05:13 +0100
Message-ID: <20200122090513.cycvhh2uinu7vktg@beryllium.lan>
In-Reply-To: <8648726d-dd94-84a6-4d98-7dec428aa55a@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4630387962686040086==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 21, 2020 at 04:36:37PM -0600, Denis Kenzior wrote:
> Hi Daniel,
> =

> On 1/19/20 10:31 AM, Daniel Wagner wrote:
> > The NLMSG_NEXT macro calculates the next nlmsg and updates the len
> > field:
> > =

> >    #define NLMSG_NEXT(nlh,len)	 ((len) -=3D NLMSG_ALIGN((nlh)->nlmsg_le=
n), \
> > 				  (struct nlmsghdr*)(((char*)(nlh)) + NLMSG_ALIGN((nlh)->nlmsg_len)=
))
> > =

> > That means nlmsg_len needs to be an multiple of NLMSG_ALIGNTO to avoid
> > an underflow in len. But there are message which do not have a valid
> > lenght:
> > =

> =

> hmm, do you have a pcap of such a message?

I can try to capture one. The problem is that the monitor crashes
without this patch.

> >    Breakpoint 1, nlmon_receive (io=3D0x4da210, user_data=3D0x4d4cc0) at=
 monitor/nlmon.c:6947
> >    6947                            printf("malformed packet\n");
> >    (gdb) bt
> >    #0  nlmon_receive (io=3D0x4da210, user_data=3D0x4d4cc0) at monitor/n=
lmon.c:6947
> >    #1  0x0000000000439a91 in io_callback (fd=3D7, events=3D1, user_data=
=3D0x4da210) at ell/io.c:126
> >    #2  0x0000000000438861 in l_main_iterate (timeout=3D-1) at ell/main.=
c:473
> >    #3  0x0000000000438968 in l_main_run () at ell/main.c:520
> >    #4  0x0000000000438c80 in l_main_run_with_signal (callback=3D0x4038e=
6 <signal_handler>, user_data=3D0x0) at ell/main.c:642
> >    #5  0x0000000000403cc9 in main (argc=3D3, argv=3D0x7fffffffec28) at =
monitor/main.c:806
> >    (gdb) p nlmsg->nlmsg_len
> >    $5 =3D 17
> > =

> > By adding an lenght check after each processed message garantees that
> > we do not underflow. The downside is that as soon an invalid length is
> > spotted the processing stops.
> =

> Hmm, isn't NLMSG_OK already enough for this?  It checks that length is
> positive and above a certain threshold?

No, the problem is how the len is calculated. In the above example len
will be -3

	len =3D 17 - 20

and from there the next pointer nlmsg pointer will be calculated,
which is invalid.


> > ---
> >   monitor/nlmon.c | 5 +++++
> >   1 file changed, 5 insertions(+)
> > =

> > diff --git a/monitor/nlmon.c b/monitor/nlmon.c
> > index 6b0afef8a497..5498e9fa0f23 100644
> > --- a/monitor/nlmon.c
> > +++ b/monitor/nlmon.c
> > @@ -6941,6 +6941,11 @@ static bool nlmon_receive(struct l_io *io, void =
*user_data)
> >   			nlmon_message(nlmon, tv, tp, nlmsg);
> >   			break;
> >   		}
> > +
> > +		if (nlmsg->nlmsg_len & (NLMSG_ALIGNTO-1)) {
> > +			printf("malformed packet\n");
> > +			break;
> > +		}
> =

> Also I'm not sure whether this really holds for messages that are 'last'.
> There's no sense to check or enforce alignment in such a case/

In my example it is the last message. I've printed out the nlmsg_len
and all of them seem to be a mulitple of NLMSG_ALIGNTO.

Thanks,
Daniel
--===============4630387962686040086==--

