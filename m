Content-Type: multipart/mixed; boundary="===============1847225054567216021=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 1/2] scan: refactor start_next_scan_request to not send
 duplicate requests
Date: Thu, 04 Jun 2020 13:31:09 -0500
Message-ID: <053d938e-c873-79f1-ca84-020af2e2f285@gmail.com>
In-Reply-To: <20200601171117.122574-1-alsi@bang-olufsen.dk>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1847225054567216021==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alvin,

On 6/1/20 12:11 PM, Alvin =C5=A0ipraga wrote:
> If start_scan_next_request() is called while a scan request
> (NL80211_CMD_TRIGGER_SCAN) is still running, the same scan request will
> be sent again. Add a check in the function to avoid sending a request if
> one is already in progress.
> =

> This also fixes a crash that occurs if the following conditions are met:
>    - the duplicated request is the only request in the scan request
>      queue, and
>    - both scan requests fail with an error not EBUSY.

Nice catch on this.  Scanning code is some of the most complex in the =

project, so kudos.

> =

> In this case, the first callback to scan_request_triggered() will delete
> the request from the scan request queue. The second callback will find
> an empty queue and consequently pass a NULL scan_request pointer to
> scan_request_failed(), causing a segmentation fault.

So for my own education, can you elaborate a bit more on how this is =

actually triggered?  I'm guessing that there are pending scans (probably =

triggered by invocation of Scan() via D-Bus?).  But an exact sequence of =

what happens would be nice.

> ---
>   src/scan.c | 3 +++
>   1 file changed, 3 insertions(+)
> =

> diff --git a/src/scan.c b/src/scan.c
> index 718f7497..106fa81c 100644
> --- a/src/scan.c
> +++ b/src/scan.c
> @@ -839,6 +839,9 @@ static bool start_next_scan_request(struct scan_conte=
xt *sc)
>   	if (sc->state !=3D SCAN_STATE_NOT_RUNNING)
>   		return true;
>   =

> +	if (sc->start_cmd_id)
> +		return true;
> +

So I think Andrew's suggestion of also checking for get_scan_id being =

not zero also makes sense.  It would keep things consistent with the =

comment in scan_notify where it says that we do not start the next =

request until GET_SCAN has been done.

Regards,
-Denis
--===============1847225054567216021==--

