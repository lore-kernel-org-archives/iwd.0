Content-Type: multipart/mixed; boundary="===============2513019759029681245=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v5 1/2] scan: refactor to use wiphy radio work queue
Date: Fri, 10 Jul 2020 13:36:01 -0500
Message-ID: <a13b2f61-3806-0722-548e-65ba11dac737@gmail.com>
In-Reply-To: <20200710174444.13839-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2513019759029681245==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 7/10/20 12:44 PM, James Prestwood wrote:
> To use the wiphy radio work queue, scanning mostly remained the same.
> start_next_scan_request was modified to be used as the work callback,
> as well as not start the next scan if the current one was done
> (since this is taken care of by wiphy work queue now). All
> calls to start_next_scan_request were removed, and more or less
> replaced with wiphy_radio_work_done.
> =

> scan_{suspend,resume} were both removed since radio management
> priorities solve this for us. ANQP requests can be inserted ahead of
> scan requests, which accomplishes the same thing.
> ---
>   src/scan.c    | 140 ++++++++++++++++++++++----------------------------
>   src/scan.h    |   3 --
>   src/station.c |  16 +-----
>   3 files changed, 61 insertions(+), 98 deletions(-)
> =

> v5:
>   - Fixed some logic errors with exernal scans and starting the next
>     internal scan.
> =


<snip>

> @@ -1720,6 +1724,7 @@ static void scan_notify(struct l_genl_msg *msg, voi=
d *user_data)
>   =

>   		if (sc->triggered) {
>   			sc->triggered =3D false;
> +			sc->work_started =3D false;
>   =

>   			scan_finished(sc, -ECANCELED, NULL, sr);
>   		} else {

I took this chunk out (since scan_finished will reset work_started anyway) =
and =

applied.

Regards,
-Denis

--===============2513019759029681245==--

