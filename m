Content-Type: multipart/mixed; boundary="===============3922732849348035852=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v3 1/3] scan: move scan_freq_set* into util
Date: Tue, 30 Nov 2021 12:31:24 -0600
Message-ID: <470ddf74-f85d-ca08-b06b-d2f23eec5db4@gmail.com>
In-Reply-To: 20211130182413.437115-1-prestwoj@gmail.com

--===============3922732849348035852==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 11/30/21 12:24 PM, James Prestwood wrote:
> This will allow scan_freq_set utilities to be used in any
> modules requiring unit testing
> ---
>   src/scan.c | 160 ----------------------------------------------------
>   src/scan.h |  14 -----
>   src/util.c | 161 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>   src/util.h |  15 +++++
>   4 files changed, 176 insertions(+), 174 deletions(-)
> =


All applied, thanks.

Regards,
-Denis
--===============3922732849348035852==--

