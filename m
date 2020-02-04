Content-Type: multipart/mixed; boundary="===============5783824792821927339=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: AP mode crash
Date: Tue, 04 Feb 2020 10:58:24 -0600
Message-ID: <21950f6b-7ab8-3530-d3ec-880e29590909@gmail.com>
In-Reply-To: <5898b6d9-9c2e-2a1d-51f6-f3adac6345cb@monom.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5783824792821927339==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

> #0=C2=A0 0x7fc63e910030 in /lib64/libc.so.6
> #1=C2=A0 0x7fc63ea35891 in /lib64/libc.so.6
> #2=C2=A0 0x43ad5e in ap_probe_req_cb() at src/ap.c:1100 (discriminator 1)
> #3=C2=A0 0x45435a in frame_watch_unicast_notify() at src/frame-xchg.c:184 =

> (discriminator 6)
> #4=C2=A0 0x4818c3 in dispatch_unicast_watches() at ell/genl.c:899
> #5=C2=A0 0x48197b in process_unicast() at ell/genl.c:919
> #6=C2=A0 0x481d21 in received_data() at ell/genl.c:1035
> #7=C2=A0 0x47cfea in io_callback() at ell/io.c:126
> #8=C2=A0 0x47baf8 in l_main_iterate() at ell/main.c:473
> #9=C2=A0 0x47bbff in l_main_run() at ell/main.c:516
> #10 0x47bf17 in l_main_run_with_signal() at ell/main.c:642
> #11 0x404a36 in main() at src/main.c:497
> #12 0x7fc63e8fae0b in /lib64/libc.so.6
> +++++++++++++++++++++++++++
> =

> What I did was, enabling WiFi tethering in ConnMan, terminate ConnMan =

> (this tells iwd to shutdown the connection) and restart ConnMan again. =

> ConnMan then tries to restore the old setup, starting the AP mode.
> =

> Haven't really debugged it yet. Maybe someone spots the problem more =

> easily than I do :)
> =


I'm guessing Andrew's patches (applied upstream) that came in a few =

hours after this report fixed this issue?

Regards,
-Denis
--===============5783824792821927339==--

