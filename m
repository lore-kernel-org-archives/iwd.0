Content-Type: multipart/mixed; boundary="===============3349404191806173341=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] test-runner: use **kwargs for start_process
Date: Tue, 15 Sep 2020 16:46:11 -0500
Message-ID: <94ec5ae7-c3cf-c59a-41bf-79ee89ff30e6@gmail.com>
In-Reply-To: <20200915173620.513612-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3349404191806173341==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 9/15/20 12:36 PM, James Prestwood wrote:
> This is just a more concise/pythonic way of doing function arguments.
> Since Process/start_process have basically the same argument names
> we can simplify and use **kwargs which will pass the named arguments
> directly to Process(). This also allows us to add arguments to Process
> without touching start_process if we need.
> ---
>   tools/test-runner | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> =



Applied, thanks.

Regards,
-Denis

--===============3349404191806173341==--

