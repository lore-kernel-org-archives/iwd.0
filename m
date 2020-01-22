Content-Type: multipart/mixed; boundary="===============5090077221193301102=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: Re: [PATCH] monitor: Add message length check to nlmon_receice
Date: Wed, 22 Jan 2020 18:26:21 +0100
Message-ID: <20200122172621.kol6ix6dqyswefe2@beryllium.lan>
In-Reply-To: <e16778ee-3929-3bf4-df17-e38d38b11bbb@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5090077221193301102==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Wed, Jan 22, 2020 at 10:21:10AM -0600, Denis Kenzior wrote:
> On 1/22/20 3:05 AM, Daniel Wagner wrote:
> > On Tue, Jan 21, 2020 at 04:36:37PM -0600, Denis Kenzior wrote:
> > > Hi Daniel,
> > > =

> > > On 1/19/20 10:31 AM, Daniel Wagner wrote:
> > > > The NLMSG_NEXT macro calculates the next nlmsg and updates the len
> > > > field:
> > > > =

> > > >     #define NLMSG_NEXT(nlh,len)	 ((len) -=3D NLMSG_ALIGN((nlh)->nlm=
sg_len), \
> > > > 				  (struct nlmsghdr*)(((char*)(nlh)) + NLMSG_ALIGN((nlh)->nlmsg_=
len)))
> > > > =

> > > > That means nlmsg_len needs to be an multiple of NLMSG_ALIGNTO to av=
oid
> > > > an underflow in len. But there are message which do not have a valid
> > > > lenght:
> > > > =

> > > =

> > > hmm, do you have a pcap of such a message?
> > =

> > I can try to capture one. The problem is that the monitor crashes
> > without this patch.
> =

> Are you running the latest version btw? From your backtrace it seems like
> the nlmon.c file I have is different from yours.

Oh, I thought I did the patch against head, but well. It was against:

2a7c4a9c3d22 ("doc: Fix wrong interface name")

> Right, I get that.  But I think the issue isn't what you think it is
> exactly.  Here's the rough loop inside nlmon_receive:
> =

> size_t nlmsg_len;
> =

> nlmsg_len =3D bytes_read;
> =

> for (nlmsg =3D foo; NLMSG_OK(nlmsg, nlmsg_len;
> 			nlmsg =3D NLMSG_NEXT(nlmsg, nlmsg_len)) {
> 	// process message nlmsg
> }
> =

> NLMSG_OK and NLMSG_NEXT are macros in linux/netlink.h.  The problem is th=
at
> NLMSG_OK and NLMSG_NEXT expect to operate on an int according to 'man
> netlink', but they don't actually cast the argument to an int.
> =

> So what happens is that nlmsg_len underflows, wraps around to some large
> number and the crash happens.

It's not the current message which triggers the crash, it's the next
loop iteration which triggers the crash.

> See if changing the nlmsg_len type to an int fixes this problem.

Indeed, changing the type fixed it:

$ git diff
diff --git a/monitor/nlmon.c b/monitor/nlmon.c
index 77f5dda42946..45bd37202f9d 100644
--- a/monitor/nlmon.c
+++ b/monitor/nlmon.c
@@ -6876,7 +6876,7 @@ static bool nlmon_receive(struct l_io *io, void *user=
_data)
        unsigned char buf[8192];
        unsigned char control[32];
        ssize_t bytes_read;
-       size_t nlmsg_len;
+       ssize_t nlmsg_len;
        int fd;
 =

        fd =3D l_io_get_fd(io);

> > > Also I'm not sure whether this really holds for messages that are 'la=
st'.
> > > There's no sense to check or enforce alignment in such a case/
> > =

> > In my example it is the last message. I've printed out the nlmsg_len
> > and all of them seem to be a mulitple of NLMSG_ALIGNTO.
> > =

> =

> Then I don't see how a crash would happen, wouldn't nlmsg_len just become=
 0
> then?

The check would just abort the loop as soon a the lenght check
triggers. I've tested the new version and nlmsg_len still got
underflow but the macro aborts the loop now.

Do you want me to send a new patch or are you going to fix it
yourself? I don't mind :)

Thanks,
Daniel
--===============5090077221193301102==--

