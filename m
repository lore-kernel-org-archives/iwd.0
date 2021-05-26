Content-Type: multipart/mixed; boundary="===============3932159720281995745=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] scan: parse NL80211_BSS_LAST_SEEN_BOOTTIME in units of
 nanoseconds
Date: Wed, 26 May 2021 10:21:44 -0500
Message-ID: <85dd6c57-b88a-8c89-d478-be7e30c6777a@gmail.com>
In-Reply-To: <20210522120621.118459-1-alsi@bang-olufsen.dk>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3932159720281995745==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alvin,

On 5/22/21 7:06 AM, Alvin =C5=A0ipraga wrote:
> NL80211_BSS_LAST_SEEN_BOOTTIME is expressed in nanoseconds, while BSS
> timestamps are expressed in microseconds internally. Convert the
> attribute to microseconds when using it to timestamp a BSS. This makes
> iwd expire absent BSSes within 30 seconds as intended.
> ---
>   src/scan.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> =


Nice catch.  My bad for not testing this enough.  I added a Fixes: tag and =

applied, thanks!

Regards,
-Denis
--===============3932159720281995745==--

