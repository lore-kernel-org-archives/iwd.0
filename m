Content-Type: multipart/mixed; boundary="===============8005319028570540088=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/6] netdev: use NL80211_STA_INFO_SIGNAL rather than
 average
Date: Wed, 10 Mar 2021 15:12:10 -0600
Message-ID: <ecea1d5c-606f-c6d1-d253-521581dfe030@gmail.com>
In-Reply-To: <20210310202746.28475-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8005319028570540088==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 3/10/21 2:27 PM, James Prestwood wrote:
> Since GET_STATION (and in turn GetDiagnostics) gets the most
> current station info this attribute serves as a better indication
> of the current signal strength. In addition full mac cards don't
> appear to always have the average attribute.
> ---
>   src/netdev.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> =


This seems fine, so I went ahead an applied it.  I do wonder if we should p=
arse =

SIGNAL_AVG and report it separately (if available).

Regards,
-Denis
--===============8005319028570540088==--

