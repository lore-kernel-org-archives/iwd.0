Content-Type: multipart/mixed; boundary="===============1920542019371304447=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] monitor: Add message length check to nlmon_receice
Date: Tue, 21 Jan 2020 16:36:37 -0600
Message-ID: <8648726d-dd94-84a6-4d98-7dec428aa55a@gmail.com>
In-Reply-To: <20200119163111.31753-1-wagi@monom.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1920542019371304447==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On 1/19/20 10:31 AM, Daniel Wagner wrote:
> The NLMSG_NEXT macro calculates the next nlmsg and updates the len
> field:
> =

>    #define NLMSG_NEXT(nlh,len)	 ((len) -=3D NLMSG_ALIGN((nlh)->nlmsg_len)=
, \
> 				  (struct nlmsghdr*)(((char*)(nlh)) + NLMSG_ALIGN((nlh)->nlmsg_len)))
> =

> That means nlmsg_len needs to be an multiple of NLMSG_ALIGNTO to avoid
> an underflow in len. But there are message which do not have a valid
> lenght:
> =


hmm, do you have a pcap of such a message?

>    Breakpoint 1, nlmon_receive (io=3D0x4da210, user_data=3D0x4d4cc0) at m=
onitor/nlmon.c:6947
>    6947                            printf("malformed packet\n");
>    (gdb) bt
>    #0  nlmon_receive (io=3D0x4da210, user_data=3D0x4d4cc0) at monitor/nlm=
on.c:6947
>    #1  0x0000000000439a91 in io_callback (fd=3D7, events=3D1, user_data=
=3D0x4da210) at ell/io.c:126
>    #2  0x0000000000438861 in l_main_iterate (timeout=3D-1) at ell/main.c:=
473
>    #3  0x0000000000438968 in l_main_run () at ell/main.c:520
>    #4  0x0000000000438c80 in l_main_run_with_signal (callback=3D0x4038e6 =
<signal_handler>, user_data=3D0x0) at ell/main.c:642
>    #5  0x0000000000403cc9 in main (argc=3D3, argv=3D0x7fffffffec28) at mo=
nitor/main.c:806
>    (gdb) p nlmsg->nlmsg_len
>    $5 =3D 17
> =

> By adding an lenght check after each processed message garantees that
> we do not underflow. The downside is that as soon an invalid length is
> spotted the processing stops.

Hmm, isn't NLMSG_OK already enough for this?  It checks that length is =

positive and above a certain threshold?

> ---
>   monitor/nlmon.c | 5 +++++
>   1 file changed, 5 insertions(+)
> =

> diff --git a/monitor/nlmon.c b/monitor/nlmon.c
> index 6b0afef8a497..5498e9fa0f23 100644
> --- a/monitor/nlmon.c
> +++ b/monitor/nlmon.c
> @@ -6941,6 +6941,11 @@ static bool nlmon_receive(struct l_io *io, void *u=
ser_data)
>   			nlmon_message(nlmon, tv, tp, nlmsg);
>   			break;
>   		}
> +
> +		if (nlmsg->nlmsg_len & (NLMSG_ALIGNTO-1)) {
> +			printf("malformed packet\n");
> +			break;
> +		}

Also I'm not sure whether this really holds for messages that are =

'last'.  There's no sense to check or enforce alignment in such a case/

>   	}
>   =

>   	return true;
> =


Regards,
-Denis
--===============1920542019371304447==--

