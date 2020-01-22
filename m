Content-Type: multipart/mixed; boundary="===============1020372246074668059=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] monitor: Add message length check to nlmon_receice
Date: Wed, 22 Jan 2020 10:21:10 -0600
Message-ID: <e16778ee-3929-3bf4-df17-e38d38b11bbb@gmail.com>
In-Reply-To: <20200122090513.cycvhh2uinu7vktg@beryllium.lan>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1020372246074668059==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On 1/22/20 3:05 AM, Daniel Wagner wrote:
> On Tue, Jan 21, 2020 at 04:36:37PM -0600, Denis Kenzior wrote:
>> Hi Daniel,
>>
>> On 1/19/20 10:31 AM, Daniel Wagner wrote:
>>> The NLMSG_NEXT macro calculates the next nlmsg and updates the len
>>> field:
>>>
>>>     #define NLMSG_NEXT(nlh,len)	 ((len) -=3D NLMSG_ALIGN((nlh)->nlmsg_l=
en), \
>>> 				  (struct nlmsghdr*)(((char*)(nlh)) + NLMSG_ALIGN((nlh)->nlmsg_len)=
))
>>>
>>> That means nlmsg_len needs to be an multiple of NLMSG_ALIGNTO to avoid
>>> an underflow in len. But there are message which do not have a valid
>>> lenght:
>>>
>>
>> hmm, do you have a pcap of such a message?
> =

> I can try to capture one. The problem is that the monitor crashes
> without this patch.

Are you running the latest version btw? From your backtrace it seems =

like the nlmon.c file I have is different from yours.

> =

>>>     Breakpoint 1, nlmon_receive (io=3D0x4da210, user_data=3D0x4d4cc0) a=
t monitor/nlmon.c:6947
>>>     6947                            printf("malformed packet\n");
>>>     (gdb) bt
>>>     #0  nlmon_receive (io=3D0x4da210, user_data=3D0x4d4cc0) at monitor/=
nlmon.c:6947
>>>     #1  0x0000000000439a91 in io_callback (fd=3D7, events=3D1, user_dat=
a=3D0x4da210) at ell/io.c:126
>>>     #2  0x0000000000438861 in l_main_iterate (timeout=3D-1) at ell/main=
.c:473
>>>     #3  0x0000000000438968 in l_main_run () at ell/main.c:520
>>>     #4  0x0000000000438c80 in l_main_run_with_signal (callback=3D0x4038=
e6 <signal_handler>, user_data=3D0x0) at ell/main.c:642
>>>     #5  0x0000000000403cc9 in main (argc=3D3, argv=3D0x7fffffffec28) at=
 monitor/main.c:806
>>>     (gdb) p nlmsg->nlmsg_len
>>>     $5 =3D 17
>>>
>>> By adding an lenght check after each processed message garantees that
>>> we do not underflow. The downside is that as soon an invalid length is
>>> spotted the processing stops.
>>
>> Hmm, isn't NLMSG_OK already enough for this?  It checks that length is
>> positive and above a certain threshold?
> =

> No, the problem is how the len is calculated. In the above example len
> will be -3
> =

> 	len =3D 17 - 20

Right, I get that.  But I think the issue isn't what you think it is =

exactly.  Here's the rough loop inside nlmon_receive:

size_t nlmsg_len;

nlmsg_len =3D bytes_read;

for (nlmsg =3D foo; NLMSG_OK(nlmsg, nlmsg_len;
			nlmsg =3D NLMSG_NEXT(nlmsg, nlmsg_len)) {
	// process message nlmsg
}

NLMSG_OK and NLMSG_NEXT are macros in linux/netlink.h.  The problem is =

that NLMSG_OK and NLMSG_NEXT expect to operate on an int according to =

'man netlink', but they don't actually cast the argument to an int.

So what happens is that nlmsg_len underflows, wraps around to some large =

number and the crash happens.

See if changing the nlmsg_len type to an int fixes this problem.

<snip>

>>
>> Also I'm not sure whether this really holds for messages that are 'last'.
>> There's no sense to check or enforce alignment in such a case/
> =

> In my example it is the last message. I've printed out the nlmsg_len
> and all of them seem to be a mulitple of NLMSG_ALIGNTO.
> =


Then I don't see how a crash would happen, wouldn't nlmsg_len just =

become 0 then?

Regards,
-Denis

--===============1020372246074668059==--

