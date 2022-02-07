Content-Type: multipart/mixed; boundary="===============5031826890456778840=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH] netdev: fix crash from not cancelling netdev_get_oci
Date: Mon, 07 Feb 2022 13:52:25 -0600
Message-ID: <b0cf3f4a-024c-a8a8-9aa0-e5b02e4bf63c@gmail.com>
In-Reply-To: 20220207194334.402597-1-prestwoj@gmail.com

--===============5031826890456778840==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 2/7/22 13:43, James Prestwood wrote:
> If netdev_connect_failed is called before netdev_get_oci_cb() the
> netdev's handshake will be destroyed and ultimately crash when the
> callback is called.
> =

> This patch moves the cancelation into netdev_connect_free rather than
> netdev_free.
> =

> ++++++++ backtrace ++++++++
> 0  0x7f4e1787d320 in /lib64/libc.so.6
> 1  0x42634c in handshake_state_set_chandef() at src/handshake.c:1057
> 2  0x40a11b in netdev_get_oci_cb() at src/netdev.c:2387
> 3  0x483d7b in process_unicast() at ell/genl.c:986
> 4  0x480d3c in io_callback() at ell/io.c:120
> 5  0x48004d in l_main_iterate() at ell/main.c:472 (discriminator 2)
> 6  0x4800fc in l_main_run() at ell/main.c:521
> 7  0x48032c in l_main_run_with_signal() at ell/main.c:649
> 8  0x403e95 in main() at src/main.c:532
> 9  0x7f4e17867b75 in /lib64/libc.so.6
> +++++++++++++++++++++++++++
> ---
>   src/netdev.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============5031826890456778840==--

