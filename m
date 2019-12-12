Content-Type: multipart/mixed; boundary="===============4300489984158466581=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] eap-gtc: Try to auth even if request not Password
Date: Thu, 12 Dec 2019 10:24:01 -0600
Message-ID: <f6e3748f-944e-9c26-7638-13ec103b72ee@gmail.com>
In-Reply-To: <20191212012301.2162-1-xdavidwuph@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4300489984158466581==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pinghao,

On 12/11/19 7:23 PM, Pinghao Wu wrote:
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
> =


Applied, thanks.

Regards,
-Denis

--===============4300489984158466581==--

