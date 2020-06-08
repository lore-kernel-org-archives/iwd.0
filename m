Content-Type: multipart/mixed; boundary="===============5904128897496904859=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v3] scan: refactor start_next_scan_request to not send
 duplicate requests
Date: Mon, 08 Jun 2020 15:12:02 -0500
Message-ID: <a42325c0-7b1c-618d-27c9-ed078992d152@gmail.com>
In-Reply-To: <20200608084207.151665-1-alsi@bang-olufsen.dk>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5904128897496904859==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alvin,

On 6/8/20 3:42 AM, Alvin =C5=A0ipraga wrote:
> If start_scan_next_request() is called while a scan request
> (NL80211_CMD_TRIGGER_SCAN) is still running, the same scan request will
> be sent again. Add a check in the function to avoid sending a request if
> one is already in progress. For consistency, check also that scan
> results are not being requested (NL80211_CMD_GET_SCAN), before trying to
> send the next scan request. Finally, remove similar checks at
> start_next_scan_request() callsites to simplify the code.
> =

> This also fixes a crash that occurs if the following conditions are met:
>    - the duplicated request is the only request in the scan request
>      queue, and
>    - both scan requests fail with an error not EBUSY.
> =

> In this case, the first callback to scan_request_triggered() will delete
> the request from the scan request queue. The second callback will find
> an empty queue and consequently pass a NULL scan_request pointer to
> scan_request_failed(), causing a segmentation fault.
> ---
>   src/scan.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============5904128897496904859==--

