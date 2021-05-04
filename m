Content-Type: multipart/mixed; boundary="===============9050959519134943025=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] test-runner: increase RAM for valgrind
Date: Tue, 04 May 2021 10:31:19 -0500
Message-ID: <17fbbd6c-16e3-f05b-2d68-c742ae33ca25@gmail.com>
In-Reply-To: <20210503213041.361836-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============9050959519134943025==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 5/3/21 4:30 PM, James Prestwood wrote:
> Certain tests like testAP spawn two IWD process in separate
> namespaces. When --valrind is used this eats up quite a bit
> of RAM and causes the VM to run out of memory and start
> killing off processes.
> ---
>   tools/test-runner | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============9050959519134943025==--

