Content-Type: multipart/mixed; boundary="===============6059156595218872988=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] ap: fix off by one error
Date: Fri, 29 Jan 2021 15:04:28 -0600
Message-ID: <f6b46bfe-7b6d-0cdc-cb6e-02473f129c74@gmail.com>
In-Reply-To: <20210129205950.106936-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6059156595218872988==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 1/29/21 2:59 PM, James Prestwood wrote:
> The RSN element was not being allocated properly which caused
> an invalid read in some cases.
> ---
>   src/ap.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> =


Applied, thanks.

Regards,
-Denis

--===============6059156595218872988==--

