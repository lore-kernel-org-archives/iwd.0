Content-Type: multipart/mixed; boundary="===============3340800212459163901=="
MIME-Version: 1.0
From: Alvin =?unknown-8bit?q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>
Subject: Re: [PATCH v2 1/2] scan: refactor start_next_scan_request to not send
 duplicate requests
Date: Tue, 09 Jun 2020 13:49:24 +0200
Message-ID: <c5c3d21d-8145-9ddd-afc6-701aa5fa7634@bang-olufsen.dk>
In-Reply-To: <f4f06da6-647a-3cb3-d4f1-73bc79761fc1@bang-olufsen.dk>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3340800212459163901==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

As promised, here is some more detail on how the duplicate scan request =

gets sent, and the subsequent crash.

On 6/6/20 7:33 PM, Alvin =C5=A0ipraga wrote:
> On 6/4/20 8:31 PM, Denis Kenzior wrote:
>>> In this case, the first callback to scan_request_triggered() will delete
>>> the request from the scan request queue. The second callback will find
>>> an empty queue and consequently pass a NULL scan_request pointer to
>>> scan_request_failed(), causing a segmentation fault.
>>
>> So for my own education, can you elaborate a bit more on how this is
>> actually triggered?=C2=A0 I'm guessing that there are pending scans (pro=
bably
>> triggered by invocation of Scan() via D-Bus?).=C2=A0 But an exact sequen=
ce of
>> what happens would be nice.
> =

> The crash is a little hard to reproduce. I have only observed it while
> looping a Wi-Fi integration test we have, where it happens maybe 10-20%
> of the time. When I am back in the office on Monday I will try to
> prepare a detailed answer to your question.

I traced the following events leading to a duplicate scan request being =

sent. The scenario assumes that the scan request queue is empty in the =

beginning.


station_enter_state: disconnected -> autoconnect_quick
   -> station_quick_scan_trigger
     -> station_scan_trigger: notify cb =3D station_quick_scan_results
       -> scan_passive
         -> scan_common
           -> scan_request_send_trigger
           -> l_queue_push_tail: scan request queue size =3D 1
scan_notify: quick scan triggered
network_connect: requested over dbus
   -> network_connect_psk
     -> station_connect_network
       -> station_enter_state: autoconnect_quick -> connecting
         -> periodic_scan_stop
           -> scan_periodic_stop
             -> scan_cancel
scan_notify: quick scan aborted
   -> scan_finished
     -> l_queue_remove: scan request queue size =3D 0
     -> station_quick_scan_results: quick scan's notify callback
     . -> station_enter_state: connecting -> autoconnect_full
     .   -> scan_periodic_start
     .     -> scan_periodic_queue
     .       -> scan_{active_full,passive}: idk which; doesn't matter
     .         -> scan_common
     .           -> scan_request_send_trigger
     .           -> l_queue_push_tail: scan request queue size =3D 1
     -> start_next_scan_request: head of queue has already been sent
       -> scan_request_send_trigger: send it again


Now the two requests both fail because the driver is busy connecting:

kernel: brcmfmac: brcmf_cfg80211_escan: Connecting: status (3)
kernel: brcmfmac: brcmf_cfg80211_scan: scan error (-11)
kernel: brcmfmac: brcmf_cfg80211_escan: Connecting: status (3)
kernel: brcmfmac: brcmf_cfg80211_scan: scan error (-11)

The errors get reported via the scan_request_triggered callback. The =

first callback deletes the scan_request from the scan request queue. The =

second callback gets a NULL scan_request pointer due to the queue being =

empty, and subsequently dereferences that pointer. Here is the stack =

trace after the segmentation fault:

(gdb) bt
#0  scan_request_failed (sr=3Dsr(a)entry=3D0x0, err=3Derr(a)entry=3D-11, =

sc=3D<optimized out>)
     at /usr/src/debug/iwd/1.7-r0/git/src/scan.c:157
#1  0x0000000000424bf0 in scan_request_triggered (msg=3D<optimized out>, =

userdata=3D0x37f320e0)
     at /usr/src/debug/iwd/1.7-r0/git/src/scan.c:222
#2  0x0000ffffb770bc0c in process_unicast (nlmsg=3D0xffffc2ab2dc0, =

genl=3D0x37f16830)
     at /usr/src/debug/ell/0.31-r0/ell-0.31/ell/genl.c:979
#3  received_data (io=3D<optimized out>, user_data=3D0x37f16830)
     at /usr/src/debug/ell/0.31-r0/ell-0.31/ell/genl.c:1087
#4  0x0000ffffb7707e78 in io_callback (fd=3D<optimized out>, events=3D1, =

user_data=3D0x37f168d0)
     at /usr/src/debug/ell/0.31-r0/ell-0.31/ell/io.c:126
#5  0x0000ffffb77070d4 in l_main_iterate (timeout=3D<optimized out>)
     at /usr/src/debug/ell/0.31-r0/ell-0.31/ell/main.c:473
#6  0x0000ffffb7707194 in l_main_run () at =

/usr/src/debug/ell/0.31-r0/ell-0.31/ell/main.c:520
#7  0x0000ffffb77073ac in l_main_run_with_signal =

(callback=3Dcallback(a)entry=3D0x408ee0 <signal_handler>,
     user_data=3Duser_data(a)entry=3D0x0) at =

/usr/src/debug/ell/0.31-r0/ell-0.31/ell/main.c:642
#8  0x0000000000408b8c in main (argc=3D<optimized out>, argv=3D<optimized o=
ut>)
     at /usr/src/debug/iwd/1.7-r0/git/src/main.c:512


Hope that helps - let me know if you have any questions. And thanks for =

accepting the patches.

Kind regards,
Alvin
--===============3340800212459163901==--

