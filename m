Content-Type: multipart/mixed; boundary="===============2626573131014079563=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 2/2] scan: refactor scan_common to not scan while
 scanning is suspended
Date: Thu, 04 Jun 2020 13:19:37 -0500
Message-ID: <b48879d9-1c0b-d20b-fae7-4c26c9259f3a@gmail.com>
In-Reply-To: <20200601171117.122574-2-alsi@bang-olufsen.dk>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2626573131014079563==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alvin,

On 6/1/20 12:11 PM, Alvin =C5=A0ipraga wrote:
> If scanning is suspended, have scan_common() queue its scan request
> rather than issuing it immediately. This respects the assumption that
> scans are not requested while sc->suspended is true.
> ---
>   src/scan.c | 3 +++
>   1 file changed, 3 insertions(+)
> =


I reworded the commit header slightly and applied, thanks.

Regards,
-Denis

--===============2626573131014079563==--

