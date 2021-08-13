Content-Type: multipart/mixed; boundary="===============7558198609299402076=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/6] station: implement Scan on debug interface
Date: Fri, 13 Aug 2021 10:46:41 -0500
Message-ID: <1b4ec3f3-bf67-048a-0d67-a00e2fdb15b6@gmail.com>
In-Reply-To: <20210812231233.747743-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7558198609299402076==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 8/12/21 6:12 PM, James Prestwood wrote:
> This is to support the autotesting framework by allowing a smaller
> scan subset. This will cut down on the amount of time spent scanning
> via normal DBus scans (where the entire spectrum is scanned).
> ---
>   src/station.c | 107 ++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 107 insertions(+)
> =


All applied, thanks.

Regards,
-Denis

--===============7558198609299402076==--

