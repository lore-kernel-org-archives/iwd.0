Content-Type: multipart/mixed; boundary="===============4328866639234945806=="
MIME-Version: 1.0
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen_=3Ctoke_at_toke=2Edk=3E?=
To: iwd at lists.01.org
Subject: Re: [PATCH] handshake: Do not crash if handshake is destroyed
Date: Thu, 03 Feb 2022 11:49:33 +0100
Message-ID: <874k5gcjia.fsf@toke.dk>
In-Reply-To: 20220202171305.2451-1-denkenz@gmail.com

--===============4328866639234945806==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Denis Kenzior <denkenz(a)gmail.com> writes:

> Commit 4d2176df2985 ("handshake: Allow event handler to free handshake")
> introduced a re-entrancy guard so that handshake_state objects that are
> destroyed as a result of the event do not cause a crash.  It rightly
> used a temporary object to store the passed in handshake.  Unfortunately
> this caused variable shadowing which resulted in crashes fixed by commit
> d22b174a7318 ("handshake: use _hs directly in handshake_event").
> However, since the temporary was no longer used, this fix itself caused
> a crash:
>
>  #0  0x00005555f0ba8b3d in eapol_handle_ptk_1_of_4 (sm=3Dsm(a)entry=3D0x5=
555f2b4a920, ek=3D0x5555f2b62588, ek(a)entry=3D0x16, unencrypted=3Dunencryp=
ted(a)entry=3Dfalse) at src/eapol.c:1236
> 1236				handshake_event(sm->handshake,
> (gdb) bt
>  #0  0x00005555f0ba8b3d in eapol_handle_ptk_1_of_4 (sm=3Dsm(a)entry=3D0x5=
555f2b4a920, ek=3D0x5555f2b62588, ek(a)entry=3D0x16, unencrypted=3Dunencryp=
ted(a)entry=3Dfalse) at src/eapol.c:1236
>  #1  0x00005555f0bab118 in eapol_key_handle (unencrypted=3D<optimized out=
>, frame=3D<optimized out>, sm=3D0x5555f2b4a920) at src/eapol.c:2343
>  #2  eapol_rx_packet (proto=3D<optimized out>, from=3D<optimized out>, fr=
ame=3D<optimized out>, unencrypted=3D<optimized out>, user_data=3D0x5555f2b=
4a920) at src/eapol.c:2665
>  #3  0x00005555f0bac497 in __eapol_rx_packet (ifindex=3D62, src=3Dsrc(a)e=
ntry=3D0x5555f2b62574 "x\212 J\207\267", proto=3Dproto(a)entry=3D34958, fra=
me=3Dframe(a)entry=3D0x5555f2b62588 "\002\003",
>    len=3Dlen(a)entry=3D121, noencrypt=3Dnoencrypt(a)entry=3Dfalse) at src=
/eapol.c:3017
>  #4  0x00005555f0b8c617 in netdev_control_port_frame_event (netdev=3D0x55=
55f2b64450, msg=3D0x5555f2b62588) at src/netdev.c:5574
>  #5  netdev_unicast_notify (msg=3Dmsg(a)entry=3D0x5555f2b619a0, user_data=
=3D<optimized out>) at src/netdev.c:5613
>  #6  0x00007f60084c9a51 in dispatch_unicast_watches (msg=3D0x5555f2b619a0=
, id=3D<optimized out>, genl=3D0x5555f2b3fc80) at ell/genl.c:954
>  #7  process_unicast (nlmsg=3D0x7fff61abeac0, genl=3D0x5555f2b3fc80) at e=
ll/genl.c:973
>  #8  received_data (io=3D<optimized out>, user_data=3D0x5555f2b3fc80) at =
ell/genl.c:1098
>  #9  0x00007f60084c61bd in io_callback (fd=3D<optimized out>, events=3D1,=
 user_data=3D0x5555f2b3fd20) at ell/io.c:120
>  #10 0x00007f60084c536d in l_main_iterate (timeout=3D<optimized out>) at =
ell/main.c:478
>  #11 0x00007f60084c543e in l_main_run () at ell/main.c:525
>  #12 l_main_run () at ell/main.c:507
>  #13 0x00007f60084c5670 in l_main_run_with_signal (callback=3Dcallback(a)=
entry=3D0x5555f0b89150 <signal_handler>, user_data=3Duser_data(a)entry=3D0x=
0) at ell/main.c:647
>  #14 0x00005555f0b886a4 in main (argc=3D<optimized out>, argv=3D<optimize=
d out>) at src/main.c:532
>
> This happens when the driver does not support rekeying, which causes iwd =
to
> attempt a disconnect and re-connect.  The disconnect action is
> taken during the event callback and destroys the underlying eapol state
> machine.  Since a temporary isn't used, attempting to dereference
> sm->handshake results in a crash.
>
> Fix this by introducing a UNIQUE_ID macro which should prevent shadowing
> and using a temporary variable as originally intended.
>
> Fixes: d22b174a7318 ("handshake: use _hs directly in handshake_event")
> Fixes: 4d2176df2985 ("handshake: Allow event handler to free handshake")
> Reported-By: Toke H=C3=B8iland-J=C3=B8rgensen <toke(a)toke.dk>

With this patch, the crashes are gone - thanks!

Tested-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke(a)toke.dk>
--===============4328866639234945806==--

