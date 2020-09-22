Content-Type: multipart/mixed; boundary="===============6326933298482704489=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/5] resolve: Exit methods if resolve is NULL
Date: Mon, 21 Sep 2020 22:13:10 -0500
Message-ID: <0d7bba65-3fa4-c721-b8b1-90a3d5ecb577@gmail.com>
In-Reply-To: <20200921190425.615855-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6326933298482704489==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 9/21/20 2:04 PM, Andrew Zaborowski wrote:
> If no resolve method gets configured, the resolve_new() call in
> netconfig returns NULL.  To avoid adding checks netconfig every time
> netconfig->resolve is used, add these checks directly in the resolve_*
> methods.  Fixes the following crash:

Hmm, how exactly is this triggered?  I'm fairly certain I made it so that =

resolve module fails to start if the resolve method is mis-configured.  See =

resolv.c:568 or so.

> =

> src/netconfig.c:netconfig_destroy()
> Aborting (signal 11) [/path/iwd]
> ++++++++ backtrace ++++++++
>   #0  0x7f3ee427f210 in /lib/x86_64-linux-gnu/libc.so.6
>   #1  0x43bcf4 in resolve_revert() at src/resolve.c:85

I wonder why you crash here and not in .add_dns or .add_domain_name

>   #2  0x43ae2d in netconfig_destroy() at src/netconfig.c:1206
>   #3  0x440cd6 in p2p_connection_reset() at src/p2p.c:662
>   #4  0x47200f in process_unicast() at ell/genl.c:979
>   #5  0x46e807 in io_callback() at ell/io.c:126
>   #6  0x46d9bd in l_main_iterate() at ell/main.c:467 (discriminator 2)
>   #7  0x46da8c in l_main_run() at ell/main.c:516
>   #8  0x4047c6 in main() at src/main.c:506
>   #9  0x7f3ee42600b3 in /lib/x86_64-linux-gnu/libc.so.6
> +++++++++++++++++++++++++++
> ---
>   src/resolve.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> =


Regards,
-Denis

--===============6326933298482704489==--

