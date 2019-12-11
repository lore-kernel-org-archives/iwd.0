Content-Type: multipart/mixed; boundary="===============6689424179037629103=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] eap-gtc: Try to auth even if request not Password
Date: Wed, 11 Dec 2019 14:57:26 -0600
Message-ID: <66a25792-2327-b3c8-d324-e7b353abcbe1@gmail.com>
In-Reply-To: <20191211123904.27413-1-xdavidwuph@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6689424179037629103==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 12/11/19 6:39 AM, xdavidwu wrote:
> There are some server implementations that send requests that are
> not "Password" but still want us send password. This commit modify
> the behavior to send a warning and still try to auth with password.
> =

> This makes me able to auth with server in my school which sends
> "Enter Aruba Login".
> =

> wpa_supplicant does not check if it is "Password".
> ---
>   src/eap-gtc.c | 12 +++---------
>   1 file changed, 3 insertions(+), 9 deletions(-)
>

Thanks for the patch.  Looks good.  Any chance you can resubmit with =

your real name as the author info so I can apply this?  While we don't =

use Signed-off-by, our expectation for submissions are similar to [1], =

including the real name requirement.

[1] =

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#deve=
loper-s-certificate-of-origin-1-1

Regards,
-Denis
--===============6689424179037629103==--

