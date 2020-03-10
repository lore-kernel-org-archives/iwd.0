Content-Type: multipart/mixed; boundary="===============2301247026392348810=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH V3] Makefile.am: Avoid redirection of input and output
 files
Date: Mon, 09 Mar 2020 22:21:21 -0500
Message-ID: <a9da1ca7-f8cc-c8f9-d564-e356bcbc6e61@gmail.com>
In-Reply-To: <20200306192253.1758531-1-raj.khem@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2301247026392348810==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Khem,

On 3/6/20 1:22 PM, Khem Raj wrote:
> Ensure that directory is created before its written to
> =

> This can cause a build race in a highly parallelised build where a direct=
ory is not yet created but
> output file is being written using redirection e.g.
> =

> rst2man.py --strict --no-raw --no-generator --no-datestamp < ../git/monit=
or/iwmon.rst > monitor/iwmon.1
> /bin/sh: monitor/iwmon.1: No such file or directory
> make[1]: *** [Makefile:3544: monitor/iwmon.1] Error 1
> =

> Signed-off-by: Khem Raj <raj.khem@gmail.com>
> ---
> v2: create directory before emitting doc files into it
> v3: No change, rebased on master
> =

>   Makefile.am | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============2301247026392348810==--

