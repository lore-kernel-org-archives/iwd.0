Content-Type: multipart/mixed; boundary="===============1133501287033114898=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH v2 1/2] scan: refactor start_next_scan_request to not send
 duplicate requests
Date: Tue, 02 Jun 2020 10:45:09 +0200
Message-ID: <CAOq732LvdW3nHvq-a8RLkmvrkMGCDMp_iJ1+0RLADF8mc29Dtg@mail.gmail.com>
In-Reply-To: <20200601171117.122574-1-alsi@bang-olufsen.dk>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1133501287033114898==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 1 Jun 2020 at 19:11, Alvin =C5=A0ipraga <alsi@bang-olufsen.dk> wr=
ote:
> If start_scan_next_request() is called while a scan request
> (NL80211_CMD_TRIGGER_SCAN) is still running, the same scan request will
> be sent again. Add a check in the function to avoid sending a request if
> one is already in progress.
>
> This also fixes a crash that occurs if the following conditions are met:
>   - the duplicated request is the only request in the scan request
>     queue, and
>   - both scan requests fail with an error not EBUSY.
>
> In this case, the first callback to scan_request_triggered() will delete
> the request from the scan request queue. The second callback will find
> an empty queue and consequently pass a NULL scan_request pointer to
> scan_request_failed(), causing a segmentation fault.
> ---
>  src/scan.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/src/scan.c b/src/scan.c
> index 718f7497..106fa81c 100644
> --- a/src/scan.c
> +++ b/src/scan.c
> @@ -839,6 +839,9 @@ static bool start_next_scan_request(struct scan_conte=
xt *sc)
>         if (sc->state !=3D SCAN_STATE_NOT_RUNNING)
>                 return true;
>
> +       if (sc->start_cmd_id)
> +               return true;

How about checking sc->get_scan_cmd_id as well?  I guess I'd put these
two and the sc->state check in one if ().

Also you can now drop those checks in scan_notify in the
NL80211_CMD_SCAN_ABORTED case because as you mentioned in the other
thread you're moving the checks from the callers into
start_next_scan_request.

Best regards
--===============1133501287033114898==--

