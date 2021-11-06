Content-Type: multipart/mixed; boundary="===============5680492129586481438=="
MIME-Version: 1.0
From: noreply.torsten at gmail.com
To: iwd at lists.01.org
Subject: Re: [PATCH] station: Prevent a NULL pointer access
Date: Sat, 06 Nov 2021 15:53:29 +0000
Message-ID: <20211106155329.2830.42492@ml01.vlan13.01.org>
In-Reply-To: 20211106023651.15224-1-noreply.torsten@gmail.com

--===============5680492129586481438==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This bug was found in the wild:

iwd[580]: segfault at 28 ip 000055d0d46059f9 sp 00007ffd21aea400 error 4 in=
 iwd[55d0d45ed000+7f000]

Here is the full backtrace of the coredump, showing open_info was NULL.

(gdb) bt full
#0  0x000055d0d46059f9 in network_has_open_pair (owe=3D0x55d0d51b5410, netw=
ork=3D0x55d0d51a7250) at src/station.c:707
        open =3D 0x55d0d51acfe0
        open_info =3D 0x0
        entry =3D 0x55d0d51b04e0
        owe_info =3D 0x55d0d51b54f0
        entry =3D <optimized out>
        owe_info =3D <optimized out>
        open =3D <optimized out>
        open_info =3D <optimized out>
#1  station_owe_transition_results (err=3D0, bss_list=3D<optimized out>, fr=
eqs=3D<optimized out>, userdata=3D<optimized out>) at src/station.c:746
        network =3D <optimized out>
        station =3D <optimized out>
        bss =3D 0x55d0d51b5410
        __func__ =3D "station_owe_transition_results"
#2  0x000055d0d46147d0 in scan_finished (sc=3D0x55d0d51a8b70, err=3D0, bss_=
list=3D0x55d0d51b0930, freqs=3D0x55d0d51b0970, sr=3D0x55d0d51a89c0) at src/=
scan.c:1677
        new_owner =3D false
#3  0x000055d0d46159b2 in get_scan_done (user=3D0x55d0d51b16a0) at src/scan=
.c:1707
        results =3D 0x55d0d51b16a0
        sc =3D 0x55d0d51a8b70
        __func__ =3D "get_scan_done"
#4  0x00007f89595efaf3 in ?? () from /usr/lib/libell.so.0
No symbol table info available.
#5  0x00007f89595ec19d in ?? () from /usr/lib/libell.so.0
No symbol table info available.
#6  0x00007f89595eb34d in l_main_iterate () from /usr/lib/libell.so.0
No symbol table info available.
#7  0x00007f89595eb41e in l_main_run () from /usr/lib/libell.so.0
No symbol table info available.
#8  0x00007f89595eb650 in l_main_run_with_signal () from /usr/lib/libell.so=
.0
No symbol table info available.
#9  0x000055d0d45ee32f in main (argc=3D<optimized out>, argv=3D<optimized o=
ut>) at src/main.c:532
        exit_status =3D 1
        dbus =3D 0x55d0d5195010
        config_dir =3D <optimized out>
        config_dirs =3D <optimized out>
        i =3D <optimized out>
        __func__ =3D "main"
--===============5680492129586481438==--

