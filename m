Content-Type: multipart/mixed; boundary="===============4433862021933051372=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v5 3/5] station: create StationDiagnostic interface
Date: Thu, 14 Jan 2021 15:14:52 -0600
Message-ID: <b10d452e-7b42-c55f-8319-684e66818bb7@gmail.com>
In-Reply-To: <20210114205442.84552-3-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4433862021933051372==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 1/14/21 2:54 PM, James Prestwood wrote:
> This interface sits aside the regular station interface but
> provides low level connection details for diagnostic and
> testing purposes.
> ---
>   src/station.c | 155 ++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 155 insertions(+)
> =

> v5:
>   * Changed Rx/TxRateType to Rx/TxMode
>   * Removed 'legacy' terminology, the rate mode will not be included
>     if the AP is operating in legacy modes.
> =


Applied, thanks.

Regards,
-Denis

--===============4433862021933051372==--

