Content-Type: multipart/mixed; boundary="===============0948651949448835621=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v2] scan: Sort scan_requests by wiphy work item priority
Date: Mon, 02 May 2022 09:18:12 -0500
Message-ID: <cde7744e-82dd-b1f1-e7a7-cad4dadee2d9@gmail.com>
In-Reply-To: 20220429165819.12162-1-denkenz@gmail.com

--===============0948651949448835621==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 4/29/22 11:58, Denis Kenzior wrote:
> Periodic scan requests are meant to be performed with a lower priority
> than normal scan requests.  They're thus given a different priority when
> inserting them into the wiphy work queue.  Unfortunately, the priority
> is not taken into account when they are inserted into the
> sr->requests queue.  This can result in the scanning code being confused
> since it assumes the top of the queue is always the next scheduled or
> currently ongoing scan.  As a result any further wiphy_work might never be
> started properly.
> =

> Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/wiphy.c:wiphy_radio_work_inser=
t() Inserting work item 3
> Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/wiphy.c:wiphy_radio_work_next(=
) Starting work item 3
> Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/scan.c:scan_periodic_timeout()=
 1
> Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/wiphy.c:wiphy_radio_work_inser=
t() Inserting work item 4
> Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/wiphy.c:wiphy_radio_work_inser=
t() Inserting work item 5
> Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/wiphy.c:wiphy_radio_work_done(=
) Work item 3 done
> Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/wiphy.c:wiphy_radio_work_next(=
) Starting work item 5
> Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:scan_notify() Scan noti=
fication Trigger Scan(33)
> Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:scan_request_triggered(=
) Passive scan triggered for wdev 1
> Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:scan_periodic_triggered=
() Periodic scan triggered for wdev 1
> =

> In the above log, scan request 5 (triggered by dbus) is started before
> scan request 4 (periodic scan).  Yet the scanning code thinks scan
> request 4 was triggered.
> =

> Fix this by using the wiphy_work priority to sort the sr->requests queue
> so that the scans are ordered in the same manner.
> =

> Reported-by: Alvin =C5=A0ipraga <ALSI(a)bang-olufsen.dk>
> ---
> =

> v2 - Send priority as user_data since wiphy_radio_work_item part of the
> request hasn't been initialized yet (not inserted onto the wiphy work
> queue) and can't be compared.
> =

>   src/scan.c | 21 +++++++++++++++++++--
>   1 file changed, 19 insertions(+), 2 deletions(-)
> =


Applied.

Regards,
-Denis

--===============0948651949448835621==--

