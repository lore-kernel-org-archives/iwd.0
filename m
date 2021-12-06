Content-Type: multipart/mixed; boundary="===============6611307120264762332=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v4 1/2] wiphy: update wiphy_radio_work_is_running to
 return int
Date: Mon, 06 Dec 2021 14:13:07 -0600
Message-ID: <3dfffa89-1d54-5bbe-a997-c1b273fc5918@gmail.com>
In-Reply-To: 20211206201726.1192621-1-prestwoj@gmail.com

--===============6611307120264762332==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 12/6/21 2:17 PM, James Prestwood wrote:
> This differentiates between pending, running, and non-existent:
> false, true, -ENOENT respectively
> ---
>   src/wiphy.c | 10 +++++-----
>   src/wiphy.h |  2 +-
>   2 files changed, 6 insertions(+), 6 deletions(-)
> =

> v4:
>   * Changed to return true/false and -ENOENT rather than a zero success r=
eturn
> =


Both applied, thanks.

Regards,
-Denis

--===============6611307120264762332==--

