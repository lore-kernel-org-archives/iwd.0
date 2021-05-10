Content-Type: multipart/mixed; boundary="===============3695323909633257755=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 1/7] ie: fix ie_parse_data_rates to handle NULL
Date: Mon, 10 May 2021 10:09:02 -0500
Message-ID: <7b584352-d9b1-ca86-270b-57b978398430@gmail.com>
In-Reply-To: <20210507202620.93540-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3695323909633257755==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 5/7/21 3:26 PM, James Prestwood wrote:
> The code was partially there to handle NULL IEs but not
> quite. If NULL IEs are passed in base the data rate totally
> on the basic rate RSSI table.
> ---
>   src/ie.c | 19 ++++++++++++-------
>   1 file changed, 12 insertions(+), 7 deletions(-)
> =


I went ahead and applied patches 1, 5, 6 (see reply separately) and 7.  I'l=
l =

leave the rest up for a few days to see if there's any additional comments.

Regards,
-Denis

--===============3695323909633257755==--

